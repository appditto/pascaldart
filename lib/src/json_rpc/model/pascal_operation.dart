import 'package:json_annotation/json_annotation.dart';
import 'package:pascaldart/src/common/model/accountnumber.dart';
import 'package:pascaldart/src/common/model/currency.dart';
import 'package:pascaldart/src/common/model/keys/publickey.dart';
import 'package:pascaldart/src/json_rpc/model/changer.dart';
import 'package:pascaldart/src/json_rpc/model/receiver.dart';
import 'package:pascaldart/src/json_rpc/model/response/rpc_response.dart';
import 'package:pascaldart/src/json_rpc/converters.dart';
import 'package:pascaldart/src/json_rpc/model/sender.dart';

part 'pascal_operation.g.dart';

/// Represents an 'Operation' object returned by PascalCoin json-RPC API
@JsonSerializable()
class PascalOperation extends RPCResponse {
  @JsonKey(name: 'valid', includeIfNull: false)
  bool valid;

  @JsonKey(name: 'errors', includeIfNull: false)
  String errors;

  @JsonKey(name: 'block', includeIfNull: false)
  int block;

  @JsonKey(
      name: 'time',
      includeIfNull: false,
      fromJson: toDateTime,
      toJson: fromDateTime)
  DateTime time;

  @JsonKey(name: 'opblock', includeIfNull: false)
  int opblock;

  @JsonKey(name: 'maturation')
  int maturation;

  @JsonKey(name: 'optype', includeIfNull: false)
  int optype;

  @JsonKey(
      name: 'account',
      includeIfNull: false,
      fromJson: intToAccountNum,
      toJson: accountNumToInt)
  AccountNumber account;

  @JsonKey(name: 'optxt', includeIfNull: false)
  String optxt;

  @JsonKey(
      name: 'amount',
      includeIfNull: false,
      toJson: currencyToDouble,
      fromJson: pascalToCurrency)
  Currency amount;

  @JsonKey(
      name: 'fee',
      includeIfNull: false,
      toJson: currencyToDouble,
      fromJson: pascalToCurrency)
  Currency fee;

  @JsonKey(
      name: 'balance',
      includeIfNull: false,
      toJson: currencyToDouble,
      fromJson: pascalToCurrency)
  Currency balance;

  @JsonKey(name: 'ophash', includeIfNull: false)
  String ophash;

  @JsonKey(name: 'payload', includeIfNull: false)
  String payload;

  @JsonKey(
      name: 'signer_account',
      includeIfNull: false,
      fromJson: intToAccountNum,
      toJson: accountNumToInt)
  AccountNumber signerAccount;

  @JsonKey(name: 'senders', includeIfNull: false)
  List<Sender> senders;

  @JsonKey(name: 'receivers', includeIfNull: false)
  List<Receiver> receivers;

  @JsonKey(name: 'changers', includeIfNull: false)
  List<Changer> changers;

  @JsonKey(
      name: 'enc_pubkey',
      includeIfNull: false,
      fromJson: hexToPublicKey,
      toJson: publicKeyToHex)
  PublicKey encPubkey;

  PascalOperation(
      {this.valid,
      this.errors,
      this.block,
      this.time,
      this.opblock,
      this.maturation,
      this.optype,
      this.account,
      this.optxt,
      this.amount,
      this.fee,
      this.balance,
      this.ophash,
      this.payload,
      this.signerAccount,
      this.senders,
      this.receivers,
      this.changers,
      this.encPubkey});

  factory PascalOperation.fromJson(Map<String, dynamic> json) =>
      _$PascalOperationFromJson(json);
  Map<String, dynamic> toJson() => _$PascalOperationToJson(this);

  /// Operator overrides
  bool operator ==(o) => (o != null && o.hashCode == hashCode);
  int get hashCode => ophash.hashCode;
}
