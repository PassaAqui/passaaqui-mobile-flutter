import 'package:flutter/material.dart';
import 'package:passaaqui_mobile_flutter/core/widgets/app_logo.dart';

class MapHeader extends StatelessWidget {
  final String userName;
  final int xpAmount;

  const MapHeader({super.key, required this.userName, required this.xpAmount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        spacing: 12,
        children: [
          AppLogo(width: 55, height: 55, borderRadius: 100),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(fontSize: 20, fontFamily: 'Itim'),
              ),
              Text(
                "$xpAmount XP",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Itim',
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
