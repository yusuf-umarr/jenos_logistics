import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/core/repository/request_repository.dart';
import 'package:jenos/scr/core/util/enums.dart';
import 'package:jenos/scr/features/request/controller/request_state.dart';

class RequestController extends StateNotifier<RequestState> {
  RequestController(this.requestRepository) : super(RequestState.initial());

  final RequestRepository requestRepository;

  void setSelectedCustomer(String name) {
    state = state.copyWith(selectedCustomer: name);
  }

  filteredRequest(data) {
    List result = [];

    for (var element in data) {
      if (element['createdBy'] != null) {
        result.add(element);
      }
    }

    return result;
  }

  Future<void> updateRequest(
    String request,
    String requestId,
    context,
  ) async {
    state = state.copyWith(
      loadState: NetworkState.loading,
    );
    try {
      // Future.delayed(Duration(seconds: 3), () {
      //   state = state.copyWith(
      //     loadState: NetworkState.success,
      //     message: "request accepted!",
      //   );
      // });

      final response =
          await requestRepository.updateRequest(request, requestId);

      if (response.success) {
        state = state.copyWith(
          loadState: NetworkState.success,
          message: response.message,
        );
        log("success response ${response.data}");

        Future.delayed(Duration(seconds: 4), () {
          state = state.copyWith(
            loadState: NetworkState.idle,
          );
        });

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

  Future getRiderRequest() async {
    try {
      final response = await requestRepository.getRiderRequest();

      if (response.success) {
        state = state.copyWith(
          requestData: filteredRequest(response.data),
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

  Future<void> updatePayMethod({String? method}) async {
    state = state.copyWith(
      paymentMethod: method,
    );
  }

  Future<void> updatePayType({String? type}) async {
    state = state.copyWith(
      paymentType: type,
    );
  }

  Future<void> cleardata() async {
    state = state.copyWith(
      paymentType: state.paymentType = null,
      paymentMethod: state.paymentMethod = null,
    );
  }
}

final requestController =
    StateNotifierProvider<RequestController, RequestState>(
        (ref) => RequestController(ref.read(requestRepository)));
