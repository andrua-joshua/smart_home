import 'package:flutter/material.dart';
import 'package:smart_home/bloc/storage_logic/storage.dart';
import 'package:smart_home/route.dart';
import 'package:smart_home/screens/dialogs/dialogs.dart';
import 'package:smart_home/screens/room_details_screen/widgets/room_details_widget.dart';
import 'package:smart_home/util/app_colors.dart';
import 'package:smart_home/util/app_fontsizes.dart';
import 'package:smart_home/util/app_styles.dart';

class RoomDetailsScreen extends StatefulWidget{
  final int  roomIndex;
  const RoomDetailsScreen({required this.roomIndex ,super.key});

  @override
  RoomDetailsScreenState createState () => RoomDetailsScreenState();

}


class RoomDetailsScreenState extends State<RoomDetailsScreen>{

  

  @override
  Widget build(BuildContext context){
    final devices = DataStorage.allRooms[widget.roomIndex].devices;

    return Scaffold(
      backgroundColor: AppColor.dualWhiteBgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=> Navigator.pop(context), 
          icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: Text(DataStorage.allRooms[widget.roomIndex].roomLabel, style: AppStyle.titleStyle,),
        actions: [
          IconButton(
            onPressed: (){
              showDialog(
                context: context, 
                builder:(context) {
                  return SimpleDialog(
                    title: Text("Remove Room"),
                    
                    children: [
                      const Center(child:Text("Your about to Remove room!", style: TextStyle(fontSize: AppFontSize.normalFontSize),)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed:()async {
                              await DataStorage.changeAllRomDeviceState(roomIndex: widget.roomIndex, state: 0);
                              await DataStorage.removeRoom(roomIndex: widget.roomIndex);
                              Navigator.pop(context);
                              Navigator.pushNamed(context, RouteGenerator.homeScreen);
                            }, 
                            child: const Text("Remove", style: TextStyle(color: Colors.red, fontSize: AppFontSize.normalFontSize),)),
                          
                          TextButton(
                            onPressed:()=> Navigator.pop(context), 
                            child: const Text("Cancel", style: TextStyle(fontSize: AppFontSize.normalFontSize),))
                        ],
                      )
                    ],
                  );
                },);
            }, 
            icon: const Icon(Icons.more_vert))
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                const AdsWidget(),
                const SizedBox(height: 25,),
                SimpleRow(
                  label: "Devices",
                  onclick: () {
                    showDialog(
                      context: context, 
                      builder: (conetext){
                        return AlertDialog(
                          contentPadding: EdgeInsets.all(0),
                          content: AddDeviceDialog(
                            roomIndex: widget.roomIndex,
                            onAdded: (){
                              setState(() {
                        
                              });
                            },
                          )
                        );
                    });
                  },),
                const SizedBox(height: 10,),
                Devices(
                  roomIndex: widget.roomIndex,
                  devices: devices
                )
              ],
            ),
          ),)),
    );
  }
}