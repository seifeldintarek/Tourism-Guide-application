import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
  ];

  /// Sentence: Header for the sign-in form.
  ///
  /// In en, this message translates to:
  /// **'Sign in to your journal'**
  String get signInToYourJournal;

  /// Sentence: Greeting message.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, Explorer'**
  String get welcomeBackExplorer;

  /// Noun/Word: Used as a label for the email input field.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// Sentence: Placeholder hint inside the email input field.
  ///
  /// In en, this message translates to:
  /// **'e.g., journal@archive.com'**
  String get emailHint;

  /// Noun/Word: Used as a label for the password input field.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Action Phrase: Button text to submit the sign-in form.
  ///
  /// In en, this message translates to:
  /// **'Continue Journey'**
  String get continueJourney;

  /// Sentence/Question: Link for password recovery.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// Word: Divider text.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// Action Phrase: Button text for Google OAuth.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signInWithGoogle;

  /// Sentence/Question: Prompt asking if the user needs to register.
  ///
  /// In en, this message translates to:
  /// **'New here?'**
  String get newHere;

  /// Action Phrase: Register to db.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// Action Phrase: Link to navigate to the registration page.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get createAnAccount;

  /// Sentence: Header for the sign-up form.
  ///
  /// In en, this message translates to:
  /// **'Tell us about yourself'**
  String get tellUsAboutYourself;

  /// Noun Phrase: Label for the first name input field.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// Noun Phrase: Label for the last name input field.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// Action Phrase: Label for the new password input field.
  ///
  /// In en, this message translates to:
  /// **'Create Password'**
  String get createPassword;

  /// Action Phrase: Label for the confirm password input field.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// Noun/Word: Label for the language dropdown.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Noun/Word: Label for the currency dropdown.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// Sentence fragment: The beginning of the checkbox agreement text. Left a trailing space for RichText merging.
  ///
  /// In en, this message translates to:
  /// **'By creating an account, I agree to '**
  String get agreeToTermsPrefix;

  /// Noun Phrase: Clickable Terms of Service link.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// Word: Conjunction in the agreement text. Includes padding spaces.
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get and;

  /// Noun Phrase: Clickable Privacy Policy link.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Sentence/Question: Prompt asking if the user already has an account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyAMember;

  /// Action Phrase: Link to navigate back to the login page.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// Small overline text above the main title
  ///
  /// In en, this message translates to:
  /// **'CURATED JOURNEYS'**
  String get curatedJourneys;

  /// Main title on the home screen (Sentence)
  ///
  /// In en, this message translates to:
  /// **'Explore the Collections'**
  String get exploreTheCollections;

  /// Placeholder text in the search bar (Sentence)
  ///
  /// In en, this message translates to:
  /// **'Search a destination...'**
  String get searchDestination;

  /// Section title for recently viewed items (Phrase)
  ///
  /// In en, this message translates to:
  /// **'Recently viewed'**
  String get recentlyViewed;

  /// App bar title and section title (Phrase)
  ///
  /// In en, this message translates to:
  /// **'Saved places'**
  String get savedPlaces;

  /// User title or subtitle (Word)
  ///
  /// In en, this message translates to:
  /// **'Explorer'**
  String get explorer;

  /// Label for number of visited places (Word)
  ///
  /// In en, this message translates to:
  /// **'VISITED'**
  String get visited;

  /// Label for number of saved places (Word)
  ///
  /// In en, this message translates to:
  /// **'SAVED'**
  String get saved;

  /// Label for number of reviews (Word)
  ///
  /// In en, this message translates to:
  /// **'REVIEWS'**
  String get reviews;

  /// Button text to see all items in a list (Phrase)
  ///
  /// In en, this message translates to:
  /// **'VIEW ALL'**
  String get viewAll;

  /// Category tag for a place (Phrase)
  ///
  /// In en, this message translates to:
  /// **'HISTORIC SITE'**
  String get historicSite;

  /// Category tag for a museum (Phrase)
  ///
  /// In en, this message translates to:
  /// **'HISTORIC MUSEUM'**
  String get historicMuseum;

  /// Category tag for natural places (Word)
  ///
  /// In en, this message translates to:
  /// **'NATURE'**
  String get nature;

  /// No description provided for @wadiElRayan.
  ///
  /// In en, this message translates to:
  /// **'Wadi El Rayan'**
  String get wadiElRayan;

  /// No description provided for @elFayoumEgypt.
  ///
  /// In en, this message translates to:
  /// **'El Fayoum, Egypt'**
  String get elFayoumEgypt;

  /// No description provided for @saltLake.
  ///
  /// In en, this message translates to:
  /// **'Salt lake'**
  String get saltLake;

  /// No description provided for @siwaOasisEgypt.
  ///
  /// In en, this message translates to:
  /// **'Siwa Oasis, Egypt'**
  String get siwaOasisEgypt;

  /// No description provided for @abuSimbelTemple.
  ///
  /// In en, this message translates to:
  /// **'Abu Simbel Temple'**
  String get abuSimbelTemple;

  /// No description provided for @aswanEgypt.
  ///
  /// In en, this message translates to:
  /// **'Aswan, Egypt'**
  String get aswanEgypt;

  /// No description provided for @redSea.
  ///
  /// In en, this message translates to:
  /// **'Red Sea'**
  String get redSea;

  /// No description provided for @hurghadaEgypt.
  ///
  /// In en, this message translates to:
  /// **'Hurghada, Egypt'**
  String get hurghadaEgypt;

  /// No description provided for @pyramids.
  ///
  /// In en, this message translates to:
  /// **'Pyramids'**
  String get pyramids;

  /// No description provided for @gizaEgypt.
  ///
  /// In en, this message translates to:
  /// **'Giza, Egypt'**
  String get gizaEgypt;

  /// No description provided for @theGrandEgyptianMuseum.
  ///
  /// In en, this message translates to:
  /// **'The Grand Egyptian Museum'**
  String get theGrandEgyptianMuseum;

  /// No description provided for @kebdetElPrince.
  ///
  /// In en, this message translates to:
  /// **'Kebdet El-Prince'**
  String get kebdetElPrince;

  /// No description provided for @sheikhZayedGizaEgypt.
  ///
  /// In en, this message translates to:
  /// **'Shekh Zayed, Giza, Egypt'**
  String get sheikhZayedGizaEgypt;

  /// No description provided for @cairo.
  ///
  /// In en, this message translates to:
  /// **'Cairo'**
  String get cairo;

  /// No description provided for @philaeTemple.
  ///
  /// In en, this message translates to:
  /// **'Philae Temple'**
  String get philaeTemple;

  /// No description provided for @aswan.
  ///
  /// In en, this message translates to:
  /// **'Aswan'**
  String get aswan;

  /// Main title of the screen (Phrase)
  ///
  /// In en, this message translates to:
  /// **'Egyptian Museum'**
  String get egyptianMuseum;

  /// No description provided for @siwaOasis.
  ///
  /// In en, this message translates to:
  /// **'Siwa Oasis'**
  String get siwaOasis;

  /// No description provided for @westernDesert.
  ///
  /// In en, this message translates to:
  /// **'Western Desert'**
  String get westernDesert;

  /// Filter/Category tag (Word)
  ///
  /// In en, this message translates to:
  /// **'HISTORICAL'**
  String get historical;

  /// Filter/Category tag (Phrase)
  ///
  /// In en, this message translates to:
  /// **'ARTIFACTS'**
  String get artifacts;

  /// Filter/Category tag (Word)
  ///
  /// In en, this message translates to:
  /// **'LANDMARK'**
  String get landmark;

  /// Section title for the description (Word).
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Label for current operational state (Word)
  ///
  /// In en, this message translates to:
  /// **'STATUS'**
  String get status;

  /// State indicating the place is currently operating (Word)
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// Label for operating hours (Phrase).
  ///
  /// In en, this message translates to:
  /// **'HOURS'**
  String get hours;

  /// Label for base ticket price (Phrase).
  ///
  /// In en, this message translates to:
  /// **'STARTING'**
  String get starting;

  /// Currency abbreviation for Egyptian Pound (Word/Abbreviation).
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get egp;

  /// Section title for the image grid (Word)
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// Label for photo count (Word).
  ///
  /// In en, this message translates to:
  /// **'PHOTOS'**
  String get photos;

  /// Call to action button text (Sentence/Command)
  ///
  /// In en, this message translates to:
  /// **'PLAN MY VISIT'**
  String get planMyVisit;

  /// Category title for historical sites
  ///
  /// In en, this message translates to:
  /// **'Heritage'**
  String get heritage;

  /// Filter button to show all items
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @templeOfHatshepsut.
  ///
  /// In en, this message translates to:
  /// **'Temple of hatshepsut'**
  String get templeOfHatshepsut;

  /// No description provided for @luxorEgypt.
  ///
  /// In en, this message translates to:
  /// **'Luxor, Egypt'**
  String get luxorEgypt;

  /// No description provided for @blueHole.
  ///
  /// In en, this message translates to:
  /// **'Blue Hole'**
  String get blueHole;

  /// No description provided for @dahabEgypt.
  ///
  /// In en, this message translates to:
  /// **'Dahab, Egypt'**
  String get dahabEgypt;

  /// No description provided for @jabalMousa.
  ///
  /// In en, this message translates to:
  /// **'Jabal Mousa'**
  String get jabalMousa;

  /// No description provided for @sinaiEgypt.
  ///
  /// In en, this message translates to:
  /// **'Sinai, Egypt'**
  String get sinaiEgypt;

  /// No description provided for @northCoast.
  ///
  /// In en, this message translates to:
  /// **'North Coast'**
  String get northCoast;

  /// Category title (Word)
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get food;

  /// Category title (Word)
  ///
  /// In en, this message translates to:
  /// **'Spiritual'**
  String get spiritual;

  /// Restaurant name (Phrase)
  ///
  /// In en, this message translates to:
  /// **'Qasr Elkababgi'**
  String get qasrElkababgi;

  /// Location (Phrase)
  ///
  /// In en, this message translates to:
  /// **'New Cairo, Cairo, Egypt'**
  String get newCairoCairoEgypt;

  /// Restaurant name (Phrase)
  ///
  /// In en, this message translates to:
  /// **'Abou Tarek'**
  String get abouTarek;

  /// Location (Phrase)
  ///
  /// In en, this message translates to:
  /// **'Cairo, Egypt'**
  String get cairoEgypt;

  /// Restaurant name (Word)
  ///
  /// In en, this message translates to:
  /// **'Arabiata'**
  String get arabiata;

  /// Location (Phrase)
  ///
  /// In en, this message translates to:
  /// **'El korba, Cairo, Egypt'**
  String get elKorbaCairoEgypt;

  /// Restaurant name (Word)
  ///
  /// In en, this message translates to:
  /// **'Asmak'**
  String get asmak;

  /// Landmark name (Phrase)
  ///
  /// In en, this message translates to:
  /// **'Amr Ibn AL-As Mosque'**
  String get amrIbnAlAsMosque;

  /// Location (Phrase)
  ///
  /// In en, this message translates to:
  /// **'Al-Fustat (Old Cairo), Egypt'**
  String get alFustatOldCairoEgypt;

  /// Landmark name (Phrase)
  ///
  /// In en, this message translates to:
  /// **'Al-Azhar Mosque'**
  String get alAzharMosque;

  /// Location (Phrase)
  ///
  /// In en, this message translates to:
  /// **'Islamic Cairo, Egypt'**
  String get islamicCairoEgypt;

  /// Landmark name (Phrase)
  ///
  /// In en, this message translates to:
  /// **'The Hanging Church'**
  String get theHangingChurch;

  /// Location (Phrase)
  ///
  /// In en, this message translates to:
  /// **'Coptic Cairo, Old Cairo, Egypt'**
  String get copticCairoOldCairoEgypt;

  /// Landmark name (Phrase)
  ///
  /// In en, this message translates to:
  /// **'Al-Hussein Mosque'**
  String get alHusseinMosque;

  /// Location (Phrase)
  ///
  /// In en, this message translates to:
  /// **'Hussein Square, Cairo, Egypt'**
  String get husseinSquareCairoEgypt;

  /// Landmark name (Phrase)
  ///
  /// In en, this message translates to:
  /// **'Saint Catherine Monastery'**
  String get saintCatherineMonastery;

  /// Location (Phrase)
  ///
  /// In en, this message translates to:
  /// **'South Sinai, Egypt'**
  String get southSinaiEgypt;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'de', 'en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
