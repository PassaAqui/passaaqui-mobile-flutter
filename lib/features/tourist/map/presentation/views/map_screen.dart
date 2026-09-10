import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passaaqui_mobile_flutter/features/tourist/map/presentation/widgets/map_header.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarContrastEnforced: false,
      ),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 65,
          title: MapHeader(userName: "Nome do usuario", xpAmount: 0),
        ),
      ),
    );
  }
}
