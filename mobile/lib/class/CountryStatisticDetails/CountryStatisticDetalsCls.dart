class CountryStatisticDetals {
    List<int> _totalConfirmed, _totalDeaths, _totalRecovered, _totalActive;

    CountryStatisticDetals({
        List<int> totalConfirmed,
        List<int> totalDeaths, 
        List<int> totalRecovered,
        List<int> totalActive
    }) {
        this._totalConfirmed = totalConfirmed;
        this._totalActive = totalActive;
        this._totalDeaths = totalDeaths;
        this._totalRecovered = totalRecovered;
    }

    List<int> get totalConfirmed => this._totalConfirmed;
    set totalConfirmed(List<int> totalConfirmed) => this._totalConfirmed = totalConfirmed;

    List<int> get totalDeaths => this._totalDeaths;
    set totalDeaths(List<int> totalDeaths) => this._totalDeaths = totalDeaths;

    List<int> get totalRecovered => this._totalRecovered;
    set totalRecovered(List<int> totalRecovered) => this._totalRecovered = totalRecovered;

    List<int> get totalActive => this._totalActive;
    set totalActive(List<int> totalActive) => this._totalActive = totalActive;

    factory CountryStatisticDetals.fromJson(List data) {
        return new CountryStatisticDetals(
            totalActive: List<int>.from(data.map((x) => x['Active'])),
            totalConfirmed:  List<int>.from(data.map((x) => x['Confirmed'])),
            totalDeaths: List<int>.from(data.map((x) => x['Deaths'])),
            totalRecovered: List<int>.from(data.map((x) => x['Recovered'])),
         );
     }
}