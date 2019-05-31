import 'package:json_annotation/json_annotation.dart';
import 'package:pascaldart/src/json_rpc/model/response/rpc_response.dart';

part 'pascal_account.g.dart';

/// Represents an 'Account' object returned by PascalCoin json-RPC API
@JsonSerializable()
class PascalAccount extends RPCResponse {
  @JsonKey(name:'account')
  int account;

  @JsonKey(name:'enc_pubkey')
  String encPubkey;

  @JsonKey(name:'balance')
  double balance;

  @JsonKey(name:'n_operation')
  int nOperation;

  @JsonKey(name:'updated_b')
  int updatedBlock;

  PascalAccount({this.account, this.encPubkey, this.balance, this.nOperation, this.updatedBlock});

  factory PascalAccount.fromJson(Map<String, dynamic> json) => _$PascalAccountFromJson(json);
  Map<String, dynamic> toJson() => _$PascalAccountToJson(this);
}