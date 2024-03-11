import 'package:flutter/material.dart';
import 'package:smart_home/bloc/storage_logic/storage.dart';
import 'package:smart_home/route.dart';
import 'package:smart_home/util/app_colors.dart';
import 'package:smart_home/util/app_images.dart';

class WelcomeScreen extends StatelessWidget{
  const WelcomeScreen({super.key});


  @override
  Widget build(BuildContext context){
    tasks().then((value) {
      Navigator.pushNamed(context, RouteGenerator.homeScreen);
    },);
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(AppImages.backgroundImage),
              ),
            
          ),
          child:Container(
            // color: const Color.fromARGB(200, 7, 151, 247),
            color: const Color.fromARGB(200, 255, 152, 0),
            padding: const EdgeInsets.all(10),
            child:Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppImages.schoolBudge),
                    const Text("www.mgtug.com", style: TextStyle(
                      color: Colors.white
                    ),)      
                  ],
                )),
              // www.mgtug.com
              const Text("Copyright @R&DNVTC 2024", style: TextStyle(
                      color: Colors.white
                    ),)
            ],
          )),)),
    );
  }

  Future<void> tasks()async {
    await DataStorage.loadFromFile();
    debugPrint(">>>>> initiating data from storage.........");
    await DataStorage.initState();
    debugPrint(">>>>> initiating data from storage completed.........");
    await Future.delayed(Duration(seconds: 3));
  }
}