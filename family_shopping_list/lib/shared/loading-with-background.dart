import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWithBackground extends StatelessWidget {
  const LoadingWithBackground({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.blue[300],
          size: 50.0,
        ),
      ),
    );
  }
}
