import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location;    //location name of the UI
  String time = '';        //time of that location
  String flag;        //url to an asset flag icon
  String url;         //location url for api endpoint
  bool isDayTime = true;

  WorldTime({required this.location, required this.url, required this.flag});


  //Simulate network request for a user name.
  Future <void> getTime() async {

    try {
      //make the request
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      //print(datetime);
      //print(offset);


      //create a datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      //Set the time property
      time = DateFormat.jm().format(now);

    } catch (e){
      print('Error Occured: $e');
      time = 'Cannot get Time data';

    }




  }

}

