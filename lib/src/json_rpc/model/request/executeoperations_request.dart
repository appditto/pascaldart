import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:pascaldart/src/json_rpc/model/request/base_request.dart';

part 'executeoperations_request.g.dart';

@JsonSerializable()
class ExecuteOperationsRequest extends BaseRequest {
  @JsonKey(name: 'params')
  Map<String, dynamic> params;

  @JsonKey(ignore: true)
  get rawOperations {
    return params['rawoperations'];
  }

  ExecuteOperationsRequest({@required String rawOperations}) : super(method: 'executeoperations') {
    this.params = Map();
    this.params['rawoperations'] = rawOperations;
  }

  Map<String, dynamic> toJson() => _$ExecuteOperationsRequestToJson(this); 
}