// import 'package:jenos/scr/core/util/enums.dart';
// import 'package:jenos/scr/core/models/user_merchant_model.dart';

// /// This class defines the UserDataState
// /// @author  Yusuf umar
// /// @version 1.0
// /// @since   2023-12-19
// ///

// /// Represents the state of user data.
// class UserDataState {
//   /// The network state of the user data.
//   final NetworkState loadState;

//   /// The user model containing user data.
//   final userData;

//   /// A message related to the user data state.
//   final String? message;

//   UserDataState({
//     required this.loadState,
//     required this.message,
//     required this.userData,
//   });

//   /// Factory method to create the initial user data state.
//   factory UserDataState.initial() {
//     return UserDataState(
//         loadState: NetworkState.idle, message: null, userData: null);
//   }

//   /// Method to create a new UserDataState by copying the current state and applying changes to specified properties.
//   UserDataState copyWith({NetworkState? loadState, String? message, userData}) {
//     return UserDataState(
//       loadState: loadState ?? this.loadState,
//       message: message ?? this.message,
//       userData: userData ?? this.userData,
//     );
//   }
// }
