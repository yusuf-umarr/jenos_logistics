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
    int selectedIndex;

    bool isEndtripLoading =false;


  /// Constructs a [TripState] instance.
  TripState({
    required this.tripsData,
    required this.riderAnalysis,
    this.loadState,
    this.message,
   required this.selectedIndex,
   required this.isEndtripLoading,
  });

  /// Constructs an initial [TripState] with default values.
  factory TripState.initial() {
    return TripState(
      tripsData: [],
      loadState: NetworkState.idle,
      message: null,
      riderAnalysis: {},
      selectedIndex: 0,
      isEndtripLoading: false,
    );
  }

  TripState copyWith({
    NetworkState? loadState,
    List? tripsData,
    String? message,
    int? selectedIndex,
    bool? isEndtripLoading,
    Map<String, dynamic>? riderAnalysis,
  }) {
    return TripState(
      tripsData: tripsData ?? this.tripsData,
      loadState: loadState ?? this.loadState,
      message: message ?? this.message,
      riderAnalysis: riderAnalysis ?? this.riderAnalysis,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isEndtripLoading: isEndtripLoading ?? this.isEndtripLoading,
    );
  }
}
