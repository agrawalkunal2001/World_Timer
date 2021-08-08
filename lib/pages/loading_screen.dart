import 'dart:js';
import 'package:flutter/material.dart';
import 'package:world_timer/pages/location_screen.dart';
import 'package:world_timer/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// First screen that loads up when app is started.
class LoadingScreen extends StatelessWidget {

  WorldTime instance = WorldTime(location: 'Jakarta', flag: 'indonesia.png', url: 'Asia/Jakarta');

  Future<void> setupWorldTime(BuildContext context) async {
    await instance.getTime();  // Await is used to finish this function before executing next operation.
    print(instance.time); //This will not work because WorldTime class is asynchronous. It will take some time to bring data back from http request.
  }

  @override
  Widget build(BuildContext context) {
    setupWorldTime(context); // This function will run as soon as the widget loads up.
    return FutureBuilder(builder: (context, ss){
      if(ss.connectionState==ConnectionState.waiting)
        return Scaffold(
        backgroundColor: Colors.blue[800],
        body: Center(
          child: SpinKitFadingCircle(
            color: Colors.white,
            size: 150.0,
          ),
        ),
      );
      else if(ss.connectionState==ConnectionState.done){
        print(instance.location);
        print(instance.flag);

        Navigator.pushReplacementNamed(context, 'home', arguments: {  // pushReplacementNamed is used to replace the route beneath the current route because it will be no longer used.
          'location': instance.location,  // arguments contains the data which is to be passed onto the next screen
          'flag': instance.flag,
          'time': instance.time,
          'isDayTime': instance.isDayTime,
        });}
    }
     ,future: setupWorldTime(context));
}
    }

