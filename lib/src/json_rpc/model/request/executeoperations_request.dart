import 'package:json_annotation/json_annotation.dart';
import 'package:pascaldart/src/json_rpc/model/request/base_request.dart';

part 'executeoperations_request.g.dart';

@JsonSerializable()
class ExecuteOperationsRequest extends BaseRequest {
  @JsonKey(name: 'params')
  Map<String, dynamic>? params;

  @JsonKey(ignore: true)
  get rawOperations {
    return params!['rawoperations'];
  }

  ExecuteOperationsRequest({String? rawOperations})
      : super(method: 'executeoperations') {
    this.params = Map();
    if (rawOperations != null) {
      this.params!['rawoperations'] = rawOperations;
    }
  }

  Map<String, dynamic> toJson() => _$ExecuteOperationsRequestToJson(this);
  factory ExecuteOperationsRequest.fromJson(Map<String, dynamic> json) =>
      _$ExecuteOperationsRequestFromJson(json);
}
