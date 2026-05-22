import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}

extension LocalizationHelper on AppLocalizations {
  String getByKey(String key) {
    final map = {
      'heritagequote': heritagequote,
      'spiritualquote': spiritualquote,
      'naturequote': naturequote,
      'foodquote': foodquote,

      'pyramidsname': pyramidsname,
      'alharam': alharam,
      'aboutpyramids': aboutpyramids,
      'pyramidstag0': pyramidstag0,
      'pyramidstag1': pyramidstag1,
      'pyramidstag2': pyramidstag2,

      'philaetemplename': philaetemplename,
      'philaetemplelocation': philaetemplelocation,
      'aboutphilaetemple': aboutphilaetemple,
      'philaetempletag0': philaetempletag0,
      'philaetempletag1': philaetempletag1,
      'philaetempletag2': philaetempletag2,

      'hatshepsuttemplename': hatshepsuttemplename,
      'hatshepsuttemplelocation': hatshepsuttemplelocation,
      'aboutatshepsuttemple': aboutatshepsuttemple,
      'hatshepsuttempletag0': hatshepsuttempletag0,
      'hatshepsuttempletag1': hatshepsuttempletag1,
      'hatshepsuttempletag2': hatshepsuttempletag2,

      'grandegyptianmuseumname': grandegyptianmuseumname,
      'grandegyptianmuseumlocation': grandegyptianmuseumlocation,
      'aboutgrandegyptianmuseum': aboutgrandegyptianmuseum,
      'grandegyptianmuseumtag0': grandegyptianmuseumtag0,
      'grandegyptianmuseumtag1': grandegyptianmuseumtag1,
      'grandegyptianmuseumtag2': grandegyptianmuseumtag2,

      'abusimblename': abusimblename,
      'abusimbellocation': abusimbellocation,
      'aboutabusimbel': aboutabusimbel,
      'abusimbletag0': abusimbletag0,
      'abusimbletag1': abusimbletag1,
      'abusimbletag2': abusimbletag2,

      'blueholename': blueholename,
      'blueholeofdahab': blueholeofdahab,
      'aboutbluehole': aboutbluehole,
      'blueholetag0': blueholetag0,
      'blueholetag1': blueholetag1,
      'blueholetag2': blueholetag2,

      'abugaloumname': abugaloumname,
      'abugaloum': abugaloum,
      'aboutabugaloum': aboutabugaloum,
      'abugaloumtag0': abugaloumtag0,
      'abugaloumtag1': abugaloumtag1,
      'abugaloumtag2': abugaloumtag2,

      'wadielgemalname': wadielgemalname,
      'wadielgemalreserve': wadielgemalreserve,
      'aboutwadielgemal': aboutwadielgemal,
      'wadielgemaltag0': wadielgemaltag0,
      'wadielgemaltag1': wadielgemaltag1,
      'wadielgemaltag2': wadielgemaltag2,

      'wadielrayanname': wadielrayanname,
      'wadielrayan': wadielrayan,
      'aboutwadielrayan': aboutwadielrayan,
      'wadielrayantag0': wadielrayantag0,
      'wadielrayantag1': wadielrayantag1,
      'wadielrayantag2': wadielrayantag2,

      'whitedesertname': whitedesertname,
      'whitedesertnationalpark': whitedesertnationalpark,
      'aboutwhitedesert': aboutwhitedesert,
      'whitedeserttag0': whitedeserttag0,
      'whitedeserttag1': whitedeserttag1,
      'whitedeserttag2': whitedeserttag2,

      'arabiataname': arabiataname,
      'nasrcity': nasrcity,
      'aboutarabiata': aboutarabiata,
      'arabiatatag0': arabiatatag0,
      'arabiatatag1': arabiatatag1,
      'arabiatatag2': arabiatatag2,

      'baharyname': baharyname,
      'fifthsettlement': fifthsettlement,
      'aboutbahary': aboutbahary,
      'baharytag0': baharytag0,
      'baharytag1': baharytag1,
      'baharytag2': baharytag2,

      'elmalkyname': elmalkyname,
      'elmoattam': elmoattam,
      'aboutelmalky': aboutelmalky,
      'elmalkytag0': elmalkytag0,
      'elmalkytag1': elmalkytag1,
      'elmalkytag2': elmalkytag2,

      'koueidername': koueidername,
      'heliopolis': heliopolis,
      'aboutkoueider': aboutkoueider,
      'koueidertag0': koueidertag0,
      'koueidertag1': koueidertag1,
      'koueidertag2': koueidertag2,

      'qasrelkababginame': qasrelkababginame,
      'fifthsettlementt': fifthsettlement,
      'aboutqasrelkababgi': aboutqasrelkababgi,
      'qasrelkababgitag0': qasrelkababgitag0,
      'qasrelkababgitag1': qasrelkababgitag1,
      'qasrelkababgitag2': qasrelkababgitag2,

      'alHusseinMosque': alHusseinMosque,
      'husseinSquareCairoEgypt': husseinSquareCairoEgypt,

      'saintCatherineMonastery': saintCatherineMonastery,
      'southSinaiEgypt': southSinaiEgypt,
      'sinaiEgypt': sinaiEgypt,

      'government': government,
      'selectgov': selectgov,

      'cairo': cairo,
      'giza': giza,
      'alexandria': alexandria,
      'dakahlia': dakahlia,
      'redSea': redSea,
      'beheira': beheira,
      'fayoum': fayoum,
      'gharbia': gharbia,
      'ismailia': ismailia,
      'menofia': menofia,
      'minya': minya,
      'qalyubia': qalyubia,
      'newValley': newValley,
      'suez': suez,
      'aswan': aswan,
      'assiut': assiut,
      'beniSuef': beniSuef,
      'portSaid': portSaid,
      'damietta': damietta,
      'sharkia': sharkia,
      'southSinai': southSinai,
      'kafrElSheikh': kafrElSheikh,
      'matrouh': matrouh,
      'luxor': luxor,
      'qena': qena,
      'northSinai': northSinai,
      'sohag': sohag,
      'neweiba': neweiba,

      'mosquehassanname': mosquehassanname,
      'aboutmosquehassan': aboutmosquehassan,
      'salaheldinlocation': salaheldinlocation,
      'mosquehassantag0': mosquehassantag0,
      'mosquehassantag1': mosquehassantag1,
      'mosquehassantag2': mosquehassantag2,

      'saintcatherinemonasteryname': saintcatherinemonasteryname,
      'aboutsaintcatherinemonastery': aboutsaintcatherinemonastery,
      'mountsinailocation': mountsinailocation,
      'southsinai': southsinai,
      'saintcatherinemonasterytag0': saintcatherinemonasterytag0,
      'saintcatherinemonasterytag1': saintcatherinemonasterytag1,
      'saintcatherinemonasterytag2': saintcatherinemonasterytag2,

      'mosqueofalhakimbiamrallahname': mosqueofalhakimbiamrallahname,
      'aboutmosqueofalhakimbiamrallah': aboutmosqueofalhakimbiamrallah,
      'almuizzstreetlocation': almuizzstreetlocation,
      'mosqueofalhakimbiamrallahtag0': mosqueofalhakimbiamrallahtag0,
      'mosqueofalhakimbiamrallahtag1': mosqueofalhakimbiamrallahtag1,
      'mosqueofalhakimbiamrallahtag2': mosqueofalhakimbiamrallahtag2,

      'alhusseinmosquename': alhusseinmosquename,
      'aboutalhusseinmosque': aboutalhusseinmosque,
      'khanelkhalililocation': khanelkhalililocation,
      'alhusseinmosquetag0': alhusseinmosquetag0,
      'alhusseinmosquetag1': alhusseinmosquetag1,
      'alhusseinmosquetag2': alhusseinmosquetag2,

      'alrifaimosquename': alrifaimosquename,
      'aboutalrifaimosque': aboutalrifaimosque,
      'salaheldinlocationn': salaheldinlocation,
      'alrifaimosquetag0': alrifaimosquetag0,
      'alrifaimosquetag1': alrifaimosquetag1,
      'alrifaimosquetag2': alrifaimosquetag2,
    };

    return map[key] ?? key;
  }
}
