// /// This class defines the VerifyNotifier
// /// @author  Yusuf umar
// /// @version 1.0
// /// @since   2023-12-19 
// /// 


// import 'package:flutter_riverpod/flutter_riverpod.dart';

// /// Notifier class for managing the verification of OTP.
// class VerifyNotifier extends StateNotifier<VerifyOtpState> {
//   VerifyNotifier(this.authRepository) : super(VerifyOtpState.initial());

//   final AuthRepository authRepository;

//   /// Verifies the OTP with the provided OTP model.
//   Future<void> verifyOtp(OtpModel model) async {
//     try {
//       state = state.copyWith(
//         loadState: NetworkState.loading,
//       );
//       final response = await authRepository.verifyOtp(model);
//       if (response.success) {
//         state = state.copyWith(
//           userModel: response.data,
//           loadState: NetworkState.success,
//           message: "Done",
//         );
//         return;
//       }
//       state = state.copyWith(
//         loadState: NetworkState.error,
//         message: response.message,
//       );
//     } catch (e) {
//       state = state.copyWith(
//         loadState: NetworkState.error,
//         message: e.toString(),
//       );
//     }
//   }

//   /// Resends the OTP for the provided email.
//   Future<void> resendOTP(String email) async {
//     await authRepository.resendOtp(email);
//   }
// }

// /// Provider for the VerifyNotifier and VerifyOtpState.
// final verifyOtpNotifier = StateNotifierProvider<VerifyNotifier, VerifyOtpState>(
//   (ref) => VerifyNotifier(ref.read(authRepository)),
// );
