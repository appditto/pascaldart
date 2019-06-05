import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:pascaldart/src/common/model/currency.dart';
import 'package:pascaldart/src/json_rpc/model/request/base_request.dart';

part 'findaccounts_request.g.dart';

@JsonSerializable()
class FindAccountsRequest extends BaseRequest {
  @JsonKey(name: 'params')
  Map<String, dynamic> params;

  @JsonKey(ignore: true)
  get name {
    return params['name'];
  }

  @JsonKey(ignore: true)
  get type {
    return params['type'];
  }

  @JsonKey(ignore: true)
  get start {
    return params['start'];
  }

  @JsonKey(ignore: true)
  get max {
    return params['max'];
  }

  @JsonKey(ignore: true)
  get exact {
    return params['exact'];
  }

  @JsonKey(ignore: true)
  get minBalance {
    return params['min_balance'] != null ? Currency.fromMolina(params['min_balance']) : null;
  }

  @JsonKey(ignore: true)
  get maxBalance {
    return params['max_balance'] != null ? Currency.fromMolina(params['max_balance']) : null;
  }

  @JsonKey(ignore: true)
  get encPubkey {
    return params['enc_pubkey'];
  }

  @JsonKey(ignore: true)
  get b58Pubkey {
    return params['b58_pubkey'];
  }

  FindAccountsRequest({
    String name,
    int type,
    int start,
    int max,
    bool exact,
    Currency minBalance,
    Currency maxBalance,
    String encPubkey,
    String b58Pubkey
  }) : super(method: 'findaccounts') {
    this.params = Map();
    if (name != null) {
      this.params['name'] = name;
    }
    if (type != null) {
      this.params['type'] = type;
    }
    if (start != null) {
      this.params['start'] = start;
    }
    if (max != null) {
      this.params['max'] = max;
    }
    if (exact != null) {
      this.params['exact'] = exact;
    }
    if (minBalance != null) {
      this.params['min_balance'] = minBalance.toMolina();
    }
    if (maxBalance != null) {
      this.params['max_balance'] = maxBalance.toMolina();
    }
    if (encPubkey != null) {
      this.params['enc_pubkey'] = encPubkey;
    }
    if (b58Pubkey != null) {
      this.params['b58_pubkey'] = b58Pubkey;
    }
  }

  Map<String, dynamic> toJson() => _$FindAccountsRequestToJson(this); 
}