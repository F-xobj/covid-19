class Global {
    int _newConfirmed, _totalConfirmed, _newDeaths, _totalDeaths, _newRecovered, _totalRecovered;

    Global({
        int newConfirmed,
        int totalConfirmed,
        int newDeaths,
        int totalDeaths,
        int newRecovered,
        int totalRecovered
    }) {
        this._newConfirmed = newConfirmed;
        this._totalConfirmed = totalConfirmed;
        this._newDeaths = newDeaths;
        this._totalDeaths = totalDeaths;
        this._newRecovered = newRecovered;
        this._totalRecovered = totalRecovered;
    }

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


    factory Global.fromJson(Map<String,dynamic> data) {
        return new Global(
            newConfirmed: data['Global']['NewConfirmed'],
            newDeaths: data['Global']['NewDeaths'],
            totalRecovered: data['Global']['TotalRecovered'],
            newRecovered: data['Global']['NewRecovered'],
            totalConfirmed: data['Global']['TotalConfirmed'],
            totalDeaths: data['Global']['TotalDeaths']
         );
     }
}