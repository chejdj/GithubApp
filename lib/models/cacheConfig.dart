import 'package:flutter/foundation.dart';


@immutable
class CacheConfig {

  const CacheConfig({
    required this.enable,
    required this.maxAge,
    required this.maxCount,
  });

  final bool enable;
  final int maxAge;
  final int maxCount;

  factory CacheConfig.fromJson(Map<String,dynamic> json) => CacheConfig(
    enable: json['enable'] as bool,
    maxAge: json['maxAge'] as int,
    maxCount: json['maxCount'] as int
  );
  
  Map<String, dynamic> toJson() => {
    'enable': enable,
    'maxAge': maxAge,
    'maxCount': maxCount
  };

  CacheConfig clone() => CacheConfig(
    enable: enable,
    maxAge: maxAge,
    maxCount: maxCount
  );


  CacheConfig copyWith({
    bool? enable,
    int? maxAge,
    int? maxCount
  }) => CacheConfig(
    enable: enable ?? this.enable,
    maxAge: maxAge ?? this.maxAge,
    maxCount: maxCount ?? this.maxCount,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is CacheConfig && enable == other.enable && maxAge == other.maxAge && maxCount == other.maxCount;

  @override
  int get hashCode => enable.hashCode ^ maxAge.hashCode ^ maxCount.hashCode;
}
