// using dio
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:network_flutter/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UserService {
  String endpoint = 'https://jsonplaceholder.typicode.com/users';
  Future<List<User>> getUsers() async {
     List<User> users = [];
    try {
      final response = await Dio().get(endpoint);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('users', jsonEncode(response.data));
      response.data.forEach((user) {
        users.add(User.fromJson(user));
      });

    } catch (e) {
      print(e);
    }
     return users;
  }

}