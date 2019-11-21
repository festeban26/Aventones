import 'package:aventones/models/address.dart';
import 'package:aventones/models/trip.dart';
import 'package:aventones/res/company_colors.dart';
import 'package:aventones/res/dimensions.dart';
import 'package:flutter/material.dart';

class PostAutocompleteItem extends StatelessWidget {
  final Trip trip;
  final Color color;
  final Function onTap;

  const PostAutocompleteItem({Key key, this.trip, this.color, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.trip_origin,
                    color: CompanyColors.customWhite, size: 24),
                SizedBox(width: 8),
                _address(trip.origin)
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: <Widget>[
                Icon(Icons.location_on,
                    color: CompanyColors.customWhite, size: 24),
                SizedBox(width: 8),
                _address(trip.destination)
              ],
            ),
            SizedBox(height: 12),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(children: <Widget>[
                    Icon(Icons.event_seat,
                        color: CompanyColors.customWhite, size: 24),
                    SizedBox(width: 4),
                    Text(
                      trip.numberOfAvailableSeats.toString(),
                      style: TextStyle(
                          color: CompanyColors.customWhite,
                          fontSize: Dimensions.modalText_TextSize),
                    )
                  ]),
                  Divider(),

                  Row(children: <Widget>[
                    Icon(Icons.attach_money,
                        color: CompanyColors.customWhite, size: 24),
                    Text(
                      trip.pricePerSeat.toString(),
                      style: TextStyle(
                          color: CompanyColors.customWhite,
                          fontSize: Dimensions.modalText_TextSize),
                    )
                  ])
                ])
          ],
        ),
      ),
    );
  }
}

Widget _address(Address address) {
  return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(address.city,
          style: TextStyle(
              color: CompanyColors.customWhite,
              fontSize: Dimensions.modalText_TextSize,
              fontWeight: FontWeight.bold)),
      Text(address.streetName,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: Dimensions.small_TextSize,
              color: CompanyColors.customWhite)),
    ],
  ));

  /*RichText(
      text: TextSpan(
          children: <TextSpan>[
        TextSpan(
          text: address.city + "\n",
          style: TextStyle(
              color: CompanyColors.customWhite,
              fontSize: Dimensions.modalText_TextSize,
              fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text: address.streetName,
          style: TextStyle(
              fontSize: Dimensions.small_TextSize,
              color: CompanyColors.customWhite),
        )
      ]),
    ),*/
}
