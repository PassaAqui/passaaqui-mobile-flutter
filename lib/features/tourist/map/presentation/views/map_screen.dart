import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:passaaqui_mobile_flutter/features/tourist/map/presentation/widgets/map_header.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final String mapStyleUrl;

  MapLibreMapController? mapController;

  @override
  void initState() {
    super.initState();

    final mapTilerKey = dotenv.env['MAPTILER_API_KEY'];

    if (mapTilerKey == null || mapTilerKey.isEmpty) {
      throw StateError("MapTiler API Key was not configured.");
    }

    mapStyleUrl =
        "https://api.maptiler.com/maps/01a08c63-b260-733f-8081-77da900e16c0/style.json?key=$mapTilerKey";
  }

  Future<void> _addTouristLocationMarker() async {
    if (mapController == null) return;

    final ByteData touristMarker = await rootBundle.load(
      'assets/images/tourist/map/tourist-marker.png',
    );

    await mapController?.addImage(
      'tourist-marker',
      touristMarker.buffer.asUint8List(),
    );

    await mapController?.addSymbol(
      const SymbolOptions(
        geometry: LatLng(-8.0675, -34.9167), // Centro de Recife)
        iconImage: 'tourist-marker',
        iconSize: 1.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarContrastEnforced: false,
      ),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: MapHeader(userName: "Nome do usuario", xpAmount: 0),
        ),
        body: MapLibreMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(-8.0675, -34.9167), // Centro de Recife
            zoom: 17,
            tilt: 60,
          ),
          styleString: mapStyleUrl,
          myLocationEnabled: true,
          myLocationTrackingMode: MyLocationTrackingMode.none,

          onMapCreated: (controller) {
            mapController = controller;
          },

          onStyleLoadedCallback: () {
            _addTouristLocationMarker();
          },
        ),
      ),
    );
  }
}
