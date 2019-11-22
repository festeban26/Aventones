import 'package:aventones/res/company_colors.dart';
import 'package:aventones/res/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocationOnMapRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SelectLocationOnMapRouteState();
}

class SelectLocationOnMapRouteState extends State<SelectLocationOnMapRoute> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO. Background should be a map underneath floating button
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Selecciona la ubicación"),
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
          Positioned(
            child: ShaderMask(
              blendMode: BlendMode.srcOut,
              shaderCallback: (bounds) => LinearGradient(
                  colors: [CompanyColors.customBlack],
                  stops: [0.0]).createShader(bounds),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0)),
                ),
              ),
            ),
          )
        ],
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
