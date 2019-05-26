import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:pascaldart/src/json_rpc/model/request/BaseRequest.dart';

part 'GetAccountRequest.g.dart';

@JsonSerializable()
class GetAccountRequest extends BaseRequest {
  @JsonKey(name: 'params')
  Map<String, dynamic> params;

  @JsonKey(ignore: true)
  int account;

  GetAccountRequest({@required this.account}) : super(method: 'getaccount') {
    this.params = Map();
    this.params['account'] = account;
  }

  factory GetAccountRequest.fromJson(Map<String, dynamic> json) => _$GetAccountRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetAccountRequestToJson(this); 
}