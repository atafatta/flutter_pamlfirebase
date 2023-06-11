// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserMdl {
  String name;
  String email;
  String uId;
  UserMdl({
    required this.name,
    required this.email,
    required this.uId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'uId': uId,
    };
  }

  factory UserMdl.fromMap(Map<String, dynamic> map) {
    return UserMdl(
      name: map['name'] as String,
      email: map['email'] as String,
      uId: map['uId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserMdl.fromJson(String source) =>
      UserMdl.fromMap(json.decode(source) as Map<String, dynamic>);
}
