import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movie_app/res/color.dart';
import 'package:movie_app/view/landing_view.dart';
import '../res/size_config.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LandingView(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        color: AppColors.bgColor,
        child: const SizedBox(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.movie_creation_outlined,
              color: AppColors.whiteColor,
              size: 100,
            ),
            Text(
              "Movie App",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: AppColors.whiteColor),
            ),
            Text(
              "@Developed by PranavPaithankar",
              style: TextStyle(color: AppColors.whiteColor),
            ),
          ],
        )),
      ),
    );
  }
}
