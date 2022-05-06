import 'dart:async';
import 'dart:convert';

import 'package:LibreFit/fitness_app/profile/utils/user_profile.dart';
import 'package:http/http.dart' as http;

String access_token = '';
String refresh_token = '';

class AuthUser {
  final String access_token;
  final String refresh_token;

  const AuthUser({required this.access_token, required this.refresh_token});

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      access_token: json['access-token'],
      refresh_token: json['refresh-token'],
    );
  }
}

Future<AuthUser> _createAuthUser(String id, String pass) async {
  final response = await http.post(
    Uri.parse('http://10.100.26.63:5000/api/auth/login'), // TODO
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'user_name': id,
      'user_pass': pass,
    }),
  );
  print(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    
    return AuthUser.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to convert!');
  }
}

Future<bool> login(String id, String pass) async{
  print('Login Invoked');
  Future<AuthUser> au;
  try {
    await _createAuthUser(id, pass).then((value) {
      access_token = value.access_token;
      refresh_token = value.refresh_token;
      print('Tokens Generated');
      getProfile();
    });
  } catch (e) {
    print('Error');
    return false;
  }
  return true;
}
