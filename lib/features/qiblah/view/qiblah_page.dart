
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/qiblah_cubit.dart';
import '../cubit/qiblah_state.dart';


class QiblaPage extends StatelessWidget {
  const QiblaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QiblaCubit()..checkLocationPermission(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0F2C3F),
                Color(0xFF0F2C3F),],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: QiblaCompass(),
          ),
        ),
      ),
    );
  }
}

class QiblaCompass extends StatelessWidget {
  const QiblaCompass({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QiblaCubit, QiblaState>(
      builder: (context, state) {
        if (state is QiblaInitial || state is QiblaLoading) {
          return const Center(child: CupertinoActivityIndicator(radius: 20.0, color: CupertinoColors.activeBlue));
        } else if (state is QiblaError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "⚠️ ${state.message}",
                  style: const TextStyle(color: Colors.redAccent, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => context.read<QiblaCubit>().checkLocationPermission(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else if (state is QiblaLoaded) {
          final qiblahData = state.qiblahData;
          final qiblahDirection = qiblahData.qiblah; // Qibla direction from north
          final deviceDirection = qiblahData.direction ?? 0; // Device heading from north

          // Calculate the angle between device direction and Qibla direction
          double angleDifference = (deviceDirection - qiblahDirection).abs();

          // Normalize the angle to be between 0 and 180
          if (angleDifference > 180) {
            angleDifference = 360 - angleDifference;
          }

          final isFacingQibla = angleDifference < 5;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Compass
              Expanded(
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Compass background with markers
                      Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2),
                          ],
                          border: Border.all(color: Colors.blue, width: 2),
                        ),

                      ),

                      // Arrow pointing to Qibla
                      Transform.rotate(
                        angle: -qiblahDirection * (math.pi / 180), // Convert degrees to radians
                        child: Icon(
                          Icons.navigation,
                          size: 80,
                          color: isFacingQibla ? Colors.green : Colors.blue,
                        ),
                      ),

                      // Center indicator
                      Container(
                        width: 15,
                        height: 15,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),

                      // Kaaba icon at the top (North position)
                      Positioned(
                        top: 20,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration:  BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue[900],
                            boxShadow: [
                              BoxShadow(color: Colors.black26, blurRadius: 4, spreadRadius: 1),
                            ],
                          ),
                          child: Center(
                            child: Image.asset(
                              "assets/kaaba.png",
                              width: 30,
                              height: 30,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.place, color: Colors.white, size: 30);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

}