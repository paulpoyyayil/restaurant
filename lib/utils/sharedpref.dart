import 'package:flutter/material.dart';
import 'package:restaurant/main.dart';
import 'package:restaurant/screens/login/login.dart';
import 'package:restaurant/utils/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Service {
  saveEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
  }

  getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email') ?? '';
    return email;
  }

  removeEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
  }

  saveLogin() async {
    isLoggedIn = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('login', true);
  }

  logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn = false;
    prefs.remove('login');
    if (context.mounted) {
      navigationReplacement(context, const LoginScreen());
    }
  }
}
