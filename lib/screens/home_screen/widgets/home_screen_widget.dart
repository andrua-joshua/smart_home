import 'package:flutter/material.dart';
import 'package:smart_home/bloc/logic.dart';
import 'package:smart_home/bloc/storage_logic/model/room.dart';
import 'package:smart_home/bloc/storage_logic/storage.dart';
import 'package:smart_home/providers/devices_provider.dart';
import 'package:smart_home/route.dart';
import 'package:smart_home/screens/dialogs/dialogs.dart';
import 'package:smart_home/util/app_colors.dart';
import 'package:smart_home/util/app_images.dart';
import 'package:smart_home/util/app_styles.dart';
import 'package:provider/provider.dart';

class TopWidget extends StatefulWidget{
  const TopWidget({super.key});


  @override
  TopWidgetState createState () => TopWidgetState();
  
}

class TopWidgetState extends State<TopWidget>{

  bool isConnected = false;
  @override
  Widget build(BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 3)
        )  ,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15)
        )
      ),

      padding: const EdgeInsets.all(10),

      child: Column(
        children: [
          const SizedBox(height: 50,),
          SizedBox(
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: AppColor.dualWhiteBgColor,
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(AppImages.appLogoImage))
                  ),
                ),
                const SizedBox(width: 20,),
                const Expanded(child: Text("MGT TECHNOLOGIES", style: AppStyle.titleStyle,)),
                IconButton(
                  onPressed: (){
                    showDialog(
                      context: context, 
                      builder: (conetext){
                        return AlertDialog(
                          contentPadding: const EdgeInsets.all(0),
                          content: BTListDialog(
                            onConnected: (){
                              setState(() {
                                isConnected = true;
                              });
                            },
                          ),
                        );
                      });
                  }, 
                  icon: CircleAvatar(
                    backgroundColor: isConnected? AppColor.primaryColor: null,
                    child:const Icon(Icons.bluetooth)))
              ],
            ),
          ),

          const SizedBox(height: 30,),
          const SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SimpleInputDataWidget(
                  label: "Indoor Temp", 
                  value: "10 C"),
                VDivider(height: 40, width: 1, color: Colors.grey),
                SimpleInputDataWidget(
                  label: "Smoke Sensor", 
                  value: "30"),
                VDivider(height: 40, width: 1, color: Colors.grey),
                SimpleInputDataWidget(
                  label: "Indoor Temp", 
                  value: "10 C"),
              ],
            ),
          ),

          // const SizedBox(height: 10,)
        ],
      ),
    );
  }
}


class SimpleInputDataWidget extends StatelessWidget{
  final String  label;
  final String value;

  const SimpleInputDataWidget({
    required this.label,
    required this.value,
    super.key
  });

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Text(value, style: AppStyle.sensorDataStyle,),
        Text(label)
      ],
    );
  }
}


class VDivider extends StatelessWidget{
  final double height;
  final double width;
  final Color color;

  const VDivider({
    required this.height,
    required this.width,
    required this.color,
    super.key
  });


  @override
  Widget build(BuildContext context){
    return Container(
      width: width,
      height: height,
      color: color,
    );
  }
}



class OptionsWidget extends StatefulWidget{
  final Function(int) onChange;
  final List<String> labels;
  final int currentIndex;

  const OptionsWidget({
    required this.labels,
    required this.onChange,
    required this.currentIndex,
    super.key
  });


  @override
  OptionsWidgetState createState () => OptionsWidgetState();

}


class OptionsWidgetState extends State<OptionsWidget>{

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.labels.length, (index) => GestureDetector(
          onTap: ()=> widget.onChange(index),
          child:OptionsItemWidget(
          label: widget.labels[index], 
          isActive: widget.currentIndex == index))),
    );
  }
}


class OptionsItemWidget extends StatelessWidget{
  final bool isActive;
  final String label;

