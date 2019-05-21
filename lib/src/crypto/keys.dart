import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/pointycastle.dart' as pc;

import 'package:pascaldart/common.dart' as common;

/// Handling of cryptographic keys
class Keys {
  /// Generate a keypair for the given curve
  static common.KeyPair generate({common.Curve curve}) {
    if (curve == null) {
      curve = common.Curve.getDefaultCurve();
    } else if (!curve.supported) {
      throw UnsupportedError('Curve ${curve.name} is not supported');
    }

    pc.SecureRandom secureRandom = pc.SecureRandom("Fortuna");
    Random random = Random.secure();
    List<int> seeds = [];
    for (int i = 0; i < 32; i++) {
      seeds.add(random.nextInt(255));
    }
    secureRandom.seed(pc.KeyParameter(Uint8List.fromList(seeds)));

    pc.ECDomainParameters domainParams = pc.ECDomainParameters(curve.name);
    pc.ECKeyGeneratorParameters ecParams = pc.ECKeyGeneratorParameters(domainParams);
    pc.ParametersWithRandom params =
        pc.ParametersWithRandom<pc.ECKeyGeneratorParameters>(ecParams, secureRandom);

    pc.KeyGenerator keyGenerator = pc.KeyGenerator("EC");
    keyGenerator.init(params);

    pc.AsymmetricKeyPair keyPair = keyGenerator.generateKeyPair();
    pc.ECPrivateKey privateKey = keyPair.privateKey;
    pc.ECPublicKey publicKey = keyPair.publicKey;
    return common.KeyPair(
      common.PrivateKey(common.Util.encodeBigInt(privateKey.d), curve),
      common.PublicKey(common.Util.encodeBigInt(publicKey.Q.x.toBigInteger()), common.Util.encodeBigInt(publicKey.Q.y.toBigInteger()), curve)
     );
  }
}