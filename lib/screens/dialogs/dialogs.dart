import 'package:flutter/material.dart';
import 'package:smart_home/util/app_colors.dart';
import 'package:smart_home/util/app_styles.dart';

class AddRoomDialog extends StatefulWidget{
  const AddRoomDialog({super.key});

  @override
  AddRoomDialogState createState () => AddRoomDialogState();
  
}


class AddRoomDialogState extends State<AddRoomDialog>{
  

  @override
  Widget build(BuildContext context){
    return Container();
  }
}


class AddDeviceDialog extends StatefulWidget{
  const AddDeviceDialog({super.key});

  @override
  AddDeviceDialogState createState () => AddDeviceDialogState();
  
}


class AddDeviceDialogState extends State<AddDeviceDialog>{
  

  @override
  Widget build(BuildContext context){
    return Container();
  }
}



class BTListDialog extends StatefulWidget{
  const BTListDialog({super.key});

  @override
  BTListDialogState createState () => BTListDialogState();
  
}


class BTListDialogState extends State<BTListDialog>{
  

  @override
  Widget build(BuildContext context){
    return Container(
      height: 200,
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
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  6, (index) => UnitBTDeviceItem(btName: "BT Device $index")),
              ),
            ))
        ],
      ),
    );
  }
}



class UnitBTDeviceItem extends StatelessWidget{
  final String btName;
  const UnitBTDeviceItem({
    required this.btName,
    super.key
  });


  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Text(btName),
      ),
    );
  }
}