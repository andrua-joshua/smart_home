import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: AppColor.dualWhiteBgColor,
      body: const SafeArea(
        child: SingleChildScrollView(
          child:Column(
          children: [
            TopWidget(),
            SizedBox(height: 20,),
            Text("Available Rooms", style:  AppStyle.titleStyle,),
            // OptionsWidget(
            //   labels: const ["Rooms", "Devices"], 
            //   onChange: (val){
            //     setState(() {
            //       currentIndex = val;
            //     });
            //   }, currentIndex: currentIndex),
            SizedBox(height: 20,),
            RoomItems()
          ],
        ))),

      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: const Icon(Icons.add),),
    );
  }
}