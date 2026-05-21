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

  /// No description provided for @egypttourismguide.
  ///
  /// In en, this message translates to:
  /// **'Egypt Tourism Guide'**
  String get egypttourismguide;

  /// Sentence: Header for the sign-in form.
  ///
  /// In en, this message translates to:
  /// **'Sign in to your journal'**
  String get signInToYourJournal;

  /// Sentence: user logged in with wrong email/password
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get invalidcreds;

  /// Sentence: Greeting message.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, \nExplorer'**
  String get welcomeBackExplorer;

  /// Noun/Word: Used as a label for the email input field.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// Sentence: Placeholder hint inside the email input field.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get emailHint;

  /// No description provided for @invalidEmailFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get invalidEmailFormat;

  /// Noun/Word: Used as a label for the password input field.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @currentpassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentpassword;

  /// No description provided for @newpassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newpassword;

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
  /// **'Tell us about \nyourself'**
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

  /// No description provided for @exploreThe.
  ///
  /// In en, this message translates to:
  /// **'Explore the'**
  String get exploreThe;

  /// No description provided for @collections.
  ///
  /// In en, this message translates to:
  /// **'Collections'**
  String get collections;

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

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Label for number of saved places (Word)
  ///
  /// In en, this message translates to:
  /// **'Saved'**
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

  /// nature category
  ///
  /// In en, this message translates to:
  /// **'Nature'**
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

  /// Governorate name
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

  /// Governorate name
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

  /// food category
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

  /// Action Phrase: error uploading user
  ///
  /// In en, this message translates to:
  /// **'Failed to store user data. Please try again.'**
  String get failtostoreuser;

  /// App bar title for the language selection screen (Word)
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageTitle;

  /// Overline text above the main title on the language screen (Phrase)
  ///
  /// In en, this message translates to:
  /// **'PREFERENCE SELECTION'**
  String get preferenceSelection;

  /// Main title on the language selection screen (Sentence/Command)
  ///
  /// In en, this message translates to:
  /// **'Curate Your Experience'**
  String get curateYourExperience;

  /// No description provided for @countryEgypt.
  ///
  /// In en, this message translates to:
  /// **'Egypt'**
  String get countryEgypt;

  /// No description provided for @countryUk.
  ///
  /// In en, this message translates to:
  /// **'UK'**
  String get countryUk;

  /// No description provided for @countrySpain.
  ///
  /// In en, this message translates to:
  /// **'Spain'**
  String get countrySpain;

  /// No description provided for @countryItaly.
  ///
  /// In en, this message translates to:
  /// **'Italy'**
  String get countryItaly;

  /// No description provided for @countryGermany.
  ///
  /// In en, this message translates to:
  /// **'Germany'**
  String get countryGermany;

  /// App bar title for the edit profile screen (Phrase)
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfileTitle;

  /// Action text under the avatar to change the profile photo (Phrase)
  ///
  /// In en, this message translates to:
  /// **'CHANGE PHOTO'**
  String get changePhoto;

  /// Label for the full name input field (Phrase)
  ///
  /// In en, this message translates to:
  /// **'FULL NAME'**
  String get fullNameLabel;

  /// Label for the user role/title input field (Word)
  ///
  /// In en, this message translates to:
  /// **'TITLE'**
  String get titleLabel;

  /// Section header for managing saved locations (Phrase)
  ///
  /// In en, this message translates to:
  /// **'Manage Saved Places'**
  String get manageSavedPlaces;

  /// Action button to enter edit mode for saved places list (Phrase)
  ///
  /// In en, this message translates to:
  /// **'EDIT SAVED'**
  String get editSaved;

  /// Primary button to submit and save profile edits (Phrase)
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @firstNameHint.
  ///
  /// In en, this message translates to:
  /// **'Edit your first name'**
  String get firstNameHint;

  /// No description provided for @lastNameHint.
  ///
  /// In en, this message translates to:
  /// **'Edit your last name'**
  String get lastNameHint;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Edit your password'**
  String get passwordHint;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'OR CONTINUE WITH'**
  String get orContinueWith;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get enterPassword;

  /// No description provided for @password8charserror.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get password8charserror;

  /// No description provided for @passwordcapitalerror.
  ///
  /// In en, this message translates to:
  /// **'Add at least one capital letter'**
  String get passwordcapitalerror;

  /// No description provided for @passwordsmallerror.
  ///
  /// In en, this message translates to:
  /// **'Add at least one small letter'**
  String get passwordsmallerror;

  /// No description provided for @passwordnumbererror.
  ///
  /// In en, this message translates to:
  /// **'Add at least one number'**
  String get passwordnumbererror;

  /// No description provided for @passwordspecialcharerror.
  ///
  /// In en, this message translates to:
  /// **'Add at least one special character'**
  String get passwordspecialcharerror;

  /// No description provided for @nodatafound.
  ///
  /// In en, this message translates to:
  /// **'No data found'**
  String get nodatafound;

  /// quote of heritage
  ///
  /// In en, this message translates to:
  /// **'\"To know the heart of a culture, one must walk through the echoes of its stone\"'**
  String get heritagequote;

  /// quote of spiritual
  ///
  /// In en, this message translates to:
  /// **'\"Where faith and silence meet, the spirit begins to heal.\"'**
  String get spiritualquote;

  /// quote of nature
  ///
  /// In en, this message translates to:
  /// **'\"To understand the earth, one must listen to the stories written in its rivers, skies, and silence.\"'**
  String get naturequote;

  /// quote of food
  ///
  /// In en, this message translates to:
  /// **'\"Every dish tells a story, seasoned with culture, history, and the warmth of its people.\"'**
  String get foodquote;

  /// name of pyramids
  ///
  /// In en, this message translates to:
  /// **'Pyramids'**
  String get pyramidsname;

  /// about description of pyramids
  ///
  /// In en, this message translates to:
  /// **'The world-famous pyramids of ancient Egypt, built as royal tombs and considered one of the Seven Wonders of the Ancient World.'**
  String get aboutpyramids;

  /// location of pyramids
  ///
  /// In en, this message translates to:
  /// **'Al Haram'**
  String get alharam;

  /// first tag of pyramids
  ///
  /// In en, this message translates to:
  /// **'PYRAMIDS'**
  String get pyramidstag0;

  /// second tag of pyramids
  ///
  /// In en, this message translates to:
  /// **'WONDER'**
  String get pyramidstag1;

  /// third tag of pyramids
  ///
  /// In en, this message translates to:
  /// **'LANDMARK'**
  String get pyramidstag2;

  /// No description provided for @abusimblename.
  ///
  /// In en, this message translates to:
  /// **'Abu Simbel Temple'**
  String get abusimblename;

  /// No description provided for @abusimbellocation.
  ///
  /// In en, this message translates to:
  /// **'Abu Simbel'**
  String get abusimbellocation;

  /// No description provided for @aboutabusimbel.
  ///
  /// In en, this message translates to:
  /// **'Massive rock-cut temples built by Ramses II, famous for their giant statues and remarkable relocation to protect them from flooding.'**
  String get aboutabusimbel;

  /// No description provided for @abusimbletag0.
  ///
  /// In en, this message translates to:
  /// **'HISTORICAL'**
  String get abusimbletag0;

  /// No description provided for @abusimbletag1.
  ///
  /// In en, this message translates to:
  /// **'MONUMENT'**
  String get abusimbletag1;

  /// No description provided for @abusimbletag2.
  ///
  /// In en, this message translates to:
  /// **'UNESCO'**
  String get abusimbletag2;

  /// No description provided for @hatshepsuttemplename.
  ///
  /// In en, this message translates to:
  /// **'Temple of Hatshepsut'**
  String get hatshepsuttemplename;

  /// No description provided for @hatshepsuttemplelocation.
  ///
  /// In en, this message translates to:
  /// **'Deir el-Bahari'**
  String get hatshepsuttemplelocation;

  /// Governorate name
  ///
  /// In en, this message translates to:
  /// **'Luxor'**
  String get luxor;

  /// No description provided for @aboutatshepsuttemple.
  ///
  /// In en, this message translates to:
  /// **'A magnificent temple carved into the cliffs of Luxor, built for Queen Hatshepsut, one of ancient Egypt’s most powerful rulers.'**
  String get aboutatshepsuttemple;

  /// No description provided for @hatshepsuttempletag0.
  ///
  /// In en, this message translates to:
  /// **'TEMPLE'**
  String get hatshepsuttempletag0;

  /// No description provided for @hatshepsuttempletag1.
  ///
  /// In en, this message translates to:
  /// **'ARCHITECTURE'**
  String get hatshepsuttempletag1;

  /// No description provided for @hatshepsuttempletag2.
  ///
  /// In en, this message translates to:
  /// **'HISTORICAL'**
  String get hatshepsuttempletag2;

  /// No description provided for @grandegyptianmuseumname.
  ///
  /// In en, this message translates to:
  /// **'The Grand Egyptian Museum'**
  String get grandegyptianmuseumname;

  /// No description provided for @grandegyptianmuseumlocation.
  ///
  /// In en, this message translates to:
  /// **'Cairo-Alex Road'**
  String get grandegyptianmuseumlocation;

  /// No description provided for @giza.
  ///
  /// In en, this message translates to:
  /// **'Giza'**
  String get giza;

  /// No description provided for @aboutgrandegyptianmuseum.
  ///
  /// In en, this message translates to:
  /// **'A modern museum near the pyramids showcasing thousands of ancient Egyptian artifacts, including King Tutankhamun’s treasures.'**
  String get aboutgrandegyptianmuseum;

  /// No description provided for @grandegyptianmuseumtag0.
  ///
  /// In en, this message translates to:
  /// **'ARTIFACTS'**
  String get grandegyptianmuseumtag0;

  /// No description provided for @grandegyptianmuseumtag1.
  ///
  /// In en, this message translates to:
  /// **'MUSEUM'**
  String get grandegyptianmuseumtag1;

  /// No description provided for @grandegyptianmuseumtag2.
  ///
  /// In en, this message translates to:
  /// **'CULTURE'**
  String get grandegyptianmuseumtag2;

  /// No description provided for @philaetemplename.
  ///
  /// In en, this message translates to:
  /// **'Philae Temple'**
  String get philaetemplename;

  /// No description provided for @philaetemplelocation.
  ///
  /// In en, this message translates to:
  /// **'Agilkia Island'**
  String get philaetemplelocation;

  /// No description provided for @aboutphilaetemple.
  ///
  /// In en, this message translates to:
  /// **'A beautiful island temple dedicated to the goddess Isis, known for its stunning Nile views and ancient carvings.'**
  String get aboutphilaetemple;

  /// No description provided for @philaetempletag0.
  ///
  /// In en, this message translates to:
  /// **'ISLAND'**
  String get philaetempletag0;

  /// No description provided for @philaetempletag1.
  ///
  /// In en, this message translates to:
  /// **'TEMPLE'**
  String get philaetempletag1;

  /// No description provided for @philaetempletag2.
  ///
  /// In en, this message translates to:
  /// **'HERITAGE'**
  String get philaetempletag2;

  /// white desert name
  ///
  /// In en, this message translates to:
  /// **'White Desert'**
  String get whitedesertname;

  /// white desert location
  ///
  /// In en, this message translates to:
  /// **'White Desert National Park'**
  String get whitedesertnationalpark;

  /// city of white desert
  ///
  /// In en, this message translates to:
  /// **'South West of Cairo'**
  String get southwestofcairo;

  /// Information about white desert
  ///
  /// In en, this message translates to:
  /// **'A breathtaking desert reserve famous for its unique white rock formations and camping experiences.'**
  String get aboutwhitedesert;

  /// first tag of the white desert
  ///
  /// In en, this message translates to:
  /// **'DESERT'**
  String get whitedeserttag0;

  /// second tag of the white desert
  ///
  /// In en, this message translates to:
  /// **'CAMPING'**
  String get whitedeserttag1;

  /// third tag of the white desert
  ///
  /// In en, this message translates to:
  /// **'SAFARI'**
  String get whitedeserttag2;

  /// Blue Hole name
  ///
  /// In en, this message translates to:
  /// **'Blue Hole'**
  String get blueholename;

  /// Blue Hole location
  ///
  /// In en, this message translates to:
  /// **'Blue Hole of Dahab'**
  String get blueholeofdahab;

  /// city of Blue Hole
  ///
  /// In en, this message translates to:
  /// **'Dahab'**
  String get dahab;

  /// Information about Blue Hole
  ///
  /// In en, this message translates to:
  /// **'A world-famous diving destination known for crystal-clear waters and vibrant coral reefs.'**
  String get aboutbluehole;

  /// first tag of theBlue Hole
  ///
  /// In en, this message translates to:
  /// **'DIVING'**
  String get blueholetag0;

  /// second tag of the Blue Hole
  ///
  /// In en, this message translates to:
  /// **'CORAL'**
  String get blueholetag1;

  /// third tag of the Blue Hole
  ///
  /// In en, this message translates to:
  /// **'ADVENTURE'**
  String get blueholetag2;

  /// Abu Galoum name
  ///
  /// In en, this message translates to:
  /// **'Abu Galoum'**
  String get abugaloumname;

  /// Abu Galoum location
  ///
  /// In en, this message translates to:
  /// **'Abu Galoum'**
  String get abugaloum;

  /// city of Abu Galoum
  ///
  /// In en, this message translates to:
  /// **'Neweiba'**
  String get neweiba;

  /// Information about Abu Galoum
  ///
  /// In en, this message translates to:
  /// **'A protected coastal reserve famous for snorkeling, coral reefs, mountains, and Bedouin camps.'**
  String get aboutabugaloum;

  /// first tag of Abu Galoum
  ///
  /// In en, this message translates to:
  /// **'SNORKELING'**
  String get abugaloumtag0;

  /// second tag of Abu Galoum
  ///
  /// In en, this message translates to:
  /// **'NATURE'**
  String get abugaloumtag1;

  /// third tag of Abu Galoum
  ///
  /// In en, this message translates to:
  /// **'CAMPING'**
  String get abugaloumtag2;

  /// Wadi El Gemal name
  ///
  /// In en, this message translates to:
  /// **'Wadi El Gemal'**
  String get wadielgemalname;

  /// Wadi El Gemal location
  ///
  /// In en, this message translates to:
  /// **'Wadi El Gemal Reserve'**
  String get wadielgemalreserve;

  /// city of Wadi El Gemal
  ///
  /// In en, this message translates to:
  /// **'Marsa Alam'**
  String get marsaalam;

  /// Information about Wadi El Gemal
  ///
  /// In en, this message translates to:
  /// **'A stunning natural reserve combining desert mountains, mangroves, coral reefs, and Red Sea wildlife.'**
  String get aboutwadielgemal;

  /// first tag of Wadi El Gemal
  ///
  /// In en, this message translates to:
  /// **'MARINE'**
  String get wadielgemaltag0;

  /// second tag of Wadi El Gemal
  ///
  /// In en, this message translates to:
  /// **'SAFARI'**
  String get wadielgemaltag1;

  /// third tag of Wadi El Gemal
  ///
  /// In en, this message translates to:
  /// **'WILDLIFE'**
  String get wadielgemaltag2;

  /// Wadi el rayan name
  ///
  /// In en, this message translates to:
  /// **'Wadi el rayan'**
  String get wadielrayanname;

  /// Wadi el rayan location
  ///
  /// In en, this message translates to:
  /// **'Wadi el rayan'**
  String get wadielrayan;

  /// city of Wadi el rayan
  ///
  /// In en, this message translates to:
  /// **'Faiyum'**
  String get faiyum;

  /// Information about Wadi el rayan
  ///
  /// In en, this message translates to:
  /// **'A beautiful desert oasis known for waterfalls, lakes, sand dunes, and safari adventures.'**
  String get aboutwadielrayan;

  /// first tag of Wadi el rayan
  ///
  /// In en, this message translates to:
  /// **'WATERFALLS'**
  String get wadielrayantag0;

  /// second tag of Wadi el rayan
  ///
  /// In en, this message translates to:
  /// **'DESERT'**
  String get wadielrayantag1;

  /// third tag of Wadi el rayan
  ///
  /// In en, this message translates to:
  /// **'LAKES'**
  String get wadielrayantag2;

  /// name of arabiata
  ///
  /// In en, this message translates to:
  /// **'Arabiata'**
  String get arabiataname;

  /// about description of arabiata
  ///
  /// In en, this message translates to:
  /// **'A popular Egyptian restaurant serving authentic foul, falafel, and traditional breakfast meals.'**
  String get aboutarabiata;

  /// location of arabiata
  ///
  /// In en, this message translates to:
  /// **'Nasr City'**
  String get nasrcity;

  /// first tag of arabiata
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get arabiatatag0;

  /// second tag of arabiata
  ///
  /// In en, this message translates to:
  /// **'StreetFood'**
  String get arabiatatag1;

  /// third tag of arabiata
  ///
  /// In en, this message translates to:
  /// **'Oriental'**
  String get arabiatatag2;

  /// name of qasr-elkababgi
  ///
  /// In en, this message translates to:
  /// **'Qasr Elkababgi'**
  String get qasrelkababginame;

  /// about description of qasr-elkababgi
  ///
  /// In en, this message translates to:
  /// **'A renowned Egyptian restaurant chain celebrated for authentic oriental cuisine, traditional grills, and theatrical dining experiences'**
  String get aboutqasrelkababgi;

  /// location of qasr-elkababgi
  ///
  /// In en, this message translates to:
  /// **'Fifth Settlement'**
  String get fifthsettlement;

  /// first tag of qasr-elkababgi
  ///
  /// In en, this message translates to:
  /// **'Grills'**
  String get qasrelkababgitag0;

  /// second tag of qasr-elkababgi
  ///
  /// In en, this message translates to:
  /// **'Dining'**
  String get qasrelkababgitag1;

  /// third tag of qasr-elkababgi
  ///
  /// In en, this message translates to:
  /// **'Oriental'**
  String get qasrelkababgitag2;

  /// name of bahary
  ///
  /// In en, this message translates to:
  /// **'Bahary'**
  String get baharyname;

  /// about description of bahary
  ///
  /// In en, this message translates to:
  /// **'A modern seafood restaurant famous for grilled fish, seafood platters, and fresh Mediterranean flavors.'**
  String get aboutbahary;

  /// first tag of bahary
  ///
  /// In en, this message translates to:
  /// **'SeaFood'**
  String get baharytag0;

  /// second tag of bahary
  ///
  /// In en, this message translates to:
  /// **'Fresh'**
  String get baharytag1;

  /// third tag of bahary
  ///
  /// In en, this message translates to:
  /// **'OceanFlavors'**
  String get baharytag2;

  /// name of koueider
  ///
  /// In en, this message translates to:
  /// **'Koueider'**
  String get koueidername;

  /// about description of koueider
  ///
  /// In en, this message translates to:
  /// **'One of Egypt’s oldest dessert shops, famous for oriental sweets and authentic Arabic pastries.'**
  String get aboutkoueider;

  /// location of koueider
  ///
  /// In en, this message translates to:
  /// **'Heliopolis'**
  String get heliopolis;

  /// first tag of koueider
  ///
  /// In en, this message translates to:
  /// **'Desserts'**
  String get koueidertag0;

  /// second tag of koueider
  ///
  /// In en, this message translates to:
  /// **'Ice Cream'**
  String get koueidertag1;

  /// third tag of koueider
  ///
  /// In en, this message translates to:
  /// **'Sweets'**
  String get koueidertag2;

  /// name of elmalky
  ///
  /// In en, this message translates to:
  /// **'ElMalky'**
  String get elmalkyname;

  /// about description of elmalky
  ///
  /// In en, this message translates to:
  /// **'A legendary Egyptian dessert destination known for rice pudding, ice cream, and classic sweets.'**
  String get aboutelmalky;

  /// name of mosquesultanhassan
  ///
  /// In en, this message translates to:
  /// **'Mosque-Madrassa Sultan Hassan'**
  String get mosquehassanname;

  /// about description of mosquesultanhassan
  ///
  /// In en, this message translates to:
  /// **'A magnificent Mamluk mosque famous for its grand Islamic architecture and historic spiritual atmosphere.'**
  String get aboutmosquehassan;

  /// location of mosquesultanhassan
  ///
  /// In en, this message translates to:
  /// **'Salah El-Din Square, Islamic Cairo'**
  String get salaheldinlocation;

  /// first tag of mosquesultanhassan
  ///
  /// In en, this message translates to:
  /// **'Islamic'**
  String get mosquehassantag0;

  /// second tag of mosquesultanhassan
  ///
  /// In en, this message translates to:
  /// **'Mamluk'**
  String get mosquehassantag1;

  /// third tag of mosquesultanhassan
  ///
  /// In en, this message translates to:
  /// **'Architecture'**
  String get mosquehassantag2;

  /// name of saintcatherinemonasteryname
  ///
  /// In en, this message translates to:
  /// **'Saint Catherine\'s Monastery'**
  String get saintcatherinemonasteryname;

  /// about description of saintcatherinemonasteryname
  ///
  /// In en, this message translates to:
  /// **'One of the oldest Christian monasteries in the world, located at the foot of Mount Sinai.'**
  String get aboutsaintcatherinemonastery;

  /// location of saintcatherinemonasteryname
  ///
  /// In en, this message translates to:
  /// **'Mount Sinai, Saint Catherine'**
  String get mountsinailocation;

  /// city of saintcatherinemonasteryname
  ///
  /// In en, this message translates to:
  /// **'South Sinai'**
  String get southsinai;

  /// first tag of saintcatherinemonasteryname
  ///
  /// In en, this message translates to:
  /// **'Christian'**
  String get saintcatherinemonasterytag0;

  /// second tag of saintcatherinemonasteryname
  ///
  /// In en, this message translates to:
  /// **'Monastery'**
  String get saintcatherinemonasterytag1;

  /// third tag of saintcatherinemonasteryname
  ///
  /// In en, this message translates to:
  /// **'Pilgrimage'**
  String get saintcatherinemonasterytag2;

  /// name of mosqueofalhakimbiamrallah
  ///
  /// In en, this message translates to:
  /// **'Mosque of al-Hakim bi-Amr Allah'**
  String get mosqueofalhakimbiamrallahname;

  /// about description  of mosqueofalhakimbiamrallah
  ///
  /// In en, this message translates to:
  /// **'A historic Fatimid mosque known for its impressive architecture and spiritual importance in Islamic Cairo.'**
  String get aboutmosqueofalhakimbiamrallah;

  /// location of mosqueofalhakimbiamrallah
  ///
  /// In en, this message translates to:
  /// **'Al-Muizz Street, Cairo'**
  String get almuizzstreetlocation;

  /// first tag of mosqueofalhakimbiamrallah
  ///
  /// In en, this message translates to:
  /// **'Fatimid'**
  String get mosqueofalhakimbiamrallahtag0;

  /// second tag of mosqueofalhakimbiamrallah
  ///
  /// In en, this message translates to:
  /// **'Mosque'**
  String get mosqueofalhakimbiamrallahtag1;

  /// third tag of mosqueofalhakimbiamrallah
  ///
  /// In en, this message translates to:
  /// **'Heritage'**
  String get mosqueofalhakimbiamrallahtag2;

  /// name of alhusseinmosque
  ///
  /// In en, this message translates to:
  /// **'Al-Hussein Mosque'**
  String get alhusseinmosquename;

  /// about description of alhusseinmosque
  ///
  /// In en, this message translates to:
  /// **'One of Egypt’s most sacred mosques, located in the heart of historic Islamic Cairo near Khan El Khalili.'**
  String get aboutalhusseinmosque;

  /// location of alhusseinmosque
  ///
  /// In en, this message translates to:
  /// **'Khan El Khalili, Islamic Cairo'**
  String get khanelkhalililocation;

  /// first tag of alhusseinmosque
  ///
  /// In en, this message translates to:
  /// **'Islamic'**
  String get alhusseinmosquetag0;

  /// second tag of alhusseinmosque
  ///
  /// In en, this message translates to:
  /// **'Heritage'**
  String get alhusseinmosquetag1;

  /// third tag of alhusseinmosque
  ///
  /// In en, this message translates to:
  /// **'Landmark'**
  String get alhusseinmosquetag2;

  /// name of alhusseinmosque
  ///
  /// In en, this message translates to:
  /// **'Al-Rifa\'i Mosque'**
  String get alrifaimosquename;

  /// about description of alhusseinmosque
  ///
  /// In en, this message translates to:
  /// **'A royal mosque famous for its Ottoman-inspired architecture and the tombs of Egyptian royals.'**
  String get aboutalrifaimosque;

  /// first of alhusseinmosque
  ///
  /// In en, this message translates to:
  /// **'Ottoman'**
  String get alrifaimosquetag0;

  /// second tag of alhusseinmosque
  ///
  /// In en, this message translates to:
  /// **'Mosque'**
  String get alrifaimosquetag1;

  /// thrid tag of alhusseinmosque
  ///
  /// In en, this message translates to:
  /// **'Architecture'**
  String get alrifaimosquetag2;

  /// location of elmalky
  ///
  /// In en, this message translates to:
  /// **'ElMoattam'**
  String get elmoattam;

  /// first tag of elmalky
  ///
  /// In en, this message translates to:
  /// **'Traditional'**
  String get elmalkytag0;

  /// second tag of elmalky
  ///
  /// In en, this message translates to:
  /// **'Ice Cream'**
  String get elmalkytag1;

  /// third tag of elmalky
  ///
  /// In en, this message translates to:
  /// **'Desserts'**
  String get elmalkytag2;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @manageProfile.
  ///
  /// In en, this message translates to:
  /// **'Manage Profile'**
  String get manageProfile;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutConfirmTitle;

  /// No description provided for @logoutConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirmMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @choosecategory.
  ///
  /// In en, this message translates to:
  /// **'Choose a category'**
  String get choosecategory;

  /// No description provided for @changecategory.
  ///
  /// In en, this message translates to:
  /// **'Change category'**
  String get changecategory;

  /// Ticket price label for Egyptian visitors
  ///
  /// In en, this message translates to:
  /// **'Egyptian'**
  String get egyptian;

  /// Ticket price label for non-Egyptian visitors
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// State indicating the place is not currently operating
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// No description provided for @government.
  ///
  /// In en, this message translates to:
  /// **'GOVERNORATE'**
  String get government;

  /// No description provided for @selectlang.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectlang;

  /// No description provided for @selectgov.
  ///
  /// In en, this message translates to:
  /// **'Select Governorate'**
  String get selectgov;

  /// Governorate name
  ///
  /// In en, this message translates to:
  /// **'Alexandria'**
  String get alexandria;

  /// Governorate name
  ///
  /// In en, this message translates to:
  /// **'Dakahlia'**
  String get dakahlia;

  /// Governorate name
  ///
  /// In en, this message translates to:
  /// **'Beheira'**
  String get beheira;

  /// Governorate name
  ///
  /// In en, this message translates to:
  /// **'Fayoum'**
  String get fayoum;

  /// Governorate name
  ///
  /// In en, this message translates to:
  /// **'Gharbia'**
  String get gharbia;

  /// Governorate name
  ///
  /// In en, this message translates to:
  /// **'Ismailia'**
  String get ismailia;

  /// Governorate name
  ///
  /// In en, this message translates to:
  /// **'Menofia'**
  String get menofia;

  /// Governorate name
  ///
  /// In en, this message translates to:
  /// **'Minya'**
  String get minya;

  /// Governorate name
  ///
  /// In en, this message translates to:
  /// **'Qalyubia'**
  String get qalyubia;

  /// Governorate name
  ///
  /// In en, this message translates to:
  /// **'New Valley'**
  String get newValley;

  /// Governorate name
  ///
  /// In en, this message translates to:
  /// **'Suez'**
  String get suez;

  /// Governorate name
  ///
  /// In en, this message translates to:
  /// **'Assiut'**
  String get assiut;

  /// Governorate name
  ///
  /// In en, this message translates to:
  /// **'Beni Suef'**
  String get beniSuef;

  /// Governorate name
  ///
  /// In en, this message translates to:
  /// **'Port Said'**
  String get portSaid;

  /// Governorate name
  ///
  /// In en, this message translates to:
  /// **'Damietta'**
  String get damietta;

  /// Governorate name
  ///
  /// In en, this message translates to:
  /// **'Sharkia'**
  String get sharkia;

  /// Governorate name
  ///
  /// In en, this message translates to:
  /// **'South Sinai'**
  String get southSinai;

  /// Governorate name
  ///
  /// In en, this message translates to:
  /// **'Kafr El Sheikh'**
  String get kafrElSheikh;

  /// Governorate name
  ///
  /// In en, this message translates to:
  /// **'Matrouh'**
  String get matrouh;

  /// Governorate name
  ///
  /// In en, this message translates to:
  /// **'Qena'**
  String get qena;

  /// Governorate name
  ///
  /// In en, this message translates to:
  /// **'North Sinai'**
  String get northSinai;

  /// Governorate name
  ///
  /// In en, this message translates to:
  /// **'Sohag'**
  String get sohag;

  /// No description provided for @goodmorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get goodmorning;

  /// No description provided for @discover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get discover;

  /// No description provided for @hidden.
  ///
  /// In en, this message translates to:
  /// **'hidden'**
  String get hidden;

  /// No description provided for @treasures.
  ///
  /// In en, this message translates to:
  /// **'treasures'**
  String get treasures;

  /// No description provided for @errorgetingdata.
  ///
  /// In en, this message translates to:
  /// **'Error fetching data'**
  String get errorgetingdata;

  /// No description provided for @featuredplaces.
  ///
  /// In en, this message translates to:
  /// **'Featured places'**
  String get featuredplaces;

  /// No description provided for @handpickedplaces.
  ///
  /// In en, this message translates to:
  /// **'Hand-picked curation for your \njourney based on your city'**
  String get handpickedplaces;
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
