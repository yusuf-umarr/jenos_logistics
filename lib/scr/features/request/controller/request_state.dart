// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:jenos/scr/core/util/enums.dart';

/// This class defines the RequestState
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19
///

class RequestState {
  final String? selectedCustomer;
  final NetworkState loadState;
  final requestData;
  final String? message;
   String? paymentMethod;
   String? paymentType;

  /// Constructs a [RequestState] instance.
  RequestState({
    this.selectedCustomer,
    this.paymentMethod,
    this.paymentType,
    required this.loadState,
    required this.requestData,
    required this.message,
  });

  factory RequestState.initial() {
    return RequestState(
      selectedCustomer: "",
      requestData: [],
      loadState: NetworkState.idle,
      message: null,
      paymentType: "Pay on delivery",
      paymentMethod: "POS/Bank transfer",
    );
  }

  RequestState copyWith({
    String? selectedCustomer,
    NetworkState? loadState,
    requestData,
    String? message,
    String? paymentMethod,
    String? paymentType,
  }) {
    return RequestState(
      selectedCustomer: selectedCustomer ?? this.selectedCustomer,
      loadState: loadState ?? this.loadState,
      requestData: requestData ?? this.requestData,
      message: message ?? this.message,
      paymentType: paymentType ?? this.paymentType,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}
