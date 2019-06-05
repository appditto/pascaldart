import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:pascaldart/src/json_rpc/model/request/base_request.dart';

part 'findoperation_request.g.dart';

@JsonSerializable()
class FindOperationRequest extends BaseRequest {
  @JsonKey(name: 'params')
  Map<String, dynamic> params;

  @JsonKey(ignore: true)
  get ophash {
    return params['ophash'];
  }

  FindOperationRequest({@required String ophash}) : super(method: 'findoperation') {
    this.params = Map();
    this.params['ophash'] = ophash;
  }

  Map<String, dynamic> toJson() => _$FindOperationRequestToJson(this); 
}