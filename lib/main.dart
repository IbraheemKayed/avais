import 'package:ecommerce_app/common/widgets/bottom_bar.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/features/auth/screens/auth_screen.dart';
import 'package:ecommerce_app/features/auth/services/auth_service.dart';
import 'package:ecommerce_app/providers/language_provider.dart';
import 'package:ecommerce_app/providers/user_provider.dart';
import 'package:ecommerce_app/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ecommerce_app/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LanguageProvider(),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: L10n.all,
            title: AppLocalizations.of(context)?.title ?? '',
            locale: Provider.of<LanguageProvider>(context).locale,
            theme: ThemeData(
              scaffoldBackgroundColor: GlobalVariables.backgroundColor,
              colorScheme: const ColorScheme.light(
                primary: GlobalVariables.secondaryColor,
              ),
              appBarTheme: const AppBarTheme(
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
            ),
            onGenerateRoute: (settings) => generateRoute(settings),
            home: Provider.of<UserProvider>(context).user.token.isNotEmpty
                
                    ? const BottomBar()
                    
                : const AuthScreen(),
          );
        });
  }
}
