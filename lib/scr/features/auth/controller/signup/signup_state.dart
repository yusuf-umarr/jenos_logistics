
import 'package:jenos/scr/core/enums.dart';
import 'package:jenos/scr/features/auth/models/user_model.dart';

/// This class defines the SignupState
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-07-19 

/// Represents the state of the signup process.
class SignupState {
  /// The network state of the signup process.
  final NetworkState loadState;

  /// The user model containing signup data.
  final UserModel userModel;

  /// A message related to the signup state.
  final String? message;

  SignupState({
    required this.loadState,
    required this.userModel,
    required this.message,
  });

  /// Factory method to create the initial signup state.
  factory SignupState.initial() {
    return SignupState(
      userModel: UserModel(
        name: "",
        email: "",
        password: "",
        id: "",
        v: 0,
      ),
      loadState: NetworkState.idle,
      message: null,
    );
  }

  /// Method to create a new SignupState by copying the current state and applying changes to specified properties.
  SignupState copyWith({
    NetworkState? loadState,
    UserModel? userModel,
    String? message,
  }) {
    return SignupState(
      loadState: loadState ?? this.loadState,
      userModel: userModel ?? this.userModel,
      message: message ?? this.message,
    );
  }
}
