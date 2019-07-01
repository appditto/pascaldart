import 'dart:typed_data';

import 'package:pascaldart/pascaldart.dart';

main() async {
  // Generating a keypair
  KeyPair kp = Keys.generate(curve: Curve.getDefaultCurve());
  // RPC client
  RPCClient rpc = RPCClient(rpcAddress: 'http://127.0.0.1:4003');
  // Creating transaction operation and signing it
  TransactionOperation op = TransactionOperation(
      sender: AccountNumber.fromInt(1234),
      target: AccountNumber.fromInt(1000),
      amount: Currency('10'))
    ..withNOperation(2)
    ..withPayload(PDUtil.stringToBytesUtf8('Hello Payload'))
    ..withFee(Currency('0'))
    ..sign(kp.privateKey);
  // Executing operation
  Uint8List encodedRawOp = RawOperationCoder.encodeToBytes(op);
  ExecuteOperationsRequest request =
      ExecuteOperationsRequest(rawOperations: PDUtil.byteToHex(encodedRawOp));
  RPCResponse rawResp = await rpc.makeRpcRequest(request);
  if (rawResp.isError) {
    // Handling an error
    ErrorResponse errResp = rawResp;
    print(errResp.errorMessage);
  } else {
    OperationsResponse opResp = rawResp;
    opResp.operations.forEach((op) {
      print(op.amount.toStringOpt());
    });
  }
}
