import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'messages_all.dart';

class GmLocalizations{
  static Future<GmLocalizations> load(Locale locale){
    final String name = locale.countryCode!.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return new GmLocalizations();
    });
  }
  static GmLocalizations? of(BuildContext context){
    return Localizations.of<GmLocalizations>(context, GmLocalizations);
  }

  String get title => Intl.message("Github", name: 'title');
  String get language => Intl.message('语言', name: 'language');
  String get setting => Intl.message('设置', name: 'setting');
  String get theme => Intl.message('主题', name: 'theme');
  String get auto => Intl.message('自动', name: 'auto');
  String get home => Intl.message("首页", name: "home");
  String get login => Intl.message("登录", name: 'login');
  String get statemanagement => Intl.message('状态管理', name: 'statemanagement');
  String get noDescription => Intl.message("无描述", name: "noDescription");
}

class GmLocalizationsDelegate extends LocalizationsDelegate<GmLocalizations>{
  @override
  bool isSupported(Locale locale) {
     return ['en','zh'].contains(locale.languageCode);
  }

  @override
  Future<GmLocalizations> load(Locale locale) {
     return GmLocalizations.load(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<GmLocalizations> old) {
      return false;
  }
}