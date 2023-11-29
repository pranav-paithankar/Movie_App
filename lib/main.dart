import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/res/color.dart';
import 'package:movie_app/view_model/Serach_Bar_Provider.dart';
import 'package:movie_app/view_model/now_playing_movies_view_model.dart';
import 'package:provider/provider.dart';

import 'utils/routes/routes.dart';
import 'utils/routes/routes_name.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.bgColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => SearchBarProvider()),
    ChangeNotifierProvider(create: (context) => NowPlayinMoviesViewModel()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 226, 169, 12)),
        useMaterial3: true,
      ),
      initialRoute: RoutesName.now_playing_movies,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
