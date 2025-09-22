import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islam/features/azkar/cubit/azkar_cubit.dart';

import '../../home/widgets/custom_app_bar.dart';


class AzkarListPage extends StatelessWidget {
  const AzkarListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AzkarCubit()..getAzkar(),
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Text(
            "Azkar",
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
        body: BlocBuilder<AzkarCubit, AzkarState>(
          builder: (context, state) {
            if (state is AzkarLoading) {
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
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "جاري تحميل الأذكار",
                        style: GoogleFonts.tajawal(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is AzkarError) {
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
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          state.message,
                          style: GoogleFonts.tajawal(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () => context.read<AzkarCubit>().getAzkar(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF2D5A72),
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text(
                            "حاول مرة أخرى",
                            style: GoogleFonts.tajawal(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is AzkarLoaded) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors:[Color(0xFF0F2C3F),
                      Color(0xFF0F2C3F),],
                  ),
                ),
                child: SafeArea(

                  child: Column(
                    children: [


                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Introduction card
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.lightbulb_outline,
                                      size: 40,
                                      color: Colors.amber[200],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "الأذكار تطرد الشيطان وتجلب الرزق وتفرج الهم",
                                      style: GoogleFonts.tajawal(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),

                              // Azkar list
                              ...state.azkar.map((azkarGroup) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    if (azkarGroup.title != null)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        child: Text(
                                          azkarGroup.title!,
                                          style: GoogleFonts.tajawal(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),

                                    ...azkarGroup.content!.map((content) {
                                      return Container(
                                        margin: const EdgeInsets.symmetric(vertical: 8),
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.95),
                                          borderRadius: BorderRadius.circular(16),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            // Zekr text
                                            Text(
                                              content.zekr ?? '',
                                              style: GoogleFonts.tajawal(
                                                fontSize: 18,
                                                height: 1.6,
                                                color: const Color(0xFF333333),
                                              ),
                                              textAlign: TextAlign.right,
                                            ),

                                            // Bless text
                                            if ((content.bless ?? '').isNotEmpty)
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8.0),
                                                child: Text(
                                                  content.bless!,
                                                  style: GoogleFonts.tajawal(
                                                    fontSize: 14,
                                                    color: Colors.grey[700],
                                                  ),
                                                  textAlign: TextAlign.right,
                                                ),
                                              ),

                                            const SizedBox(height: 12),

                                            // Repeat count and bookmark
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              textDirection: TextDirection.ltr,
                                              children: [

                                                // Repeat count
                                                if (content.repeat != null)
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xFF2D5A72).withOpacity(0.1),
                                                      borderRadius: BorderRadius.circular(20),
                                                      border: Border.all(
                                                        color: const Color(0xFF2D5A72),
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.repeat,
                                                          size: 16,
                                                          color: Color(0xFF2D5A72),
                                                        ),
                                                        const SizedBox(width: 4),
                                                        Text(
                                                          "${content.repeat}",
                                                          style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.bold,
                                                            color: Color(0xFF2D5A72),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),

                                    const SizedBox(height: 20),
                                  ],
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
