import 'package:json_annotation/json_annotation.dart';
import 'package:pascaldart/src/common/model/accountname.dart';
import 'package:pascaldart/src/common/model/accountnumber.dart';
import 'package:pascaldart/src/common/model/currency.dart';
import 'package:pascaldart/src/common/model/keys/publickey.dart';
import 'package:pascaldart/src/json_rpc/model/response/rpc_response.dart';
import 'package:pascaldart/src/json_rpc/converters.dart';

part 'changer.g.dart';

/// Represents an 'Changer' object returned by PascalCoin json-RPC API
@JsonSerializable()
class Changer extends RPCResponse {
  @JsonKey(
      name: 'account',
      includeIfNull: false,
      fromJson: intToAccountNum,
      toJson: accountNumToInt)
  AccountNumber changingAccount;

  @JsonKey(name: 'n_operation', includeIfNull: false)
  int nOperation;

  @JsonKey(
      name: 'new_enc_pubkey',
      includeIfNull: false,
      fromJson: hexToPublicKey,
      toJson: publicKeyToHex)
  PublicKey newEncPubkey;

  @JsonKey(
      name: 'new_name',
      includeIfNull: false,
      fromJson: strToAccountName,
      toJson: accountNameToStr)
  AccountName newName;

  @JsonKey(name: 'new_type', includeIfNull: false)
  int newType;

  @JsonKey(
      name: 'seller_account',
      includeIfNull: false,
      fromJson: intToAccountNum,
      toJson: accountNumToInt)
  AccountNumber sellerAccount;

  @JsonKey(
      name: 'account_price',
      includeIfNull: false,
      toJson: currencyToDouble,
      fromJson: pascalToCurrency)
  Currency accountPrice;

  @JsonKey(name: 'locked_until_block', includeIfNull: false)
  int lockedUntilBlock;

  @JsonKey(
      name: 'fee',
      includeIfNull: false,
      toJson: currencyToDouble,
      fromJson: pascalToCurrency)
  Currency fee;

  Changer(
      {this.changingAccount,
      this.nOperation,
      this.newEncPubkey,
      this.newName,
      this.newType,
      this.sellerAccount,
      this.accountPrice,
      this.lockedUntilBlock,
      this.fee});

  factory Changer.fromJson(Map<String, dynamic> json) =>
      _$ChangerFromJson(json);
  Map<String, dynamic> toJson() => _$ChangerToJson(this);
}
