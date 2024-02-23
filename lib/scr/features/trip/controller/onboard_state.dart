// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:geolocator/geolocator.dart';


/// This class defines the TripState
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19
///

class TripState {
  final Position? position;

  /// Constructs a [TripState] instance.
  TripState({
     this.position,
  });

  /// Constructs an initial [TripState] with default values.
  factory TripState.initial() {
    return TripState( );
  }


  TripState copyWith({
    Position? position,
  }) {
    return TripState(
      position: position ?? this.position,
    );
  }
}
