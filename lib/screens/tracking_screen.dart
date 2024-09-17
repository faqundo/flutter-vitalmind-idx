import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class TrackingScreen extends StatefulWidget {
  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  late GoogleMapController _mapController;
  Location _location = Location();
  LatLng _initialPosition = LatLng(39.4699, -0.3763); // Valencia, España
  bool _isMapInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    if (!kIsWeb) {
      // Para móvil: Obtén la ubicación actual.
      await _getCurrentLocation();
    } else {
      // Para la web: Configuración específica (si se requiere).
      setState(() {
        _isMapInitialized = true;
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    // Revisa si el servicio de ubicación está habilitado.
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Verifica permisos.
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Obtiene la ubicación actual.
    LocationData locationData = await _location.getLocation();
    setState(() {
      _initialPosition = LatLng(
          locationData.latitude ?? 39.4699, locationData.longitude ?? -0.3763);
      _isMapInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tracking'),
      ),
      body: _isMapInitialized
          ? GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
                if (!kIsWeb) {
                  // Centrar el mapa en la ubicación actual para móvil.
                  _mapController.moveCamera(
                    CameraUpdate.newLatLng(_initialPosition),
                  );
                }
              },
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 15.0,
              ),
              myLocationEnabled:
                  !kIsWeb, // Habilitar ubicación en móvil, no en web.
              myLocationButtonEnabled:
                  !kIsWeb, // Habilitar botón de ubicación en móvil, no en web.
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
