import 'package:aventones/helpers/places_api_autocomplete.dart';
import 'package:aventones/models/google_autocomplete_place.dart';
import 'package:aventones/res/company_colors.dart';
import 'package:aventones/res/dimensions.dart';
import 'package:flutter/material.dart';

class SelectLocationOnAutocomplete extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SelectLocationOnAutocompleteState();
}

class SelectLocationOnAutocompleteState
    extends State<SelectLocationOnAutocomplete> {
  final TextEditingController _textEditingController =
      new TextEditingController();
  List<GoogleAutocompletePlace> _googlePlacesPredictions = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CompanyColors.customBlack,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 12.0, bottom: 12.0, left: 8.0, right: 8.0),
              child: Row(
                children: <Widget>[
                  InkWell(
                    borderRadius: BorderRadius.circular(18.0),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 36.0,
                      width: 36.0,
                      child:
                          Icon(Icons.arrow_back, color: Colors.white, size: 32),
                    ),
                  ),
                  SizedBox(width: 4.0),
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Ingresa una dirección',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 16.0),
                        fillColor: CompanyColors.customLightGray,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _googlePlacesPredictions.clear();
                            });

                            // Has to be like it because of flutter issue 35848
                            Future.delayed(Duration(milliseconds: 50)).then((_){
                              _textEditingController.clear();
                            });
                          },
                        ),
                      ),
                      controller: _textEditingController,
                      onChanged: (text) {
                        GooglePlacesApiAutocomplete.autocomplete(text)
                            .then((predictions) {
                          setState(() {
                            if (predictions != null)
                              _googlePlacesPredictions = predictions;
                          });
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft:
                      Radius.circular(Dimensions.BorderRadiusEffect_Radius),
                  topRight:
                      Radius.circular(Dimensions.BorderRadiusEffect_Radius),
                ),
                child: Container(
                  color: Colors.white,
                  child: Material(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: ListView.separated(
                        itemCount: _googlePlacesPredictions.length,
                        itemBuilder: ((context, index) {
                          var prediction = _googlePlacesPredictions[index];
                          return ListTile(
                            title: Text(
                              prediction.mainText,
                              style: TextStyle(
                                fontSize: Dimensions.listItemNormal_TextSize,
                              ),
                            ),
                            subtitle: Text(
                              prediction.secondaryText,
                              style: TextStyle(
                                fontSize: Dimensions.small_TextSize,
                              ),
                            ),
                            leading: Icon(Icons.location_on,
                            size: 40.0,
                            color: CompanyColors.customBlack,),
                            dense: true,
                            onTap: () {
                              print('test');
                            },
                          );
                        }),
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
