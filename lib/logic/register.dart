import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

String access_token = '';
String refresh_token = '';

class RegUser {

  const RegUser();

  factory RegUser.fromJson(Map<String, dynamic> json) {
    return RegUser();
  }
}

Future<RegUser> _createRegUser(String id, String email, String pass) async {
  final response = await http.post(
    Uri.parse('http://10.100.26.63:5000/api/auth/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'user_name': id,
      'email_id': email,
      'user_pass': pass,
    }),
  );
  print(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.

    return RegUser.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to convert!');
  }
}

Future<bool> register(String id, String email, String pass) async {
  print('Register Invoked');
  try {
    await _createRegUser(id, email, pass).then((value) {
      print('User Created.');
    });
  } catch (e) {
    print('Error');
    return false;
  }
  return true;
}
