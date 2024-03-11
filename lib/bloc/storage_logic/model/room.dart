import 'package:smart_home/bloc/storage_logic/model/device.dart';

class Room {
  final String roomLabel;
  final List<Device> devices;

  const Room({required this.roomLabel, required this.devices});

  Map<String, dynamic> toJson(){
    
    List<Map<String, dynamic>> _devices = [];

    devices.forEach((device) {
      _devices.add(device.toJson());
     });

    return {
      "roomLabel": roomLabel,
      "devices": _devices
    };
  }
}


///
///Room storage structure
///--> roomName {String}
///--> devicesConnected {List<device>}
