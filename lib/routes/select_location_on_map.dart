import 'package:aventones/models/location.dart';
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
  // The Google Maps map controller
  GoogleMapController _mapController;

  Location _location;
  String _locationInformationMainText;
  String _locationInformationSecondaryText;

  bool _showPinOnMap;
  DateTime _lastTimeOnMapCameraIdleWasCalled;

  @override
  void initState() {
    super.initState();

    // Default initial location is a a place on Quito, Ecuador
    _location = Location(-0.179471, -78.467756,
        country: 'Ecuador',
        administrativeArea: 'Pichincha',
        city: 'Quito',
        streetName: 'Parque Metropolitano de Quito');

    // Example: Quito, Ecuador
    _locationInformationMainText = _location.city + ', ' + _location.country;
    _locationInformationSecondaryText = _location.streetName;

    // Do not show pin on map on start up. Show it once the map is loaded
    _showPinOnMap = false;
  }

  void _onMapCreated(GoogleMapController controller) {
    // Sets the controller
    _mapController = controller;

    // Update the map location tu user current location
    _updateLocation();

    // Wait then update the UI by showing the pin
    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        _showPinOnMap = true;
      });
    });
  }

  /// Update the LatLng text with every camera move.
  /// This keeps the coordinates of _location synced with the Map
  void _onCameraMove(CameraPosition position) {
    setState(() {
      LatLng target = position.target;
      _location.setCoordinates(target.latitude, target.longitude);
    });
  }

  void _updateLocation() async {
    try {
      Geolocator()
          .getCurrentPosition(
            desiredAccuracy: LocationAccuracy.medium,
            locationPermissionLevel: GeolocationPermission.locationWhenInUse,
          )
          .timeout(Duration(seconds: 10))
          .then(
        (value) {
          // Move the camera to the user position
          _mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(value.latitude, value.longitude), zoom: 15.0),
            ),
          );
        },
      );
    }
    // TODO
    catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  /// If 2 seconds has passed since the last user interaction with the map,
  /// call the geolocator to get an address
  void _onCameraIdle() {
    _lastTimeOnMapCameraIdleWasCalled = DateTime.now();

    Future.delayed(
      const Duration(milliseconds: 2000),
      () {
        Duration difference =
            DateTime.now().difference(_lastTimeOnMapCameraIdleWasCalled);
        if (difference.inMilliseconds > 2000) {
          _updateAddressText();
        }
      },
    );
  }

  void _onCameraMoveStarted() {
    setState(() {
      _locationInformationMainText = 'Cargando...';
      _locationInformationSecondaryText = '';
    });
  }

  void _updateAddressText() async {
    try {
      Geolocator()
          .placemarkFromCoordinates(_location.latitude, _location.longitude)
          .timeout(Duration(seconds: 10))
          .then(
        (value) {
          String country = value.last.country;
          String city = value.last.locality;
          String administrativeArea = value.last.administrativeArea;
          String streetName = value.last.thoroughfare;

          _location.country = country;
          _location.administrativeArea = administrativeArea;
          _location.city = city;
          _location.streetName = streetName;

          setState(() {
            // If city is null or empty
            if (city?.isEmpty ?? true) {
              // Display province + country
              _locationInformationMainText =
                  administrativeArea + ', ' + country;
            } else
              // Display city + country
              _locationInformationMainText = city + ', ' + country;

            _locationInformationSecondaryText = streetName;
          });

          /* EXAMPLES
          print('name: ' + value.last.name); // 3
          print('country: ' + value.last.country); // Ecuador
          print('postalCode: ' + value.last.postalCode); // 'Empty'
          print('administrativeArea: ' + value.last.administrativeArea); // Provincia de Imbabura
          print('subAdministrativeArea: ' + value.last.subAdministrativeArea); // Ibarra
          print('locality: ' + value.last.locality); // Ibarra
          print('subLocality: ' + value.last.subLocality); // Parroquia el Sagrario
          print('thoroughfare: ' + value.last.thoroughfare); // José María Larrea y Jijón
          print('subThoroughfare: ' + value.last.subThoroughfare); // 3
           */
        },
      );
    }
    // TODO
    catch (e) {
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
            onCameraMove: _onCameraMove,
            onCameraIdle: () {
              _onCameraIdle();
            },
            onCameraMoveStarted: () {
              _onCameraMoveStarted();
            },
            initialCameraPosition: CameraPosition(
              target: _location.getCoordinates(),
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
              // So the pin bottom is shown at the center of the screen.
              // Added 12 points  (24 = 48 / 2) + 2 due to white area around pin
              // image asset. It is not clear but 36 offset sets the pin bottom
              // at the center of the screen.
              padding: const EdgeInsets.only(bottom: 36.0),
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
              Text(_locationInformationMainText,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.pageTitles_TextSize,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Text(_locationInformationSecondaryText,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.paragraphBodyAndNormalText_TextSize,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 4.0),
              Text(
                  _location.latitude.toStringAsFixed(6) +
                      ', ' +
                      _location.longitude.toStringAsFixed(6),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.small_TextSize)),
            ],
          ),
        ),
      ),
    );
  }

  void _onSelectButtonPressed() {}
}
