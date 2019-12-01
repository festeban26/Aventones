import 'package:aventones/res/company_colors.dart';
import 'package:aventones/res/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocationOnMapRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SelectLocationOnMapRouteState();
}

class SelectLocationOnMapRouteState extends State<SelectLocationOnMapRoute> {
  GoogleMapController _mapController;

  Position _selectedPosition;
  bool _showPinOnMap;

  @override
  void initState() {
    super.initState();

    // Do not show pin on map on start up. Show it once the map is loaded
    _showPinOnMap = false;
  }

  void _onMapCreated(GoogleMapController controller) {
    // Sets the controller
    _mapController = controller;

    // Update the map location tu user current location
    _updateLocation();


    // Wait then ppdate the UI by showing the pin
    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        _showPinOnMap = true;
      });
    });


  }

  void _updateLocation() async {
    try {
      Geolocator()
          .getCurrentPosition(
            desiredAccuracy: LocationAccuracy.medium,
            locationPermissionLevel: GeolocationPermission.locationWhenInUse,
          )
          .timeout(Duration(seconds: 15))
          .then((value) {
        // Set the new map center, then move the camera to it
        _selectedPosition = value;
        _mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(value.latitude, value.longitude), zoom: 15.0),
          ),
        );
      });
    } catch (e) {
      print('Error: ${e.toString()}');
    }
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
              // Initialize camera on Ecuador
              target: const LatLng(-0.179471, -78.467756),
              // initial map zoom
              zoom: 7.0,
            ),
            mapType: MapType.normal,
            // No tilt or rotation gestures enabled
            rotateGesturesEnabled: false,
            tiltGesturesEnabled: false,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
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
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Visibility(
                visible: _showPinOnMap,
                child: Icon(
                  Icons.location_on,
                  color: CompanyColors.customBlack,
                  size: 48.0,
                ),
              ),
            ),
          ),
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
