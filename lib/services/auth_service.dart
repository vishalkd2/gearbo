
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
import 'package:gearbo/model/user_login_model.dart';

class AuthService {
  static const String _baseUrl = 'https://hr-team-ds4i.onrender.com/api/rooms';

  Future<UserLoginModel?> login(String email,String password)async{
    try{
      final response =  await http.post(Uri.parse('$_baseUrl/login'),
      headers: {'Content-Type':'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );

      if(response.statusCode==200){
        final Map<String,dynamic> data = jsonDecode(response.body);
        debugPrint("Debug #1: $data");
        return UserLoginModel.fromJson(data);
      }else {
        final Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint('Login failed: ${data['message']}');
        return null;
      }
    }catch(e){print("Exception error in AuthService class $e");}
    return null;
  }

}