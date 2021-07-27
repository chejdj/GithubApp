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
    // if(!Global.isRelease){
    //   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //   (client){
    //     client.findProxy =(uri){
    //       return "PROXY 10.1.10.250.8888";
    //     };
    //     client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    //   };
    // }
    dio.interceptors.add(LoggingInterceptor());
  }

  Future<User> login(String userName, String pwd) async{
     String basic = 'Basic' + base64.encode(utf8.encode('$login:$pwd'));
     var r = await dio.get(
       "/users/$userName",
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

class LoggingInterceptor extends Interceptor{
  // 通过控制台打印所有的请求信息以及相应信息，以方便我们调试请求中的问题
  int _maxCharactersPerLine = 200;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("--> ${options.method} ${options.path}");
    debugPrint("Content type: ${options.contentType}");
    debugPrint("<-- END HTTP");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // debugPrint(
    //     "<-- ${response.statusCode} ${response.} ${response.request.path}");
    String responseAsString = response.data.toString();
    if (responseAsString.length > _maxCharactersPerLine) {
      int iterations =
      (responseAsString.length / _maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * _maxCharactersPerLine + _maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        debugPrint(responseAsString.substring(
            i * _maxCharactersPerLine, endingIndex));
      }
    } else {
      debugPrint(response.data);
    }
    debugPrint("<-- END HTTP");
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
      debugPrint("<-- Error -->");
      debugPrint(err.error);
      debugPrint(err.message);
      return super.onError(err, handler);
  }
}