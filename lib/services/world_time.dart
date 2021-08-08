import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

// Custom class for choose location

class WorldTime{
  String location=""; // Actual location which user sees on UI
  String time="";     // Actual time at the location
  String flag="";     // URL to asset flag icon
  String url="";      // Location url for API endpoint
  bool isDayTime=true;     // True if day and false if night

  WorldTime({required this.location, required this.flag, required this.url}); // Using named parameters and automatically assigning input arguments to respective variables

  String datetime="";

  Future<void> getTime() async{       // get function can be used to import 'dart:convert';  // To use await keyword in loading_screen.dart, Future must be used.    // Future is like a placeholder value. It will return void when the function is executed completely.
    try{
      Response response = await get(Uri.parse("http://worldtimeapi.org/api/timezone/$url")); // Await is used to wait for the function to finish before storing it in variables.
      Map data = jsonDecode(response.body); // It returns data which can be used in the form of map
      print(data);
      // print(data['title']); // Properties of 'data' can be used using [] because of map
      datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3); // Substring is used to trim down the string finally including the characters of index passed in as argument
      // print(datetime);
      // print(offset);

      // Create DateTime object
      DateTime  now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset))); // Converting string offset into integer offset

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false; // Considering day from 6am to 8pm

      time = DateFormat.jm().format(now); // Converting time into easily readable format
    }
    catch(e){
      print("Caught error: $e");
      time = "Could not get time data";
    }
  }

}