import 'dart:ffi';

import 'package:covied_19/AppLocale/AppLocalization.dart';
import 'package:covied_19/Exception/InternetException.dart';
import 'package:covied_19/Theme/AppColor.dart';
import 'package:covied_19/Utilts/Dialog.dart';
import 'package:covied_19/ViewModel/CovidVm.dart';
import 'package:covied_19/class/Covid-19-statistic.dart';
import 'package:covied_19/class/Global.dart';
import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BaseScreen extends StatefulWidget {
    BaseScreen({Key key, this.title}) : super(key: key);

    final String title;

    @override
    _MyBaseScreen createState() => _MyBaseScreen();
}

class _MyBaseScreen extends State<BaseScreen> {
    Covid covid;
    @override
    void initState() {
        super.initState();
        getCovidStatistics();
    }

    Future<void> getCovidStatistics() async {
        CovidVm.getCovidStatistics().then((data) {
            setState(() {
                covid = data;
            }); 
        }).catchError((error) {
            if(error is InternetException) {
                OwnDialog.customDialog(
                    context,
                    'no_internet_connection',
                    new SvgPicture.asset('No-Signal-wifi.svg',color: PRIMARY_COLOR,width: 120,height: 120,),
                );
            }
            else {
                OwnDialog.showAlertDialog(context, 'something_wrong');
            }
        });
    }
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: BACKGROUND,
            appBar: AppBar(
                title: Text(
                    AppLocalizations.of(context).translate('covid_statistics'),
                )
            ),
            body: covid != null
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: covid.countryData.length,
                    padding: EdgeInsets.all(8),
                    itemBuilder: (BuildContext context, int index) {
                        return Text(covid.countryData[index].countryName);
                    }
                )
                : Center(
                    child: CircularProgressIndicator(
                        backgroundColor: BACKGROUND,
                        valueColor: new AlwaysStoppedAnimation<Color>(PRIMARY_COLOR)
                    ),
                )
        );
    }

    Widget _buildGlobalStatistics(Global global) {
        return Container(
            child: Column(
                children: <Widget>[
                    ListTile(
                        title: Text(
                            AppLocalizations.of(context).translate('new_confirmed'),
                            style: TextStyle(
                                color: PRIMARY_COLOR,
                                fontSize: 18
                            ),
                        ),
                        leading: Flags.getFullFlag('AD', 100, null),
                        trailing: Text(
                            global.newConfirmed.toString(),
                            style: TextStyle(
                                color: SECONDARY_COLOR,
                                fontSize: 18
                            ),
                        ),
                    ),
                    ListTile(
                        title: Text(
                            AppLocalizations.of(context).translate('new_confirmed'),
                            style: TextStyle(
                                color: PRIMARY_COLOR,
                                fontSize: 18
                            ),
                        ),
                        leading: Flags.getFullFlag('AD', 100, null),
                        trailing: Text(
                            global.newConfirmed.toString(),
                            style: TextStyle(
                                color: SECONDARY_COLOR,
                                fontSize: 18
                            ),
                        ),
                    ),
                    ListTile(
                        title: Text(
                            AppLocalizations.of(context).translate('new_confirmed'),
                            style: TextStyle(
                                color: PRIMARY_COLOR,
                                fontSize: 18
                            ),
                        ),
                        leading: Flags.getFullFlag('AD', 100, null),
                        trailing: Text(
                            global.newConfirmed.toString(),
                            style: TextStyle(
                                color: SECONDARY_COLOR,
                                fontSize: 18
                            ),
                        ),
                    ),
                    ListTile(
                        title: Text(
                            AppLocalizations.of(context).translate('new_confirmed'),
                            style: TextStyle(
                                color: PRIMARY_COLOR,
                                fontSize: 18
                            ),
                        ),
                        leading: Flags.getFullFlag('AD', 100, null),
                        trailing: Text(
                            global.newConfirmed.toString(),
                            style: TextStyle(
                                color: SECONDARY_COLOR,
                                fontSize: 18
                            ),
                        ),
                    ),
                    ListTile(
                        title: Text(
                            AppLocalizations.of(context).translate('new_confirmed'),
                            style: TextStyle(
                                color: PRIMARY_COLOR,
                                fontSize: 18
                            ),
                        ),
                        leading: Flags.getFullFlag('AD', 100, null),
                        trailing: Text(
                            global.newConfirmed.toString(),
                            style: TextStyle(
                                color: SECONDARY_COLOR,
                                fontSize: 18
                            ),
                        ),
                    ),
                    ListTile(
                        title: Text(
                            AppLocalizations.of(context).translate('new_confirmed'),
                            style: TextStyle(
                                color: PRIMARY_COLOR,
                                fontSize: 18
                            ),
                        ),
                        leading: Flags.getFullFlag('AD', 100, null),
                        trailing: Text(
                            global.newConfirmed.toString(),
                            style: TextStyle(
                                color: SECONDARY_COLOR,
                                fontSize: 18
                            ),
                        ),
                    )
                ],
            ),
        );
    }
}