// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:jenos/scr/core/util/enums.dart';

/// This class defines the OnboardState
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19
///

class OnboardState {
  final AccountType accountType;

  /// Constructs a [OnboardState] instance.
  OnboardState({
    required this.accountType,
  });

  /// Constructs an initial [OnboardState] with default values.
  factory OnboardState.initial() {
    return OnboardState(accountType: AccountType.individual);
  }



  OnboardState copyWith({
    AccountType? accountType,
  }) {
    return OnboardState(
      accountType: accountType ?? this.accountType,
    );
  }
}
