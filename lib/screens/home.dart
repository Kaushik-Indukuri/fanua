import 'package:fanua/constants/colors.dart';
import 'package:fanua/services/constants.dart';
import 'package:fanua/services/helperfunctions.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dashboard.dart';
import 'property/property-list.dart';
import 'messaging/chatroom.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;

  final tabs = [
    Dashboard(),
    PropertyList(),
  ];

  @override void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async{
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: tabs[_currentIndex],

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: secondaryBackground,
        ),
        padding: const EdgeInsets.all(1),
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(
                  blurRadius: 20,
                  offset: Offset(0, 9),
                )],
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: _currentIndex,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                elevation: 10,
                backgroundColor: secondaryBackground,
                unselectedItemColor: Colors.grey[400].withOpacity(0.3),
                selectedItemColor: Colors.white,
                items: [
                  BottomNavigationBarItem(
                    icon: Container(
                      //color: Colors.red,
                      margin: EdgeInsets.only(right: 35),
                        child: Icon(MdiIcons.viewDashboardOutline, size: 30,)
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      margin: EdgeInsets.only(left: 35),
                        child: Icon(MdiIcons.homeCityOutline, size: 30,)
                    ),
                    label: '',
                  ),
                ],
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width/2.4,
              bottom: 20,
              child: Container(
                height: MediaQuery.of(context).size.width/6,
                width: MediaQuery.of(context).size.width/6,
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(
                    blurRadius: 3,
                    offset: Offset(0,1),
                  )],
                    gradient: buttonGradient,
                    borderRadius: BorderRadius.circular(50)
                ),
                child: FloatingActionButton(
                    elevation: 0.0,
                    child: Icon(Icons.add, color: secondaryBackground, size: 42,),
                    backgroundColor: Colors.transparent,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Chatroom()));
                    }
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
