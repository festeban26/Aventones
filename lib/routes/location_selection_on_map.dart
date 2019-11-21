import 'package:aventones/res/company_colors.dart';
import 'package:aventones/res/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationSelectionOnMapRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO. Background should be a map underneath floating button
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Selecciona la ubicación"),
        elevation: 0.0,
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
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
                                children: <Widget>[])))),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check, color: CompanyColors.customWhite),
        backgroundColor: CompanyColors.customBlack,
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBar(
        color: CompanyColors.customBlack,
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Ibarra, Ecuador",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.pageTitles_TextSize,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 8.0),
                Text("José Larrea 2-40, Ibarra",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            Dimensions.paragraphBodyAndNormalText_TextSize,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 4.0),
                Text("0.342901, -78.110276",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.small_TextSize)),
              ],
            )),
      ),
    );
  }
}
