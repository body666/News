import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/home_layout.dart';
import 'package:news/observer.dart';
import 'package:news/repo/remote_data_source.dart';
import 'package:news/screens/SplashScreen/splash_screen.dart';
import 'package:news/screens/settings/settings_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cubit/HomeCubit/cubit.dart';
import 'cubit/HomeCubit/states.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(
      BlocProvider(
          create: (context) => HomeCubit(RemoteDataSource())..loadLanguage(),
          child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initSharedPref(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return MaterialApp(
          locale: Locale(cubit.locale), // Rebuild with updated locale
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          title: 'News',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
            useMaterial3: true,
          ),
          initialRoute: SplashScreen.routeName,
          routes: {
            HomeLayout.routeName: (context) => HomeLayout(),
            SettingsScreen.routeName: (context) => SettingsScreen(),
            SplashScreen.routeName: (context) => SplashScreen(),
          },
        );
      },
    );
  }

  void initSharedPref(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String lang = prefs.getString("lang") ?? "en";
    HomeCubit.get(context).changeLanguage(lang);
  }
}



