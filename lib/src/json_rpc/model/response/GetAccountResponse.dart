import 'package:json_annotation/json_annotation.dart';
import 'package:pascaldart/src/json_rpc/model/response/BaseResponse.dart';

part 'GetAccountResponse.g.dart';

@JsonSerializable()
class GetAccountResponse extends BaseResponse {
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

  GetAccountResponse({this.account, this.encPubkey, this.balance, this.nOperation, this.updatedBlock});

  factory GetAccountResponse.fromJson(Map<String, dynamic> json) => _$GetAccountResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetAccountResponseToJson(this);
}