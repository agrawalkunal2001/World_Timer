import 'package:flutter/material.dart';
import 'package:world_timer/pages/loading_screen.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {

  Object? data = {}; // Empty map at the start to store data incoming from previous screen.
                     // The question mark means that we will assign value to the data variable identifier of type Object later on.

  @override
  Widget build(BuildContext context) {

    Map data = {}; // Null value must be initiated to avoid error if nothing is extracted from http request.
    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map; // After choosing a location, the location screen pops off. The widget in home screen is not re-built. So, this function is not called
    print(data);
    // Not using setState here because this is the first time build function runs before returning any widget tree.

    // Set background
    String bgImage = data['isDayTime'] ? 'pexels-darius-krause-2931915.jpg' : 'pexels-roberto-nickson-2885320.jpg';
    Color? bgColor = data['isDayTime'] ? Colors.blue[500] : Colors.blue[900];
    Color? textColor = data['isDayTime'] ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/$bgImage"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: <Widget>[
                FlatButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, 'location'); // Navigator is used to travel between multiple screens.
                      if(result!=null){
                        setState(() {
                          data = {
                            'time': result['time'],
                            'location': result['location'],
                            'flag': result['flag'],
                            'isDayTime': result['isDayTime'],
                          };
                          print(data);
                        });
                      }
                  },                                                                 // Push is used to push the new screen over existing screen.
                  icon: Icon(                                                        // Named is used to provide the name of new screen.
                    Icons.edit_location,
                    color: textColor,
                  ),
                  label: Text(
                      "Edit Location",
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 45.0,
                        color: textColor,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 65.0,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
