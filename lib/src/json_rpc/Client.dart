import 'package:http/http.dart' as http;

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
}