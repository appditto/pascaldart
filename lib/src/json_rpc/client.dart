import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pascaldart/src/json_rpc/model/pascal_account.dart';
import 'package:pascaldart/src/json_rpc/model/pascal_block.dart';
import 'package:pascaldart/src/json_rpc/model/pascal_operation.dart';
import 'package:pascaldart/src/json_rpc/model/request/base_request.dart';
import 'package:pascaldart/src/json_rpc/model/response/accounts_response.dart';
import 'package:pascaldart/src/json_rpc/model/response/base_response.dart';
import 'package:pascaldart/src/json_rpc/model/response/blocks_response.dart';
import 'package:pascaldart/src/json_rpc/model/response/error_response.dart';
import 'package:pascaldart/src/json_rpc/model/response/operations_response.dart';
import 'package:pascaldart/src/json_rpc/model/response/rpc_response.dart';

class RPCClient {
  String rpcAddress;
  int id; // Json-RPC ID, auto-increments for each request this instance makes

  RPCClient({this.rpcAddress = 'http://127.0.0.1:4003', this.id = 0});

  /// Post json to the RPC address
  Future<String> rpcPost(Map<String, dynamic> json) async {
    this.id++;
    http.Response response = await http.post(rpcAddress, body: json);
    if (response.statusCode != 200) {
      return null; // TODO - make this an error response with more details
    }
    return response.body;
  }

  /// Make a request, and return deserialized response
  Future<RPCResponse> makeRpcRequest(BaseRequest request) async {
    request.id = id;
    String responseJson = await rpcPost(request.toJson());
    if (responseJson == null) {
      throw Exception('Did not receive a response');
    }
    // Parse base response
    BaseResponse resp = BaseResponse.fromJson(json.decode(responseJson));
    // Determine if error response
    if (resp.result.containsKey('code') && resp.result.containsKey('message')) {
      return ErrorResponse.fromJson(resp.result);
    }
    // Determine correct response type
    switch (request.method) {
      case 'getaccount':
        return PascalAccount.fromJson(resp.result);
      case 'getblock':
        return PascalBlock.fromJson(resp.result);
      case 'findoperation':
        return PascalOperation.fromJson(resp.result);
      case 'getblocks':
        return BlocksResponse.fromJson(json.decode(responseJson));
      case 'getwalletaccounts':
      case 'findaccounts':
        return AccountsResponse.fromJson(json.decode(responseJson));
      case 'getblockoperations':
      case 'getaccountoperations':
      case 'getpendings':
        return OperationsResponse.fromJson(json.decode(responseJson));
      default:
        return BaseResponse.fromJson(resp.result);
    }
  }
}