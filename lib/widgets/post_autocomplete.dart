import 'package:aventones/widgets/components/post_autocomplete_item/autcomplete_item.dart';
import 'package:aventones/models/address.dart';
import 'package:aventones/models/trip.dart';
import 'package:aventones/res/company_colors.dart';
import 'package:aventones/res/dimensions.dart';
import 'package:flutter/material.dart';

class Autocomplete extends StatelessWidget {
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
        SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              PostAutocompleteItem(
                trip: sampleTrip1,
                color: CompanyColors.customBlack,
                onTap: () {},
              ),
              SizedBox(width: 8),
              PostAutocompleteItem(
                trip: sampleTrip2,
                color: CompanyColors.customBlack,
                onTap: () {},
              ),
              SizedBox(width: 8),
              PostAutocompleteItem(
                trip: sampleTrip1,
                color: CompanyColors.customBlack,
                onTap: () {},
              ),
              SizedBox(width: 8),
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
