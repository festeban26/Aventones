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
  Position _currentUserPosition;
  LatLng _mapCenter;
  final double _mapZoom = 7.0;

  @override
  void initState() {
    // Initialize map center on Ecuador
    _mapCenter = const LatLng(-0.179471, -78.467756);

    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _getCurrentLocation();
  }

  _updateMapCameraToCurrentLocation() {
    if (_currentUserPosition != null) {
      _mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                _currentUserPosition.latitude, _currentUserPosition.longitude),
            zoom: 15.0),
      ));
    }
  }

  _getCurrentLocation() {
    Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.medium)
        .then(
      ((Position position) {
        setState(() {
          _currentUserPosition = position;
          //_updateMapCameraToCurrentLocation();
        });
      }),
    );
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
              target: _mapCenter,
              zoom: _mapZoom,
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
