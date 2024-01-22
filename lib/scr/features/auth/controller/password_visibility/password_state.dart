/// This class defines the PasswordNotifier
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19
///
///

/// Represents the state of the password visibility.
class PasswordState {
  /// The visibility flag for the password.
  final bool visibility;
  final bool confirmVisibility;

  PasswordState({
    required this.visibility,
    required this.confirmVisibility,
  });

  /// Factory method to create the initial password state.
  factory PasswordState.initial() {
    return PasswordState(visibility: true, confirmVisibility: true);
  }

  /// Method to create a new PasswordState by copying the current state and applying changes to specified properties.
  PasswordState copyWith({
    bool? visibility,
    bool? confirmVisibility,
  }) {
    return PasswordState(
      visibility: visibility ?? this.visibility,
      confirmVisibility: confirmVisibility ?? this.confirmVisibility,
    );
  }
}
