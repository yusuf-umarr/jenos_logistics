// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:geolocator/geolocator.dart';
import 'package:jenos/scr/core/util/enums.dart';

/// This class defines the TripState
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19
///

class TripState {
  final Position? position;
  final List tripsData;
  final NetworkState? loadState;
  final String? message;

  /// Constructs a [TripState] instance.
  TripState({
    this.position,
    required this.tripsData,
    this.loadState,
    this.message,
  });

  /// Constructs an initial [TripState] with default values.
  factory TripState.initial() {
    return TripState(
      tripsData: [],
      loadState: NetworkState.idle,
      message: null,
    );
  }

  TripState copyWith({
    Position? position,
    NetworkState? loadState,
    List? tripsData,
    String? message,
  }) {
    return TripState(
      position: position ?? this.position,
      tripsData: tripsData ?? this.tripsData,
      loadState: loadState ?? this.loadState,
      message: message ?? this.message,
    );
  }
}