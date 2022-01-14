import 'package:json_annotation/json_annotation.dart';
import 'package:pascaldart/src/common/model/accountnumber.dart';
import 'package:pascaldart/src/common/model/currency.dart';
import 'package:pascaldart/src/json_rpc/model/response/rpc_response.dart';
import 'package:pascaldart/src/json_rpc/converters.dart';

part 'sender.g.dart';

/// Represents an 'Sender' object returned by PascalCoin json-RPC API
@JsonSerializable()
class Sender extends RPCResponse {
  @JsonKey(
      name: 'account',
      includeIfNull: false,
      fromJson: intToAccountNum,
      toJson: accountNumToInt)
  AccountNumber? sendingAccount;

  @JsonKey(name: 'n_operation', includeIfNull: false)
  int? nOperation;

  @JsonKey(
      name: 'amount',
      includeIfNull: false,
      toJson: currencyToDouble,
      fromJson: pascalToCurrency)
  Currency? amount;

  @JsonKey(name: 'payload', includeIfNull: false)
  String? payload;

  Sender({this.sendingAccount, this.nOperation, this.amount, this.payload});

  factory Sender.fromJson(Map<String, dynamic> json) => _$SenderFromJson(json);
  Map<String, dynamic> toJson() => _$SenderToJson(this);
}
