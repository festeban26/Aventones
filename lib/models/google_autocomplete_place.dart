class GoogleAutocompletePlace{

  //  contains the human-readable name for the returned result. For establishment
  //  results, this is usually the business name.
  String description;

  // is a textual identifier that uniquely identifies a place. To retrieve
  // information about the place, pass this identifier in the placeId field of
  // a Places API request. For more information about place IDs, see the Place
  // IDs overview.
  String placeId;

  // contains the main text of a prediction, usually the name of the place.
  String mainText;

  // contains the secondary text of a prediction, usually the location of the place.
  String secondaryText;

  GoogleAutocompletePlace(Map<String, dynamic> prediction){
    try{
      this.description = prediction['description'];
      this.placeId = prediction['place_id'];

      Map<String, dynamic> structuredFormatting = prediction['structured_formatting'];

      this.mainText = structuredFormatting['main_text'];
      this.secondaryText = structuredFormatting['secondary_text'];
    }
    catch(e){
      // TODO Error Handling
      print(e);
    }
  }
}