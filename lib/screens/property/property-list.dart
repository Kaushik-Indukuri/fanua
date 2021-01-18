import 'package:fanua/backend/Services.dart';
import 'package:fanua/constants/LoadingAnimation.dart';
import 'package:fanua/constants/colors.dart';
import 'package:fanua/screens/property/property_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:fanua/backend/PropertySearch.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'filter.dart';


class PropertyList extends StatefulWidget {
  @override
  _PropertyListState createState() => _PropertyListState();
}

class _PropertyListState extends State<PropertyList> {

  String city = "dublin";
  String state = "ca";

  String url = "http://10.0.2.2:5000/query?city=&state=ca&proptype=single_family";
  PropertySearch _propertyList;
  String address = "";

  Future loadData() async{
    try {
      final response = await http.get(url);
      if (200 == response.statusCode) {
        final jsonBody = json.decode(response.body);
        PropertySearch propertySearch = new PropertySearch.fromJson(jsonBody);
        return propertySearch;
      }
    } catch (e) {
      print(e);
    }
  }

  Widget buildFilter(String filterName){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          border: Border.all(
            color: Colors.grey[400].withOpacity(0.3),
            width: 1,
          )
      ),
      child: Center(
        child: Text(
          filterName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  @override void initState() {
    // TODO: implement initState
    super.initState();
    loadData().then((propertySearch) {
      setState(() {
        _propertyList = propertySearch;

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //if(_propertyList == null) return Loading();
    return Scaffold(
      backgroundColor: background,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 35,),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text("Explore Properties", style: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),),
            ),
            SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 195,
                  child: TextField(
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    cursorColor: Colors.white,
                    obscureText: false,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.gps_fixed, color: blueText,),
                      hintText: "City",
                      hintStyle: TextStyle(color: Colors.grey[400].withOpacity(0.3)),
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.grey[400].withOpacity(0.3))
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.grey[400].withOpacity(0.3))
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 110,
                  child: TextField(
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    cursorColor: Colors.white,
                    obscureText: false,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        color: Colors.white,
                        onPressed: (){},
                        icon: Icon(Icons.search),
                      ),
                      hintText: "State",
                      hintStyle: TextStyle(color: Colors.grey[400].withOpacity(0.3)),
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.grey[400].withOpacity(0.3))
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.grey[400].withOpacity(0.3))
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: IconButton(
                      icon: Icon(MdiIcons.tuneVertical,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: (){
                        _showBottomSheet();
                      },
                  ),
                ),
              ],
            ),
            SizedBox(height: 14,),
            Container(
              height: 32,
              child: Stack(
                children: [
                  ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      buildFilter("Condo"),
                      buildFilter("Single Family"),
                      buildFilter("Multi Family"),
                      buildFilter("Farm"),
                      buildFilter("Land"),
                      buildFilter("Other"),
                      SizedBox(
                        width: 85,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 102,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                            background,
                            background.withOpacity(0.6),
                          ],
                            stops: [
                              0.95, 0.1
                            ]
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    top: 6,
                    child: GestureDetector(
                      onTap: (){},
                      child: Container(
                        child: Text("Property:", style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            _propertyList == null ? LoadingProperties() : Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _propertyList.properties.length,
                  itemBuilder: (context, index) {
                    return PropertyTile(
                      _propertyList.properties[index].address.line,
                      _propertyList.properties[index].price,
                      _propertyList.properties[index].lotSize.size,
                      _propertyList.properties[index].beds,
                      _propertyList.properties[index].baths,
                      _propertyList.properties[index].thumbnail,
                    );
                  }
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        builder: (BuildContext context){
          return Wrap(
            children: [
              Filter(),
            ],
          );
        }
    );
  }
}

class LoadingProperties extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: background,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(blueText),
        ),
      ),
    );
  }
}