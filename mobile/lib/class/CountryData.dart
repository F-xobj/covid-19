class CountryData {
    String _countryName, _countryCode, _slug, _date;
    int _newConfirmed, _totalConfirmed, _newDeaths, _totalDeaths,
           _newRecovered, _totalRecovered;
    
    CountryData({
        String countryName,
        String countryCode,
        String slug,
        String date,
        int newConfirmed,
        int totalConfirmed,
        int newDeaths,
        int totalDeaths,
        int newRecovered,
        int totalRecovered
    }) {
        this._countryName = countryName;
        this._countryCode = countryCode;
        this._slug = slug;
        this._date = date;
        this._newConfirmed = newConfirmed;
        this._totalConfirmed = totalConfirmed;
        this._newDeaths = newDeaths;
        this._totalDeaths = totalDeaths;
        this._newRecovered = _newRecovered;
        this._totalRecovered = totalRecovered;
    }

    String get countryName => this._countryName;
    set countryName(String countryName) => this._countryName = countryName;

    String get countryCode => this._countryCode;
    set countryCode(String countryCode) => this._countryCode = countryCode;

    String get slug => this._slug;
    set slug(String slug) => this._slug = slug;

    String get date => this._date;
    set date(String date) => this._date = date;

    int get newConfirmed => this._newConfirmed;
    set newConfirmed(int newConfirmed) => this._newConfirmed = newConfirmed;

    int get totalConfirmed => this._totalConfirmed;
    set totalConfirmed(int totalConfirmed) => this._totalConfirmed = totalConfirmed;

    int get newDeaths => this._newDeaths;
    set newDeaths(int newDeaths) => this._newDeaths = newDeaths;

    int get totalDeaths => this._totalDeaths;
    set totalDeaths(int totalDeaths) => this._totalDeaths = totalDeaths;

    int get newRecovered => this._newRecovered;
    set newRecovered(int newRecovered) => this._newRecovered = newRecovered;

    int get totalRecovered => this._totalRecovered;
    set totalRecovered(int totalRecovered) => this._totalRecovered = totalRecovered;

     factory CountryData.fromJson(Map<String,dynamic> data) {

         return new CountryData(
            countryCode: data['CountryCode'],
            countryName: data['Country'],
            date: data['Date'],
            newConfirmed: data['NewConfirmed'],
            newDeaths: data['NewDeaths'],
            totalRecovered: data['TotalRecovered'],
            newRecovered: data['NewRecovered'],
            slug: data['Slug'],
            totalConfirmed: data['TotalConfirmed'],
            totalDeaths: data['TotalDeaths']
         );
     }
}