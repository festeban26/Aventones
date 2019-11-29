import 'package:aventones/res/dimensions.dart';
import 'package:aventones/routes/select_location.dart';
import 'package:flutter/material.dart';
import 'package:aventones/res/company_colors.dart';

class OriginAndDestinationContainer extends StatefulWidget {
  OriginAndDestinationContainer({Key key, this.isTheContainerAPreview})
      : super(key: key);

  final bool isTheContainerAPreview;

  @override
  State<StatefulWidget> createState() => OriginAndDestinationContainerState();
}

class OriginAndDestinationContainerState
    extends State<OriginAndDestinationContainer> {
  String _originExample;
  String _destinationExample;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: Dimensions.Elevation_CardUnselected,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: InkWell(
        onTap: () {
          // Only if the container is a preview
          if (widget.isTheContainerAPreview) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SelectLocationRoute()),
            );
          }
        },
        borderRadius: BorderRadius.circular(16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 85,
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 15, child: _originAndDestinationIcons()),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 70,
                      child: _originAndDestinationInputs(_originExample,
                          _destinationExample, widget.isTheContainerAPreview),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 15,
                child: _originAndDestinationSwapIcon(),
              ),
            ],
          ),
        ),
      ),
    );
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
            color: CompanyColors.customBlack, size: 16),
        Icon(Icons.fiber_manual_record,
            color: CompanyColors.customBlack, size: 16),
        Icon(Icons.fiber_manual_record,
            color: CompanyColors.customBlack, size: 16),
        Icon(Icons.location_on, color: CompanyColors.customBlack, size: 32),
      ],
    ),
  );
}

Widget _originOrDestinationTextWidget(
    String address, bool isOrigin, bool isTheContainerAPreview) {
  Widget child;

  String labelText;
  String hintText;

  if (isOrigin) {
    labelText = 'Origen';
    hintText = 'Selecciona tu origen';
  } else {
    labelText = 'Destino';
    hintText = 'Selecciona tu destino';
  }

  // If there is no address
  if (address?.isEmpty ?? true) {
    child = TextFormField(
      initialValue: (() {
        if (isTheContainerAPreview)
          return hintText;
        else
          return '';
      }()),
      // If the container is a preview, disable editing
      enabled: (() {
        if (isTheContainerAPreview)
          return false;
        else
          return true;
      }()),
      autofocus: (() {
        if (!isTheContainerAPreview && isOrigin)
          return true;
        else
          return false;
      }()),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: InputBorder.none,
      ),
    );
  } else {
    child = TextFormField(
      initialValue: hintText,
      enabled: false,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: InputBorder.none,
      ),
    );
  }
  return child;
}

Widget _originAndDestinationInputs(
    String origin, String destination, bool isTheContainerAPreview) {
  return Column(
    children: <Widget>[
      _originOrDestinationTextWidget(origin, true, isTheContainerAPreview),
      _originOrDestinationTextWidget(
          destination, false, isTheContainerAPreview),
    ],
  );
}

Widget _originAndDestinationSwapIcon() {
  return InkWell(
    onTap: () {},
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Icon(Icons.swap_vert, color: CompanyColors.customBlack, size: 40),
    ),
    customBorder: CircleBorder(),
  );
}
