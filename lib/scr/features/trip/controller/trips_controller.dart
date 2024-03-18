/// This class defines the TripController
/// @author  Yusuf umar
/// @version 1.0
/// @since   2023-12-19
///

import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/core/repository/trips_repository.dart';
import 'package:jenos/scr/core/util/enums.dart';
import 'package:jenos/scr/core/util/util.dart';
import 'package:jenos/scr/features/trip/controller/trips_state.dart';

class TripController extends StateNotifier<TripState> {
  TripController(this.tripsRepository) : super(TripState.initial());

  final TripsRepository tripsRepository;

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
  Future startTrip(String tripId, context) async {
    state = state.copyWith(
      loadState: NetworkState.loading,
    );
    try {
      final response = await tripsRepository.startTrip(tripId);

      if (response.success) {
        state = state.copyWith(
          tripsData: response.data,
          // message: response.message,
          loadState: NetworkState.success,
        );
        log("start trip ${state.tripsData}");
        Util.showSnackBar(context, "Trip started");
        getTrips();

        return true;
      }

      state = state.copyWith(
        loadState: NetworkState.error,
        message: response.message,
      );

      return false;
    } catch (e) {
      state = state.copyWith(
        loadState: NetworkState.error,
        message: e.toString(),
      );
    }
    return false;
  }

//
//
  Future updateRiderAvailability(String update, context) async {
    state = state.copyWith(
      loadState: NetworkState.loading,
    );
    try {
      final response = await tripsRepository.updateRiderAvailability(update);

      if (response.success) {
        state = state.copyWith(
          loadState: NetworkState.success,
        );
        log("rider availability : ${state.message}");
        Util.showSnackBar(context, "Availability updated");

        return true;
      }

      state = state.copyWith(
        loadState: NetworkState.error,
        message: response.message,
      );

      return false;
    } catch (e) {
      state = state.copyWith(
        loadState: NetworkState.error,
        message: e.toString(),
      );
    }
    return false;
  }

//
  Future endTrip(String tripId, String otp, context) async {
    state = state.copyWith(
      loadState: NetworkState.loading,
    );
    try {
      final response = await tripsRepository.endTrip(tripId, otp);

      if (response.success) {
        state = state.copyWith(
          loadState: NetworkState.success,

          tripsData: response.data,
          // message: response.message,
        );
        log("end trip ${state.tripsData}");
        Util.showSnackBar(context, "Trip ended");
        // getTrips();

        return true;
      }

      log("end trip response ${response.data}");
      log("end trip message ${response.message}");

      state = state.copyWith(
        loadState: NetworkState.error,
        message: response.message,
      );

      return false;
    } catch (e) {
      state = state.copyWith(
        loadState: NetworkState.error,
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
        // log("get getRiderAnalysis() success ${state.riderAnalysis}");

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

  void clearData() {
    state = state.copyWith(tripsData: state.tripsData = []);
  }

//
}

/// Provider for accessing the [TripController] instance.
final tripController = StateNotifierProvider<TripController, TripState>(
    (ref) => TripController(ref.read(tripsRepository)));
