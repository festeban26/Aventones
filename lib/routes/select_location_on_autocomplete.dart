import 'package:aventones/res/company_colors.dart';
import 'package:aventones/res/dimensions.dart';
import 'package:flutter/material.dart';

class SelectLocationOnAutocomplete extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SelectLocationOnAutocompleteState();
}

class SelectLocationOnAutocompleteState
    extends State<SelectLocationOnAutocomplete> {
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
                        contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                        fillColor: CompanyColors.customLightGray,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {},
                        ),
                      ),
                      onChanged: (text){
                        print(text);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: CompanyColors.customLightGray,
                  borderRadius: BorderRadius.only(
                      topLeft:
                          Radius.circular(Dimensions.BorderRadiusEffect_Radius),
                      topRight: Radius.circular(
                          Dimensions.BorderRadiusEffect_Radius)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: Dimensions.BoxShadowEffect_blurRadius,
                      spreadRadius: Dimensions.BoxShadowEffect_spreadRadius,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
