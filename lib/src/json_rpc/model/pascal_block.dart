import 'package:json_annotation/json_annotation.dart';
import 'package:pascaldart/src/json_rpc/model/response/rpc_response.dart';

part 'pascal_block.g.dart';

DateTime _toDateTime(int v) {
  return DateTime.fromMicrosecondsSinceEpoch(v);
}

int _fromDateTime(DateTime dt) {
  return dt.millisecondsSinceEpoch;
}

/// Represents an 'Account' object returned by PascalCoin json-RPC API
@JsonSerializable()
class PascalBlock extends RPCResponse {
  @JsonKey(name:'block')
  int block;

  @JsonKey(name:'enc_pubkey')
  String encPubkey;

  @JsonKey(name:'reward')
  int reward;

  @JsonKey(name:'fee')
  double fee;

  @JsonKey(name:'ver')
  int ver;

  @JsonKey(name:'ver_a')
  int ver_a;

  @JsonKey(name:'timestamp', fromJson: _toDateTime, toJson: _fromDateTime)
  DateTime timestamp;

  @JsonKey(name:'target')
  int target;

  @JsonKey(name:'nonce')
  int nonce;

  @JsonKey(name:'payload')
  String payload;

  @JsonKey(name:'sbh')
  String sbh;

  @JsonKey(name:'oph')
  String oph;

  @JsonKey(name:'pow')
  String pow;

  @JsonKey(name:'operations')
  int operations;

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
    this.operations
  });

  factory PascalBlock.fromJson(Map<String, dynamic> json) => _$PascalBlockFromJson(json);
  Map<String, dynamic> toJson() => _$PascalBlockToJson(this);
}