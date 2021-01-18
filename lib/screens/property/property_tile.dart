import 'package:fanua/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PropertyTile extends StatelessWidget {
  final String address;
  final int price;
  final int lotSize;
  final int beds;
  final int baths;
  final String image;
  PropertyTile(
      this.address,
      this.price,
      this.lotSize,
      this.beds,
      this.baths,
      this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 25),
          height: 215,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.fill
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 15,
                left: 15,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical:5),
                  decoration: BoxDecoration(
                    color: thirdBackground,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text("FOR SALE", style: TextStyle(
                      fontSize: 16,
                      color: blueText,
                      fontWeight: FontWeight.w500
                  )),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(MdiIcons.mapMarkerOutline, color: blueText, size: 25,),
                            Text(address, style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),),
                          ],
                        ),
                        Text(r"$"+ "$price", style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12, bottom: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(" $beds Beds | $baths Baths", style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),),
                        Row(
                          children: [
                            Icon(MdiIcons.arrowExpandAll, color: Colors.white, size: 17,),
                            SizedBox(width: 3,),
                            Text("$lotSize sqft", style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
