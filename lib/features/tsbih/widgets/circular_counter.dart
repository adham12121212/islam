import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/model/zikr_model.dart';


class CircularCounter extends StatelessWidget {
  final Zikr zikr;
  final int count;
  final int currentCount;
  final int previousCount;
  final Animation<double> scaleAnimation;

  const CircularCounter({
    super.key,
    required this.zikr,
    required this.count,
    required this.currentCount,
    required this.previousCount,
    required this.scaleAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (currentCount - previousCount) / zikr.count;

    return Stack(
      alignment: Alignment.center,
      children: [
        // Background Circle
        Container(
          width: 280,
          height: 280,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                zikr.color.withOpacity(0.3),
                Colors.transparent,
              ],
              stops: const [0.1, 1.0],
            ),
          ),
        ),

        // Counter Circle
        ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: zikr.color.withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Center(
              child: Text(
                "$count",
                style: GoogleFonts.tajawal(
                  fontSize: 54,
                  fontWeight: FontWeight.bold,
                  color: zikr.color,
                ),
              ),
            ),
          ),
        ),

        // Progress Ring
        SizedBox(
          width: 240,
          height: 240,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 3,
            backgroundColor: Colors.white.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(zikr.color),
          ),
        ),
      ],
    );
  }
}