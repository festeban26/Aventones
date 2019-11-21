import 'package:aventones/res/company_colors.dart';
import 'package:aventones/widgets/post_autocomplete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aventones/widgets/origin_and_destination_container.dart';
import 'package:aventones/widgets/post_preferences.dart';
import 'package:aventones/res/dimensions.dart';

class PostScreen extends StatefulWidget {
  PostScreen({Key key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CompanyColors.customBlack,
        appBar: AppBar(
          title: const Text("Publicar viaje"),
          elevation: 0,
        ),
        body: Container(
          child: SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: CompanyColors.customLightGray,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32)),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 8),
                      OriginAndDestinationContainer(),
                      SizedBox(height: 16),
                      PostPreferences(),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 48.0,
                        child: RaisedButton(
                          child: Text("PUBLICAR VIAJE",
                              style: TextStyle(
                                  fontSize: Dimensions.button_TextSize,
                                  fontWeight: FontWeight.bold,
                                  color: CompanyColors.customWhite)),
                          color: CompanyColors.customBlack,
                          textColor: CompanyColors.customWhite,
                          padding: EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0)),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(height: 32),
                      Autocomplete(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
