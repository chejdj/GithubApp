import 'package:flutter/foundation.dart';


@immutable
class User {

   User({
    required this.login,
    required this.avatarUrl,
    required this.type,
    required this.name,
    required this.company,
    required this.blog,
    required this.location,
    required this.email,
    required this.hireable,
    required this.bio,
    required this.publicRepos,
    required this.followers,
    required this.following,
    required this.createdAt,
    required this.updatedAt,
    required this.totalPrivateRepos,
    required this.ownedPrivateRepos,
  });

  String? login;
  String? avatarUrl;
  String? type;
  String? name;
  String? company;
  String? blog;
  String? location;
  String? email;
  final bool hireable;
  String? bio;
  final int publicRepos;
  final int followers;
  final int following;
  String? createdAt;
  String? updatedAt;
  final int totalPrivateRepos;
  final int ownedPrivateRepos;

  factory User.fromJson(Map<String,dynamic> json) => User(
    login: json['login'] as String,
    avatarUrl: json['avatar_url'] as String,
    type: json['type'] as String,
    name: json['name'] as String,
    company: json['company'] as String,
    blog: json['blog'] as String,
    location: json['location'] as String,
    email: json['email'] as String,
    hireable: json['hireable'] as bool,
    bio: json['bio'] as String,
    publicRepos: json['public_repos'] as int,
    followers: json['followers'] as int,
    following: json['following'] as int,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
    totalPrivateRepos: json['total_private_repos'] as int,
    ownedPrivateRepos: json['owned_private_repos'] as int
  );
  
  Map<String, dynamic> toJson() => {
    'login': login,
    'avatar_url': avatarUrl,
    'type': type,
    'name': name,
    'company': company,
    'blog': blog,
    'location': location,
    'email': email,
    'hireable': hireable,
    'bio': bio,
    'public_repos': publicRepos,
    'followers': followers,
    'following': following,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'total_private_repos': totalPrivateRepos,
    'owned_private_repos': ownedPrivateRepos
  };

  User clone() => User(
    login: login,
    avatarUrl: avatarUrl,
    type: type,
    name: name,
    company: company,
    blog: blog,
    location: location,
    email: email,
    hireable: hireable,
    bio: bio,
    publicRepos: publicRepos,
    followers: followers,
    following: following,
    createdAt: createdAt,
    updatedAt: updatedAt,
    totalPrivateRepos: totalPrivateRepos,
    ownedPrivateRepos: ownedPrivateRepos
  );


  User copyWith({
    String? login,
    String? avatarUrl,
    String? type,
    String? name,
    String? company,
    String? blog,
    String? location,
    String? email,
    bool? hireable,
    String? bio,
    int? publicRepos,
    int? followers,
    int? following,
    String? createdAt,
    String? updatedAt,
    int? totalPrivateRepos,
    int? ownedPrivateRepos
  }) => User(
    login: login ?? this.login,
    avatarUrl: avatarUrl ?? this.avatarUrl,
    type: type ?? this.type,
    name: name ?? this.name,
    company: company ?? this.company,
    blog: blog ?? this.blog,
    location: location ?? this.location,
    email: email ?? this.email,
    hireable: hireable ?? this.hireable,
    bio: bio ?? this.bio,
    publicRepos: publicRepos ?? this.publicRepos,
    followers: followers ?? this.followers,
    following: following ?? this.following,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    totalPrivateRepos: totalPrivateRepos ?? this.totalPrivateRepos,
    ownedPrivateRepos: ownedPrivateRepos ?? this.ownedPrivateRepos,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is User && login == other.login && avatarUrl == other.avatarUrl && type == other.type && name == other.name && company == other.company && blog == other.blog && location == other.location && email == other.email && hireable == other.hireable && bio == other.bio && publicRepos == other.publicRepos && followers == other.followers && following == other.following && createdAt == other.createdAt && updatedAt == other.updatedAt && totalPrivateRepos == other.totalPrivateRepos && ownedPrivateRepos == other.ownedPrivateRepos;

  @override
  int get hashCode => login.hashCode ^ avatarUrl.hashCode ^ type.hashCode ^ name.hashCode ^ company.hashCode ^ blog.hashCode ^ location.hashCode ^ email.hashCode ^ hireable.hashCode ^ bio.hashCode ^ publicRepos.hashCode ^ followers.hashCode ^ following.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode ^ totalPrivateRepos.hashCode ^ ownedPrivateRepos.hashCode;
}
