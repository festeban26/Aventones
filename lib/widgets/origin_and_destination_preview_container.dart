import 'package:aventones/res/dimensions.dart';
import 'package:aventones/routes/select_location.dart';
import 'package:flutter/material.dart';
import 'package:aventones/res/company_colors.dart';

class OriginAndDestinationPreviewContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      OriginAndDestinationPreviewContainerState();
}

class OriginAndDestinationPreviewContainerState
    extends State<OriginAndDestinationPreviewContainer> {
  String _originExample;
  String _destinationExample;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
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
                    Expanded(
                        flex: 70,
                        child: _originAndDestination(
                            _originExample, _destinationExample))
                  ])),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 15,
              child: _originAndDestinationSwapIcon(),
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

Widget _originOrDestinationTextWidget(String address, bool isOrigin) {
  Widget child;

  String descriptionText;
  String hintText;

  if (isOrigin) {
    descriptionText = 'Origen';
    hintText = 'Selecciona tu origen';
  } else {
    descriptionText = 'Destino';
    hintText = 'Selecciona tu destino';
  }

  // If there is no address
  if (address?.isEmpty ?? true) {
    child = RichText(
      text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: descriptionText + '\n',
            style: TextStyle(
                color: CompanyColors.textCustomLightGray,
                fontSize: Dimensions.paragraphBodyAndNormalText_TextSize)),
        TextSpan(
          text: hintText,
          style: TextStyle(
              fontSize: Dimensions.input_TextSize, color: Colors.black),
        )
      ]),
    );
  } else {
    child = RichText(
      text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: descriptionText + '\n',
            style: TextStyle(
                color: CompanyColors.textCustomLightGray,
                fontSize: Dimensions.paragraphBodyAndNormalText_TextSize)),
        TextSpan(
          text: address,
          style: TextStyle(
              fontSize: Dimensions.input_TextSize, color: Colors.black),
        )
      ]),
    );
  }

  return child;
}

Widget _originAndDestination(String origin, String destination) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      _originOrDestinationTextWidget(origin, true),
      SizedBox(height: 16),
      _originOrDestinationTextWidget(destination, false)
    ],
  );
}

Widget _originAndDestinationSwapIcon() {
  return InkWell(
    onTap: () {},
    child: Padding(
        padding: const EdgeInsets.all(4.0),
        child:
            Icon(Icons.swap_vert, color: CompanyColors.customBlack, size: 40)),
    customBorder: CircleBorder(),
  );
}
