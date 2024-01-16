/// This class defines the UserDataNotifier
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-07-19 
/// 


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/core/enums.dart';
import 'package:jenos/scr/features/auth/controller/user/user_data_state.dart';
import 'package:jenos/scr/features/auth/repository/auth_repository.dart';

/// Notifier class for handling the user data state.
class UserDataNotifier extends StateNotifier<UserDataState> {
  UserDataNotifier(this.authRepository) : super(UserDataState.initial());

  final AuthRepository authRepository;

  /// Method to retrieve user data.
  Future<void> getUserData() async {
    try {
      final response = await authRepository.getUserData();

      if (response.success) {
        state = state.copyWith(
          userModel: response.data,
          loadState: NetworkState.success,
          message: response.message,
        );

        return;
      }
      state = state.copyWith(
        loadState: NetworkState.error,
        message: response.message,
      );
    } catch (e) {
      state = state.copyWith(
        loadState: NetworkState.error,
        message: e.toString(),
      );
    }
  }



 
}

/// Provider for the UserDataNotifier class.
final userDataNotifier = StateNotifierProvider<UserDataNotifier, UserDataState>(
    (ref) => UserDataNotifier(ref.read(authRepository)));
