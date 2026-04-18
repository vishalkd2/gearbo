

import 'package:flutter/foundation.dart';
import 'package:gearbo/model/room_model.dart';
import 'package:gearbo/services/room_service.dart';

class RoomProvider extends ChangeNotifier{
  final RoomService _roomService = RoomService();

  List<RoomModel> _rooms = [];
  List<RoomModel> get rooms => _rooms;

  bool _isLoading = false ;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchRooms(String token)async{
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    final result = await _roomService.getRooms(token);
    _isLoading = false;
    if (result != null) {
      _rooms = result;
    } else {
      _errorMessage = 'Rooms are not loading plz try again.';
    }
    notifyListeners();
  }
}