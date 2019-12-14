import 'package:aventones/models/google_autocomplete_place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:uuid/uuid.dart';

/*
Pricing: 17.00 per 1000. Remember there is a 200$ credit each month for Google
Maps APIs.

If pricing becomes an issue search for "Places autocomplete alternatives", there
is plenty of alternatives.
 */

class GooglePlacesApiAutocomplete {

  static final String key = 'AIzaSyDvx7-w8LgfiWT47Ck96hOLCjZyFOcKCYo';
  static DateTime _lastTimeUuidWasGenerated;
  static String _currentUuid;

  // -1.877212, -78.144345
  // 3810000


  static Future<List<GoogleAutocompletePlace>> autocomplete(String input) async {

    if (input.length > 0) {

      String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/';

      // Request a json as the output format
      url += 'json?';

      // Add the input (Required)
      url += 'input=$input';

      // Add the Ecuador center location to bias results
      // The center location was selected manually via Google Earth
      url += '&location=-1.877212, -78.144345';

      // Bias the result to Ecuador addresses by setting a radius from the
      // location. Radius is expressed in meters
      url += '&radius=381000';

      // Limit the results to the location + radius area
      url += '&strictbounds=true';

      // Add the API key (Required)
      url += '&key=${GooglePlacesApiAutocomplete.key}';

      // Add the session token
      url += '&sessiontoken=${_getUuid()}';

      final response = await http.get(url);

      // Parsing process

      final Map<String, dynamic> json = JSON.jsonDecode(response.body);
      // If there was an error
      if(json['error_message'] != null){
        // TODO Error handling
        print(json['error_message']);
        return null;
      }
      else{
        final predictions = json['predictions'];

        List<GoogleAutocompletePlace> predictedPlaces = List();

        for(Map<String, dynamic> prediction in predictions){
          var place = GoogleAutocompletePlace(prediction);
          predictedPlaces.add(place);
        }

        return predictedPlaces;
      }
    }
    return null;
  }


  static String _getUuid(){
    if(_lastTimeUuidWasGenerated == null || _currentUuid == null){
      _lastTimeUuidWasGenerated = DateTime.now();
      _currentUuid = Uuid().v4();
      print(_lastTimeUuidWasGenerated.toIso8601String());
    }
    /// If 5 minutes has passed since the UUID was generated, generate another
    /// UUID due to Google Places API UUID time lifespan (5 min between calls with
    /// the same UUID).
    else if(DateTime.now().difference(_lastTimeUuidWasGenerated) > Duration(minutes: 5)){
      _lastTimeUuidWasGenerated = DateTime.now();
      _currentUuid = Uuid().v4();
    }
    return _currentUuid;
  }
}
