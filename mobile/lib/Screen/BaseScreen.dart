import 'package:covied_19/AppLocale/AppLocalization.dart';
import 'package:covied_19/Exception/InternetException.dart';
import 'package:covied_19/Theme/AppColor.dart';
import 'package:covied_19/Utilts/Dialog.dart';
import 'package:covied_19/ViewModel/CovidVm.dart';
import 'package:covied_19/class/BaseScreenCls/CountryDataCls.dart';
import 'package:covied_19/class/BaseScreenCls/Covid-19-statisticCls.dart';
import 'package:covied_19/class/BaseScreenCls/GlobalCls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'ConntryStatisticDetailsScreen.dart';
import 'Custom/CustomGlobalStatisticCard.dart';

class BaseScreen extends StatefulWidget {
    BaseScreen({Key key}) : super(key: key);

    @override
    _MyBaseScreen createState() => _MyBaseScreen();
}

class _MyBaseScreen extends State<BaseScreen> {
    Covid covid;
    Icon _searchIcon = new Icon(Icons.search);
    String _searchText = "";
    Widget _appBarTitle;
    List<CountryData> filteredParticipants = new List();
    final TextEditingController _filter = new TextEditingController();
    int colorIndex = -1;
    List<Color> colors = [
        DARK_BLUE,
        GREEN,
        ORANGE,
        LIGHT_BLUE,
        RED
    ];

    @override
    void initState() {
        super.initState();
        getCovidStatistics();
    }

    Future<void> getCovidStatistics() async {
        CovidVm.getCovidStatistics().then((data) {
            setState(() {
                covid = data;
                filteredParticipants = covid.countryData;
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

    void _searchPressed(BuildContext context) {
        setState(() {
            if(_searchIcon.icon == Icons.search) {
                _searchIcon = new Icon(Icons.close);
                _appBarTitle = new TextField(
                        style: TextStyle(
                            color: BACKGROUND
                        ),
                        controller: _filter,
                        onChanged: (value) {
                            if (value.isEmpty) {
                                setState(() {
                                    _searchText = "";
                                    filteredParticipants = covid.countryData;
                                });
                            } 
                            else {
                                setState(() {
                                    _searchText = value;
                                    filteredParticipants = covid.countryData;
                                });
                            }
                        }, 
                        decoration: new InputDecoration(
                                hintStyle: TextStyle(
                                    color: BACKGROUND
                                ),
                                hintText: AppLocalizations.of(context).translate('search')
                            ),
                );
            }
            else {
                _searchText = '';
                _searchIcon = new Icon(Icons.search);
                filteredParticipants = covid.countryData;
                _filter.clear();
            }
        });
    }

    void sortListBasedOnNewConfirmed(BuildContext context) {
        OwnDialog.showWaitingDialog(context);
        filteredParticipants.sort((a, b) => a.newConfirmed.compareTo(b.newConfirmed));
        setState(() {
            filteredParticipants = new List.from(filteredParticipants.reversed); 
        });
        Navigator.pop(context);
    }

    void sortListBasedOnTotalConfirmed(BuildContext context) {
        OwnDialog.showWaitingDialog(context);
        filteredParticipants.sort((a, b) => a.totalConfirmed.compareTo(b.totalConfirmed));
        setState(() {
            filteredParticipants = new List.from(filteredParticipants.reversed); 
        });
        Navigator.pop(context);
    }

    void sortListBasedOnTotalDeaths(BuildContext context) {
        OwnDialog.showWaitingDialog(context);
        filteredParticipants.sort((a, b) => a.totalDeaths.compareTo(b.totalDeaths));
        setState(() {
            filteredParticipants = new List.from(filteredParticipants.reversed); 
        });
        Navigator.pop(context);
    }

    void sortListBasedOnTotalRecoverd(BuildContext context) {
        OwnDialog.showWaitingDialog(context);
        filteredParticipants.sort((a, b) => a.totalRecovered.compareTo(b.totalRecovered));
        setState(() {
            filteredParticipants = new List.from(filteredParticipants.reversed); 
        });
        Navigator.pop(context);
    }

    void resetToAll(BuildContext context) {
        OwnDialog.showWaitingDialog(context);
        setState(() {
            filteredParticipants = covid.countryData;
        });
        Navigator.pop(context);
    }

    @override
    Widget build(BuildContext context) {
        if(_searchIcon.icon == Icons.search) {
            _appBarTitle = new Text(AppLocalizations.of(context).translate('covid_statistics'));
        }
        if(_searchText.isNotEmpty) {
            List<CountryData> tempList = new List();
            for (int i = 0; i < filteredParticipants.length; i++) {
                if (filteredParticipants[i].countryName.toLowerCase().contains(_searchText.toLowerCase())) {
                    tempList.add(filteredParticipants[i]);
                }
            }
            filteredParticipants = tempList;
        }
        return Scaffold(
            backgroundColor: BACKGROUND,
            appBar: AppBar(
                title: _appBarTitle,
                actions: <Widget>[
                    new IconButton(
                        icon: _searchIcon,
                        onPressed: () {
                            _searchPressed(context);
                        },
                    ),
                ],
            ),
            body: covid != null
                ? ListView(
                    children: <Widget>[
                        _bulidFilterTab(),
                        Container(
                            height: 0.5,
                            color: TITLE_DARK,
                        ),
                        _buildGlobalStatistics(covid.globalData),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: filteredParticipants.length,
                            itemBuilder: (BuildContext context, int index) {
                                return _buildCountryStatistics(filteredParticipants[index]);
                            }
                        )
                    ],
                )
                : Center(
                    child: CircularProgressIndicator(
                        backgroundColor: BACKGROUND,
                        valueColor: new AlwaysStoppedAnimation<Color>(PRIMARY_COLOR)
                    ),
                )
        );
    }

    Container _bulidFilterTab() {
        return Container (
                width: double.infinity,
                height: 60,
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 1.0),
                                        blurRadius: 6.0,
                                    ),
                                ],
                            ),
                child: Container(
                        child: new FlatButton.icon(
                        onPressed: () {
                            _bulidTypeActionCheat();
                        },
                        icon: Icon(Icons.arrow_drop_down, size: 30, color: DARK_PRIMARY_COLOR,),
                        label: Flexible(
                                child: Text(
                                        AppLocalizations.of(context).translate('Country Filter'),
                                        style: TextStyle(
                                                    color: DARK_PRIMARY_COLOR,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold
                                                ),
                                        overflow: TextOverflow.ellipsis,
                                    )
                            ),
                        ),
                ), 
            );
    }

