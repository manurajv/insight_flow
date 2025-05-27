import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../utils/glassmorphism_effects.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ModalBarrier(
          dismissible: false,
          color: Colors.black.withOpacity(0.5),
        ),
        Center(
          child: GlassContainer(
            width: 80,
            height: 80,
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
              ),
            ),
          ),
        ),
      ],
    );
  }
}