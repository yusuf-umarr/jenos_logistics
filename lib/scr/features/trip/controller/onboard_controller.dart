/// This class defines the TripController
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19
///

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jenos/scr/core/enums.dart';
import 'package:jenos/scr/features/trip/controller/onboard_state.dart';

/// Controller class for managing the navigation bar state.
class TripController extends StateNotifier<TripState> {
  TripController() : super(TripState.initial());

  // void setAccountType(AccountType type) {
  //   state = state.copyWith(accountType: type);

  //   print("state:${state.accountType}");
  // }

  getCurrentLocation() async {
    print("location called");
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();

    state = state.copyWith(position: position);

    print("position:${state.position}");
    // _currentPosition = position;

    // print("------currentPosition ${_currentPosition!.latitude.toString()}");

    // GoogleMapController googleMapController = await _controller.future;

    // Future.delayed(const Duration(milliseconds: 100), () {
    //   googleMapController.animateCamera(
    //     CameraUpdate.newCameraPosition(
    //       CameraPosition(
    //         zoom: 13.5,
    //         target: LatLng(
    //           position.latitude,
    //           position.longitude,
    //         ),
    //       ),
    //     ),
    //   );
    // });
  }
//
}

/// Provider for accessing the [TripController] instance.
final tripController =
    StateNotifierProvider<TripController, TripState>((ref) => TripController());
