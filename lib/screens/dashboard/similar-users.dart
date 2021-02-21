import 'package:fanua/constants/colors.dart';
import 'package:flutter/material.dart';

class SimilarUsers extends StatefulWidget {
  @override
  _SimilarUsersState createState() => _SimilarUsersState();
}

class _SimilarUsersState extends State<SimilarUsers> {
  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width =  MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Align(
          alignment: Alignment.topLeft,
          child: Container(
              margin: const EdgeInsets.only(left: 85),
              child: Text('Network', style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 26,
                  fontWeight: FontWeight.w400
              ),)),
        ),
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: secondaryBackground,
        toolbarHeight: height/10.5,
      ),
    );
  }
}

