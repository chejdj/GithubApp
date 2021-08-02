//提供五套可选主题色
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_logan/flutter_logan.dart';
import 'package:github_app/models/cacheConfig.dart';
import 'package:github_app/models/profile.dart';
import 'package:github_app/network/cache_object.dart';
import 'package:github_app/network/git.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

class Global{
  static const  int LOG_FLAG =2;
  static SharedPreferences? _prefs;
  static Profile profile = Profile(user: null, token: null, theme: 0, cache: null, lastLogin: null, locale: null);
   //网络缓存对象
  static NetCache netCache = NetCache();

   //可选的主题列表
   static List<MaterialColor> get themes => _themes;
   //是否为release版
   static bool get isRelease => bool.fromEnvironment("dart.vm.product");
   //初始化全局消息， 会在App启动时执行
   static Future init() async{
     WidgetsFlutterBinding.ensureInitialized();
     _prefs = await SharedPreferences.getInstance();
     var _profile = _prefs?.getString("profile");
     if(_profile != null){
       try{
         profile =Profile.fromJson(jsonDecode(_profile));
       }catch( e){
         print(e);
       }
     }

     //如果没有缓存策略，设置默认缓存策略
     profile.cache = profile.cache ?? CacheConfig(enable: true, maxAge: 3600, maxCount: 100);
     //c初始化网络请求配置
     Git.init();
     
     //初始化日志框架
     FlutterLogan.init('1234', '123', 1024*1024*10);
   }

   static saveProfile() => _prefs?.setString("profile", jsonEncode(profile.toJson()));

}