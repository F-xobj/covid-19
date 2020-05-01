import 'CountryDataCls.dart';
import 'GlobalCls.dart';

class Covid{
    Global _globalData;
    List<CountryData> _countryData;

    Covid({
        Global globalData,
        List<CountryData> countryData
    }) {
        this._globalData = globalData;
        this._countryData = countryData;
    }

    Global get globalData => this._globalData;
    set globalData(Global globalData) => this._globalData = globalData;

    List<CountryData> get countryData => this._countryData;
    set countryData(List<CountryData> totalRecovered) => this._countryData = countryData;

    factory Covid.fromJson(Map<String,dynamic> data) {
         return new Covid(
            globalData: Global.fromJson(data),
            countryData: List<CountryData>.from(data['Countries'].map((x) => CountryData.fromJson(x))),
         );
     }
}
