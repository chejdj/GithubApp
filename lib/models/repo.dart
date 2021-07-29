import 'package:flutter/foundation.dart';
import 'user.dart';
import 'repo.dart';


@immutable
class Repo {

  const Repo({
    required this.id,
    required this.name,
    required this.fullName,
    required this.owner,
    required this.private,
    required this.description,
    required this.fork,
    required this.language,
    required this.forksCount,
    required this.stargazersCount,
    required this.size,
    required this.defaultBranch,
    required this.openIssuesCount,
    required this.pushedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.license,
  });

  final int id;
  final String name;
  final String fullName;
  final User owner;
  final bool private;
  final String description;
  final bool fork;
  final String? language;
  final int forksCount;
  final int stargazersCount;
  final int size;
  final String defaultBranch;
  final int openIssuesCount;
  final String pushedAt;
  final String createdAt;
  final String updatedAt;
  final License? license;

  factory Repo.fromJson(Map<String,dynamic> json) => Repo(
    id: json['id'] as int,
    name: json['name'] as String,
    fullName: json['full_name'] as String,
    owner: User.fromJson(json['owner'] as Map<String, dynamic>),
    private: json['private'] as bool,
    description: json['description'] as String,
    fork: json['fork'] as bool,
    language: json['language'] as String,
    forksCount: json['forks_count'] as int,
    stargazersCount: json['stargazers_count'] as int,
    size: json['size'] as int,
    defaultBranch: json['default_branch'] as String,
    openIssuesCount: json['open_issues_count'] as int,
    pushedAt: json['pushed_at'] as String,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
    license: json['license'] != null ? License.fromJson(json['license'] as Map<String, dynamic>) : null
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'full_name': fullName,
    'owner': owner.toJson(),
    'private': private,
    'description': description,
    'fork': fork,
    'language': language,
    'forks_count': forksCount,
    'stargazers_count': stargazersCount,
    'size': size,
    'default_branch': defaultBranch,
    'open_issues_count': openIssuesCount,
    'pushed_at': pushedAt,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'license': license!=null ? license!.toJson():''
  };

  Repo clone() => Repo(
    id: id,
    name: name,
    fullName: fullName,
    owner: owner.clone(),
    private: private,
    description: description,
    fork: fork,
    language: language,
    forksCount: forksCount,
    stargazersCount: stargazersCount,
    size: size,
    defaultBranch: defaultBranch,
    openIssuesCount: openIssuesCount,
    pushedAt: pushedAt,
    createdAt: createdAt,
    updatedAt: updatedAt,
    license: license?.clone()
  );


  Repo copyWith({
    int? id,
    String? name,
    String? fullName,
    User? owner,
    bool? private,
    String? description,
    bool? fork,
    String? language,
    int? forksCount,
    int? stargazersCount,
    int? size,
    String? defaultBranch,
    int? openIssuesCount,
    String? pushedAt,
    String? createdAt,
    String? updatedAt,
    License? license
  }) => Repo(
    id: id ?? this.id,
    name: name ?? this.name,
    fullName: fullName ?? this.fullName,
    owner: owner ?? this.owner,
    private: private ?? this.private,
    description: description ?? this.description,
    fork: fork ?? this.fork,
    language: language ?? this.language,
    forksCount: forksCount ?? this.forksCount,
    stargazersCount: stargazersCount ?? this.stargazersCount,
    size: size ?? this.size,
    defaultBranch: defaultBranch ?? this.defaultBranch,
    openIssuesCount: openIssuesCount ?? this.openIssuesCount,
    pushedAt: pushedAt ?? this.pushedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    license: license ?? this.license,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Repo && id == other.id && name == other.name && fullName == other.fullName && owner == other.owner && private == other.private && description == other.description && fork == other.fork && language == other.language && forksCount == other.forksCount && stargazersCount == other.stargazersCount && size == other.size && defaultBranch == other.defaultBranch && openIssuesCount == other.openIssuesCount && pushedAt == other.pushedAt && createdAt == other.createdAt && updatedAt == other.updatedAt  && license == other.license;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ fullName.hashCode ^ owner.hashCode ^ private.hashCode ^ description.hashCode ^ fork.hashCode ^ language.hashCode ^ forksCount.hashCode ^ stargazersCount.hashCode ^ size.hashCode ^ defaultBranch.hashCode ^ openIssuesCount.hashCode ^ pushedAt.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode ^ license.hashCode;
}

@immutable
class License {

  const License({
    required this.key,
    required this.name,
    required this.spdxId,
    required this.url,
    required this.nodeId,
  });

  final String key;
  final String name;
  final String spdxId;
  final String url;
  final String nodeId;

  factory License.fromJson(Map<String,dynamic> json) => License(
    key: json['key'] as String,
    name: json['name'] as String,
    spdxId: json['spdx_id'] as String,
    url: json['url'] as String,
    nodeId: json['node_id'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'key': key,
    'name': name,
    'spdx_id': spdxId,
    'url': url,
    'node_id': nodeId
  };

  License clone() => License(
    key: key,
    name: name,
    spdxId: spdxId,
    url: url,
    nodeId: nodeId
  );


  License copyWith({
    String? key,
    String? name,
    String? spdxId,
    String? url,
    String? nodeId
  }) => License(
    key: key ?? this.key,
    name: name ?? this.name,
    spdxId: spdxId ?? this.spdxId,
    url: url ?? this.url,
    nodeId: nodeId ?? this.nodeId,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is License && key == other.key && name == other.name && spdxId == other.spdxId && url == other.url && nodeId == other.nodeId;

  @override
  int get hashCode => key.hashCode ^ name.hashCode ^ spdxId.hashCode ^ url.hashCode ^ nodeId.hashCode;
}
