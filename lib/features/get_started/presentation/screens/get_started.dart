import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:wallpaper_app/core/constants/app_constants.dart';
import 'package:wallpaper_app/core/routes/app_router_constants.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    List randomImage = [
      AppConstants.getStarted1,
      AppConstants.getStarted2,
      AppConstants.getStarted3,
    ]..shuffle();
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(30),
        child: Column(
          spacing: 25,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 4),
            SizedBox(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    left: 30,
                    bottom: 20,
                    child: Transform.rotate(
                      angle: -13 * pi / 180,
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(20),
                        child: Image.asset(
                          width: 200,
                          randomImage[2],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    right: 30,
                    bottom: 20,
                    child: Transform.rotate(
                      angle: 13 * pi / 180,
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(20),
                        child: Image.asset(
                          width: 200,

                          randomImage[0],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(20),
                    child: Image.asset(
                      width: 200,
                      height: 350,
                      randomImage[1],
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(flex: 1),
            Text(
              'Transform Your Screen.',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton.filled(
                  padding: EdgeInsets.all(15),
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(context).cardColor,
                    iconSize: 30,
                  ),
                  onPressed: () {
                    context.goNamed(AppRouterConstants.detailsScreen);
                  },
                  icon: Icon(LucideIcons.chevronsRight500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
