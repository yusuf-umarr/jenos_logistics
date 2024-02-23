import 'package:jenos/scr/core/util/enums.dart';
import 'package:jenos/scr/core/models/user_merchant_model.dart';

/// This class defines the SigninState
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19
///

/// Represents the state of the signin process.
class SigninState {
  /// The network state of the signin process.
  final NetworkState loadState; 

  /// The user model containing signin data.
  final dynamic userModel;

  /// uses to store message related to the signin state.
  final String? message;

  SigninState({
    required this.loadState,
    required this.userModel,
    required this.message,
  });

  /// Factory method to create the initial signin state.
  factory SigninState.initial() {
    return SigninState(
      userModel: null,
      loadState: NetworkState.idle,
      message: null,
    );
  }

  /// Method to create a new SigninState by copying the current state and applying changes to specified properties.
  SigninState copyWith({
    NetworkState? loadState,
    dynamic userModel,
    String? message,
  }) {
    return SigninState(
      loadState: loadState ?? this.loadState,
      userModel: userModel ?? this.userModel,
      message: message ?? this.message,
    );
  }
}
