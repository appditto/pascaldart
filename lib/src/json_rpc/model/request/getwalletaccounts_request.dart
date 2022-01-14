import 'package:json_annotation/json_annotation.dart';
import 'package:pascaldart/src/json_rpc/model/request/base_request.dart';

part 'getwalletaccounts_request.g.dart';

@JsonSerializable()
class GetWalletAccountsRequest extends BaseRequest {
  @JsonKey(name: 'params')
  Map<String, dynamic>? params;

  @JsonKey(ignore: true, includeIfNull: false)
  get encPubkey {
    return params!['enc_pubkey'];
  }

  @JsonKey(ignore: true, includeIfNull: false)
  get b58pubkey {
    return params!['b58_pubkey'];
  }

  @JsonKey(ignore: true, includeIfNull: false)
  get start {
    return params!['start'];
  }

  @JsonKey(ignore: true, includeIfNull: false)
  get max {
    return params!['max'];
  }

  GetWalletAccountsRequest(
      {String? encPubkey, String? b58pubkey, int? start, int? max, this.params})
      : super(method: 'getwalletaccounts') {
    this.params = Map();
    if (encPubkey != null) {
      this.params!['enc_pubkey'] = encPubkey;
    }
    if (b58pubkey != null) {
      this.params!['b58_pubkey'] = b58pubkey;
    }
    if (start != null) {
      this.params!['start'] = start;
    }
    if (max != null) {
      this.params!['max'] = max;
    }
  }

  Map<String, dynamic> toJson() => _$GetWalletAccountsRequestToJson(this);
  factory GetWalletAccountsRequest.fromJson(Map<String, dynamic> json) =>
      _$GetWalletAccountsRequestFromJson(json);
}
