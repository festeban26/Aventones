import 'package:aventones/helpers/google_places_api_session_token_generator.dart';
import 'package:aventones/res/apis_keys.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class GooglePlacesApiPlaceDetails{

  static const String _key = ApisKeys.MAPS_API_KEY;

  static Future<LatLng> getCoordinatesOfPlaceId(String placeId) async {

    String url = 'https://maps.googleapis.com/maps/api/place/details/';

    // Request a json as the output format
    url += 'json?';

    // Add the place id
    url += 'place_id=$placeId';

    // Request the geometry, which contains the geocoded latitude, longitude
    // values for the place
    url += '&fields=geometry';

    // Add the API key (Required)
    url += '&key=${GooglePlacesApiPlaceDetails._key}';

    // Add the session token
    url += '&sessiontoken=${GooglePlacesApiSessionTokenGenerator.getToken()}';

    try {
      final response = await http.get(url);

      // Parsing process

      final Map<String, dynamic> json = JSON.jsonDecode(response.body);

      // Parsing process to get Place ID coordinates

      // If there was an error
      if (json['error_message'] != null) {
        // TODO Error handling
        print(json['error_message']);
      } else {
        final result = json['result'];
        final geometry = result['geometry'];

        final location = geometry['location'];
        double latitude = location['lat'];
        double longitude = location['lng'];

        // reset the session token
        GooglePlacesApiSessionTokenGenerator.resetToken();
        return LatLng(latitude, longitude);
      }
    } catch (e) {
      // TODO error handling
      print(e);
    }
    return null;
  }

}