  const OptionsItemWidget({
    required this.label,
    required this.isActive,
    super.key
  });


  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),

      margin: const EdgeInsets.symmetric(horizontal: 5),

      padding:  EdgeInsets.symmetric(
        horizontal: isActive? 5: 0, 
        vertical: isActive? 1:0),
      
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10
        ),

        child: Text(label),
      ),
    );
  }
}


class UnitRoomItem extends StatefulWidget{
  final String label;
  final int roomIndex;
  final int devicesCount;
  final double width;

  const UnitRoomItem({
    required this.label,
    required this.roomIndex,
    required this.devicesCount,
    required this.width,
    super.key
  });


  @override
  UnitRoomItemState createState () => UnitRoomItemState();


}

class UnitRoomItemState extends State<UnitRoomItem>{

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, RouteGenerator.roomDetailsScreen, arguments: widget.roomIndex),
      child:Container(
      width: widget.width,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      padding: const EdgeInsets.all(10),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleAvatar(),
                DToggleButton(
                  onChange: (val){
                    DataStorage.changeAllRomDeviceState(roomIndex: widget.roomIndex, state: val? 0:1);
                  })                
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Text(widget.label, style: AppStyle.roomLabelStyle,),
          Text("${widget.devicesCount} devices connected", style: AppStyle.deviceCountLabelStyle,),
          const SizedBox(height: 20,),
          Center(child:Text("${widget.devicesCount-1} devices active")),
          const SizedBox(height: 10,),
        ],
      ),
    ));
  }
}


class RoomItems extends StatelessWidget{
  final List<Room> rooms;
  const RoomItems({super.key, required this.rooms});


  @override
  Widget build(BuildContext context){


    return ChangeNotifierProvider<RoomDevicesProvider>(
      create: (context) => RoomDevicesProvider(),
      builder:(context, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child:LayoutBuilder(
      builder: (context, constraints){

        double width = constraints.maxWidth*0.48;
        int count = 0;
        int itemsCount = rooms.length;
        int rows = (itemsCount/2).ceil();
        int rem = itemsCount%2;

        debugPrint("::::: items Count::> $itemsCount");
        return Consumer<RoomDevicesProvider>(
          builder:(context, value, child) {
            return Column(
          children: List.generate(
            rows, (index) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                (rem>0 && rows == (index+1))? 1: 2 , (index2)  {

                  ++count;
                  debugPrint("::::>>>>>>>>> current roomIndex:  ${count}");
                  return UnitRoomItem(
                    devicesCount:  rooms[count-1].devices.length,
                  label: rooms[count-1].roomLabel, roomIndex: count-1, width: width);}),
            )),
        );
          }, );

      }));
      },);
  }
}


class DToggleButton extends StatefulWidget{
  bool? initState;
  final Function(bool) onChange;
  DToggleButton({required this.onChange ,super.key, this.initState});

  @override
  DToggleButtonState createState () => DToggleButtonState();

}


class DToggleButtonState extends State<DToggleButton>{

  bool? isActive;

  @override
  Widget build(BuildContext context){
    bool newState;
    if(widget.initState!=null && isActive ==null){
      isActive = widget.initState;
    }else if(widget.initState==null && isActive ==null){
      isActive = false;
    }
    return GestureDetector(
      onTap: (){
        setState(() {
          
          bool state = isActive?? false;
          isActive = !state;
          widget.onChange(state);
        });
      },
      child:Container(
      decoration: BoxDecoration(
        color: (newState = isActive??false)? AppColor.primaryColor: null,
        border:(newState = isActive??false)? null : Border.all(color: AppColor.primaryColor, width: 1),
        borderRadius: BorderRadius.circular(6)
      ),

      padding: EdgeInsets.only(
        left: (newState = isActive??false)? 12: 1,
        right: (newState = isActive??false)? 1: 12
      ),

      child: CircleAvatar(
        radius: 6,
        backgroundColor: (newState = isActive??false)? Colors.white: AppColor.primaryColor,
      ),
    ));
  }
}