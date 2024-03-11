import 'package:flutter/material.dart';
import 'package:smart_home/screens/home_screen/home_screen.dart';
import 'package:smart_home/screens/room_details_screen/room_details_screen.dart';
import 'package:smart_home/screens/welcome_screen/welcome_screen.dart';

class RouteGenerator{

  static const String welcomeScreen = "/";
  static const String homeScreen = "/homescreen";
  static const String roomDetailsScreen = "/roomdetailsscreen";

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case welcomeScreen:
        return MaterialPageRoute(
          builder: (context) => const WelcomeScreen());

      case homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen());

      case roomDetailsScreen:
        int args = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => RoomDetailsScreen(roomIndex: args,));

      default:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen());

    }
  }

}