import 'package:dzest_mobile/src/constants/app_colors.dart';
import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  const IconText({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: const TextStyle(
          color: AppColors.textColor,
        ),
        children: [
          WidgetSpan(
            child: Icon(
              icon,
              size: 20,
            ),
          ),
          TextSpan(
            text: text,
          ),
        ],
      ),
    );
  }
}
