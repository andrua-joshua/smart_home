import 'package:flutter/material.dart';
import 'package:smart_home/bloc/storage_logic/model/device.dart';
import 'package:smart_home/bloc/storage_logic/storage.dart';
import 'package:smart_home/screens/home_screen/widgets/home_screen_widget.dart';
import 'package:smart_home/util/app_colors.dart';
import 'package:smart_home/util/app_constants.dart';
import 'package:smart_home/util/app_styles.dart';

class AdsWidget extends StatefulWidget{
  const AdsWidget({super.key});

  
  @override
  AdsWidgetState createState () => AdsWidgetState();

}

class AdsWidgetState extends State<AdsWidget>{

  @override
  Widget build(BuildContext context){
    return Container(
      constraints: const BoxConstraints.expand(height: 150),
      color: Colors.white,
    );
  }
}


class UnitDeviceItem extends StatefulWidget{
  final int deviceIndex;
  final int roomIndex;

  const UnitDeviceItem({
    required this.deviceIndex,
    required this.roomIndex,
    super.key
  });


  @override
  UnitDeviceItemState createState () => UnitDeviceItemState();

}


class UnitDeviceItemState extends State<UnitDeviceItem>{

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.primaryColor
      ),

      padding: const EdgeInsets.only(
        left: 4,
        right: 1,
        top: 1,
        bottom: 1
      ),

      margin: const EdgeInsets.symmetric(vertical: 10),

      child: Container(
        // height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),

        padding: const EdgeInsets.all(10),

        child: Row(
          children: [
            const CircleAvatar(
              radius: 20,
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DataStorage.allRooms[widget.roomIndex]
                    .devices[widget.deviceIndex].deviceName, 
                    style: AppStyle.roomLabelStyle,),
                  Text(
                    DataStorage.allRooms[widget.roomIndex]
                    .devices[widget.deviceIndex].deviceType, 
                    style: AppStyle.deviceCountLabelStyle,)
                ],
              )),
            const SizedBox(width: 10,),
            DToggleButton(
              initState: 
                DataStorage.allRooms[widget.roomIndex]
                    .devices[widget.deviceIndex].deviceState==1? true:false,
              onChange: (v)async{
                DataStorage.changeRoomDeviceState(
                  roomIndex: widget.roomIndex, 
                  deviceIndex: widget.deviceIndex, 
                  state: v?0:1);
              })
          ],
        ),
      ),
    );
  }
}


class Devices extends StatelessWidget{
  final List<Device> devices;
  final int roomIndex;
  const Devices({super.key, required this.devices, required this.roomIndex});

  @override
  Widget build(BuildContext context){

    return Column(
      children: List.generate(
        devices.length, (index) => 
        UnitDeviceItem(
          roomIndex: roomIndex,
          deviceIndex: index,)),
    );
  }
}


class SimpleRow extends StatelessWidget{
  final String label;
  final Function() onclick;
  const SimpleRow({required this.label, super.key, required this.onclick});

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppStyle.roomLabelStyle,),

        IconButton(
          onPressed: ()=> onclick(), 
          icon: const CircleAvatar(child:Icon(Icons.add)))
      ],
    );
  }
}