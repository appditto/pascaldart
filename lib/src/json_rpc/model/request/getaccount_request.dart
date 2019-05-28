import 'package:json_annotation/json_annotation.dart';
import 'package:pascaldart/src/json_rpc/model/request/base_request.dart';

part 'getaccount_request.g.dart';

@JsonSerializable()
class GetAccountRequest extends BaseRequest {
  @JsonKey(name: 'params')
  Map<String, dynamic> params;

  @JsonKey(ignore: true)
  get account {
    return params['account'];
  }

  GetAccountRequest({int account, this.params}) : super(method: 'getaccount') {
    if (this.params == null) {
      this.params = Map();
      this.params['account'] = account;
    }
  }

  Map<String, dynamic> toJson() => _$GetAccountRequestToJson(this); 
}