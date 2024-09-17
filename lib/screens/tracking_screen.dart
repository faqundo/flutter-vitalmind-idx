import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:math';

class TrackingScreen extends StatefulWidget {
  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  late GoogleMapController _mapController;
  Location _location = Location();
  LatLng _initialPosition = LatLng(39.4699, -0.3763); // Valencia, España
  List<LatLng> _routePoints =
      []; // Lista para almacenar las ubicaciones del recorrido
  double _totalDistance = 0.0; // Distancia total recorrida
  bool _isTracking = false; // Estado de seguimiento

  @override
  void initState() {
    super.initState();
    _initializeTracking();
  }

  Future<void> _initializeTracking() async {
    // Obtiene la ubicación actual al iniciar
    LocationData locationData = await _location.getLocation();
    _initialPosition =
        LatLng(locationData.latitude ?? 0.0, locationData.longitude ?? 0.0);
    _routePoints.add(_initialPosition);
    setState(() {});

    // Configura un listener para cambios de ubicación
    _location.onLocationChanged.listen((LocationData currentLocation) {
      if (_isTracking) {
        _addLocationPoint(currentLocation);
      }

      // Centra el mapa en la nueva ubicación
      _centerMap(currentLocation);
    });
  }

  void _addLocationPoint(LocationData locationData) {
    LatLng newPoint =
        LatLng(locationData.latitude ?? 0.0, locationData.longitude ?? 0.0);

    if (_routePoints.isNotEmpty) {
      // Calcula la distancia desde el último punto
      double distance = _calculateDistance(_routePoints.last, newPoint);
      _totalDistance += distance;
    }

    // Añade el nuevo punto a la lista
    setState(() {
      _routePoints.add(newPoint);
    });
  }

  void _centerMap(LocationData locationData) {
    LatLng newPoint =
        LatLng(locationData.latitude ?? 0.0, locationData.longitude ?? 0.0);
    _mapController.animateCamera(CameraUpdate.newLatLng(newPoint));
  }

  double _calculateDistance(LatLng start, LatLng end) {
    const double earthRadius = 6371000; // Radio de la Tierra en metros
    double dLat = _degreesToRadians(end.latitude - start.latitude);
    double dLon = _degreesToRadians(end.longitude - start.longitude);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(start.latitude)) *
            cos(_degreesToRadians(end.latitude)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c; // Distancia en metros

    return distance;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  void _toggleTracking() {
    setState(() {
      _isTracking = !_isTracking;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tracking'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
              // Centrar el mapa en la ubicación inicial al cargar
              _mapController
                  .animateCamera(CameraUpdate.newLatLng(_initialPosition));
            },
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 15.0,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            polylines: {
              Polyline(
                polylineId: PolylineId('route'),
                points: _routePoints,
                color: Colors.blue,
                width: 5,
              ),
            },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: _toggleTracking,
                  child: Text(_isTracking
                      ? 'Detener Seguimiento'
                      : 'Iniciar Seguimiento'),
                ),
                SizedBox(height: 10),
                Text(
                  'Distancia recorrida: ${(_totalDistance / 1000).toStringAsFixed(2)} km',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
