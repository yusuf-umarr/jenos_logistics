import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jenos/config/config.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/features/trip/controller/onboard_controller.dart';
// import 'package:location/location.dart';

class TripRoutePage extends ConsumerStatefulWidget {
  const TripRoutePage({super.key});

  @override
  ConsumerState<TripRoutePage> createState() => _TripRoutePageState();
}

class _TripRoutePageState extends ConsumerState<TripRoutePage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const LatLng sourceLocation =
      LatLng(37.42796133580664, -122.085749655962);

  static const LatLng destinationLocation =
      LatLng(37.43296265331129, -122.08832357078792);

  // Position? currentPosition;

  List<LatLng> polylineCoordinates = [];
  // LocationData? currentLocation;

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void showCameraPosition() async {
    Position position = await Geolocator.getCurrentPosition();
    position = ref.read(tripController).position!;

    print("new position:$position");

    GoogleMapController googleMapController = await _controller.future;

    Future.delayed(const Duration(milliseconds: 100), () {
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 13.5,
            target: LatLng(
              position.latitude,
              position.longitude,
            ),
          ),
        ),
      );
    });
  }

  void getCurrentLocation() async {
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
    // currentPosition = position;

    // print("------currentPosition ${currentPosition!.latitude.toString()}");

    GoogleMapController googleMapController = await _controller.future;

    Future.delayed(const Duration(milliseconds: 100), () {
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 13.5,
            target: LatLng(
              position.latitude,
              position.longitude,
            ),
          ),
        ),
      );
    });
  }
// //
  // void getCurrentLocation() async {
  //   Location location = Location();

  //   location.getLocation().then((location) {
  //     currentLocation = location;

  //     // setState(() {});
  //   });

  //   GoogleMapController googleMapController = await _controller.future;

  //   location.onLocationChanged.listen((newLoc) {
  //     currentLocation = newLoc;

  //     googleMapController.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(
  //           zoom: 13.5,
  //           target: LatLng(
  //             newLoc.latitude!,
  //             newLoc.longitude!,
  //           ),
  //         ),
  //       ),
  //     );
  //   });
  // }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(
        sourceLocation.latitude,
        sourceLocation.longitude,
      ),
      PointLatLng(
        destinationLocation.latitude,
        destinationLocation.longitude,
      ),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(
            point.latitude,
            point.longitude,
          ),
        ),
      );
      setState(() {});
    }
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/icons/sourceIcon.png")
        .then((icon) {
      sourceIcon = icon;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/icons/destinationIcon.png")
        .then((icon) {
      destinationIcon = icon;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/profileImage.png")
        .then((icon) {
      currentLocationIcon = icon;
    });
  }

  @override
  void initState() {
    // getCurrentLocation();
    // _getCurrentPosition();
    setCustomMarkerIcon();
    showCameraPosition();
    getPolyPoints();
    super.initState();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print("currentPosition:$currentPosition");

    // polylines.add(poly);

    final currentPosition = ref.watch(tripController).position;
    return Scaffold(
      appBar: CustomWidget.customAppbar(context,
          title: "Trip route", isArrow: true),
      body: currentPosition == null
          ? const Text("Loading")
          : GoogleMap(
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentPosition!.latitude!, currentPosition!.longitude!),
                zoom: 13.5,
              ),
              polylines: {
                Polyline(
                    polylineId: const PolylineId("route"),
                    points: polylineCoordinates,
                    color: Colors.blue,
                    width: 5)
              },
              markers: {
                Marker(
                    markerId: const MarkerId("cureentLocation"),
                    icon: currentLocationIcon,
                    position: LatLng(currentPosition!.latitude!,
                        currentPosition!.longitude!)),
                Marker(
                  markerId: const MarkerId("source"),
                  position: sourceLocation,
                  icon: sourceIcon,
                ),
                Marker(
                    markerId: const MarkerId("destination"),
                    position: destinationLocation,
                    icon: destinationIcon),
              },
              onMapCreated: (mapController) {
                _controller.complete(mapController);
              },
            ),
    );
  }
}
