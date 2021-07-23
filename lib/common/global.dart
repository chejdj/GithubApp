//提供五套可选主题色
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_app/models/cacheConfig.dart';
import 'package:github_app/models/profile.dart';
import 'package:github_app/models/user.dart';
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
  static SharedPreferences? _prefs;
  static Profile profile = Profile(user: User(login: null,avatarUrl: null,type: null, name: null,company: null,blog: null,location: null,email: null,hireable: false,bio: null, publicRepos: 0, followers: 0,following: 1, createdAt: null,updatedAt: null,totalPrivateRepos: 0, ownedPrivateRepos: 0), token: null, theme: 0, cache: CacheConfig(enable: true, maxAge: 0, maxCount: 0), lastLogin: null, locale: null);
   //网络缓存对象
  static NetCache netCache = NetCache();

   //可选的主题列表
   static List<MaterialColor> get themes => _themes;
   //是否为release版
   static bool get isRelease => bool.fromEnvironment("dart.vm.product");
   //初始化全局消息， 会在App启动时执行
   static Future init() async{
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
   }

   static saveProfile() => _prefs?.setString("profile", jsonEncode(profile.toJson()));

}