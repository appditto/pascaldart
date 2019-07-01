import 'package:json_annotation/json_annotation.dart';
import 'package:pascaldart/src/common/model/accountnumber.dart';
import 'package:pascaldart/src/common/model/currency.dart';
import 'package:pascaldart/src/json_rpc/model/response/rpc_response.dart';
import 'package:pascaldart/src/json_rpc/converters.dart';

part 'receiver.g.dart';

/// Represents an 'Receiver' object returned by PascalCoin json-RPC API
@JsonSerializable()
class Receiver extends RPCResponse {
  @JsonKey(
      name: 'account',
      includeIfNull: false,
      fromJson: intToAccountNum,
      toJson: accountNumToInt)
  AccountNumber receivingAccount;

  @JsonKey(
      name: 'amount',
      includeIfNull: false,
      toJson: currencyToDouble,
      fromJson: pascalToCurrency)
  Currency amount;

  @JsonKey(name: 'payload', includeIfNull: false)
  String payload;

  Receiver({this.receivingAccount, this.amount, this.payload});

  factory Receiver.fromJson(Map<String, dynamic> json) =>
      _$ReceiverFromJson(json);
  Map<String, dynamic> toJson() => _$ReceiverToJson(this);
}
