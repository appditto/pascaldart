import 'package:json_annotation/json_annotation.dart';
import 'package:pascaldart/src/common/model/currency.dart';
import 'package:pascaldart/src/json_rpc/model/response/rpc_response.dart';
import 'package:pascaldart/src/json_rpc/converters.dart';

part 'pascal_block.g.dart';

/// Represents an 'Account' object returned by PascalCoin json-RPC API
@JsonSerializable()
class PascalBlock extends RPCResponse {
  @JsonKey(name:'block', includeIfNull: false)
  int block;

  @JsonKey(name:'enc_pubkey', includeIfNull: false)
  String encPubkey;

  @JsonKey(name:'reward', includeIfNull: false, toJson: currencyToDouble, fromJson: pascalToCurrency)
  Currency reward;

  @JsonKey(name:'fee', includeIfNull: false, toJson: currencyToDouble, fromJson: pascalToCurrency)
  Currency fee;

  @JsonKey(name:'ver', includeIfNull: false)
  int ver;

  @JsonKey(name:'ver_a', includeIfNull: false)
  int ver_a;

  @JsonKey(name:'timestamp', fromJson: toDateTime, toJson: fromDateTime, includeIfNull: false)
  DateTime timestamp;

  @JsonKey(name:'target', includeIfNull: false)
  int target;

  @JsonKey(name:'nonce', includeIfNull: false)
  int nonce;

  @JsonKey(name:'payload', includeIfNull: false)
  String payload;

  @JsonKey(name:'sbh', includeIfNull: false)
  String sbh;

  @JsonKey(name:'oph', includeIfNull: false)
  String oph;

  @JsonKey(name:'pow', includeIfNull: false)
  String pow;

  @JsonKey(name:'operations', includeIfNull: false)
  int operations;

  @JsonKey(name:'hashratekhs', includeIfNull: false)
  int hashratekhs;

  @JsonKey(name:'maturation', includeIfNull: false)
  int maturation;

  PascalBlock({
    this.block,
    this.encPubkey,
    this.reward,
    this.fee,
    this.ver,
    this.ver_a,
    this.timestamp,
    this.target,
    this.nonce,
    this.payload,
    this.sbh,
    this.oph,
    this.pow,
    this.operations,
    this.hashratekhs,
    this.maturation
  });

  factory PascalBlock.fromJson(Map<String, dynamic> json) => _$PascalBlockFromJson(json);
  Map<String, dynamic> toJson() => _$PascalBlockToJson(this);
}