import 'package:flutter/widgets.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime expiryDate;
  String userId;

  Future<void> signup(String email, String password) async {}
}
