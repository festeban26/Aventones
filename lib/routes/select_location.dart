import 'package:aventones/res/company_colors.dart';
import 'package:aventones/res/dimensions.dart';
import 'package:aventones/routes/location_history.dart';
import 'package:aventones/routes/select_location_on_map.dart';
import 'package:aventones/widgets/origin_and_destination_container.dart';
import 'package:flutter/material.dart';

class SelectLocationRoute extends StatelessWidget {

  final bool wasAutoFocusRequestedOnOrigin;

  const SelectLocationRoute({Key key, this.wasAutoFocusRequestedOnOrigin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CompanyColors.customBlack,
      appBar: AppBar(
        title: const Text("Seleccionar ubicación"),
        elevation: 0.0,
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 16.0),
                child: OriginAndDestinationContainer(
                  isTheContainerAPreview: false,
                  wasAutoFocusRequestedOnOrigin: wasAutoFocusRequestedOnOrigin,
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: CompanyColors.customLightGray,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0)),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LocationHistoryRoute()),
                              );
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.history,
                                    color: CompanyColors.customBlack,
                                    size: 32.0),
                                SizedBox(width: 16.0),
                                Text(
                                  "Historial",
                                  style: TextStyle(
                                      fontSize:
                                          Dimensions.listItemNormal_TextSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Divider(height: 24.0),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SelectLocationOnMapRoute()),
                              );
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.pin_drop,
                                    color: CompanyColors.customBlack,
                                    size: 32.0),
                                SizedBox(width: 16.0),
                                Text(
                                  "Seleccionar en el mapa",
                                  style: TextStyle(
                                      fontSize:
                                          Dimensions.listItemNormal_TextSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: CompanyColors.customLightGray,
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 48.0,
                  child: RaisedButton(
                    child: Text("CONTINUAR",
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
