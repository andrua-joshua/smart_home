import 'package:flutter/material.dart';

class RoomDevicesProvider with ChangeNotifier{

  void notify(){
    notifyListeners();
  }
}