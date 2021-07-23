import 'package:flutter/foundation.dart';
import 'user.dart';
import 'cacheConfig.dart';

@immutable
class Profile {

   Profile({
    required this.user,
    required this.token,
    required this.theme,
    required this.cache,
    required this.lastLogin,
    required this.locale,
  });
   User? user;
   String? token;
  int theme;
  CacheConfig? cache;
  String? lastLogin;
  String? locale;

  factory Profile.fromJson(Map<String,dynamic> json) => Profile(
    user: User.fromJson(json['user'] as Map<String, dynamic>),
    token: json['token'] as String,
    theme: json['theme'] as int,
    cache: json['cache'] as CacheConfig,
    lastLogin: json['lastLogin'] as String,
    locale: json['locale'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'user': user?.toJson(),
    'token': token,
    'theme': theme,
    'cache': cache,
    'lastLogin': lastLogin,
    'locale': locale
  };

  Profile clone() => Profile(
    user: user?.clone(),
    token: token,
    theme: theme,
    cache: cache,
    lastLogin: lastLogin,
    locale: locale
  );


  Profile copyWith({
    User? user,
    String? token,
    int? theme,
    CacheConfig? cache,
    String? lastLogin,
    String? locale
  }) => Profile(
    user: user ?? this.user,
    token: token ?? this.token,
    theme: theme ?? this.theme,
    cache: cache ?? this.cache,
    lastLogin: lastLogin ?? this.lastLogin,
    locale: locale ?? this.locale,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Profile && user == other.user && token == other.token && theme == other.theme && cache == other.cache && lastLogin == other.lastLogin && locale == other.locale;

  @override
  int get hashCode => user.hashCode ^ token.hashCode ^ theme.hashCode ^ cache.hashCode ^ lastLogin.hashCode ^ locale.hashCode;
}
