import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/quran_cubit.dart';
import '../cubit/quran_state.dart';
import '../data/model/quran_model.dart';

class SurahDetailPage extends StatelessWidget {
  final Surah surah;

  const SurahDetailPage({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuranCubit()..fetchAyahs(surah.number),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F2E8), // Light beige background
        body: CustomScrollView(
          slivers: [
            // Custom App Bar
            SliverAppBar(
              expandedHeight: 140.0,
              pinned: true,
              backgroundColor: const Color(0xFF2D5A72), // Dark blue-green
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  surah.englishName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF0F2C3F),
                        Color(0xFF0F2C3F),]
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            surah.name,
                            style: const TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontFamily: 'Amiri',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            ),

            // Content area
            BlocBuilder<QuranCubit, QuranState>(
              builder: (context, state) {
                if (state is AyahsLoading) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2D5A72)),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "جاري تحميل الآيات...",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is AyahsError) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, size: 64, color: Colors.grey),
                          const SizedBox(height: 16),
                          Text(
                            state.message,
                            style: const TextStyle(color: Colors.grey, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () => context.read<QuranCubit>().fetchAyahs(surah.number),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2D5A72),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            ),
                            child: const Text('حاول مرة أخرى', style: TextStyle(color: Colors.white, fontSize: 16)),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is AyahsLoaded) {
                  final ayahs = state.ayahs;
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final ayah = ayahs[index];
                        return _AyahItem(
                          number: ayah['numberInSurah'],
                          text: ayah['text'] ?? '',
                        );
                      },
                      childCount: ayahs.length,
                    ),
                  );
                }
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AyahItem extends StatelessWidget {
  final int number;
  final String text;

  const _AyahItem({
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Stack(
        children: [
          // Decorative background with subtle pattern
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.rtl,
              children: [
                // Ayah text
                Expanded(
                  child: Text(
                    text,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      fontSize: 26,
                      fontFamily: 'Amiri',
                      height: 1.8,
                      color: Color(0xFF333333),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),

                const SizedBox(width: 16),

                // Ayah number in a decorative circle
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF2D5A72).withOpacity(0.1),
                    border: Border.all(
                      color: const Color(0xFF2D5A72),
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '$number',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D5A72),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Decorative corner elements
          Positioned(
            top: 0,
            left: 0,
            child: Icon(
              Icons.star,
              size: 16,
              color: const Color(0xFF2D5A72).withOpacity(0.3),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Icon(
              Icons.star,
              size: 16,
              color: const Color(0xFF2D5A72).withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}

