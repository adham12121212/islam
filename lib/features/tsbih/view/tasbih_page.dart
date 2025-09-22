import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../cubit/tasbih_cubit.dart';
import '../data/model/zikr_model.dart';
import '../widgets/action_buttons.dart';
import '../widgets/circular_counter.dart';
import '../widgets/zikr_card.dart';

class TasbihPage extends StatefulWidget {
  const TasbihPage({super.key});

  @override
  State<TasbihPage> createState() => _TasbihPageState();
}

class _TasbihPageState extends State<TasbihPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  int _currentZikrIndex = 0;
  int _previousCount = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onCountPressed(TasbihCubit cubit) {
    _animationController.forward().then((_) {
      _animationController.reverse();

      final currentCount = cubit.state;
      final currentZikr = zikrList[_currentZikrIndex];

      // Check if we've reached the required count for current zikr
      if (currentCount - _previousCount >= currentZikr.count - 1) {
        setState(() {
          _previousCount = currentCount + 1;
          _currentZikrIndex = (_currentZikrIndex + 1) % zikrList.length;
        });
      }

      cubit.increment();
    });
  }

  void _resetTasbih(TasbihCubit cubit) {
    cubit.reset();
    setState(() {
      _currentZikrIndex = 0;
      _previousCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasbihCubit(),
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Text(
            "Tasbih",
            style: GoogleFonts.tajawal(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xFF0F2C3F),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF0F2C3F),
                const Color(0xFF1A4A63).withOpacity(0.9),
              ],
            ),
          ),
          child: Column(
            children: [
              BlocBuilder<TasbihCubit, int>(
                builder: (context, count) {
                  final cubit = context.read<TasbihCubit>();
                  final currentZikr = zikrList[_currentZikrIndex];
                  final currentCount = count - _previousCount;

                  return Expanded(
                    child: Column(
                      children: [
                        // Zikr Card at the top
                        ZikrCard(
                          zikr: currentZikr,
                          currentCount: count,
                          previousCount: _previousCount,
                        ),

                        const SizedBox(height: 30),

                        // Next Zikr Preview
                        if (_currentZikrIndex < zikrList.length - 1)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Next: ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white.withOpacity(0.7),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    zikrList[_currentZikrIndex + 1].text,
                                    style: GoogleFonts.tajawal(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        const SizedBox(height: 20),

                        // Circular Counter
                        CircularCounter(
                          zikr: currentZikr,
                          count: count,
                          currentCount: count,
                          previousCount: _previousCount,
                          scaleAnimation: _scaleAnimation,
                        ),

                        const Spacer(),

                        // Action Buttons
                        ActionButtons(
                          zikr: currentZikr,
                          onReset: () => _resetTasbih(cubit),
                          onCount: () => _onCountPressed(cubit),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
