import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:github_app/common/global.dart';

class CacheObject{
  CacheObject(this.response):timeStamp = DateTime.now().millisecondsSinceEpoch;
  Response response;
  int timeStamp;

  @override
  bool operator ==(Object other) {
    return response.hashCode == other.hashCode;
  }

  @override
  int get hashCode {
     return response.realUri.hashCode;
  }
}

class NetCache extends Interceptor{
  var cache = LinkedHashMap<String, CacheObject>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
     if(!Global.profile.cache!.enable) return;
     bool refresh  = options.extra['refresh'] == true;
     if(refresh){
         if(options.extra['list'] == true){
             cache.removeWhere((key, value) => key.contains(options.path));
         }else{
           delete(options.uri.toString());
         }
         handler.next(options);
         return ;
     }
     if(options.extra['noCache'] != true &&
         options.method.toLowerCase() == 'get'){
        String key = options.extra['cacheKey'] ?? options.uri.toString();
        var ob = cache[key];
        if(ob != null){
          if((DateTime.now().millisecondsSinceEpoch - ob.timeStamp) /1000 > Global.profile.cache!.maxAge){
             handler.resolve(cache[key]!.response,false);
          }else{
            cache.remove(key);
          }
        }
     }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // 错误状态不缓存
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
      if(Global.profile.cache!.enable){
        _saveCache(response);
      }
  }
  _saveCache(Response ob){
     RequestOptions options = ob.requestOptions;
     if(options.extra['noCache'] != true &&
       options.method.toLowerCase()=="get"){
       if(cache.length == Global.profile.cache?.maxCount){
         cache.remove(cache[cache.keys.first]);
       }
     }
     String key = options.extra['cacheKey'] ?? options.uri.toString();
     cache[key] = CacheObject(ob);
  }

  void delete(String key){
    cache.remove(key);
  }
}