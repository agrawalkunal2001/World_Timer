import 'package:flutter/material.dart';
import 'package:world_timer/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// First screen that loads up when app is started.
class LoadingScreen extends StatefulWidget {

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  void setupWorldTime() async {
    WorldTime instance = WorldTime(location: 'Jakarta', flag: 'indonesia.png', url: 'Asia/Jakarta');
    await instance.getTime();  // Await is used to finish this function before executing next operation.
    print(instance.time); //This will not work because WorldTime class is asynchronous. It will take some time to bring data back from http request.
    Navigator.pushReplacementNamed(context, 'home', arguments: {  // pushReplacementNamed is used to replace the route beneath the current route because it will be no longer used.
      'location': instance.location,  // arguments contains the data which is to be passed onto the next screen
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
    });
  }

  @override
  void initState(){
     super.initState();
     setupWorldTime(); // This function will run as soon as the widget loads up.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: Center(
        child: SpinKitFadingCircle(
        color: Colors.white,
        size: 150.0,
      ),
    ),
    );
  }
}
