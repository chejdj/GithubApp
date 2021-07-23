import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_app/common/global.dart';
import 'package:github_app/common/profile_change_notifier.dart';

class ThemeModel extends ProfileChangeNotifier{
  //获取当前主题，如果为设置主题，则默认使用蓝色主题
  ColorSwatch get theme => Global.themes.firstWhere((element) => element.value == Global.profile.theme, orElse: ()=> Colors.blue);
  //主题改变后，通知其依赖项，新主题会立即生效
  set theme(ColorSwatch colorSwatch){
    if(colorSwatch != theme){
        Global.profile.theme = colorSwatch.value;
        notifyListeners();
    }
  }
}