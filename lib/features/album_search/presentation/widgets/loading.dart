import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }
}
