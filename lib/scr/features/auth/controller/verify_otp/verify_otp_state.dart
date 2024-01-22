// /// This class defines the VerifyOtpState
// /// @author  Yusuf umar
// /// @version 1.0
// /// @since   2023-12-19 
// /// 


// /// Represents the state of OTP verification.
// class VerifyOtpState {
//   final NetworkState loadState;
//   final UserModel userModel;
//   final String? message;

//   VerifyOtpState({
//     required this.loadState,
//     required this.userModel,
//     required this.message,
//   });

//   /// Creates an initial state for OTP verification.
//   factory VerifyOtpState.initial() {
//     return VerifyOtpState(
//       userModel: UserModel(
//         name: "",
//         email: "",
//         password: "",
//         isVerified: false,
//         id: "",
//         v: 0,
//       ),
//       loadState: NetworkState.idle,
//       message: null,
//     );
//   }

//   /// Creates a new state by copying the existing state and modifying its properties.
//   VerifyOtpState copyWith({
//     NetworkState? loadState,
//     UserModel? userModel,
//     String? message,
//   }) {
//     return VerifyOtpState(
//       loadState: loadState ?? this.loadState,
//       userModel: userModel ?? this.userModel,
//       message: message ?? this.message,
//     );
//   }
// }
