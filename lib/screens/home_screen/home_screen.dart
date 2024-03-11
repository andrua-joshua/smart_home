import 'package:flutter/material.dart';
import 'package:smart_home/bloc/storage_logic/storage.dart';
import 'package:smart_home/screens/dialogs/dialogs.dart';
import 'package:smart_home/screens/home_screen/widgets/home_screen_widget.dart';
import 'package:smart_home/util/app_colors.dart';
import 'package:smart_home/util/app_styles.dart';


class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState(); 

}


class HomeScreenState extends State<HomeScreen>{

  int currentIndex = 0;
  final rooms = DataStorage.allRooms;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: AppColor.dualWhiteBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child:Column(
          children: [
            const TopWidget(),
            const SizedBox(height: 20,),
            const Text("Available Rooms", style:  AppStyle.titleStyle,),
            const SizedBox(height: 20,),
            RoomItems(
              rooms: rooms
            )
          ],
        ))),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context, 
            builder: (conetext){
                return AlertDialog(
                  contentPadding: EdgeInsets.all(0),
                  content: AddRoomDialog(
                    onAdded: (){
                      setState(() {
                        
                      });
                    },
                  )
                );
            });
        },
        child: const Icon(Icons.add),),
    );
  }
}