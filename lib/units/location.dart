import 'package:location/location.dart';

class LocationHelper{
  late double longitude;
  late double latitude;

  Future <void> getCurrentLocation() async{
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    //servis isleyir?
    _serviceEnabled = await location.serviceEnabled();
    if(!_serviceEnabled){
      await location.requestService();
      if(!_serviceEnabled){
        return;
      }
    }

    //istifadeci icaze verib?
    _permissionGranted = await location.hasPermission();
    if(_permissionGranted == PermissionStatus.denied){
      await location.requestPermission();
      if(_permissionGranted != PermissionStatus.granted){
        return;
      }
    }

    //her sey tamamdisa konumu götür
    _locationData = await location.getLocation();
      longitude = _locationData.longitude ?? 0.0; 
      latitude = _locationData.latitude ?? 0.0;   
  }

}