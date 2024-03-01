import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/core/repository/request_repository.dart';
import 'package:jenos/scr/core/util/enums.dart';
import 'package:jenos/scr/features/request/controller/request_state.dart';

class RequestNotifier extends StateNotifier<RequestState> {
  RequestNotifier(this.requestRepository) : super(RequestState.initial());

  final RequestRepository requestRepository;

  void setSelectedCustomer(String name) {
    state = state.copyWith(selectedCustomer: name);
  }

//this request is used for both merchant(customer-request) and Customer-request
  Future<void> addCustomerRequest(
    String receiverName,
    String phone,
    String deliveryAddress,
    String pickUpDate,
    String pickUpTime,
    String paymentMethod,
    String paymentType,
    String senderName,
    itemImage,
    String customerId,
    String userType,
    context,
  ) async {
    state = state.copyWith(
      loadState: NetworkState.loading,
    );
    try {
      final response = await requestRepository.acceptRequest(
        receiverName,
        phone,
        deliveryAddress,
        pickUpDate,
        pickUpTime,
        paymentMethod,
        paymentType,
        senderName,
        itemImage,
        customerId,
        userType,
      );

      if (response.success) {
        state = state.copyWith(
          loadState: NetworkState.success,
          message: response.message,
        );

        return;
      }

      state = state.copyWith(
        loadState: NetworkState.error,
        message: response.message,
      );
      // log("account error ${response.data}");

      return;
    } catch (e) {
      state = state.copyWith(
        loadState: NetworkState.error,
        message: e.toString(),
      );
    }
  }

  Future getRiderRequest() async {
    try {
      final response = await requestRepository.getRiderRequest();

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

final requestNotifier = StateNotifierProvider<RequestNotifier, RequestState>(
    (ref) => RequestNotifier(ref.read(requestRepository)
    )
    );
