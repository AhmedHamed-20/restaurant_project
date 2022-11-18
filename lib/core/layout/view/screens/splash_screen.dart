import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import '../../../../features/user/Auth/view/screens/login_screen.dart';

class SplashScrenn extends StatelessWidget {
  const SplashScrenn({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: const LoginScreen(),
      backgroundColor: Colors.orange,
      imageSrc: 'assets/images/restaurant.png',
      imageSize: 130,
      duration: 4000,
      text: 'Panda Restaurant',
      textType: TextType.TyperAnimatedText,
      textStyle: Theme.of(context).textTheme.titleLarge,
    );
  }
}
