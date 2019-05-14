import 'package:pascaldart/src/common/types/Currency.dart';

/// Gets information about forks and features.
class PascalCoinInfo {

  static Currency MIN_FEE() {
    return Currency.fromMolina('1');
  }

  /// Gets the block number when 50% inflation reduction was introduced.
  static const int PIP_0010 = 210240;
  static const int INFLATION_REDUCTION = PIP_0010;

  /// Gets a value indicating whether the given block has inflation reduction
  /// activated (PIP-10).
  static bool isInflationReduction(int block) {
    return block >= PascalCoinInfo.INFLATION_REDUCTION;
  }

  /// Gets the block number when RandomHash was activated.
  static const int PIP_0009 = 260000;
  static const int RANDOM_HASH = PIP_0009;

  /// Gets a value indicating if randomhash was active at the given block.
  static bool isRandomHash(int block) {
    return block >= PascalCoinInfo.RANDOM_HASH;
  }

  /// Gets the block number when developer reward was introduced.
  static const int PIP_0011 = 210000;
  static const int DEVELOPER_REWARD = PIP_0011;

  /// Gets a value indicating if developer reward was active at the given block.
  static bool isDeveloperReward(int block) {
    return block >= PascalCoinInfo.DEVELOPER_REWARD;
  }
}