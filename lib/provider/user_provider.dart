

import 'package:flutter/material.dart';
import 'package:gearbo/model/user_login_model.dart';
import 'package:gearbo/services/auth_service.dart';

class UserProvider extends ChangeNotifier{

  final AuthService auth = AuthService();
  bool _isLoading = false;
  bool  get isLoading => _isLoading;

  UserLoginModel? _currentUser;
  UserLoginModel? get currentUser => _currentUser;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;


  Future<bool> login(String email,String password)async{
    _isLoading =  true;
    _errorMessage = null;
    notifyListeners();
    final UserLoginModel? result =  await auth.login(email, password);
    _isLoading = false;
    if (result != null && result.token != null) {
      _currentUser = result;
      notifyListeners();
      return true;
    }else {
      _errorMessage = result?.message ?? 'Invalid email or password.';
      notifyListeners();
      return false; // ✅ Failure — UI error dikhayega
    }
  }
  void logout() {
    _currentUser = null;
    _errorMessage = null;
    notifyListeners();
  }
}