
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Responsive Helper/responsive_helper.dart';
import '../../../constant/constant.dart';

class ContainerWidget extends StatelessWidget {
  final String title;
  final String logo;
  final Color color;

  const ContainerWidget({
    super.key,
    required this.title,
    required this.logo,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = ResponsiveHelper.isSmallScreen(context);
    final double containerHeight = isSmallScreen ? 250 : 350;

    return Container(
      height: containerHeight,
      decoration: BoxDecoration(
        color: Colors.white,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo with responsive size
          SizedBox(
            height: isSmallScreen ? 120 : 270,
            width: isSmallScreen ? 120 : 270,
            child: SvgPicture.asset(
              logo,
            ),
          ),
          SizedBox(height: isSmallScreen ? 8 : 12),
          // Title with responsive font size
          Text(
            title,
            style: TextStyle(
              fontSize: isSmallScreen ? 16 : 18,
              fontWeight: FontWeight.bold,
              color: Constant.Maintextcolor,
            ),
          ),
        ],
      ),
    );
  }
}