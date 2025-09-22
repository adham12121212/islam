
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Responsive Helper/responsive_helper.dart';
import '../../allahname/view/allah_name.dart';
import '../../azan/cubit/azan_page_cubit.dart';
import '../../azan/view/azan_page.dart';
import '../../azkar/view/azkar_page.dart';
import '../../hadith/view/hadith_page.dart';
import '../../quran/view/surah_list_page.dart';
import '../../tsbih/view/tasbih_page.dart';
import '../widgets/container_widget.dart';
import '../widgets/custom_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = ResponsiveHelper.isSmallScreen(context);
    final double spacing = isSmallScreen ? 12 : 16;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F2C3F), Color(0xFF0F2C3F)],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: ResponsiveHelper.getResponsivePadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<AzanPageCubit, AzanPageState>(
                  builder: (context, state) {
                    if (state is AzanPageLoaded) {
                      return CustomAppBar(
                        title: 'Islami',
                        icon: Icons.location_on,
                        location: "${state.city}",
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
                SizedBox(height: spacing),

                // First row of containers
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AzanPage())),
                        child: ContainerWidget(
                          title: 'Azan Time',
                          logo: 'assets/azantimelogo.svg',
                        ),
                      ),
                    ),
                    SizedBox(width: spacing),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SurahListPage())),
                        child: ContainerWidget(
                          title: 'Quran',
                          logo: 'assets/quran.svg',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spacing),

                // Second row of containers
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AzkarListPage())),
                        child: ContainerWidget(
                          title: 'Azkar',
                          logo: 'assets/azkar.svg',
                        ),
                      ),
                    ),
                    SizedBox(width: spacing),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AllahNamesPage())),
                        child: ContainerWidget(
                          title: 'Allah Name',
                          logo: 'assets/allah vector.svg',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spacing),

                // Third row of containers
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HadithPage())),
                        child: ContainerWidget(
                          title: 'Hadith',
                          logo: 'assets/hadith.svg',
                        ),
                      ),
                    ),
                    SizedBox(width: spacing),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TasbihPage())),
                        child: ContainerWidget(
                          title: 'Tasbih',
                          logo: 'assets/tasbih.svg',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}