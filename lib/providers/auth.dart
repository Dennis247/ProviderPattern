import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider_pattern/models/http_exception.dart';

class Auth with ChangeNotifier {
  String _apiKey = "AIzaSyBVxWjb6WHgteoB3oyawAT-yu0PuH5CoIk";
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> _authenticateUser(
      String email, String password, String urlSegment) async {
    final String _signUpUrl =
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$_apiKey";
    try {
      final response = await http.post(_signUpUrl,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      print(response.body);
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> signUp(String email, String password) async {
    await _authenticateUser(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    await _authenticateUser(email, password, "signInWithPassword");
  }
}
