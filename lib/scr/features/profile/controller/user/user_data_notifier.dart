// /// This class defines the UserDataNotifier
// /// @author  Yusuf umar
// /// @version 1.0
// /// @since   2023-12-19
// ///

// import 'dart:developer';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:jenos/scr/core/util/enums.dart';
// import 'package:jenos/scr/features/profile/controller/user/user_data_state.dart';
// import 'package:jenos/scr/core/repository/profile_repository.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// /// Notifier class for handling the user data state.
// class UserDataNotifier extends StateNotifier<UserDataState> {
//   UserDataNotifier(this.profileRepository) : super(UserDataState.initial());

//   final ProfileRepository profileRepository;

//   /// Method to retrieve user data.
//   Future<void> getUserData() async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       final response = await profileRepository.getUserData();

//       if (response.success) {
//         Future.delayed(const Duration(seconds: 1), () {

//           state = state.copyWith(
//             // userModel: response.data,
//             loadState: NetworkState.success,
//             message: response.message,
//             userData: response.data,
//           );
//         });

//         // log("usr get caaled===${response.data['data']}=========");
//         // log("usr get 2===${state.mercnantData}=========");

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

// // Future getSingleMerchant(List data, String userId){
// //     var merchant;
// //     for (var ele in data) {
// //       if (userId == ele["_id"]) {
// //         log("user found ${ele}");

// //         merchant =ele;

// //       }

// //     }

// //     return merchant;

// //   }
// }

// /// Provider for the UserDataNotifier class.
// final userDataNotifier = StateNotifierProvider<UserDataNotifier, UserDataState>(
//     (ref) => UserDataNotifier(ref.read(profileRepository)));
