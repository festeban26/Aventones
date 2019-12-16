import 'package:aventones/res/enabled_administrative_areas.dart';
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

  LatLng get coordinates{
    return LatLng(latitude, longitude);
  }

  void resetFields() {
    this.country = null;
    this.administrativeArea = null;
    this.city = null;
    this.streetName = null;
    this.setCoordinates(0.0, 0.0);
  }

  /// Required fields are country, administrativeArea, latitude and longitude
  static bool isLocationComplete(Location location) {
    // If null or empty
    if (location.country?.isEmpty ?? true) return false;

    if (location.administrativeArea?.isEmpty ?? true) return false;

    if (location.latitude == null) return false;

    if (location.longitude == null) return false;

    return true;
  }

  static bool isLocationEnabled(Location location) {
    for (String enabledProvinceName
        in EnabledAdministrativeAreas.enabledAreas) {
      if (location.administrativeArea.contains(enabledProvinceName))
        return true;
    }

    return false;
  }
}
