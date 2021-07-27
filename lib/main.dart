import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:github_app/common/global.dart';
import 'package:github_app/common/locale_model.dart';
import 'package:github_app/common/theme_model.dart';
import 'package:github_app/common/user_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'generated/l10n.dart';
import 'routes/home_page.dart';
import 'routes/language_page.dart';
import 'routes/login_page.dart';
import 'routes/theme_page.dart';

void main() {
  Global.init().then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: UserModel()),
        ChangeNotifierProvider.value(value: LocaleModel()),
      ],
      child: Consumer2<ThemeModel, LocaleModel>(
        builder: (context, themeModel, localModel, child) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: themeModel.theme as MaterialColor,
            ),
            onGenerateTitle: (context) {
              return S.current.title;
            },
            home: HomeRoute(),
            // 应用首页
            locale: localModel.getLocale(),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', 'US'),
              const Locale('zh', 'CN'),
            ],
            localeResolutionCallback:
                (Locale? _locale, Iterable<Locale> supportedLocales) {
              if (localModel.getLocale() != null) {
                return localModel.getLocale();
              } else {
                Locale locale;
                if (supportedLocales.contains(_locale)) {
                  locale = _locale!;
                } else {
                  locale = Locale('en', 'US');
                }
                return locale;
              }
            },
            routes: <String, WidgetBuilder>{
              "login": (context) => LoginRoute(),
              "themes": (context) => ThemeChangeRoute(),
              "language": (context) => LanguageRoute(),
            },
          );
        },
      ),
    );
  }
}
