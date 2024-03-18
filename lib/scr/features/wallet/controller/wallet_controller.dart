import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/core/repository/request_repository.dart';
import 'package:jenos/scr/core/repository/wallet_repository.dart';
import 'package:jenos/scr/core/util/enums.dart';
import 'package:jenos/scr/features/request/controller/request_state.dart';
import 'package:jenos/scr/features/wallet/controller/wallet_state.dart';

class WalletController extends StateNotifier<WalletState> {
  WalletController(this.walletRepository) : super(WalletState.initial());

  final WalletRepository walletRepository;

  void setSelectedCustomer(String name) {
    state = state.copyWith(selectedCustomer: name);
  }

  Future<void> withdrawFund(
    String bankName,
    int accountNumber,
    String accountName,
    String amount,
    context,
  ) async {
    state = state.copyWith(
      loadState: NetworkState.loading,
    );
    try {
     
      final response = await walletRepository.withdrawFund(
        bankName,
        accountNumber,
        accountName,
        amount,
      );

      if (response.success) {
        state = state.copyWith(
          loadState: NetworkState.success,
          message: response.message,
        );
        log("success response ${response.data}");

        // Future.delayed(Duration(seconds: 4), () {
        //   state = state.copyWith(
        //     loadState: NetworkState.idle,
        //   );
        // });

        return;
      }

      state = state.copyWith(
        loadState: NetworkState.error,
        // message: response.message,
      );
      log("account error ${response.data}");

      return;
    } catch (e) {
      state = state.copyWith(
        loadState: NetworkState.error,
        message: e.toString(),
      );
    }
  }

  //createdBy

  Future getWithdrawer() async {
    try {
      final response = await walletRepository.getWithdrawer();

      if (response.success) {
        state = state.copyWith(
          requestData: response.data,
          // message: response.message,
        );
        // log("get getRiderRequest success ${state.requestData}");

        return true;
      }

      state = state.copyWith(
        // loadState: NetworkState.error,
        message: response.message,
      );

      return false;
    } catch (e) {
      state = state.copyWith(
        // loadState: NetworkState.error,
        message: e.toString(),
      );
      return false;
    }
  }

  Future<void> cleardata() async {
    state = state.copyWith(
      paymentType: state.paymentType = null,
      paymentMethod: state.paymentMethod = null,
    );
  }
}

final walletController = StateNotifierProvider<WalletController, WalletState>(
    (ref) => WalletController(ref.read(walletRepository)));
