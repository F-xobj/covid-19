import 'package:flutter/cupertino.dart';
import 'AppLocalization.dart';

// LocalizationsDelegate is a factory for a set of localized resources
// In this case, the localized strings will be gotten in an AppLocalizations object
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
    // This delegate instance will never change (it doesn't even have fields!)
    // It can provide a constant constructor.
    const AppLocalizationsDelegate();

    @override
    bool isSupported(Locale locale) {
        // Include all of your supported language codes here
        return ['en', 'ar'].contains(locale.languageCode);
    }

    // AppLocalizations class is where the JSON loading actually runs
    @override
    Future<AppLocalizations> load(Locale locale) async {
        AppLocalizations localizations = new AppLocalizations(locale);
        await localizations.load();
        return localizations;
    }

    @override
    bool shouldReload(AppLocalizationsDelegate old) => false;
}