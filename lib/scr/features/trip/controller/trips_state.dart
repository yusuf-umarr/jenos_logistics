// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:jenos/scr/core/util/enums.dart';

/// This class defines the TripState
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19
///

class TripState {
   List tripsData;
  final NetworkState? loadState;
  final String? message;
  final Map<String, dynamic> riderAnalysis;

  /// Constructs a [TripState] instance.
  TripState({
    required this.tripsData,
    required this.riderAnalysis,
    this.loadState,
    this.message,
  });

  /// Constructs an initial [TripState] with default values.
  factory TripState.initial() {
    return TripState(
      tripsData: [],
      loadState: NetworkState.idle,
      message: null,
      riderAnalysis: {},
    );
  }

  TripState copyWith({
    NetworkState? loadState,
    List? tripsData,
    String? message,
    Map<String, dynamic>? riderAnalysis,
  }) {
    return TripState(
      tripsData: tripsData ?? this.tripsData,
      loadState: loadState ?? this.loadState,
      message: message ?? this.message,
      riderAnalysis: riderAnalysis ?? this.riderAnalysis,
    );
  }
}
