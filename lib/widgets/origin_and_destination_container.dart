import 'package:aventones/res/dimensions.dart';
import 'package:aventones/routes/select_location.dart';
import 'package:flutter/material.dart';
import 'package:aventones/res/company_colors.dart';

class OriginAndDestinationContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 85,
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectLocationRoute()),
                    );
                  },
                  child: Row(children: <Widget>[
                    Expanded(flex: 15, child: _originAndDestinationIcons()),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(flex: 70, child: _originAndDestination())
                  ])),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 15,
              child: GestureDetector(
                  onTap: () {
                    print("Switch");
                  },
                  child: _originAndDestinationSwapIcon()),
            )
          ],
        ));
  }
}

Widget _originAndDestinationIcons() {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.trip_origin, color: CompanyColors.customBlack, size: 32),
        Icon(Icons.fiber_manual_record,
            color: CompanyColors.customBlack, size: 12),
        Icon(Icons.fiber_manual_record,
            color: CompanyColors.customBlack, size: 12),
        Icon(Icons.fiber_manual_record,
            color: CompanyColors.customBlack, size: 12),
        Icon(Icons.location_on, color: CompanyColors.customBlack, size: 32),
      ],
    ),
  );
}

Widget _originAndDestination() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      RichText(
        text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: "Origen \n",
              style: TextStyle(
                  color: CompanyColors.textCustomLightGray,
                  fontSize: Dimensions.paragraphBodyAndNormalText_TextSize)),
          TextSpan(
            text: "José Larrea 2-40, Ibarra",
            style: TextStyle(
                fontSize: Dimensions.input_TextSize, color: Colors.black),
          )
        ]),
      ),
      SizedBox(height: 16),
      RichText(
        text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: "Destino \n",
              style: TextStyle(
                  color: CompanyColors.textCustomLightGray,
                  fontSize: Dimensions.paragraphBodyAndNormalText_TextSize)),
          TextSpan(
            text: "Gaspar de Villarroel, Quito",
            style: TextStyle(
                fontSize: Dimensions.input_TextSize, color: Colors.black),
          )
        ]),
      ),
    ],
  );
}

Widget _originAndDestinationSwapIcon() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Icon(Icons.swap_vert, color: CompanyColors.customBlack, size: 40),
    ],
  );
}
