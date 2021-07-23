import 'package:flutter/material.dart';
import 'package:github_app/common/global.dart';
import 'package:github_app/common/locale_model.dart';
import 'package:github_app/common/theme_model.dart';
import 'package:github_app/common/user_model.dart';
import 'package:github_app/l10n/gmlocalizations.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

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
              return GmLocalizations.of(context)!.title;
            },
            home: HomeRoute(),
            // 应用首页
            locale: localModel.getLocale(),
            supportedLocales: [
              const Locale('en', 'US'),
              const Locale('zh', 'CN'),
            ],
            localizationsDelegates: [GmLocalizationsDelegate()],
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
