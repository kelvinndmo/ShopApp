import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  String _token;
  DateTime expiryDate;
  String userId;

  Future<void> signup(String email, String password) async {
    var url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDl75pM7ccq519nrmnKVSSXCWdNDp6xoYE";

    final response = await http.post(url,
        body: json.encode(
            {'email': email, 'password': password, 'returnSecureToken': true}));

    print(json.decode(response.body));
  }
}
