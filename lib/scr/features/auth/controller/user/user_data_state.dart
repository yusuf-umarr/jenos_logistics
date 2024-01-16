import 'package:jenos/scr/core/enums.dart';
import 'package:jenos/scr/features/auth/models/user_model.dart';

/// This class defines the UserDataState
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-07-19 
/// 


/// Represents the state of user data.
class UserDataState {
  /// The network state of the user data.
  final NetworkState loadState;

  /// The user model containing user data.
  final UserModel userModel;

  /// A message related to the user data state.
  final String? message;

  /// The visibility flag for user data.
  final bool visibility;

  /// The OneSignal ID associated with the user.
  final String? oneSignalId;

  UserDataState({
    required this.loadState,
    required this.userModel,
    required this.message,
    required this.visibility,
    this.oneSignalId,
  });

  /// Factory method to create the initial user data state.
  factory UserDataState.initial() {
    return UserDataState(
      userModel: UserModel(
        name: "",
        email: "",
        password: "",
        id: "",
        v: 0,
      ),
      loadState: NetworkState.idle,
      message: null,
      visibility: true,
      oneSignalId: "",
    );
  }

  /// Method to create a new UserDataState by copying the current state and applying changes to specified properties.
  UserDataState copyWith({
    NetworkState? loadState,
    UserModel? userModel,
    String? message,
    bool? visibility,
    String? oneSignalId,
  }) {
    return UserDataState(
      loadState: loadState ?? this.loadState,
      userModel: userModel ?? this.userModel,
      message: message ?? this.message,
      visibility: visibility ?? this.visibility,
      oneSignalId: oneSignalId ?? this.oneSignalId,
    );
  }
}
