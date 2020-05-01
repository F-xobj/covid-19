import 'package:covied_19/Exception/InternetException.dart';
import 'package:covied_19/Screen/Custom/CustomGlobalStatisticCard.dart';
import 'package:covied_19/Theme/AppColor.dart';
import 'package:covied_19/Utilts/Dialog.dart';
import 'package:covied_19/ViewModel/CovidVm.dart';
import 'package:covied_19/class/BaseScreenCls/CountryDataCls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class LinearStatistic {
    final int day;
    final int count;

    LinearStatistic(this.day, this.count);
}

class ConntryStatisticDetailsScreen extends StatefulWidget {
    final CountryData countryData;
    ConntryStatisticDetailsScreen(
        this.countryData
    );

    @override
    _MyConntryStatisticDetails createState() => _MyConntryStatisticDetails(countryData);
}

class _MyConntryStatisticDetails extends State<ConntryStatisticDetailsScreen> {
    CountryData countryData;
    var formatter = new DateFormat('yyyy-MM-dd');
    bool showCharts = false;
    List<LinearStatistic> totalConfirmed = new List();
    List<LinearStatistic> totalDeaths = new List();
    List<LinearStatistic> totalRecovered = new List();
    List<LinearStatistic> totalActive = new List();

    _MyConntryStatisticDetails(this.countryData);

    @override
    void initState() {
        super.initState();
        getCountryStatistics();
    }

    List<charts.Series<LinearStatistic, int>> _createSampleData(List<LinearStatistic> data) {
        return [
            new charts.Series<LinearStatistic, int>(
                    id: 'Confimrend',
                    colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
                    domainFn: (LinearStatistic statistic, _) => statistic.day,
                    measureFn: (LinearStatistic statistic, _) => statistic.count,
                    data: data,
                )
        ];
    }

    Future<void> getCountryStatistics() async {
        CovidVm.getCountryStatisticsByDateAndStatus(
            country: countryData.countryName,
            endDate: formatter.format(new DateTime.now().subtract(Duration(days: 1))),
            startDate: formatter.format(new DateTime.now().subtract(Duration(days: 15)))
        ).then((statistics) {
            for(int ii = 0; ii < statistics.totalActive.length; ii++) {
                totalActive.add(new LinearStatistic(ii, statistics.totalActive[ii]));
            }
            for(int ii = 0; ii < statistics.totalConfirmed.length; ii++) {
                totalConfirmed.add(new LinearStatistic(ii, statistics.totalConfirmed[ii]));
            }
            for(int ii = 0; ii < statistics.totalDeaths.length; ii++) {
                totalDeaths.add(new LinearStatistic(ii, statistics.totalDeaths[ii]));
            }
            for(int ii = 0; ii < statistics.totalRecovered.length; ii++) {
                totalRecovered.add(new LinearStatistic(ii, statistics.totalRecovered[ii]));
            }
            setState(() {
                showCharts = true;
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
            appBar: AppBar(
                title: Text(
                    countryData.countryName,
                )
            ),
            body: ListView(
                children: <Widget>[
                    _buildGlobalStatistics(),
                    showCharts
                        ? Column(
                            children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(top: 16),
                                    child: Text(
                                        'Total Confirmed'
                                    ),
                                ),
                                Container(
                                    height: 250,
                                    child: new charts.LineChart(
                                        _createSampleData(totalConfirmed),
                                        animate: false,
                                        defaultRenderer: new charts.LineRendererConfig(includePoints: true)
                                    )
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 16),
                                    child: Text(
                                        'Total Recovered'
                                    ),
                                ),
                                Container(
                                    margin: EdgeInsets.all(8),
                                    height: 250,
                                    child: new charts.LineChart(
                                        _createSampleData(totalRecovered),
                                        animate: false,
                                        defaultRenderer: new charts.LineRendererConfig(includePoints: true)
                                    )
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 16),
                                    child: Text(
                                        'Total Active'
                                    ),
                                ),
                                Container(
                                    margin: EdgeInsets.all(8),
                                    height: 250,
                                    child: new charts.LineChart(
                                        _createSampleData(totalActive),
                                        animate: false,
                                        defaultRenderer: new charts.LineRendererConfig(includePoints: true)
                                    )
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 16),
                                    child: Text(
                                        'Total Deaths'
                                    ),
                                ),
                                Container(
                                    margin: EdgeInsets.all(8),
                                    height: 250,
                                    child: new charts.LineChart(
                                        _createSampleData(totalDeaths),
                                        animate: false,
                                        defaultRenderer: new charts.LineRendererConfig(includePoints: true)
                                    )
                                )
                            ],
                        )
                        : Container(
                            margin: EdgeInsets.only(top: 16),
                            child: Center(
                                child: CircularProgressIndicator(
                                    backgroundColor: BACKGROUND,
                                    valueColor: new AlwaysStoppedAnimation<Color>(PRIMARY_COLOR)
                                ),
                            )
                        )
                ],
            ),
        );
    }

    Widget _buildGlobalStatistics() {
        return Container(
            padding: EdgeInsets.all(8),
            height: 400,
            color: Colors.white,
            child: Column(
                children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(16),
                        child:Text(
                            '${countryData.countryName} Statistics',
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
                                    value: countryData.newConfirmed == null ? '--' : countryData.newConfirmed.toString(),
                                )
                            ),
                            Flexible(
                                flex: 1,
                                child: CustomGlobalStatisticCard(
                                    lable: 'Total Confirmed',
                                    iconUrl: 'icons/patient.svg',
                                    value: countryData.totalConfirmed == null ? '--' : countryData.totalConfirmed.toString(),
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
                                    value: countryData.newRecovered == null ? '--' : countryData.newRecovered.toString(),
                                )
                            ),
                            Flexible(
                                child: CustomGlobalStatisticCard(
                                    lable: 'Total Recovered',
                                    iconUrl: 'icons/team.svg',
                                    value: countryData.totalRecovered == null ? '--' : countryData.totalRecovered.toString(),
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
                                    value: countryData.newDeaths == null ? '--' : countryData.newDeaths.toString(),
                                )
                            ),
                            Flexible(
                                child: CustomGlobalStatisticCard(
                                    lable: 'Total Deaths',
                                    iconUrl: 'icons/broken-heart.svg',
                                    value: countryData.totalDeaths == null ? '--' : countryData.totalDeaths.toString(),
                                )
                            ),
                        ],
                    ),
                ],
            ),
        );
    }
}