import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:flutter_blue/gen/flutterblue.pbserver.dart';
import 'package:smart_home/bloc/logic.dart';
import 'package:smart_home/bloc/storage_logic/model/device.dart';
import 'package:smart_home/bloc/storage_logic/model/room.dart';
import 'package:smart_home/bloc/storage_logic/storage.dart';
import 'package:smart_home/providers/devices_provider.dart';
import 'package:smart_home/util/app_colors.dart';
import 'package:smart_home/util/app_fontsizes.dart';
import 'package:smart_home/util/app_styles.dart';

class AddRoomDialog extends StatefulWidget{
  final Function() onAdded;
  const AddRoomDialog({super.key, required this.onAdded});

  @override
  AddRoomDialogState createState () => AddRoomDialogState();
  
}


class AddRoomDialogState extends State<AddRoomDialog>{
 //room label 
 final TextEditingController roomLabelController = TextEditingController();


  @override
  void dispose(){
    roomLabelController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Container(
      height: 220,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10)
        )
      ),

      padding: const EdgeInsets.all(10),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(child:Text("Add Room", style: AppStyle.titleStyle,)),
          const Divider(thickness: 1, color: AppColor.dualWhiteBgColor,),
          const SizedBox(height: 10,),
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.dualWhiteBgColor
                  ),

                  padding: const EdgeInsets.symmetric(horizontal: 10),

                  child: TextField(
                    controller: roomLabelController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Room label e.g Living Room"
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                TextButton(
                  onPressed:()async{
                    final String roomLabel = roomLabelController.text;
                    await DataStorage.addRoom(
                      room: Room(roomLabel: roomLabel, devices: []));
                    Navigator.pop(context);
                    widget.onAdded();
                    debugPrint("::::Room added");
                  } , 
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColor.primaryColor
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5
                    ),

                    child: const Text(
                      "Add Room",
                      style: TextStyle(
                        fontSize: AppFontSize.normalFontSize,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),),
                  ))
              ],
            )
      )],
      ),
    );
  }
}


class AddDeviceDialog extends StatefulWidget{
  final int roomIndex;
  final Function() onAdded;
  const AddDeviceDialog({super.key, required this.roomIndex ,required this.onAdded});

  @override
  AddDeviceDialogState createState () => AddDeviceDialogState();
  
}


class AddDeviceDialogState extends State<AddDeviceDialog>{
  
  final TextEditingController deviceLabelController = TextEditingController();
  final TextEditingController deviceTypeController = TextEditingController();
  final TextEditingController devicePinController = TextEditingController();



  @override
  void dispose(){
    deviceLabelController.dispose();
    devicePinController.dispose();
    deviceTypeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Container(
      height: 320,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10)
        )
      ),

      padding: const EdgeInsets.all(10),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(child:Text("Add BT Devices", style: AppStyle.titleStyle,)),
          const Divider(thickness: 1, color: AppColor.dualWhiteBgColor,),
          const SizedBox(height: 10,),
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.dualWhiteBgColor
                  ),

                  padding: const EdgeInsets.symmetric(horizontal: 10),

                  child: TextField(
                    controller: deviceLabelController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Device Name e.g Fan"
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.dualWhiteBgColor
                  ),

                  padding: const EdgeInsets.symmetric(horizontal: 10),

                  child: TextField(
                    controller: deviceTypeController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Device Type either OUTPUT or INPUT"
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.dualWhiteBgColor
                  ),

                  padding: const EdgeInsets.symmetric(horizontal: 10),

                  child: TextField(
                    controller: devicePinController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "e.g 24"
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                TextButton(
                  onPressed:(){
                    debugPrint(":::::::Adding device clicked.....");
                    final String deviceLabel = deviceLabelController.text;
                    final String deviceType = deviceTypeController.text;
                    final int devicePin = int.parse(devicePinController.text);
                    DataStorage.addDeviceToRoom(
                      roomIndex: widget.roomIndex,
                      device: Device(
                        deviceName: deviceLabel, 
                        deviceType: deviceType, 
                        devicePin: devicePin, 
                        deviceState: 0)
                    ).then((value) {
                      Navigator.pop(context);
                      widget.onAdded();
                      RoomDevicesProvider().notify();
                    });
                    
                  } , 
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColor.primaryColor
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5
                    ),

                    child: const Text(
                      "Add Device",
                      style: TextStyle(
                        fontSize: AppFontSize.normalFontSize,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),),
                  ))
              ],
            )
      )],
      ),
    );
  }
}



class BTListDialog extends StatefulWidget{
  final Function() onConnected;
  const BTListDialog({super.key, required this.onConnected});

  @override
  BTListDialogState createState () => BTListDialogState();
  
}


class BTListDialogState extends State<BTListDialog>{
  

  @override
  Widget build(BuildContext context){
    return Container(
      height: 220,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10)
        )
      ),

      padding: const EdgeInsets.all(10),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(child:Text("Connected BT Devices", style: AppStyle.titleStyle,)),
          const Divider(thickness: 1, color: AppColor.dualWhiteBgColor,),
          const SizedBox(height: 10,),
          Expanded(
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: AppBluetoothLogic.bondedDevices(), 
                builder:(context, snapshot) {
                  
                  if(snapshot.hasData){
                    debugPrint("Drillox--prints::: ${snapshot.data!.length}");
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                      snapshot.data!.length, 
                      (index) => UnitBTDeviceItem(
                        btDevice: snapshot.data![index] as BluetoothDevice, 
                        index: index,
                        onConnected:()=> widget.onConnected(),)),
                    );
                  }

                  if(snapshot.hasError){
                    debugPrint(":::::>> ErrorObj::  ${snapshot.error}");
                    return Center(child:Text("Error, Check your BT ${snapshot.error}"));
                  }

                  return const Center(child: CircularProgressIndicator(color: AppColor.primaryColor,),);
                },),
            ))
        ],
      ),
    );
  }
}



class UnitBTDeviceItem extends StatelessWidget{
  final BluetoothDevice btDevice;
  final int index;
  final Function() onConnected;
  const UnitBTDeviceItem({
    required this.index,
    required this.onConnected,
    required this.btDevice,
    super.key
  });


  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: ()async{
        Navigator.pop(context);
        showDialog(context: context, 
        builder:(context) {
          
          return AlertDialog(
            title: const Text("Connecting to Device"),
            contentPadding: const EdgeInsets.all(10),
            content: FutureBuilder(
                future: AppBluetoothLogic.setDevice(btDevice),
                 builder: (context, snapshot){
                  if(snapshot.hasData){
                    onConnected();
                    return Text("Connected to ${btDevice.platformName} Successfully!");
                  }
                  if(snapshot.hasError){
                    return Text("Error: ${snapshot.error.toString()}");
                  }
                  return const CircleAvatar(
                    child: CircularProgressIndicator(color: AppColor.primaryColor, strokeWidth: 5,));
                 },
            ),
          );
        },);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Text(btDevice.platformName),
      ),
    );
  }
}



class DeleteRoomDialog extends StatelessWidget{
  final int roomIndex;
  const DeleteRoomDialog({super.key, required this.roomIndex});

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        
      ),

      padding: const EdgeInsets.all(10),
      
    );
  }
}