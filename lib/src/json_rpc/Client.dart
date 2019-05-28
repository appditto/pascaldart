import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pascaldart/src/json_rpc/model/request/base_request.dart';
import 'package:pascaldart/src/json_rpc/model/response/base_response.dart';
import 'package:pascaldart/src/json_rpc/model/response/error_response.dart';
import 'package:pascaldart/src/json_rpc/model/response/getaccount_response.dart';

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
  Future<dynamic> makeRpcRequest(BaseRequest request) async {
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
        return GetAccountResponse.fromJson(resp.result);
    }
  }
}