import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Responsive Helper/responsive_helper.dart';
import '../model/list_name.dart';

class AllahNamesPage extends StatelessWidget {
  const AllahNamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = ResponsiveHelper.isSmallScreen(context);
    final int crossAxisCount = isSmallScreen ? 2 : 3;
    final double childAspectRatio = isSmallScreen ? 0.85 : 0.9;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          "Allah's Names",
          style: GoogleFonts.tajawal(
            fontWeight: FontWeight.bold,
            fontSize: ResponsiveHelper.getResponsiveFontSize(context, small: 20, medium: 22, large: 24),
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF0F2C3F),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F2C3F), Color(0xFF1A4A63), Color(0xFF2D5A72)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with info
              Container(
                margin: EdgeInsets.all(isSmallScreen ? 12 : 16),
                padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.amber[300], size: isSmallScreen ? 20 : 24),
                    SizedBox(width: isSmallScreen ? 8 : 12),
                    Expanded(
                      child: Text(
                        "The 99 Beautiful Names of Allah (Asma ul Husna)",
                        style: GoogleFonts.tajawal(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: ResponsiveHelper.getResponsiveFontSize(context, small: 12, medium: 14, large: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Names grid
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.fromLTRB(
                      isSmallScreen ? 12 : 16,
                      0,
                      isSmallScreen ? 12 : 16,
                      isSmallScreen ? 12 : 16
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: isSmallScreen ? 12 : 16,
                    mainAxisSpacing: isSmallScreen ? 12 : 16,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemCount: allahNames.length,
                  itemBuilder: (context, index) {
                    final item = allahNames[index];
                    return Container(
                      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            _getGradientColor(index).withOpacity(0.9),
                            _getGradientColor(index).withOpacity(0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Number badge
                          Container(
                            width: isSmallScreen ? 28 : 32,
                            height: isSmallScreen ? 28 : 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: isSmallScreen ? 12 : 14,
                              ),
                            ),
                          ),
                          SizedBox(height: isSmallScreen ? 12 : 16),
                          // Arabic name
                          Text(
                            item.name,
                            style: GoogleFonts.tajawal(
                              fontSize: isSmallScreen ? 20 : 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: isSmallScreen ? 6 : 8),
                          // Translation
                          if (item.translation.isNotEmpty)
                            Text(
                              item.translation,
                              style: GoogleFonts.tajawal(
                                fontSize: isSmallScreen ? 12 : 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getGradientColor(int index) {
    final colors = [
      const Color(0xFF3A7A96),
      const Color(0xFF4CA1AF),
      const Color(0xFF2AA5A1),
      const Color(0xFF9B59B6),
      const Color(0xFFE74C3C),
      const Color(0xFFF39C12),
    ];
    return colors[index % colors.length];
  }
}