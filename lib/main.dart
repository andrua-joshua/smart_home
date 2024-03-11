import 'package:flutter/material.dart';
import 'package:smart_home/bloc/storage_logic/storage.dart';
import 'package:smart_home/route.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: RouteGenerator.welcomeScreen,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
