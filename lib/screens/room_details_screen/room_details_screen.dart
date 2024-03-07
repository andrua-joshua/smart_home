import 'package:flutter/material.dart';
import 'package:smart_home/screens/room_details_screen/widgets/room_details_widget.dart';
import 'package:smart_home/util/app_colors.dart';
import 'package:smart_home/util/app_styles.dart';

class RoomDetailsScreen extends StatefulWidget{
  final String  roomLabel;
  const RoomDetailsScreen({required this.roomLabel ,super.key});

  @override
  RoomDetailsScreenState createState () => RoomDetailsScreenState();

}


class RoomDetailsScreenState extends State<RoomDetailsScreen>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: AppColor.dualWhiteBgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=> Navigator.pop(context), 
          icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: Text(widget.roomLabel, style: AppStyle.titleStyle,),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.more_vert))
        ],
      ),

      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                AdsWidget(),
                SizedBox(height: 25,),
                SimpleRow(label: "Devices"),
                SizedBox(height: 10,),
                Devices()
              ],
            ),
          ),)),
    );
  }
}