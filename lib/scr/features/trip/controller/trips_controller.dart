/// This class defines the TripController
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19
///

import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jenos/scr/core/repository/trips_repository.dart';
import 'package:jenos/scr/features/trip/controller/trips_state.dart';

/// Controller class for managing the navigation bar state.
class TripController extends StateNotifier<TripState> {
  TripController(this.tripsRepository) : super(TripState.initial());

  final TripsRepository tripsRepository;

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

  Future getTrips() async {
    try {
      final response = await tripsRepository.getTrips();

      if (response.success) {
        state = state.copyWith(
          tripsData: response.data,
          // message: response.message,
        );
        // log("get getTrips() success ${state.tripsData}");

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
    }
    return false;
  }

//
  Future getRiderAnalysis() async {
    try {
      final response = await tripsRepository.getRiderAnalysis();

      if (response.success) {
        state = state.copyWith(
          riderAnalysis: response.data,
          // message: response.message,
        );
        log("get getRiderAnalysis() success ${state.riderAnalysis}");

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

//
}

/// Provider for accessing the [TripController] instance.
final tripController = StateNotifierProvider<TripController, TripState>(
    (ref) => TripController(ref.read(tripsRepository)));

//  (ref) => RequestNotifier(ref.read(requestRepository)