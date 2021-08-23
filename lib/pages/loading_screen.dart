import 'package:flutter/material.dart';
import 'package:world_timer/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'home_screen.dart';

// First screen that loads up when app is started.
class LoadingScreen extends StatelessWidget {
  final WorldTime instance = WorldTime(
      location: 'Jakarta', flag: 'indonesia.png', url: 'Asia/Jakarta');

  Future<void> setupWorldTime(BuildContext context) async {
    await instance
        .getTime(); // Await is used to finish this function before executing next operation.
    print(instance
        .time); //This will not work because WorldTime class is asynchronous. It will take some time to bring data back from http request.
  }

  @override
  Widget build(BuildContext context) {
    // setupWorldTime(
    //     context); // This function will run as soon as the widget loads up.
    return FutureBuilder(
        builder: (context, ss) {
          if (ss.connectionState == ConnectionState.waiting)
            Scaffold(
              backgroundColor: Colors.blue[800],
              body: Center(
                child: SpinKitFadingCircle(
                  color: Colors.white,
                  size: 150.0,
                ),
              ),
            );
          else if (ss.connectionState == ConnectionState.done)
            return HomeScreen(
              flag: instance.flag,
              isDayTime: instance.isDayTime,
              location: instance.location,
              time: instance.time,
            );

          return Container(
            color: Color(0xFFffe8d6),
            child: Center(
              child: Text(
                'Fetching data...',
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 16,
                    color: Colors.black),
              ),
            ),
          );
          // {
          // print(instance.location);
          // print(instance.flag);
          // }
        },
        future: setupWorldTime(context));
  }
}
