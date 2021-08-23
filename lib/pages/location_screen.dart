import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:world_timer/services/world_time.dart';

class ChooseLocationScreen extends StatelessWidget {
  /* void getData(){
    // Simulate network request for a username
    Future.delayed(Duration(seconds: 3), (){   // Second argument is a function that fires up after duration
      print("Kunal");
    });
  }

  @override
  void initState(){
    super.initState();
    getData();
  }
  */

  final List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];

  Future<void> updateTime(
      BuildContext context, int index, WorldTime instance) async {
    instance = locations[index];
    await instance.getTime();
    // Navigate back to home screen
  }

  // did not change instance in the previous code

  @override
  Widget build(BuildContext context) {
    WorldTime? instance;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Text("Choose a Location"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () async {
                  instance = locations[index];
                  await updateTime(context, index, instance!);
                  Navigator.of(context).pop({
                    'location': instance!
                        .location, // arguments contains the data which is to be passed onto the next screen
                    'flag': instance!.flag,
                    'time': instance!.time,
                    'isDayTime': instance!.isDayTime,
                  });
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/${locations[index].flag}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
