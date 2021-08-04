import 'package:flutter/material.dart';
import 'package:world_timer/pages/home_screen.dart';
import 'package:world_timer/pages/loading_screen.dart';
import 'package:world_timer/pages/location_screen.dart';

void main()=>runApp(MaterialApp(
  initialRoute: '/', // First route to load up. By default it is '/', but it can be overridden.
  routes: {                            // Routes are used to travel between multiple screens. Map ({}) is used for this.
    '/': (context) => LoadingScreen(), // '/' indicates base screen. It takes in a function and returns the corresponding
    'home': (context) => HomeScreen(), // screen. 'Context' helps flutter to find where the widget is in the widget tree.
    'location': (context) => ChooseLocationScreen(),
  },
));

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
