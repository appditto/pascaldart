import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/pointycastle.dart' as pc;

import 'package:pascaldart/common.dart' as common;
import 'package:pascaldart/src/crypto/model/Signature.dart';

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
      common.PrivateKey(common.Util.encodeBigInt(privateKey.d, endian: Endian.big), curve),
      common.PublicKey(common.Util.encodeBigInt(publicKey.Q.x.toBigInteger(), endian: Endian.big), common.Util.encodeBigInt(publicKey.Q.y.toBigInteger(), endian: Endian.big), curve)
     );
  }

  static common.KeyPair fromPrivateKey(common.PrivateKey privateKey) {
    pc.ECDomainParameters domainParams = pc.ECDomainParameters(privateKey.curve.name);
    pc.ECPrivateKey pKeyEC = pc.ECPrivateKey(common.Util.decodeBigInt(privateKey.ec(), endian: Endian.big), domainParams);
    pc.ECPoint Q = domainParams.G * pKeyEC.d;
    return common.KeyPair(
            privateKey,
            common.PublicKey(common.Util.encodeBigInt(Q.x.toBigInteger(), endian: Endian.big),
                             common.Util.encodeBigInt(Q.y.toBigInteger(), endian: Endian.big),
                             privateKey.curve)
    );
  }

  /// Sign bytes using sha256 with ecdsa
  static Signature sign(common.PrivateKey privateKey, Uint8List msgBytes) {
    /// Entropy
    pc.SecureRandom secureRandom = pc.SecureRandom("Fortuna");
    Random random = Random.secure();
    List<int> seeds = [];
    for (int i = 0; i < 32; i++) {
      seeds.add(random.nextInt(255));
    }
    secureRandom.seed(pc.KeyParameter(Uint8List.fromList(seeds)));
    // Setup non-deterministic signer
    pc.ECDomainParameters domainParams = pc.ECDomainParameters(privateKey.curve.name);
    BigInt d = common.Util.decodeBigInt(privateKey.ec(), endian: Endian.big);
    pc.PrivateKeyParameter privKeyParams = pc.PrivateKeyParameter(pc.ECPrivateKey(d, domainParams));
    pc.ParametersWithRandom signParams =
        pc.ParametersWithRandom(privKeyParams, secureRandom);
    pc.Signer signer = pc.Signer("SHA-256/ECDSA"); 
    // Sign
    signer.init(true, signParams);
    pc.ECSignature ecsig = signer.generateSignature(msgBytes);
    // Verify
    pc.Signer verifier = pc.Signer("SHA-256/ECDSA"); 
    pc.ECPoint Q = domainParams.G * d;
    pc.PublicKeyParameter pubKeyParams = pc.PublicKeyParameter(pc.ECPublicKey(Q, domainParams));
    verifier.init(false, pubKeyParams);
    if (verifier.verifySignature(msgBytes, ecsig)) {
      return Signature(r: ecsig.r, s: ecsig.s);
    }
    throw Exception("Couldn't verify signature");
  }
}