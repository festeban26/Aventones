import 'package:aventones/res/dimensions.dart';
import 'package:aventones/routes/select_location.dart';
import 'package:aventones/routes/select_location_on_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:aventones/res/company_colors.dart';

class OriginAndDestinationContainer extends StatefulWidget {
  final bool isTheContainerAPreview;
  final bool wasAutoFocusRequestedOnOrigin;

  const OriginAndDestinationContainer(
      {Key key,
      this.isTheContainerAPreview,
      this.wasAutoFocusRequestedOnOrigin = true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _OriginAndDestinationContainerState();
}

class _OriginAndDestinationContainerState
    extends State<OriginAndDestinationContainer> {
  String _originExample;
  String _destinationExample;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: Dimensions.Elevation_CardUnselected,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 85,
              child: Stack(
                children: <Widget>[
                  // The true 'Origin' and 'Destination' components
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        flex: 15,
                        child: _OriginAndDestinationIcons(),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        flex: 85,
                        child: _OriginAndDestinationTextContainer(
                          originText: _originExample,
                          destinationText: _destinationExample,
                          isTheContainerAPreview: widget.isTheContainerAPreview,
                          wasAutoFocusRequestedOnOrigin:
                              widget.wasAutoFocusRequestedOnOrigin,
                        ),
                      ),
                    ],
                  ),
                  // Only if it the Origin and Destination container is a preview
                  widget.isTheContainerAPreview
                      // The larger area described above. This area is meant to
                      // capture onClick events on 'Origin' or 'Destination'
                      // The Positioned.fill depends oon the parent (Stack) widget's size
                      ? Positioned.fill(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              // Widget that overlaps 'Origin'
                              Expanded(
                                flex: 50, //  50%
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.red),
                                  ),
                                  child: GestureDetector(
                                    // On 'Select Origin Area' tap
                                    onTap: () {
                                      // TODO
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SelectLocationRoute(
                                            wasAutoFocusRequestedOnOrigin: true,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 50, // 50%
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue),
                                  ),
                                  child: GestureDetector(
                                    // On 'Select Destination Area' tap
                                    onTap: () {
                                      // TODO
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SelectLocationRoute(
                                            wasAutoFocusRequestedOnOrigin:
                                                false,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      // Empty widget (simulating there is not widget)
                      : SizedBox(),
                ],
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 15,
              child: InkWell(
                // The swap button
                // TODO swap behavior
                onTap: () {},

                child: Container(
                  height: 48,
                  width: 48,
                  child: Center(
                    child: Icon(Icons.swap_vert,
                        color: CompanyColors.customBlack, size: 40.0),
                  ),
                ),
                customBorder: CircleBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OriginAndDestinationIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.trip_origin, color: CompanyColors.customBlack, size: 32),
          Icon(Icons.fiber_manual_record,
              color: CompanyColors.customBlack, size: 16),
          Icon(Icons.fiber_manual_record,
              color: CompanyColors.customBlack, size: 16),
          Icon(Icons.fiber_manual_record,
              color: CompanyColors.customBlack, size: 16),
          Icon(Icons.location_on, color: CompanyColors.customBlack, size: 32),
        ],
      ),
    );
  }
}

class _OriginAndDestinationTextContainer extends StatelessWidget {
  final String originText;
  final String destinationText;
  final bool isTheContainerAPreview;
  final bool wasAutoFocusRequestedOnOrigin;

  const _OriginAndDestinationTextContainer({
    Key key,
    this.originText,
    this.destinationText,
    this.isTheContainerAPreview,
    this.wasAutoFocusRequestedOnOrigin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _OriginOrDestinationTextWidget(
          addressText: this.originText,
          isOrigin: true,
          isTheContainerAPreview: this.isTheContainerAPreview,
          wasAutoFocusRequestedOnOrigin: this.wasAutoFocusRequestedOnOrigin,
        ),
        _OriginOrDestinationTextWidget(
          addressText: this.destinationText,
          isOrigin: false,
          isTheContainerAPreview: this.isTheContainerAPreview,
          wasAutoFocusRequestedOnOrigin: this.wasAutoFocusRequestedOnOrigin,
        ),
      ],
    );
  }
}

class _OriginOrDestinationTextWidget extends StatelessWidget {
  final String addressText;
  final bool isOrigin;
  final bool isTheContainerAPreview;
  final bool wasAutoFocusRequestedOnOrigin;

  const _OriginOrDestinationTextWidget({
    Key key,
    this.addressText,
    this.isOrigin,
    this.isTheContainerAPreview,
    this.wasAutoFocusRequestedOnOrigin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String labelText;
    String hintText;

    if (this.isOrigin) {
      labelText = 'Origen';
      hintText = 'Selecciona tu origen';
    } else {
      labelText = 'Destino';
      hintText = 'Selecciona tu destino';
    }

    if (this.addressText?.isEmpty ?? true) {
      return TextFormField(
        initialValue: (() {
          if (this.isTheContainerAPreview)
            return hintText;
          else
            return '';
        }()),
        // If the container is a preview, disable editing
        enabled: (() {
          if (this.isTheContainerAPreview)
            return false;
          else
            return true;
        }()),
        autofocus: (() {
          // Only if the container is not a preview
          if (!this.isTheContainerAPreview) {
            // If auto focus was requested on origin and this is the origin: Acquire auto focus
            if (this.wasAutoFocusRequestedOnOrigin && this.isOrigin)
              return true;
            // If auto focus was requested on destination and this is the destination: Acquire auto focus
            else if (!this.wasAutoFocusRequestedOnOrigin && !this.isOrigin)
              return true;
          }
          // In any other conditions, do not acquire auto focus
          return false;
        }()),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          border: InputBorder.none,
        ),
        onChanged: (text) {
          // If the text change, it means the user is entering data.
          // TODO
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectLocationOnAutocomplete(
                startSearchTermString: text,
              ),
            ),
          );
        },
      );
    } else {
      return TextFormField(
        initialValue: hintText,
        enabled: false,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          border: InputBorder.none,
        ),
      );
    }
  }
}
