// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:jenos/scr/core/util/enums.dart';

/// This class defines the WalletState
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19
///

class WalletState {
  final String? selectedCustomer;
  final NetworkState loadState;
  final requestData;
  final String? message;
   String? paymentMethod;
   String? paymentType;

  /// Constructs a [WalletState] instance.
  WalletState({
    this.selectedCustomer,
    this.paymentMethod,
    this.paymentType,
    required this.loadState,
    required this.requestData,
    required this.message,
  });

  factory WalletState.initial() {
    return WalletState(
      selectedCustomer: "",
      requestData: [],
      loadState: NetworkState.idle,
      message: null,
      paymentType: "Pay on delivery",
      paymentMethod: "POS/Bank transfer",
    );
  }

  WalletState copyWith({
    String? selectedCustomer,
    NetworkState? loadState,
    requestData,
    String? message,
    String? paymentMethod,
    String? paymentType,
  }) {
    return WalletState(
      selectedCustomer: selectedCustomer ?? this.selectedCustomer,
      loadState: loadState ?? this.loadState,
      requestData: requestData ?? this.requestData,
      message: message ?? this.message,
      paymentType: paymentType ?? this.paymentType,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}
