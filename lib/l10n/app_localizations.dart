import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_kk.dart';
import 'app_localizations_ru.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('kk'),
    Locale('ru')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Medica'**
  String get appName;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @doctors.
  ///
  /// In en, this message translates to:
  /// **'Doctors'**
  String get doctors;

  /// No description provided for @appointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointments;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @past.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get past;

  /// No description provided for @upcomingAppointments.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Appointments'**
  String get upcomingAppointments;

  /// No description provided for @pastAppointments.
  ///
  /// In en, this message translates to:
  /// **'Past Appointments'**
  String get pastAppointments;

  /// No description provided for @myAppointments.
  ///
  /// In en, this message translates to:
  /// **'My Appointments'**
  String get myAppointments;

  /// No description provided for @noUpcomingAppointments.
  ///
  /// In en, this message translates to:
  /// **'No upcoming appointments'**
  String get noUpcomingAppointments;

  /// No description provided for @noPastAppointments.
  ///
  /// In en, this message translates to:
  /// **'No past appointments'**
  String get noPastAppointments;

  /// No description provided for @cancelAppointmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel appointment?'**
  String get cancelAppointmentTitle;

  /// No description provided for @cannotUndo.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get cannotUndo;

  /// No description provided for @yesCancel.
  ///
  /// In en, this message translates to:
  /// **'Yes, cancel'**
  String get yesCancel;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @bookAppointment.
  ///
  /// In en, this message translates to:
  /// **'Book Appointment'**
  String get bookAppointment;

  /// No description provided for @confirmAppointment.
  ///
  /// In en, this message translates to:
  /// **'Confirm Appointment'**
  String get confirmAppointment;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get selectTime;

  /// No description provided for @chooseTimeSlot.
  ///
  /// In en, this message translates to:
  /// **'Choose a time slot'**
  String get chooseTimeSlot;

  /// No description provided for @patientCard.
  ///
  /// In en, this message translates to:
  /// **'Patient Card'**
  String get patientCard;

  /// No description provided for @personalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Info'**
  String get personalInfo;

  /// No description provided for @medicalInformation.
  ///
  /// In en, this message translates to:
  /// **'Medical Information'**
  String get medicalInformation;

  /// No description provided for @bloodType.
  ///
  /// In en, this message translates to:
  /// **'Blood Type'**
  String get bloodType;

  /// No description provided for @notSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSet;

  /// No description provided for @allergies.
  ///
  /// In en, this message translates to:
  /// **'Allergies'**
  String get allergies;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @addAllergy.
  ///
  /// In en, this message translates to:
  /// **'Add Allergy'**
  String get addAllergy;

  /// No description provided for @allergyHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Penicillin'**
  String get allergyHint;

  /// No description provided for @allergyExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. Penicillin'**
  String get allergyExample;

  /// No description provided for @documents.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documents;

  /// No description provided for @noDocuments.
  ///
  /// In en, this message translates to:
  /// **'No documents uploaded'**
  String get noDocuments;

  /// No description provided for @uploadDocument.
  ///
  /// In en, this message translates to:
  /// **'Upload document'**
  String get uploadDocument;

  /// No description provided for @profileSaved.
  ///
  /// In en, this message translates to:
  /// **'Profile saved'**
  String get profileSaved;

  /// No description provided for @documentUploaded.
  ///
  /// In en, this message translates to:
  /// **'Document uploaded'**
  String get documentUploaded;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @specialties.
  ///
  /// In en, this message translates to:
  /// **'Specialties'**
  String get specialties;

  /// No description provided for @topDoctors.
  ///
  /// In en, this message translates to:
  /// **'Top Doctors'**
  String get topDoctors;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @findDoctor.
  ///
  /// In en, this message translates to:
  /// **'Find Doctor'**
  String get findDoctor;

  /// No description provided for @myRecords.
  ///
  /// In en, this message translates to:
  /// **'My Records'**
  String get myRecords;

  /// No description provided for @nextAppointment.
  ///
  /// In en, this message translates to:
  /// **'Next Appointment'**
  String get nextAppointment;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @bookYourFirst.
  ///
  /// In en, this message translates to:
  /// **'Book your first consultation today'**
  String get bookYourFirst;

  /// No description provided for @searchDoctor.
  ///
  /// In en, this message translates to:
  /// **'Search by name or specialty...'**
  String get searchDoctor;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @busy.
  ///
  /// In en, this message translates to:
  /// **'Busy'**
  String get busy;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @consultationFee.
  ///
  /// In en, this message translates to:
  /// **'Consultation Fee'**
  String get consultationFee;

  /// No description provided for @appointmentBooked.
  ///
  /// In en, this message translates to:
  /// **'Appointment Booked!'**
  String get appointmentBooked;

  /// No description provided for @viewAppointments.
  ///
  /// In en, this message translates to:
  /// **'View Appointments'**
  String get viewAppointments;

  /// No description provided for @confirmed.
  ///
  /// In en, this message translates to:
  /// **'CONFIRMED'**
  String get confirmed;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'PENDING'**
  String get pending;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'COMPLETED'**
  String get completed;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'CANCELLED'**
  String get cancelled;

  /// No description provided for @offlineBanner.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Showing cached data.'**
  String get offlineBanner;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get errorOccurred;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get invalidEmail;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// No description provided for @passwordsNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsNotMatch;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @appointmentWith.
  ///
  /// In en, this message translates to:
  /// **'Appointment with Dr. {name}'**
  String appointmentWith(String name);

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @experience.
  ///
  /// In en, this message translates to:
  /// **'yr'**
  String get experience;

  /// No description provided for @experienceLabel.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get experienceLabel;

  /// No description provided for @therapist.
  ///
  /// In en, this message translates to:
  /// **'Therapist'**
  String get therapist;

  /// No description provided for @cardiologist.
  ///
  /// In en, this message translates to:
  /// **'Cardiologist'**
  String get cardiologist;

  /// No description provided for @neurologist.
  ///
  /// In en, this message translates to:
  /// **'Neurologist'**
  String get neurologist;

  /// No description provided for @dentist.
  ///
  /// In en, this message translates to:
  /// **'Dentist'**
  String get dentist;

  /// No description provided for @pediatrician.
  ///
  /// In en, this message translates to:
  /// **'Pediatrician'**
  String get pediatrician;

  /// No description provided for @dermatologist.
  ///
  /// In en, this message translates to:
  /// **'Dermatologist'**
  String get dermatologist;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'tenge'**
  String get currency;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @signInToAccount.
  ///
  /// In en, this message translates to:
  /// **'Sign in to your account'**
  String get signInToAccount;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @fillDetails.
  ///
  /// In en, this message translates to:
  /// **'Fill in your details to get started'**
  String get fillDetails;

  /// No description provided for @dontHaveAccountQuestion.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccountQuestion;

  /// No description provided for @alreadyHaveAccountQuestion.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccountQuestion;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get requiredField;

  /// No description provided for @incorrectEmailFormat.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email format.'**
  String get incorrectEmailFormat;

  /// No description provided for @minSixChars.
  ///
  /// In en, this message translates to:
  /// **'Min 6 characters'**
  String get minSixChars;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @good_morning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get good_morning;

  /// No description provided for @good_afternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get good_afternoon;

  /// No description provided for @good_evening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get good_evening;

  /// No description provided for @see_all.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get see_all;

  /// No description provided for @specialty_cardiologist.
  ///
  /// In en, this message translates to:
  /// **'Cardiologist'**
  String get specialty_cardiologist;

  /// No description provided for @specialty_neurologist.
  ///
  /// In en, this message translates to:
  /// **'Neurologist'**
  String get specialty_neurologist;

  /// No description provided for @specialty_dentist.
  ///
  /// In en, this message translates to:
  /// **'Dentist'**
  String get specialty_dentist;

  /// No description provided for @specialty_pediatrician.
  ///
  /// In en, this message translates to:
  /// **'Pediatrician'**
  String get specialty_pediatrician;

  /// No description provided for @specialty_dermatologist.
  ///
  /// In en, this message translates to:
  /// **'Dermatologist'**
  String get specialty_dermatologist;

  /// No description provided for @pharmacy.
  ///
  /// In en, this message translates to:
  /// **'Pharmacy'**
  String get pharmacy;

  /// No description provided for @darkModeDescription.
  ///
  /// In en, this message translates to:
  /// **'Switch between light and dark theme'**
  String get darkModeDescription;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @viewEditProfile.
  ///
  /// In en, this message translates to:
  /// **'View and edit your patient card'**
  String get viewEditProfile;

  /// No description provided for @myReviews.
  ///
  /// In en, this message translates to:
  /// **'My Reviews'**
  String get myReviews;

  /// No description provided for @reviewsDescription.
  ///
  /// In en, this message translates to:
  /// **'Reviews you\'ve written for doctors'**
  String get reviewsDescription;

  /// No description provided for @medicineReminders.
  ///
  /// In en, this message translates to:
  /// **'Medicine Reminders'**
  String get medicineReminders;

  /// No description provided for @medicineRemindersDescription.
  ///
  /// In en, this message translates to:
  /// **'Manage your medication schedule'**
  String get medicineRemindersDescription;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @appointmentReminders.
  ///
  /// In en, this message translates to:
  /// **'Appointment Reminders'**
  String get appointmentReminders;

  /// No description provided for @appointmentRemindersDescription.
  ///
  /// In en, this message translates to:
  /// **'Get notified before your appointments'**
  String get appointmentRemindersDescription;

  /// No description provided for @medicineAlerts.
  ///
  /// In en, this message translates to:
  /// **'Medicine Alerts'**
  String get medicineAlerts;

  /// No description provided for @medicineAlertsDescription.
  ///
  /// In en, this message translates to:
  /// **'Reminders to take your medication'**
  String get medicineAlertsDescription;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @helpFaq.
  ///
  /// In en, this message translates to:
  /// **'Help & FAQ'**
  String get helpFaq;

  /// No description provided for @helpFaqDescription.
  ///
  /// In en, this message translates to:
  /// **'Frequently asked questions'**
  String get helpFaqDescription;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @reportProblem.
  ///
  /// In en, this message translates to:
  /// **'Report a Problem'**
  String get reportProblem;

  /// No description provided for @reportProblemDescription.
  ///
  /// In en, this message translates to:
  /// **'Let us know if something is broken'**
  String get reportProblemDescription;

  /// No description provided for @reportProblemHint.
  ///
  /// In en, this message translates to:
  /// **'Describe the issue you encountered...'**
  String get reportProblemHint;

  /// No description provided for @reportSent.
  ///
  /// In en, this message translates to:
  /// **'Thank you! Your report has been sent.'**
  String get reportSent;

  /// No description provided for @sendReport.
  ///
  /// In en, this message translates to:
  /// **'Send Report'**
  String get sendReport;

  /// No description provided for @aboutMedica.
  ///
  /// In en, this message translates to:
  /// **'About Medica'**
  String get aboutMedica;

  /// No description provided for @aboutMedicaDescription.
  ///
  /// In en, this message translates to:
  /// **'Learn about our app and mission'**
  String get aboutMedicaDescription;

  /// No description provided for @aboutMedicaFullDescription.
  ///
  /// In en, this message translates to:
  /// **'Medica is a modern medical app designed to connect patients with healthcare professionals. Book appointments, chat with doctors, manage your medications, and access health resources all in one place.'**
  String get aboutMedicaFullDescription;

  /// No description provided for @madeInKazakhstan.
  ///
  /// In en, this message translates to:
  /// **'Made by Mariya and Nazerke'**
  String get madeInKazakhstan;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @privacyPolicyDescription.
  ///
  /// In en, this message translates to:
  /// **'How we handle your data'**
  String get privacyPolicyDescription;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @termsOfServiceDescription.
  ///
  /// In en, this message translates to:
  /// **'Terms and conditions of use'**
  String get termsOfServiceDescription;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get appVersion;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @supportHours.
  ///
  /// In en, this message translates to:
  /// **'Support Hours'**
  String get supportHours;

  /// No description provided for @supportHoursValue.
  ///
  /// In en, this message translates to:
  /// **'Mon–Fri, 9:00–18:00'**
  String get supportHoursValue;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @faqQuestion1.
  ///
  /// In en, this message translates to:
  /// **'How do I book an appointment?'**
  String get faqQuestion1;

  /// No description provided for @faqAnswer1.
  ///
  /// In en, this message translates to:
  /// **'Go to Doctors tab, choose a doctor and tap \"Book Appointment\". Select a date and time slot.'**
  String get faqAnswer1;

  /// No description provided for @faqQuestion2.
  ///
  /// In en, this message translates to:
  /// **'How do I chat with a doctor?'**
  String get faqQuestion2;

  /// No description provided for @faqAnswer2.
  ///
  /// In en, this message translates to:
  /// **'Open a doctor\'s profile page and tap \"Chat with Doctor\". Your conversation is saved.'**
  String get faqAnswer2;

  /// No description provided for @faqQuestion3.
  ///
  /// In en, this message translates to:
  /// **'Can I use the app offline?'**
  String get faqQuestion3;

  /// No description provided for @faqAnswer3.
  ///
  /// In en, this message translates to:
  /// **'Yes! Core features work offline thanks to Firestore caching. An offline banner will appear when you\'re disconnected.'**
  String get faqAnswer3;

  /// No description provided for @faqQuestion4.
  ///
  /// In en, this message translates to:
  /// **'How do I set medicine reminders?'**
  String get faqQuestion4;

  /// No description provided for @faqAnswer4.
  ///
  /// In en, this message translates to:
  /// **'Go to Profile → Medicine Reminders or tap Reminders on the home screen. Tap + to add a reminder.'**
  String get faqAnswer4;

  /// No description provided for @faqQuestion5.
  ///
  /// In en, this message translates to:
  /// **'How do I change the app language?'**
  String get faqQuestion5;

  /// No description provided for @faqAnswer5.
  ///
  /// In en, this message translates to:
  /// **'Go to Settings → Language and select English, Russian, or Kazakh.'**
  String get faqAnswer5;

  /// No description provided for @privacyDataCollect.
  ///
  /// In en, this message translates to:
  /// **'Data We Collect'**
  String get privacyDataCollect;

  /// No description provided for @privacyDataCollectBody.
  ///
  /// In en, this message translates to:
  /// **'We collect your name, email, health information you provide, appointment history, and usage data to improve your experience.'**
  String get privacyDataCollectBody;

  /// No description provided for @privacyDataUse.
  ///
  /// In en, this message translates to:
  /// **'How We Use Your Data'**
  String get privacyDataUse;

  /// No description provided for @privacyDataUseBody.
  ///
  /// In en, this message translates to:
  /// **'Your data is used to provide medical appointment services, connect you with doctors, and personalise your experience. We never sell your personal data to third parties.'**
  String get privacyDataUseBody;

  /// No description provided for @privacyDataSecurity.
  ///
  /// In en, this message translates to:
  /// **'Data Security'**
  String get privacyDataSecurity;

  /// No description provided for @privacyDataSecurityBody.
  ///
  /// In en, this message translates to:
  /// **'All data is encrypted and stored securely using Firebase. Authentication tokens are stored in secure storage on your device.'**
  String get privacyDataSecurityBody;

  /// No description provided for @privacyYourRights.
  ///
  /// In en, this message translates to:
  /// **'Your Rights'**
  String get privacyYourRights;

  /// No description provided for @privacyYourRightsBody.
  ///
  /// In en, this message translates to:
  /// **'You can request deletion of your account and data at any time by contacting us at support@medica.kz.'**
  String get privacyYourRightsBody;

  /// No description provided for @termsAcceptance.
  ///
  /// In en, this message translates to:
  /// **'Acceptance of Terms'**
  String get termsAcceptance;

  /// No description provided for @termsAcceptanceBody.
  ///
  /// In en, this message translates to:
  /// **'By using Medica, you agree to these terms. The app is intended for informational purposes and to facilitate appointment booking — not as a substitute for professional medical advice.'**
  String get termsAcceptanceBody;

  /// No description provided for @termsMedicalDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Medical Disclaimer'**
  String get termsMedicalDisclaimer;

  /// No description provided for @termsMedicalDisclaimerBody.
  ///
  /// In en, this message translates to:
  /// **'Medica does not provide medical diagnoses. Always consult a qualified healthcare provider for medical decisions. In case of emergency, call 103 immediately.'**
  String get termsMedicalDisclaimerBody;

  /// No description provided for @termsUserResponsibilities.
  ///
  /// In en, this message translates to:
  /// **'User Responsibilities'**
  String get termsUserResponsibilities;

  /// No description provided for @termsUserResponsibilitiesBody.
  ///
  /// In en, this message translates to:
  /// **'You are responsible for providing accurate information and maintaining the security of your account credentials.'**
  String get termsUserResponsibilitiesBody;

  /// No description provided for @termsChanges.
  ///
  /// In en, this message translates to:
  /// **'Changes to Terms'**
  String get termsChanges;

  /// No description provided for @termsChangesBody.
  ///
  /// In en, this message translates to:
  /// **'We may update these terms from time to time. Continued use of the app after changes means you accept the new terms.'**
  String get termsChangesBody;

  /// No description provided for @chatWithDoctor.
  ///
  /// In en, this message translates to:
  /// **'Chat with Doctor'**
  String get chatWithDoctor;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not Available'**
  String get notAvailable;

  /// No description provided for @pleaseSignIn.
  ///
  /// In en, this message translates to:
  /// **'Please sign in to chat with doctors'**
  String get pleaseSignIn;

  /// No description provided for @document.
  ///
  /// In en, this message translates to:
  /// **'Document'**
  String get document;

  /// No description provided for @healthTools.
  ///
  /// In en, this message translates to:
  /// **'Health Tools'**
  String get healthTools;

  /// No description provided for @bmiCalculator.
  ///
  /// In en, this message translates to:
  /// **'BMI Calculator'**
  String get bmiCalculator;

  /// No description provided for @bmiCalculatorDescription.
  ///
  /// In en, this message translates to:
  /// **'Check your body mass index'**
  String get bmiCalculatorDescription;

  /// No description provided for @trackMedications.
  ///
  /// In en, this message translates to:
  /// **'Track your medications'**
  String get trackMedications;

  /// No description provided for @myReviewsDescription.
  ///
  /// In en, this message translates to:
  /// **'View all reviews you\'ve written'**
  String get myReviewsDescription;

  /// No description provided for @messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// No description provided for @emergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get emergency;

  /// No description provided for @articles.
  ///
  /// In en, this message translates to:
  /// **'Articles'**
  String get articles;

  /// No description provided for @sosNeedHelpNow.
  ///
  /// In en, this message translates to:
  /// **'SOS — Need Help Now?'**
  String get sosNeedHelpNow;

  /// No description provided for @sosTapToFindDoctor.
  ///
  /// In en, this message translates to:
  /// **'Tap to find an available doctor immediately'**
  String get sosTapToFindDoctor;

  /// No description provided for @doctorsAvailableNow.
  ///
  /// In en, this message translates to:
  /// **'Doctors Available Now'**
  String get doctorsAvailableNow;

  /// No description provided for @callDoctorToLocation.
  ///
  /// In en, this message translates to:
  /// **'Call a doctor to your location immediately'**
  String get callDoctorToLocation;

  /// No description provided for @callAmbulance.
  ///
  /// In en, this message translates to:
  /// **'Call Ambulance'**
  String get callAmbulance;

  /// No description provided for @dial103ForEmergency.
  ///
  /// In en, this message translates to:
  /// **'Dial 103 for emergency ambulance service.'**
  String get dial103ForEmergency;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @lifeThreatening103.
  ///
  /// In en, this message translates to:
  /// **'Life-threatening emergency? Call 103'**
  String get lifeThreatening103;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @callingDoctorToLocation.
  ///
  /// In en, this message translates to:
  /// **'Calling {doctorName} to your location...'**
  String callingDoctorToLocation(String doctorName);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'kk', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'kk': return AppLocalizationsKk();
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
