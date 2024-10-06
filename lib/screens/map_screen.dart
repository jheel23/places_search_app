import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_search_app/providers/location_provider.dart';
import 'package:place_search_app/utils/functions.dart';

class MapScreen extends ConsumerStatefulWidget {
  final double lat;
  final double long;
  const MapScreen({super.key, required this.lat, required this.long});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  late LatLng currentLocation;
  MapType currentMapType = MapType.satellite;
  final Completer<GoogleMapController> mapController = Completer();
  @override
  void initState() {
    currentLocation = LatLng(widget.lat, widget.long);
    super.initState();
  }

  Future<void> _currentLocation() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator.adaptive(),
            ));
    await ref.read(locationProvider.notifier).getCurrentLocation();
    final location = ref.watch(locationProvider);
    currentLocation = LatLng(location.latitude, location.longitude);
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: currentLocation, zoom: 16),
      ),
    );
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    ref.watch(locationProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Location'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.layers),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: const Text('Normal'),
                onTap: () async {
                  setState(() {
                    currentMapType = MapType.normal;
                  });
                },
              ),
              PopupMenuItem(
                value: 2,
                child: const Text('Satellite'),
                onTap: () async {
                  setState(() {
                    currentMapType = MapType.satellite;
                  });
                },
              ),
              PopupMenuItem(
                value: 3,
                child: const Text('Terrain'),
                onTap: () async {
                  setState(() {
                    currentMapType = MapType.terrain;
                  });
                },
              )
            ],
          ),
        ],
      ),
      body: GoogleMap(
        mapType: currentMapType,
        onMapCreated: (GoogleMapController controller) {
          mapController.complete(controller);
        },
        initialCameraPosition:
            CameraPosition(target: currentLocation, zoom: 16),
        markers: {
          Marker(
            markerId: const MarkerId('current-location'),
            position: currentLocation,
            infoWindow: const InfoWindow(title: 'Your Location'),
          )
        },
      ),
      floatingActionButton: GestureDetector(
        onTap: _currentLocation,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: theme.colorScheme.secondary),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.location_history_rounded),
              addHorizontalSpace(10),
              const Text('Set Current Location')
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
