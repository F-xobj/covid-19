import 'package:covied_19/AppLocale/AppLocalization.dart';
import 'package:covied_19/Exception/InternetException.dart';
import 'package:covied_19/Theme/AppColor.dart';
import 'package:covied_19/Utilts/Dialog.dart';
import 'package:covied_19/ViewModel/CovidVm.dart';
import 'package:covied_19/class/CountryData.dart';
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
                filteredParticipants = data.countryData;
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

    Widget _buildGlobalStatistics(Global global) {
        return Container(
            padding: EdgeInsets.all(8),
            height: 435,
            color: Colors.white,
            child: Column(
                children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(16),
                        child:Text(
                            'World Statistics',
                            style: TextStyle(
                                color: PRIMARY_COLOR,
                                fontSize: 24
                            ),
                        ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                            Flexible(
                                child: Container(
                                    child: Card(
                                        elevation: 4,
                                        child: Column(
                                            children: <Widget>[
                                                Container(
                                                    width: 200,
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.all(16),
                                                    child: Text(
                                                        'Total Confirmed',
                                                        style: TextStyle(
                                                            color: PRIMARY_COLOR,
                                                            fontSize: 18,
                                                        ),
                                                    ),
                                                ),
                                                Container(
                                                    width: 200,
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.all(16),
                                                    child: Text(
                                                        global.totalConfirmed.toString(),
                                                        style: TextStyle(
                                                            color: PRIMARY_COLOR,
                                                            fontSize: 18,
                                                        ),
                                                    ),
                                                ),
                                            ],
                                        ),
                                    ),
                                ),
                            ),
                            Flexible(
                                child: Container(
                                    child: Card(
                                        elevation: 4,
                                        child: Column(
                                            children: <Widget>[
                                                Container(
                                                    width: 200,
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.all(16),
                                                    child: Text(
                                                        'New Confirmed',
                                                        style: TextStyle(
                                                            color: PRIMARY_COLOR,
                                                            fontSize: 18,
                                                        ),
                                                    ),
                                                ),
                                                Container(
                                                    width: 200,
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.all(16),
                                                    child: Text(
                                                        global.newConfirmed.toString(),
                                                        style: TextStyle(
                                                            color: PRIMARY_COLOR,
                                                            fontSize: 18,
                                                        ),
                                                    ),
                                                )
                                            ],
                                        ),
                                    ),
                                ),
                            ),
                        ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                            Flexible(
                                child: Container(
                                    child: Card(
                                        elevation: 4,
                                        child: Column(
                                            children: <Widget>[
                                                Container(
                                                    width: 200,
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.all(16),
                                                    child: Text(
                                                        'Total Recovered',
                                                        style: TextStyle(
                                                            color: PRIMARY_COLOR,
                                                            fontSize: 18,
                                                        ),
                                                    ),
                                                ),
                                                Container(
                                                    width: 200,
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.all(16),
                                                    child: Text(
                                                        global.totalRecovered.toString(),
                                                        style: TextStyle(
                                                            color: PRIMARY_COLOR,
                                                            fontSize: 18,
                                                        ),
                                                    ),
                                                )
                                            ],
                                        ),
                                    ),
                                ),
                            ),
                            Flexible(
                                child: Container(
                                    child: Card(
                                        elevation: 4,
                                        child: Column(
                                            children: <Widget>[
                                                Container(
                                                    width: 200,
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.all(16),
                                                    child: Text(
                                                        'New Recovered',
                                                        style: TextStyle(
                                                            color: PRIMARY_COLOR,
                                                            fontSize: 18,
                                                        ),
                                                    ),
                                                ),
                                                Container(
                                                    width: 200,
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.all(16),
                                                    child: Text(
                                                        global.newRecovered.toString(),
                                                        style: TextStyle(
                                                            color: PRIMARY_COLOR,
                                                            fontSize: 18,
                                                        ),
                                                    ),
                                                ),
                                            ],
                                        ),
                                    ),
                                ),
                            ),
                        ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                            Flexible(
                                child: Container(
                                    child: Card(
                                        elevation: 4,
                                        child: Column(
                                            children: <Widget>[
                                                Container(
                                                    width: 200,
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.all(16),
                                                    child: Text(
                                                        'Total Deaths',
                                                        style: TextStyle(
                                                            color: PRIMARY_COLOR,
                                                            fontSize: 18,
                                                        ),
                                                    ),
                                                ),
                                                Container(
                                                    width: 200,
                                                    padding: EdgeInsets.all(16),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        global.totalDeaths.toString(),
                                                        style: TextStyle(
                                                            color: PRIMARY_COLOR,
                                                            fontSize: 18,
                                                        ),
                                                    ),
                                                ),
                                            ],
                                        ),
                                    ),
                                ),
                            ),
                            Flexible(
                                child: Container(
                                    child: Card(
                                        elevation: 4,
                                        child: Column(
                                            children: <Widget>[
                                                Container(
                                                    width: 200,
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.all(16),
                                                    child: Text(
                                                        'New Deaths',
                                                        style: TextStyle(
                                                            color: PRIMARY_COLOR,
                                                            fontSize: 18,
                                                        ),
                                                    ),
                                                ),
                                                Container(
                                                    width: 200,
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.all(16),
                                                    child: Text(
                                                        global.newDeaths.toString(),
                                                        style: TextStyle(
                                                            color: PRIMARY_COLOR,
                                                            fontSize: 18,
                                                        ),
                                                    ),
                                                ),
                                            ],
                                        ),
                                    ),
                                )
                            ),
                        ],
                    ),
                ],
            ),
        );
    }

    Widget _buildCountryStatistics(CountryData country) {
        if(colorIndex >= 4) {
            colorIndex = 0;
        }
        else {
            colorIndex += 1;
        }

        return Container(
            color: colors[colorIndex],
            padding: EdgeInsets.all(16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                            Flexible(
                                child:Container(
                                    width: 120,
                                    height: 120,
                                    padding: EdgeInsets.all(16),
                                    decoration:  BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: new Border.all(
                                            color: BACKGROUND,
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
                                                    color: BACKGROUND,
                                                    fontSize: 18,
                                                ),
                                            ),
                                            Text(
                                                'News',
                                                style: TextStyle(
                                                    color: BACKGROUND,
                                                    fontSize: 18,
                                                ),
                                            )
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
                                                                    color: BACKGROUND,
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
                                                            color: BACKGROUND,
                                                            fontSize: 18,
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
                                                            color: BACKGROUND,
                                                            fontSize: 18,
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
                                                            child: Icon(Icons.favorite_border, color: BACKGROUND,)
                                                        ),
                                                        Container(width: 4,),
                                                        Container(
                                                            margin: EdgeInsets.only(right: 16, top: 32),
                                                            child: Text(
                                                                country.totalDeaths != null
                                                                    ? country.totalDeaths.toString()
                                                                    : '',
                                                                style: TextStyle(
                                                                    color: BACKGROUND,
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
                                                            child: Icon(Icons.feedback, color: BACKGROUND,)
                                                        ),
                                                        Container(width: 4,),
                                                        Container(
                                                            margin: EdgeInsets.only(right: 16, top: 32),
                                                            child: Text(
                                                                country.totalRecovered != null 
                                                                    ? country.totalRecovered.toString()
                                                                    : '',
                                                                style: TextStyle(
                                                                    color: BACKGROUND,
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
        );
    }
}
