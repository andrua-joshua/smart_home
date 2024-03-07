import 'dart:convert';
import 'dart:html';

import 'package:flutter_blue/flutter_blue.dart';

class AppBluetoothLogic{

  static BluetoothDevice? connectedDevice;

  static Future<void> turnOn(int pin) async {
    List<BluetoothService> services = await connectedDevice!.discoverServices();


    for(final service in services){
      for(final characteristic in service.characteristics){
        characteristic.write([pin, 1]);
      }
    }
    
  }

  static Future<void> turnOff(int pin) async {
    List<BluetoothService> services = await connectedDevice!.discoverServices();


    for(final service in services){
      for(final characteristic in service.characteristics){
        characteristic.write([pin, 0]);
      }
    }
  }

  static Future<void> readOn(int pin) async {

  }

  // static Future<void> addDevice(int pin, String deviceLabel, ) async {
  //   // window.localStorage
  // }

  static Future<List<BluetoothDevice>> connectedDevices(int pin)async{
     return await FlutterBlue.instance.connectedDevices;
  }

  static Future<void> setDevice(int index)async{
    List<BluetoothDevice> devices = await FlutterBlue.instance.connectedDevices;
    connectedDevice = devices[index];
  }

}