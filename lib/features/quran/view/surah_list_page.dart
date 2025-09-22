import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../home/widgets/custom_app_bar.dart';
import '../cubit/quran_cubit.dart';
import '../cubit/quran_state.dart';
import 'package:flutter/cupertino.dart';
import 'surah_detail_page.dart';

class SurahListPage extends StatelessWidget {
  const SurahListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuranCubit()..fetchSurahs(),
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Text(
            "Quran",
            style: GoogleFonts.tajawal(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xFF0F2C3F),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),

        ),
        body: BlocBuilder<QuranCubit, QuranState>(
          builder: (context, state) {
            if (state is QuranLoading) {
              return  Center(child: CupertinoActivityIndicator(radius: 20.0, color: CupertinoColors.activeBlue),);
            } else if (state is QuranError) {
              return Center(child: Text(state.message));
            } else if (state is QuranLoaded) {
              final surahs = state.surahs;
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF0F2C3F),
                      Color(0xFF0F2C3F),]
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: surahs.length,
                        itemBuilder: (context, index) {
                          final surah = surahs[index];
                          return Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: ListTile(
                              title: Text("${surah.number}. ${surah.englishName}" ,
                               style: GoogleFonts.quicksand(
                                 color: Colors.black,
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold,
                               ),),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SurahDetailPage(surah: surah),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
