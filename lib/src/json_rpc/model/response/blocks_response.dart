import 'package:pascaldart/src/json_rpc/model/pascal_block.dart';
import 'package:pascaldart/src/json_rpc/model/response/rpc_response.dart';

class BlocksResponse extends RPCResponse {
  List<PascalBlock> blocks;

  BlocksResponse(blocks);
}