// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class authModel {
  String username;
  authModel({
    required this.username,
  });

  authModel copyWith({
    String? username,
  }) {
    return authModel(
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
    };
  }

  factory authModel.fromMap(Map<String, dynamic> map) {
    return authModel(
      username: map['username'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory authModel.fromJson(String source) => authModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'authModel(username: $username)';

  @override
  bool operator ==(covariant authModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.username == username;
  }

  @override
  int get hashCode => username.hashCode;
}