    void _bulidTypeActionCheat() {
        showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) => CupertinoActionSheet(
                    title: Text(
                                AppLocalizations.of(context).translate('Order By'),
                                style: TextStyle(
                                        color: PRIMARY_COLOR,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                    )
                            ),
                    actions: <Widget>[
                        CupertinoActionSheetAction(
                            child: Text(
                                        AppLocalizations.of(context).translate('Default'),
                                        style: TextStyle(
                                                color: PRIMARY_COLOR,
                                            )
                                        ),
                            onPressed: () {
                                Navigator.pop(context);
                                resetToAll(context);
                            },
                        ),
                        CupertinoActionSheetAction(
                            child: Text(
                                        AppLocalizations.of(context).translate('Total Confirmed'),
                                        style: TextStyle(
                                                    color: PRIMARY_COLOR,
                                                )
                                        ),
                            onPressed: () {
                                Navigator.pop(context);
                                sortListBasedOnTotalConfirmed(context);
                            },
                        ),
                        CupertinoActionSheetAction(
                            child: Text(
                                        AppLocalizations.of(context).translate('New Confirmed'),
                                        style: TextStyle(
                                                    color: PRIMARY_COLOR,
                                                )
                                        ),
                            onPressed: () {
                                Navigator.pop(context);
                                sortListBasedOnNewConfirmed(context);
                            },
                        ),
                        CupertinoActionSheetAction(
                            child: Text(
                                        AppLocalizations.of(context).translate('Total Recovered'),
                                        style: TextStyle(
                                                    color: PRIMARY_COLOR,
                                                )
                                        ),
                            onPressed: () {
                                Navigator.pop(context);
                                sortListBasedOnTotalRecoverd(context);
                            },
                        ),
                        CupertinoActionSheetAction(
                            child: Text(
                                        AppLocalizations.of(context).translate('Total Deaths'),
                                        style: TextStyle(
                                                    color: PRIMARY_COLOR,
                                                )
                                        ),
                            onPressed: () {
                                Navigator.pop(context);
                                sortListBasedOnTotalDeaths(context);
                            },
                        ),
                    ],
                cancelButton: CupertinoActionSheetAction(
                    child: Text(
                        AppLocalizations.of(context).translate('Cancel'),
                        style: TextStyle(
                                color: PRIMARY_COLOR,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            )
                        ),
                    isDefaultAction: true,
                    onPressed: () {
                        Navigator.pop(context);
                    },
                )
            ),
        );
    }

    Widget _buildGlobalStatistics(Global global) {
        return Container(
            padding: EdgeInsets.all(8),
            height: 400,
            color: Colors.white,
            child: Column(
                children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(16),
                        child:Text(
                            'World Statistics',
                            style: TextStyle(
                                color: DARK_BLUE,
                                fontSize: 24
                            ),
                        ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                            Flexible(
                                flex: 1,
                                child: CustomGlobalStatisticCard(
                                    lable: 'New Confirmed',
                                    iconUrl: 'icons/confirmed.svg',
                                    value: global.newConfirmed.toString(),
                                )
                            ),
                            Flexible(
                                flex: 1,
                                child: CustomGlobalStatisticCard(
                                    lable: 'Total Confirmed',
                                    iconUrl: 'icons/patient.svg',
                                    value: global.totalConfirmed.toString(),
                                )
                            ),
                        ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                            Flexible(
                                child:CustomGlobalStatisticCard(
                                    lable: 'New Recovered',
                                    iconUrl: 'icons/team.svg',
                                    value: global.newRecovered.toString(),
                                )
                            ),
                            Flexible(
                                child: CustomGlobalStatisticCard(
                                    lable: 'Total Recovered',
                                    iconUrl: 'icons/team.svg',
                                    value: global.totalRecovered.toString(),
                                )
                            ),
                        ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                            Flexible(
                                child: CustomGlobalStatisticCard(
                                    lable: 'New Deaths',
                                    iconUrl: 'icons/broken-heart.svg',
                                    value: global.newDeaths.toString(),
                                )
                            ),
                            Flexible(
                                child: CustomGlobalStatisticCard(
                                    lable: 'Total Deaths',
                                    iconUrl: 'icons/broken-heart.svg',
                                    value: global.totalDeaths.toString(),
                                )
                            ),
                        ],
                    ),
                ],
            ),
        );
    }

    Widget _buildCountryStatistics(CountryData country) {
        return InkWell(
            child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(right: 8, left: 8, top: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget> [
                                Flexible(
                                    child:Container(
                                        width: 120,
                                        height: 120,
                                        padding: EdgeInsets.all(16),
                                        decoration:  BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: new Border.all(
                                                color: DARK_PRIMARY_COLOR,
                                                width: 2.5,
                                            ),
                                        ),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                                Text(
                                                    country.newConfirmed != null
                                                        ? country.newConfirmed.toString()
                                                        : '',
                                                    style: TextStyle(
                                                        color: DARK_PRIMARY_COLOR,
                                                        fontSize: 18,
                                                    ),
                                                ),
                                                Text(
                                                    'News',
                                                    style: TextStyle(
                                                        color: DARK_PRIMARY_COLOR,
                                                        fontSize: 18,
                                                    ),
                                                ),
                                                new SvgPicture.asset('icons/confirmed.svg',color: DARK_PRIMARY_COLOR, width: 24,height: 24,)
                                            ],
                                        ),
                                    )
                                ),
                                Flexible(
                                    flex: 2,
                                    child:Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                            Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                    Flexible(
                                                        child:Container(
                                                            margin: EdgeInsets.only(left:16, top: 16),
                                                            child:Text(
                                                                    country.countryName,
                                                                    style: TextStyle(
                                                                        color: DARK_PRIMARY_COLOR,
                                                                        fontSize: 24,
                                                                    ),
                                                                    // textAlign: TextAlign.justify,
                                                                    // maxLines: 1,
                                                                    // softWrap: true,
                                                                )
                                                        )
                                                    ),
                                                ],
                                            ),
                                            Row(
                                                children: <Widget>[
                                                    Container(
                                                        margin: EdgeInsets.only(left: 16, top: 8),
                                                        child: Text(
                                                            'TotalConfirmed :',
                                                            style: TextStyle(
                                                                color: DARK_PRIMARY_COLOR,
                                                                fontSize: 16,
                                                            ),
                                                        )
                                                    ),
                                                    Container(
                                                        margin: EdgeInsets.only(right: 16, top: 8),
                                                        child: Text(
                                                            country.totalConfirmed != null
                                                                ? country.totalConfirmed.toString()
                                                                : '',
                                                            style: TextStyle(
                                                                color: DARK_PRIMARY_COLOR,
                                                                fontSize: 16,
                                                            ),
                                                        )
                                                    )
                                                ],
                                            ),
                                            Row(
                                                children: <Widget>[
                                                    Row(
                                                        children: <Widget>[
                                                            Container(
                                                                margin: EdgeInsets.only(left: 16, top: 32),
                                                                child: new SvgPicture.asset('icons/broken-heart.svg',color: DARK_PRIMARY_COLOR, width: 24,height: 24,)
                                                            ),
                                                            Container(width: 4,),
                                                            Container(
                                                                margin: EdgeInsets.only(right: 16, top: 32),
                                                                child: Text(
                                                                    country.totalDeaths != null
                                                                        ? country.totalDeaths.toString()
                                                                        : '',
                                                                    style: TextStyle(
                                                                        color: DARK_PRIMARY_COLOR,
                                                                        fontSize: 18,
                                                                    ),
                                                                )
                                                            )
                                                        ],
                                                    ),
                                                    Row(
                                                        children: <Widget>[
                                                            Container(
                                                                margin: EdgeInsets.only(left: 16, top: 32),
                                                                child: new SvgPicture.asset('icons/patient.svg',color: DARK_PRIMARY_COLOR, width: 24,height: 24)
                                                            ),
                                                            Container(width: 4,),
                                                            Container(
                                                                margin: EdgeInsets.only(right: 16, top: 32),
                                                                child: Text(
                                                                    country.totalRecovered != null 
                                                                        ? country.totalRecovered.toString()
                                                                        : '',
                                                                    style: TextStyle(
                                                                        color: DARK_PRIMARY_COLOR,
                                                                        fontSize: 18,
                                                                    ),
                                                                )
                                                            )
                                                        ],
                                                    ),
                                                ],
                                            )
                                        ],
                                    )
                                )
                            ],
                        ),
                    ],
                ),
            ),
            onTap: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ConntryStatisticDetailsScreen(country)),
                );
            },
        );
    }
}
