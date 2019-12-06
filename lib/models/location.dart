import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {

  // Constructor
  Location(
    double latitude,
    double longitude, {
    String country = 'Ecuador',
    String administrativeArea,
    String city,
    String streetName,
  }) {
    this.latitude = latitude;
    this.longitude = longitude;

    // Named optional parameters setup
    this.country = country;
    this.administrativeArea = administrativeArea;
    this.city = city;
    this.streetName = streetName;
  }

  String country;

  // The state or province
  String administrativeArea;

  // The locality
  String city;

  // The street
  String streetName;

  // The coordinates
  double latitude;
  double longitude;

  void setCoordinates(double latitude, double longitude) {
    if (latitude <= 90.0 && latitude >= -90.0) this.latitude = latitude;

    if (longitude <= 180.0 && longitude >= -180.0) this.longitude = longitude;
  }

  LatLng getCoordinates(){
    return LatLng(latitude, longitude);
  }


}
