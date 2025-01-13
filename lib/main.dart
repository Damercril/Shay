import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shayniss/core/providers/auth_provider.dart';
import 'package:shayniss/core/providers/locale_provider.dart';
import 'package:shayniss/core/router/app_router.dart';
import 'package:shayniss/core/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = await SharedPreferences.getInstance();
  await AppRouter.initialize();
  await ScreenUtil.ensureScreenSize();
  
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(prefs)),
        ChangeNotifierProvider(create: (_) => LocaleProvider(prefs)),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          final localeProvider = Provider.of<LocaleProvider>(context);
          return MaterialApp.router(
            title: 'Shayniss',
            theme: AppTheme.lightTheme,
            themeMode: ThemeMode.light,
            routerConfig: AppRouter.router,
            locale: localeProvider.locale,
            supportedLocales: const [
              Locale('fr'),
              Locale('en'),
              Locale('es'),
              Locale('ar'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
