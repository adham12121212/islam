import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../home/widgets/custom_app_bar.dart';
import '../cubit/hadith_cubit.dart';
import '../data/model/hadith_model.dart';

class HadithPage extends StatelessWidget {
  const HadithPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HadithCubit()..getHadith(),
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Text(
            "Al-Hadith",
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
        body: BlocBuilder<HadithCubit, HadithState>(
          builder: (context, state) {
            if (state is HadithLoading) {
              return _buildLoading();
            } else if (state is HadithError) {
              return _buildError(context, state.message);
            } else if (state is HadithLoaded) {
              final hadiths = state.hadithModel.hadiths?.data ?? [];
              return _buildContent(hadiths);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF2D5A72), Color(0xFF3A7A96)],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const CupertinoActivityIndicator( radius: 20.0, color: CupertinoColors.activeBlue),
            const SizedBox(height: 20),
            Text(
              "جاري تحميل الأحاديث",
              style: GoogleFonts.tajawal(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Error Screen
  Widget _buildError(BuildContext context, String message) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF2D5A72), Color(0xFF3A7A96)],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.white),
              const SizedBox(height: 20),
              Text(
                message,
                style: GoogleFonts.tajawal(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => context.read<HadithCubit>().getHadith(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF2D5A72),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                child: Text("حاول مرة أخرى", style: GoogleFonts.tajawal(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Main Content
  Widget _buildContent(List<Data> hadiths) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0F2C3F), Color(0xFF0F2C3F)],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.amber[300]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "The 25 Beautiful Hadith ",
                      style: GoogleFonts.tajawal(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: hadiths.length,
                itemBuilder: (context, index) {
                  return _buildHadithCard(hadiths[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Hadith Card
  Widget _buildHadithCard(Data hadith) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.98),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Arabic Hadith
          if (hadith.hadithArabic != null) ...[
            Text(
              hadith.hadithArabic!,
              textAlign: TextAlign.right,
              style: GoogleFonts.tajawal(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                height: 1.8,
                color: const Color(0xFF222222),
              ),
            ),
            const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Chip(
                    label: Text(hadith.book!.bookName!, style: GoogleFonts.tajawal(fontSize: 15 ,color: Colors.black
                     ),),
                    backgroundColor: Colors.blue.shade50,
                    labelStyle: const TextStyle(color: Color(0xFF0F2C3F)),
                  ),
                ],
              ),
          ],
        ],
      ),
    );
  }
}
