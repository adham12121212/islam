import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../qiblah/view/qiblah_page.dart';
import '../cubit/azan_page_cubit.dart';
import '../data/model/azan_sound.dart';

class AzanPage extends StatefulWidget {
  const AzanPage({super.key});

  @override
  State<AzanPage> createState() => _AzanPageState();
}

class _AzanPageState extends State<AzanPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _goToPage(int index) {
    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          "Azan&Qibla",
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
      backgroundColor: const Color(0xFF0F2C3F),
      body: Column(
        children: [


          // Tab Buttons
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildTabButton("Prayer Times", Iconsax.timer, 0),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTabButton("Qibla", Iconsax.location, 1),
                ),
              ],
            ),
          ),

          // PageView Content
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              children: const [
                _AzanContent(),
                QiblaPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, IconData icon, int index) {
    final bool isActive = _currentIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton.icon(
        onPressed: () => _goToPage(index),
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive ? const Color(0xFF4CA1AF) : Colors.white.withOpacity(0.1),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: isActive ? 4 : 0,
        ),
        label: Text(
          title,
          style: GoogleFonts.tajawal(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _AzanContent extends StatelessWidget {
  const _AzanContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AzanPageCubit, AzanPageState>(
      builder: (context, state) {
        if (state is AzanPageLoading) {
          return _buildLoadingState();
        } else if (state is AzanPageLoaded) {
          return _buildLoadedState(context, state);
        } else if (state is AzanPagePlaying) {
          return _buildPlayingState(context, state);
        } else if (state is AzanPageError) {
          return _buildErrorState(context, state);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          const SizedBox(height: 20),
          Text(
            "Loading Prayer Times...",
            style: GoogleFonts.tajawal(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, AzanPageLoaded state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Location Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                const Icon(Iconsax.location, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "${state.city}, ${state.country}",
                    style: GoogleFonts.tajawal(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Next Prayer Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  "Next Prayer",
                  style: GoogleFonts.tajawal(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      state.nextPrayer.name,
                      style: GoogleFonts.tajawal(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat.jm().format(state.nextPrayer.time),
                      style: GoogleFonts.tajawal(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: _calculateProgress(state.nextPrayer.time),
                  backgroundColor: Colors.white.withOpacity(0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Prayer Times List
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: state.prayerTimes.map((prayer) {
                final isNext = prayer.name == state.nextPrayer.name;
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: isNext ? Colors.white.withOpacity(0.15) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isNext ? const Color(0xFF4facfe).withOpacity(0.2) : Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _getPrayerIcon(prayer.name),
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    title: Text(
                      prayer.name,
                      style: GoogleFonts.tajawal(
                        color: Colors.white,
                        fontWeight: isNext ? FontWeight.bold : FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    trailing: Text(
                      DateFormat.jm().format(prayer.time),
                      style: GoogleFonts.tajawal(
                        color: Colors.white,
                        fontWeight: isNext ? FontWeight.bold : FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayingState(BuildContext context, AzanPagePlaying state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated Mosque Icon
          const Icon(
            Iconsax.menu_board,
            size: 80,
            color: Colors.white,
          ),
          const SizedBox(height: 30),

          // Prayer Time Info
          Text(
            "It's time for",
            style: GoogleFonts.tajawal(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            state.prayer.name,
            style: GoogleFonts.tajawal(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            DateFormat.jm().format(state.prayer.time),
            style: GoogleFonts.tajawal(
              color: Colors.white,
              fontSize: 24,
            ),
          ),

          const SizedBox(height: 50),

          // Stop Button
          ElevatedButton(
            onPressed: () {
              AzanPlayer.stopAzan();
              context.read<AzanPageCubit>().loadPrayerTimes();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF0F2C3F),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 5,
            ),
            child: Text(
              "Stop Azan",
              style: GoogleFonts.tajawal(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, AzanPageError state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            Text(
              "Unable to load prayer times",
              style: GoogleFonts.tajawal(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              state.error,
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                context.read<AzanPageCubit>().loadPrayerTimes();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF0F2C3F),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "Try Again",
                style: GoogleFonts.tajawal(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to get icon for each prayer
  IconData _getPrayerIcon(String prayerName) {
    switch (prayerName.toLowerCase()) {
      case "fajr":
        return Iconsax.sun_1;
      case "dhuhr":
        return Iconsax.sun;
      case "asr":
        return Iconsax.sun_fog;
      case "maghrib":
        return Iconsax.moon;
      case "isha":
        return Iconsax.moon5;
      default:
        return Iconsax.clock;
    }
  }

  // Helper function to calculate progress to next prayer
  double _calculateProgress(DateTime nextPrayerTime) {
    final now = DateTime.now();
    final nextPrayer = DateTime(now.year, now.month, now.day,
        nextPrayerTime.hour, nextPrayerTime.minute);

    final lastPrayer = nextPrayer.subtract(const Duration(hours: 6));

    if (now.isAfter(nextPrayer)) {
      return 1.0;
    } else if (now.isBefore(lastPrayer)) {
      return 0.0;
    } else {
      final totalDuration = nextPrayer.difference(lastPrayer);
      final elapsedDuration = now.difference(lastPrayer);
      return elapsedDuration.inSeconds / totalDuration.inSeconds;
    }
  }
}