import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_home/bloc/logic.dart';
import 'package:smart_home/bloc/storage_logic/model/device.dart';
import 'package:smart_home/bloc/storage_logic/model/room.dart';

class DataStorage{

  static final LocalStorage storage = LocalStorage('smart_home.json');
  
  

  static final List<Room> allRooms = [];

  // ignore: slash_for_doc_comments
  /**
   * ======the functionalities of the class======
   *  1. add a room
   *  2. remove room
   *  3. add device to room
   *  4. remove device from room
   *  5. change room device state
   *  6. change room's all devices state
   **/

  static Future<File> localSaveFile () async{
    final directory = await getApplicationDocumentsDirectory();

    return File("${directory.path}/smart_home.json");
  }


   static Future<void> saveData()async{
      final jsonString = jsonEncode(allRooms);

      final file = await localSaveFile();
      await file.writeAsString(jsonString);
      debugPrint("::: >   data saved====>  $jsonString");

   }

   static Future<void> loadFromFile()async{
    final file = await localSaveFile();
    if(await file.exists()){
      
    final dataString = await file.readAsString();

    if(dataString!=""){
      final jsonData1 = jsonDecode(dataString);
      debugPrint(":::::::decoded jsonData from file:::   $jsonData1");
      final jsonData = jsonDecode(dataString) as Map<String,dynamic>;

    debugPrint(":::::::decoded jsonData from file:::   $jsonData");

    // ignore: prefer_null_aware_operators
    jsonData['rooms']!=null? jsonData['rooms'].forEach((room) {
        final _room = room as Map<String, dynamic>;
        debugPrint(":::::::Room data(Map):::   ${_room['roomLabel']}");

        final roomDevices = _room['devices'] as List<dynamic>;
        final List<Device> devices = [];
        roomDevices.forEach((_device) {
            devices.add(Device(
              deviceName: _device["deviceName"], 
              deviceType: _device["deviceType"], 
              devicePin: _device["devicePin"] as int, 
              deviceState: _device["deviceState"]));
            
            debugPrint("Device saved and added...................");
         });
        allRooms.add(Room(
          roomLabel: _room['roomLabel'], 
          devices: devices));
        debugPrint("Data completely saved and added...................");
     }):null;}}


   }


   static Future<void> initState () async{

      if(storage.getItem("rooms")!=null){
        debugPrint("::::::::::::::>>>>>> Room not null");
        final jsonRooms  = storage.getItem("rooms") as List<Map<String, dynamic>>;
        jsonRooms.forEach((room) {
        final roomLabel = room["roomLabel"];
        final List<Device> roomDevices = [];

        final roomDevicesAsJson = room["devices"] as List<Map<String, dynamic>>;
        
        roomDevicesAsJson.forEach((device) { 
          roomDevices.add(
            Device(
              deviceName: device["deviceName"], 
              deviceType: device["deviceType"], 
              devicePin: device["devicePin"], 
              deviceState: device["deviceState"])
          );
        });

        allRooms.add(Room(roomLabel: room["roomLabel"] , 
            devices: roomDevices));
      });}
   }

   static Future<void> addRoom({required Room room}) async{
      await storage.ready;
      final List<Map<String, dynamic>> jsonRooms = [];
      allRooms.add(room);
      debugPrint("::::>>>>>>>>> New room added:  ${room.roomLabel} current roomCount: ${allRooms.length}");
      allRooms.forEach((room2) { 
        jsonRooms.add(room2.toJson());
      });

      debugPrint("::::>>>>>>>>> New room added (after):  ${room.roomLabel} current roomCount: ${allRooms.length}");

      await storage.setItem("rooms", jsonRooms);
      // await initState();
      await saveData();
      debugPrint("::::>>>>>>>>> New room added (end):  ${room.roomLabel} current roomCount: ${allRooms.length}");
   }

   static Future<void> removeRoom({required int roomIndex}) async{
      await storage.ready;
      allRooms.removeAt(roomIndex);
      final List<Map<String, dynamic>> jsonRooms = [];
      allRooms.forEach((room) { 
        jsonRooms.add(room.toJson());
      });

      await saveData();
      await storage.setItem("rooms", jsonRooms);
      
   }

   static Future<void> addDeviceToRoom({required int roomIndex, required Device device}) async{
    debugPrint("::::>> Starting to add device to room.....");
      await storage.ready;

      allRooms[roomIndex].devices.add(device);
      debugPrint("::::>> Device added to Room: ${device.deviceName}");
      final List<Map<String, dynamic>> jsonRooms = [];
      allRooms.forEach((room) { 
        jsonRooms.add(room.toJson());
      });
      await saveData();
      await storage.setItem("rooms", jsonRooms);
   }

   static Future<void> removeDeviceFromRoom({required int roomIndex, required int deviceIndex}) async{
      await storage.ready;

      allRooms[roomIndex].devices.removeAt(deviceIndex);

      final List<Map<String, dynamic>> jsonRooms = [];
      allRooms.forEach((room) { 
        jsonRooms.add(room.toJson());
      });

      await storage.setItem("rooms", jsonRooms);
   }

   static Future<void> changeRoomDeviceState({required int roomIndex, required int deviceIndex, required int state}) async{
      await storage.ready;
      Device device = allRooms[roomIndex].devices[deviceIndex];
      
      await AppBluetoothLogic.sendOne(pin: device.devicePin, state: state);
      device.deviceState = state;
      

      final List<Map<String, dynamic>> jsonRooms = [];
      allRooms.forEach((room) { 
        jsonRooms.add(room.toJson());
      });

      await storage.setItem("rooms", jsonRooms);
   }

   static Future<void> changeAllRomDeviceState({required int roomIndex, required int state}) async{

      List<int> pins = [];
      allRooms.forEach((room) {
        room.devices.forEach((device) { 
          pins.add(device.devicePin);
        });
       });

       await AppBluetoothLogic.sendBulk(pins: pins, state: state);
   }

}