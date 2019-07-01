import 'package:json_annotation/json_annotation.dart';
import 'package:pascaldart/src/json_rpc/model/pascal_account.dart';
import 'package:pascaldart/src/json_rpc/model/response/rpc_response.dart';

part 'accounts_response.g.dart';

@JsonSerializable()
class AccountsResponse extends RPCResponse {
  @JsonKey(name: 'result')
  List<PascalAccount> accounts;

  AccountsResponse({this.accounts});

  factory AccountsResponse.fromJson(Map<String, dynamic> json) =>
      _$AccountsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AccountsResponseToJson(this);
}
