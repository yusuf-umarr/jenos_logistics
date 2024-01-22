/// This class defines the PasswordNotifier
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19
///
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/features/auth/controller/password_visibility/password_state.dart';

/// Notifier class for managing the password visibility state.
class PasswordNotifier extends StateNotifier<PasswordState> {
  PasswordNotifier() : super(PasswordState.initial());

  /// Toggles the password visibility state.
  void togglePasswordVisibility() {
    state = state.copyWith(
      visibility: !state.visibility,
    );
  }

  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(
      confirmVisibility: !state.confirmVisibility,
    );
  }
}

/// Provider for the PasswordNotifier and PasswordState.
final passwordNotifier = StateNotifierProvider<PasswordNotifier, PasswordState>(
  (ref) => PasswordNotifier(),
);
