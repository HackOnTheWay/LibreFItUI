// --- Modified
import 'dart:convert';
import 'package:LibreFit/logic/login.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

String email_id = '';
String last_seen = '';
String profile_pic = '';
String streaks = '';
String user_id = '';
String user_name = '';

class Profile {
  String email_id;
  String last_seen;
  String profile_pic;
  String streaks;
  String user_id;
  String user_name;

  Profile(
      {required this.email_id,
      required this.last_seen,
      required this.profile_pic,
      required this.streaks,
      required this.user_id,
      required this.user_name});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      email_id: json['email_id'],
      last_seen: json['last_seen'] == null ? DateTime.now().toString() : json['last_seen'].toString(),
      profile_pic: json['profile_pic'] == null ? '' : json['profile_pic'],
      streaks: json['streaks'] == null ? '0' : json['streaks'].toString(),
      user_id: json['user_id'].toString(),
      user_name: json['user_name'],
    );
  }
}

void copy({
  String? iprofile_pic,
  String? istreaks,
  String? iuser_name,
  String? iuser_id,
  String? ilast_seen,
  String? iemail,
  String? iabout,
}) {
  profile_pic = iprofile_pic ?? profile_pic;
  streaks = istreaks ?? streaks;
  user_name = iuser_name ?? user_name;
  user_id = iuser_id ?? user_id;
  last_seen = ilast_seen ?? last_seen;
  email_id = iemail ?? email_id;
}

Future<Profile> _getProfile() async {
  final response = await http.get(
    Uri.parse('http://10.100.26.63:5000/api/get_user'), //TODO
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + access_token,
    },
  );
  print(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.

    return Profile.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to convert!');
  }
}

Future<bool> getProfile() async {
  print('Get Profile Invoked');
  try {
    await _getProfile().then((value) {
      print(email_id);
      email_id = value.email_id;
      last_seen = value.last_seen;
      profile_pic = value.profile_pic;
      streaks = value.streaks;
      user_id = value.user_id;
      user_name = value.user_name;
      print('Profile Obtained');
    });
  } catch (e) {
    print('Error $e');
    return false;
  }
  return true;
}
