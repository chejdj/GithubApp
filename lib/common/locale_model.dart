import 'dart:ui';

import 'package:github_app/common/global.dart';
import 'package:github_app/common/profile_change_notifier.dart';

class LocaleModel extends ProfileChangeNotifier{
  //获取当前用户的APP语言配置Local类，如果为null, 则语言跟随系统语言
  Locale? getLocale(){
     // ignore: unnecessary_null_comparison
     if(Global.profile.locale == null){
       return null;
     }
     var t = Global.profile.locale?.split("_");
     if(t != null){
       return Locale(t[0],t[1]);
     }
     return null;
  }

  //获取当前Locale的字符串表示
  String? currentLocal = Global.profile.locale;

  //用户改变App语言后，通知依赖更新，新语言会立即生效
  set locale(String locale){
    if(locale != Global.profile.locale){
      Global.profile.locale = locale;
      notifyListeners();
    }
  }
}
