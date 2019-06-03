import 'package:json_annotation/json_annotation.dart';
import 'package:pascaldart/src/common/model/currency.dart';
import 'package:pascaldart/src/json_rpc/model/response/rpc_response.dart';
import 'package:pascaldart/src/json_rpc/converters.dart';

part 'pascal_account.g.dart';

enum AccountState {
  NORMAL,
  LISTED
}

/// Represents an 'Account' object returned by PascalCoin json-RPC API
@JsonSerializable()
class PascalAccount extends RPCResponse {
  @JsonKey(name:'account', includeIfNull: false)
  int account;

  @JsonKey(name:'enc_pubkey', includeIfNull: false)
  String encPubkey;

  @JsonKey(name:'balance', includeIfNull: false, toJson: currencyToDouble, fromJson: pascalToCurrency)
  Currency balance;

  @JsonKey(name:'n_operation', includeIfNull: false)
  int nOperation;

  @JsonKey(name:'updated_b', includeIfNull: false)
  int updatedBlock;

  @JsonKey(name: 'state', includeIfNull: false, toJson: accountStateToJson, fromJson: accountStateFromJson)
  AccountState state;

  @JsonKey(name: 'type', includeIfNull: false)
  int type;

  @JsonKey(name: 'locked_until_block', includeIfNull: false)
  int lockedUntilBlock;

  @JsonKey(name:'price', includeIfNull: false, toJson: currencyToDouble, fromJson: pascalToCurrency)
  Currency price;

  @JsonKey(name:'seller_account', includeIfNull: false)
  int sellerAccount;

  @JsonKey(name: 'private_sale', includeIfNull: false)
  bool privateSale;

  @JsonKey(name: 'new_enc_pubkey', includeIfNull: false)
  String newEncPubkey;

  @JsonKey(name: 'name', includeIfNull: false)
  String name;

  PascalAccount({
    this.account,
    this.encPubkey,
    this.balance,
    this.nOperation,
    this.updatedBlock,
    this.state,
    this.type,
    this.lockedUntilBlock,
    this.price,
    this.sellerAccount,
    this.privateSale,
    this.newEncPubkey
  });

  factory PascalAccount.fromJson(Map<String, dynamic> json) => _$PascalAccountFromJson(json);
  Map<String, dynamic> toJson() => _$PascalAccountToJson(this);
}