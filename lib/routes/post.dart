import 'package:aventones/models/address.dart';
import 'package:aventones/models/trip.dart';
import 'package:aventones/res/company_colors.dart';
import 'package:aventones/widgets/components/post_and_search_custom_buttons/custom_icon_button.dart';
import 'package:aventones/widgets/components/post_and_search_custom_buttons/date_button.dart';
import 'package:aventones/widgets/components/post_and_search_custom_buttons/time_button.dart';
import 'package:aventones/widgets/components/post_autocomplete_item/autcomplete_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aventones/widgets/origin_and_destination_container.dart';
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
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              AppBar(title: Text("Publicar viaje"), elevation: 0.0),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: CompanyColors.customLightGray,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              Dimensions.BorderRadiusEffect_Radius),
                          topRight: Radius.circular(
                              Dimensions.BorderRadiusEffect_Radius)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: Dimensions.BoxShadowEffect_blurRadius,
                          spreadRadius: Dimensions.BoxShadowEffect_spreadRadius,
                        )
                      ]),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 8),
                          _OriginAndDestinationContainer(),
                          SizedBox(height: 8),
                          _Preferences(),
                          SizedBox(height: 16),
                          _PostButton(),
                          SizedBox(height: 24),
                          _Autocomplete(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class _OriginAndDestinationContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: Dimensions.Elevation_CardUnselected,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: OriginAndDestinationContainer()));
  }
}

class _Preferences extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: DateButton(
                iconColor: CompanyColors.customBlack,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              flex: 1,
              child: TimeButton(
                iconColor: CompanyColors.customBlack,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: CustomIconButton(
                  title: "Número de asientos",
                  label: "3",
                  iconColor: CompanyColors.customBlack,
                  iconData: Icons.event_seat,
                )),
            SizedBox(width: 8.0),
            Expanded(
              flex: 1,
              child: CustomIconButton(
                title: "Precio por asiento",
                label: "5.00",
                iconColor: CompanyColors.customBlack,
                iconData: Icons.attach_money,
              ),
            )
          ],
        )
      ],
    );
  }
}

class _PostButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Dimensions.Button_Height,
      child: RaisedButton(
        elevation: Dimensions.Elevation_Button,
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
    );
  }
}


class _Autocomplete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Address sampleAddressQuito =
    Address("Quito", "Gaspar de Villarroel E 12-17", -0.171197, -78.47428);
    final Address sampleAddressIbarra =
    Address("Ibarra", "José Larrea 2-40", 0.342901, -78.110276);

    final Trip sampleTrip1 =
    Trip(sampleAddressIbarra, sampleAddressQuito, DateTime.now(), 3, 5.55);

    final Trip sampleTrip2 =
    Trip(sampleAddressQuito, sampleAddressIbarra, DateTime.now(), 3, 4.55);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          "Autocompletar con tu historial",
          style: TextStyle(
              fontSize: Dimensions.pageTitles_TextSize,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        SizedBox(height: 12.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              PostAutocompleteItem(
                trip: sampleTrip1,
                color: CompanyColors.customBlack,
                onTap: () {},
              ),
              SizedBox(width: 4),
              PostAutocompleteItem(
                trip: sampleTrip2,
                color: CompanyColors.customBlack,
                onTap: () {},
              ),
              SizedBox(width: 4),
              PostAutocompleteItem(
                trip: sampleTrip1,
                color: CompanyColors.customBlack,
                onTap: () {},
              ),
              SizedBox(width: 4),
              PostAutocompleteItem(
                trip: sampleTrip2,
                color: CompanyColors.customBlack,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}



