import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:github_app/common/global.dart';
import 'package:github_app/models/user.dart';
import 'package:github_app/models/repo.dart';

class Git{
  BuildContext context;
  Options _options;
  Git(this.context): _options =  Options(method: null,sendTimeout: null, receiveTimeout: null,extra: {"context": context}, headers: null,
      responseType: null, contentType: null, validateStatus: null, receiveDataWhenStatusError: false,
      followRedirects: false, maxRedirects: null, requestEncoder: null, responseDecoder: null,listFormat: null);
  
  static Dio dio = new Dio(BaseOptions(
    baseUrl: 'https://api/github.com/',
    headers: {
      HttpHeaders.acceptHeader: "application/vnd.github.squirrel-girl=preview, application/vnd.github.symmetra-preview+json",
    },
  ));
  
  static void init(){
    dio.interceptors.add(Global.netCache);
    dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;
    if(!Global.isRelease){
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (client){
        client.findProxy =(uri){
          return "PROXY 10.1.10.250.8888";
        };
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  Future<User> login(String login, String pwd) async{
     String basic = 'Basic' + base64.encode(utf8.encode('$login:$pwd'));
     var r = await dio.get(
       "/users/$login",
       options: _options.copyWith(headers: {
         HttpHeaders.authorizationHeader: basic
       },extra:{
         "noCache": true,
       }),
     );
     dio.options.headers[HttpHeaders.authorizationHeader] = basic;
     Global.netCache.cache.clear();
     Global.profile.token = basic;
     return User.fromJson(r.data);
  }

  Future<List<Repo>> getRepos({Map<String, dynamic>? queryParameters, bool? refresh}) async{
     if(refresh!=null && refresh){
        _options.extra?.addAll({"refresh": true, "list": true});
     }
     var r = await dio.get<List>(
       "user/repos",
         queryParameters: queryParameters,
         options:_options,
     );
     return r.data!.map((e) => Repo.fromJson(e)).toList();
  }
}