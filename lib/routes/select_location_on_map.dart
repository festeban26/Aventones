import 'dart:async';

import 'package:aventones/helpers/geolocator_helper.dart';
import 'package:aventones/models/location.dart';
import 'package:aventones/res/company_colors.dart';
import 'package:aventones/res/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocationOnMapRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SelectLocationOnMapRouteState();
}

class _SelectLocationOnMapRouteState extends State<SelectLocationOnMapRoute> {
  // The Google Maps map controller
  GoogleMapController _mapController;

  Location _location;
  String _locationInformationMainText;
  String _locationInformationSecondaryText;

  bool _showPinOnMap;
  DateTime _lastTimeOnMapCameraIdleWasCalled;

  DateTime _onMapCreatedTime;

  /// This timer is used when the submit button is pressed and the app has
  /// to periodically check if the geolocator data is loaded before continuing
  /// the submitting process.
  Timer _submittingTimer;

  /// This variable turns true when in submitting process, thus, activating the
  /// Modal Barrier.
  bool _isInSubmitting = false;

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

  @override
  void dispose() {
    _submittingTimer?.cancel();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    // Sets the controller
    _mapController = controller;

    // Update the map location tu user current location
    _updateMapsCameraToUserLocation();

    // Set the timestamp for the map creation time
    _onMapCreatedTime = DateTime.now();

    // Wait then update the UI by showing the pin
    Future.delayed(const Duration(milliseconds: 2500), () {
      setState(() {
        _showPinOnMap = true;
      });
    });
  }

  void _updateMapsCameraToUserLocation() async {
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

  /// Update the LatLng text with every camera move.
  /// This keeps the coordinates of _location synced with the Map
  void _onCameraMove(CameraPosition position) {
    setState(() {
      LatLng target = position.target;

      // Sets the _location new coordinates
      _location.setCoordinates(target.latitude, target.longitude);
    });
  }


  void _onCameraIdle() {

    // _onCameraIdle() gets called multiple times times when user is interacting
    // with the map while trying to set the pin on the map to his desired location.
    // On a group of request in a time interval of (2 sec), the app will only
    // request Geocoder data on the last call.
    //
    // It works like this: once the _onCameraIdle() is called, register the current
    // time. Then call a future (0.5 sec) and check in the future if another called
    // has been made. If another call has been made, do nothing. Else, request data
    // to the geocoder
    // .

    // Register the time of the call (it will only register the last call time)
    _lastTimeOnMapCameraIdleWasCalled = DateTime.now();

    const Duration timeToRunInTheFuture = Duration(milliseconds: 500);

    // Run in 0.5 sec into the future
    Future.delayed(timeToRunInTheFuture, (){

      Duration difference = DateTime.now().difference(_lastTimeOnMapCameraIdleWasCalled);

      // Give 50 extra milliseconds
      if(difference.inMilliseconds < timeToRunInTheFuture.inMilliseconds){
        // The user has moved the camera again so set the UI text to "Cargando"
        setState(() {
          _locationInformationMainText = 'Cargando...';
          _locationInformationSecondaryText = '';
        });
      }
      else{
        GeolocatorHelper.getLocationModelDataFromLatLng(_location.coordinates).then((onValue){
          // If the return data from the Geocoder is not null
          if(onValue != null){
            // Update the _location with the Geocoder data
            _location = onValue;
            // Update the UI
            _updateAddressText();
          }
        });
      }
    });
  }

  void _onCameraMoveStarted() {
    // Reset the _location variable
    _location.resetFields();
    setState(() {
      _locationInformationMainText = 'Cargando...';
      _locationInformationSecondaryText = '';
    });
  }

  void _updateAddressText() async {
    setState(() {
      // If city is null or empty
      if (_location.city?.isEmpty ?? true) {
        // Display province + country
        _locationInformationMainText =
            _location.administrativeArea + ', ' + _location.country;
      } else
        // Display city + country
        _locationInformationMainText =
            _location.city + ', ' + _location.country;

      _locationInformationSecondaryText = _location.streetName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
                  target: _location.coordinates,
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
            onPressed: () {
              _onSubmitLocationButtonPressed();
            },
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
                          fontSize:
                              Dimensions.paragraphBodyAndNormalText_TextSize,
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
        ),
        Visibility(
          visible: _isInSubmitting,
          child: Stack(
            children: <Widget>[
              Opacity(
                child: ModalBarrier(
                    dismissible: false, color: CompanyColors.customBlack),
                opacity: 0.80,
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// First, check if all the required fields are loaded into _location, then
  ///  check if the _location is enabled in the application
  void _onSubmitLocationButtonPressed() {
    /// The required fields are country, administrativeArea, latitude and longitude.
    /// They are loaded into _location using the geolocator.
    bool isSelectedLocationCompleteWithRequiredFields =
        Location.isLocationComplete(_location);

    if (isSelectedLocationCompleteWithRequiredFields) {
      print('All fields loaded');
    }

    /// If all the required fields are not yet loaded by the geolocator async call,
    /// then display the modal barrier and check every 500 miliseconds if
    /// the requiered fields are loaded.
    else {
      setState(() {
        _isInSubmitting = true;
      });

      _submittingTimer = Timer.periodic(
        const Duration(milliseconds: 250),
        (timer) {
          // If all required fields are loaded into _location
          if (Location.isLocationComplete(_location)) {
            print(_location.streetName);
            // Once fields are loaded, cancel the timer
            timer.cancel();
            // Then dismiss the Modal Barrier
            _dismissModalBarrier();
          }
        },
      );
    }
  }

  void _dismissModalBarrier() {
    setState(() {
      _isInSubmitting = false;
    });
  }
}
