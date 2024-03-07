import 'package:flutter/material.dart';
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
  final bool isActive;
  final String deviceType;
  final String deviceLabel;

  const UnitDeviceItem({
    required this.deviceLabel,
    required this.isActive,
    required this.deviceType,
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
                  Text(widget.deviceLabel, style: AppStyle.roomLabelStyle,),
                  Text(widget.deviceType, style: AppStyle.deviceCountLabelStyle,)
                ],
              )),
            const SizedBox(width: 10,),
            DToggleButton(onChange: (v){})
          ],
        ),
      ),
    );
  }
}


class Devices extends StatelessWidget{
  const Devices({super.key});

  @override
  Widget build(BuildContext context){

    List<String> devices = [
      "Light one",
      "Fan",
      "Ac controller",
      "Light Strips",
    ];

    return Column(
      children: List.generate(
        devices.length, (index) => UnitDeviceItem(
          deviceLabel: devices[index], 
          deviceType: AppConstants.outputDevice,
          isActive: false)),
    );
  }
}


class SimpleRow extends StatelessWidget{
  final String label;
  const SimpleRow({required this.label, super.key});

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppStyle.roomLabelStyle,),

        IconButton(
          onPressed: (){}, 
          icon: const CircleAvatar(child:Icon(Icons.add)))
      ],
    );
  }
}