import 'package:covied_19/Theme/AppColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomGlobalStatisticCard extends StatelessWidget{
    final String lable, iconUrl, value;

    CustomGlobalStatisticCard({@required this.lable, @required this.iconUrl, @required this.value});

    @override
    Widget build(BuildContext context) {
        return Container(
            child: Card(
                elevation: 4,
                child: Column(
                    children: <Widget> [
                        Container(
                            padding: EdgeInsets.only(top: 16),
                            child: Row (
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                    Container(
                                        child: Text(
                                            lable,
                                            style: TextStyle(
                                                color: DARK_BLUE,
                                                fontSize: 18,
                                            ),
                                        ),
                                    ),
                                    new SvgPicture.asset(iconUrl ,color: DARK_BLUE, width: 24,height: 24,),
                                ],
                            ),
                        ),
                        Container(
                            width: 200,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 16, bottom: 16),
                            child: Text(
                                value.toString(),
                                style: TextStyle(
                                    color: DARK_BLUE,
                                    fontSize: 18,
                                ),
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}