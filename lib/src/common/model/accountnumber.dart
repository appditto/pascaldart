import 'package:quiver/core.dart'; 
import 'package:pascaldart/src/common/pascalcoin_info.dart';

/// A simple type that holds an account number in a reliable way.
class AccountNumber {
  int account; // Account number
  int checksum; // Account checksum
  int createdInBlock; // Block this account was created in
  bool isFoundationReward; // Whether or not PC foundation got this account initially

  void calcBlockInfo() {
    this.createdInBlock = (this.account / 5).floor();
    this.isFoundationReward = PascalCoinInfo.isDeveloperReward(this.createdInBlock) && this.account % 5 == 4;
  }

  AccountNumber(String account) {
    // Parse account/checksum if present, simply account otherwise
    if (account.contains('-')) {
      List<String> accountParts = account.split('-');
      this.account = int.parse(accountParts[0]);
      this.checksum = int.parse(accountParts[1]);
      int expectedChecksum = AccountNumber.calculateChecksum(this.account);
      if (expectedChecksum != this.checksum) {
        throw Exception('Invalid account checksum account: ${this.account}, expected: $expectedChecksum, actual: ${this.checksum}');
      }
    } else {
      this.account = int.parse(account);
      this.checksum = AccountNumber.calculateChecksum(this.account);
    }
    calcBlockInfo();
  }

  AccountNumber.fromInt(int account) {
    this.account = account;
    this.checksum = AccountNumber.calculateChecksum(this.account);
    calcBlockInfo();
  }

  @override
  String toString() {
    return '${this.account}-${this.checksum}';
  }

  /// Calculates the checksum for the given account number.
  static int calculateChecksum(int account) {
    return ((account * 101) % 89) + 10;
  }

  /// Operator overrides
  bool operator == (o) => (o != null && o.hashCode == hashCode);
  int get hashCode => hash2(account.hashCode, checksum.hashCode);
}