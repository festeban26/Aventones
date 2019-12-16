import 'package:aventones/models/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeolocatorHelper {
  static int _timeoutInSeconds = 5;

  static Future<Location> getLocationModelDataFromLatLng(LatLng latLng) async {

    Location location;

    await Geolocator()
        .placemarkFromCoordinates(latLng.latitude, latLng.longitude)
        .timeout(Duration(seconds: GeolocatorHelper._timeoutInSeconds))
        .then((value) {
      /// value examples:
      // print('name: ' + value.last.name); // 3
      // print('country: ' + value.last.country); // Ecuador
      // print('postalCode: ' + value.last.postalCode); // 'Empty'
      // print('administrativeArea: ' + value.last.administrativeArea); // Provincia de Imbabura
      // print('locality: ' + value.last.locality); // Ibarra
      // print('subLocality: ' + value.last.subLocality); // Parroquia el Sagrario
      // print('thoroughfare: ' + value.last.thoroughfare); // José María Larrea y Jijón
      // print('subThoroughfare: ' + value.last.subThoroughfare); // 3

      Placemark place = value.last;

      location = Location(
        latLng.latitude,
        latLng.longitude,
        country: place.country,
        city: place.locality,
        administrativeArea: place.administrativeArea,
        streetName: place.thoroughfare,
      );
    });

    return location;
  }
}
