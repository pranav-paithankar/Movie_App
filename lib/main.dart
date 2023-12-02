import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/res/color.dart';
import 'package:movie_app/view_model/Serach_Bar_Provider.dart';
import 'package:provider/provider.dart';
import 'utils/routes/routes.dart';
import 'utils/routes/routes_name.dart';
import 'view_model/movies_list_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.bgColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => SearchBarProvider()),
    ChangeNotifierProvider(create: (context) => MoviesListViewModel()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 226, 169, 12)),
        useMaterial3: true,
      ),
      initialRoute: RoutesName.splash_view,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
