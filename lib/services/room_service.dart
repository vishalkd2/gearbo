

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:gearbo/model/room_model.dart';
import 'package:http/http.dart'as http;

class RoomService {
  static const String _baseUrl = 'https://hr-team-ds4i.onrender.com/api/rooms/get-all-rooms';

  Future<List<RoomModel>?> getRooms(String token)async{
    try{
  final response = await http.get(Uri.parse(_baseUrl),
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  });
  debugPrint('Rooms status: ${response.statusCode}');
  debugPrint('Rooms body: ${response.body}');
  if(response.statusCode==200){
    final Map<String,dynamic> data = jsonDecode(response.body);
    final List roomJson = data['rooms'];
    return roomJson.map((e)=>RoomModel.fromJson(e)).toList();
  }
    }catch(e){debugPrint('Exception in RoomService.getRooms(): $e');}
    return null;
  }
}