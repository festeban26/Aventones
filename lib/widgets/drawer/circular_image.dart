import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  final double _width, _height;
  final ImageProvider image;

  CircularImage(this.image, {double width = 64, double height = 64})
      : _width = width,
        _height = height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: image),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black45,
            )
          ]),
    );
  }
}
