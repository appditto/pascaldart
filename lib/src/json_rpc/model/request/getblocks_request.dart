import 'package:json_annotation/json_annotation.dart';
import 'package:pascaldart/src/json_rpc/model/request/base_request.dart';

part 'getblocks_request.g.dart';

@JsonSerializable()
class GetBlocksRequest extends BaseRequest {
  @JsonKey(name: 'params')
  Map<String, dynamic>? params;

  @JsonKey(ignore: true)
  get last {
    return params!['last'];
  }

  @JsonKey(ignore: true)
  get start {
    return params!['start'];
  }

  @JsonKey(ignore: true)
  get end {
    return params!['end'];
  }

  GetBlocksRequest({int? last, int? start, int? end, this.params})
      : super(method: 'getblocks') {
    this.params = Map();
    if (last != null) {
      this.params!['last'] = last;
    } else if (start != null && end != null) {
      this.params!['start'] = start;
      this.params!['end'] = end;
    } else {
      throw ArgumentError('Either last or start+end must be provided');
    }
  }

  Map<String, dynamic> toJson() => _$GetBlocksRequestToJson(this);
  factory GetBlocksRequest.fromJson(Map<String, dynamic> json) =>
      _$GetBlocksRequestFromJson(json);
}
