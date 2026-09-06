import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:passaaqui_mobile_flutter/core/widgets/app_logo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarContrastEnforced: false,
      ),
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/home/background/background.webp",
                fit: BoxFit.cover,
              ),
            ),

            Positioned.fill(
              child: Container(color: Colors.black.withValues(alpha: 0.4)),
            ),

            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 500),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppLogo(
                                  width: 130,
                                  height: 130,
                                  borderRadius: 100,
                                ),
                                SizedBox(height: 12),
                                Text(
                                  "PassaAqui",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 50,
                                    fontFamily: 'IrishGrover',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 6),
                                Text(
                                  "Transforme a cidade em uma\naventura",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'IrishGrover',
                                  ),
                                ),

                                SizedBox(height: 48),

                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    foregroundColor: Colors.white,
                                    minimumSize: const Size(
                                      double.infinity,
                                      55,
                                    ),
                                    side: BorderSide(
                                      width: 2,
                                      color: Color(0xFFEAAA6A),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "Continuar como aventureiro",
                                    style: TextStyle(
                                      fontFamily: 'Itim',
                                      fontSize: 15,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 36.0,
                                  ),
                                  child: Row(
                                    spacing: 10,
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          thickness: 1,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Ou",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Itim",
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          thickness: 1,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    minimumSize: const Size(
                                      double.infinity,
                                      55,
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "Continuar como comerciante",
                                    style: TextStyle(
                                      fontFamily: 'Itim',
                                      fontSize: 15,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
