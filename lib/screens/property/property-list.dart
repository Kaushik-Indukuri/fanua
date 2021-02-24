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
  var city = "dublin";
  var state = "ca";
  var propType = "single_family";
  int propIndex = 0;

  String url1 = "http://10.0.2.2:5000/query?city=";
  String url2 = "&state=";
  String url3 = "&proptype=";
  PropertySearch _propertyList;
  String address = "";

  Future loadData() async {
    try {
      final response = await http.get("$url1$city$url2$state$url3$propType");
      if (200 == response.statusCode) {
        final jsonBody = json.decode(response.body);
        PropertySearch propertySearch = new PropertySearch.fromJson(jsonBody);
        return propertySearch;
      }
    } catch (e) {
      print(e);
    }
  }

  updateList() {
    loadData().then((propertySearch) {
      setState(() {
        _propertyList = propertySearch;
      });
    });
  }

  updatePropType() {
    if (propIndex == 0) {
      setState(() {
        propType = "single_family";
      });
    }
    if (propIndex == 1) {
      setState(() {
        propType = "condo";
      });
    }
    if (propIndex == 2) {
      setState(() {
        propType = "multi_family";
      });
    }
    if (propIndex == 3) {
      setState(() {
        propType = "farm";
      });
    }
    if (propIndex == 4) {
      setState(() {
        propType = "land";
      });
    }
    if (propIndex == 5) {
      setState(() {
        propType = "other";
      });
    }
  }

  Widget buildFilter(String filterName, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          propIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            color: index == propIndex ? blueText : Colors.transparent,
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            border: Border.all(
              color: index == propIndex
                  ? Colors.transparent
                  : Colors.grey[500].withOpacity(0.7),
              width: 1,
            )),
        child: Center(
          child: Text(
            filterName,
            style: TextStyle(
              color: index == propIndex ? Colors.white : secondaryText,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
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
      backgroundColor: Colors.grey[300],
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                "Explore Properties",
                style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 25,
                    color: blueText,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 0.5,
                ),
                SizedBox(
                  width: 210,
                  child: TextField(
                    onSubmitted: (val) {
                      setState(() {
                        city = val;
                      });
                    },
                    style: TextStyle(fontSize: 18),
                    //cursorColor: Colors.white,
                    obscureText: false,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.gps_fixed,
                        color: blueText,
                      ),
                      hintText: "City",
                      hintStyle:
                          TextStyle(color: Colors.grey[500].withOpacity(0.9)),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Colors.grey[500].withOpacity(0.7))),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Colors.grey[500].withOpacity(0.7))),
                    ),
                  ),
                ),
                SizedBox(
                  width: 75,
                  child: TextField(
                    onSubmitted: (val) {
                      setState(() {
                        state = val;
                      });
                    },
                    style: TextStyle(fontSize: 18),
                    //cursorColor: Colors.white,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: "State",
                      hintStyle:
                          TextStyle(color: Colors.grey[500].withOpacity(0.9)),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Colors.grey[500].withOpacity(0.7))),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Colors.grey[500].withOpacity(0.7))),
                    ),
                  ),
                ),
                SizedBox(
                  width: 0,
                ),
                SizedBox(
                  width: 20,
                  height: 40,
                  child: GestureDetector(
                    onTap: () {
                      updatePropType();
                      loadData();
                      updateList();
                    },
                    child: Container(
                      child: Icon(
                        Icons.search,
                        color: secondaryText,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: IconButton(
                    icon: Icon(
                      MdiIcons.tuneVertical,
                      size: 30,
                      color: secondaryText,
                    ),
                    onPressed: () {
                      _showBottomSheet();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 14,
            ),
            Container(
              height: 32,
              child: Stack(
                children: [
                  ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(
                        width: 12,
                      ),
                      buildFilter("Single Family", 0),
                      SizedBox(
                        width: 12,
                      ),
                      buildFilter("Condo", 1),
                      SizedBox(
                        width: 12,
                      ),
                      buildFilter("Multi Family", 2),
                      SizedBox(
                        width: 12,
                      ),
                      buildFilter("Farm", 3),
                      SizedBox(
                        width: 12,
                      ),
                      buildFilter("Land", 4),
                      SizedBox(
                        width: 12,
                      ),
                      buildFilter("Other", 5),
                      SizedBox(
                        width: 12,
                      ),
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
                              Colors.grey[300],
                              Colors.grey[300].withOpacity(0.6),
                            ],
                            stops: [
                              0.95,
                              0.1
                            ]),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    top: 6,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: Text(
                          "Property:",
                          style: TextStyle(
                            color: secondaryText,
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _propertyList == null
                ? LoadingProperties()
                : Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: _propertyList.properties.length,
                        itemBuilder: (context, index) {
                          return PropertyTile(
                            _propertyList.properties[index].address.line == null
                                ? "Not Listed"
                                : _propertyList.properties[index].address.line,
                            _propertyList.properties[index].price == null
                                ? null
                                : _propertyList.properties[index].price,
                            _propertyList.properties[index].buildingSize.size ==
                                    null
                                ? null
                                : _propertyList
                                    .properties[index].buildingSize.size,
                            _propertyList.properties[index].beds == null
                                ? null
                                : _propertyList.properties[index].beds,
                            _propertyList.properties[index].baths == null
                                ? null
                                : _propertyList.properties[index].baths,
                            _propertyList.properties[index].thumbnail == null
                                ? "https://ap.rdcpix.com/077b89d05a93b71489a176c6123f91b2l-m2250185617x.jpg"
                                : _propertyList.properties[index].thumbnail,
                            city[0].toUpperCase() + city.substring(1),
                            state.toUpperCase(),
                            _propertyList.properties[index].buildingSize.size ==
                                    null
                                ? null
                                : _propertyList
                                    .properties[index].buildingSize.size,
                            _propertyList.properties[index].clientDisplayFlags
                                        .hasOpenHouse ==
                                    null
                                ? false
                                : _propertyList.properties[index]
                                    .clientDisplayFlags.hasOpenHouse,
                            _propertyList.properties[index].bathsFull == null
                                ? null
                                : _propertyList.properties[index].bathsFull,
                            _propertyList.properties[index].branding
                                        .listingOffice.listItem.name ==
                                    null
                                ? "Not Listed"
                                : _propertyList.properties[index].branding
                                    .listingOffice.listItem.name,
                            _propertyList.properties[index].agents[0].name ==
                                    null
                                ? "Not Listed"
                                : _propertyList
                                    .properties[index].agents[0].name,
                            _propertyList.properties[index].address.lat,
                            _propertyList.properties[index].address.lon,
                            index,
                          );
                        }),
                  ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        builder: (BuildContext context) {
          return Wrap(
            children: [
              Filter(),
            ],
          );
        });
  }
}

class LoadingProperties extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: Colors.grey[300],
      child: Align(
        alignment: Alignment.bottomCenter,
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(blueText),
        ),
      ),
    );
  }
}
