class Device{
  String deviceName;
  String deviceType;
  int devicePin;
  int deviceState;

  Device({
    required this.deviceName,
    required this.deviceType,
    required this.devicePin,
    required this.deviceState
  });

  Map<String, dynamic> toJson(){
    
    return {
      "deviceName": deviceName,
      "deviceType": deviceType,
      "devicePin": devicePin,
      "deviceState":deviceState
    };
  }
}




///device model
///--> deviceName {String}
///--> devicePin {int}
///--> deviceType(OUTPUT || INPUT) {String}
///--> deviceState (ON || OFF) {int}