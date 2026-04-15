// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get appName => 'Medica';

  @override
  String get login => 'Кіру';

  @override
  String get register => 'Тіркелу';

  @override
  String get email => 'Email';

  @override
  String get password => 'Құпия сөз';

  @override
  String get confirmPassword => 'Құпия сөзді растаңыз';

  @override
  String get fullName => 'Толық аты-жөні';

  @override
  String get forgotPassword => 'Құпия сөзді ұмыттыңыз ба?';

  @override
  String get dontHaveAccount => 'Аккаунтыңыз жоқ па?';

  @override
  String get alreadyHaveAccount => 'Аккаунтыңыз бар ма?';

  @override
  String get signIn => 'Кіру';

  @override
  String get signUp => 'Тіркелу';

  @override
  String get logout => 'Шығу';

  @override
  String get home => 'Басты бет';

  @override
  String get doctors => 'Дәрігерлер';

  @override
  String get appointments => 'Жазбалар';

  @override
  String get profile => 'Профиль';

  @override
  String get settings => 'Параметрлер';

  @override
  String get upcoming => 'Алдағы';

  @override
  String get past => 'Өткен';

  @override
  String get upcomingAppointments => 'Алдағы жазбалар';

  @override
  String get pastAppointments => 'Өткен жазбалар';

  @override
  String get myAppointments => 'Жазбаларым';

  @override
  String get noUpcomingAppointments => 'Алдағы жазбалар жоқ';

  @override
  String get noPastAppointments => 'Өткен жазбалар жоқ';

  @override
  String get cancelAppointmentTitle => 'Жазбаны бас тарту?';

  @override
  String get cannotUndo => 'Бұл әрекетті болдырмау мүмкін емес.';

  @override
  String get yesCancel => 'Иә, бас тарту';

  @override
  String get no => 'Жоқ';

  @override
  String get bookAppointment => 'Жазылу';

  @override
  String get confirmAppointment => 'Жазбаны растау';

  @override
  String get selectDate => 'Күн таңдаңыз';

  @override
  String get selectTime => 'Уақыт таңдаңыз';

  @override
  String get chooseTimeSlot => 'Уақыт таңдаңыз';

  @override
  String get patientCard => 'Науқас картасы';

  @override
  String get personalInfo => 'Жеке деректер';

  @override
  String get medicalInformation => 'Медициналық ақпарат';

  @override
  String get bloodType => 'Қан тобы';

  @override
  String get notSet => 'Көрсетілмеген';

  @override
  String get allergies => 'Аллергиялар';

  @override
  String get none => 'Жоқ';

  @override
  String get addAllergy => 'Аллергия қосу';

  @override
  String get allergyHint => 'мыс. Пенициллин';

  @override
  String get allergyExample => 'мыс. Пенициллин';

  @override
  String get documents => 'Құжаттар';

  @override
  String get noDocuments => 'Құжаттар жүктелмеген';

  @override
  String get uploadDocument => 'Құжат жүктеу';

  @override
  String get profileSaved => 'Профиль сақталды';

  @override
  String get documentUploaded => 'Құжат жүктелді';

  @override
  String get save => 'Сақтау';

  @override
  String get edit => 'Өңдеу';

  @override
  String get add => 'Қосу';

  @override
  String get cancel => 'Бас тарту';

  @override
  String get delete => 'Жою';

  @override
  String get specialties => 'Мамандықтар';

  @override
  String get topDoctors => 'Үздік дәрігерлер';

  @override
  String get seeAll => 'Барлығы';

  @override
  String get findDoctor => 'Дәрігер іздеу';

  @override
  String get myRecords => 'Жазбаларым';

  @override
  String get nextAppointment => 'Келесі жазба';

  @override
  String get darkMode => 'Қараңғы режим';

  @override
  String get language => 'Тіл';

  @override
  String get bookYourFirst => 'Алғашқы кеңесіңізге жазылыңыз';

  @override
  String get searchDoctor => 'Аты немесе мамандығы бойынша іздеу...';

  @override
  String get available => 'Қол жетімді';

  @override
  String get busy => 'Бос емес';

  @override
  String get about => 'Қосымша туралы';

  @override
  String get consultationFee => 'Қабылдау құны';

  @override
  String get appointmentBooked => 'Жазба жасалды!';

  @override
  String get viewAppointments => 'Жазбаларым';

  @override
  String get confirmed => 'РАСТАЛДЫ';

  @override
  String get pending => 'КҮТУДЕ';

  @override
  String get completed => 'АЯҚТАЛДЫ';

  @override
  String get cancelled => 'БАС ТАРТЫЛДЫ';

  @override
  String get offlineBanner => 'Интернет жоқ. Кэштелген деректер көрсетілуде.';

  @override
  String get errorOccurred => 'Қате орын алды';

  @override
  String get retry => 'Қайталау';

  @override
  String get fieldRequired => 'Міндетті өріс';

  @override
  String get invalidEmail => 'Дұрыс email енгізіңіз';

  @override
  String get passwordTooShort => 'Құпия сөз кемінде 6 таңбадан тұруы керек';

  @override
  String get passwordsNotMatch => 'Құпия сөздер сәйкес келмейді';

  @override
  String get unknown => 'Белгісіз';

  @override
  String appointmentWith(String name) {
    return 'Др. $name жазбасы';
  }

  @override
  String get rating => 'Рейтинг';

  @override
  String get reviews => 'Пікір';

  @override
  String get experience => 'жыл';

  @override
  String get experienceLabel => 'Тәжірибе';

  @override
  String get therapist => 'Терапевт';

  @override
  String get cardiologist => 'Кардиолог';

  @override
  String get neurologist => 'Невролог';

  @override
  String get dentist => 'Стоматолог';

  @override
  String get pediatrician => 'Педиатр';

  @override
  String get dermatologist => 'Дерматолог';

  @override
  String get currency => 'теңге';

  @override
  String get selectLanguage => 'Тіл таңдаңыз';

  @override
  String get welcomeBack => 'Қош келдіңіз';

  @override
  String get signInToAccount => 'Аккаунтыңызға кіріңіз';

  @override
  String get createAccount => 'Аккаунт жасау';

  @override
  String get fillDetails => 'Тіркелу үшін деректерді толтырыңыз';

  @override
  String get dontHaveAccountQuestion => 'Аккаунтыңыз жоқ па?';

  @override
  String get alreadyHaveAccountQuestion => 'Аккаунтыңыз бар ма?';

  @override
  String get requiredField => 'Міндетті өріс';

  @override
  String get incorrectEmailFormat => 'Қате email форматы.';

  @override
  String get minSixChars => 'Кемінде 6 таңба';

  @override
  String get passwordsDoNotMatch => 'Құпия сөздер сәйкес келмейді';

  @override
  String get firstName => 'Аты';

  @override
  String get lastName => 'Тегі';

  @override
  String get good_morning => 'Қайырлы таң';

  @override
  String get good_afternoon => 'Қайырлы күн';

  @override
  String get good_evening => 'Қайырлы кеш';

  @override
  String get see_all => 'Барлығы';

  @override
  String get specialty_cardiologist => 'Кардиолог';

  @override
  String get specialty_neurologist => 'Невролог';

  @override
  String get specialty_dentist => 'Стоматолог';

  @override
  String get specialty_pediatrician => 'Педиатр';

  @override
  String get specialty_dermatologist => 'Дерматолог';

  @override
  String get pharmacy => 'Дәріхана';

  @override
  String get darkModeDescription => 'Ашық және қараңғы тақырып арасында ауысу';

  @override
  String get account => 'Аккаунт';

  @override
  String get viewEditProfile => 'Пациент картасын қарау және өңдеу';

  @override
  String get myReviews => 'Менің пікірлерім';

  @override
  String get reviewsDescription => 'Дәрігерлер туралы жазған пікірлеріңіз';

  @override
  String get medicineReminders => 'Дәрі туралы еске салулар';

  @override
  String get medicineRemindersDescription => 'Дәрі қабылдау кестесін басқару';

  @override
  String get comingSoon => 'Жақында пайда болады';

  @override
  String get notifications => 'Хабарландырулар';

  @override
  String get appointmentReminders => 'Жазылу туралы еске салулар';

  @override
  String get appointmentRemindersDescription => 'Қабылдауға дейін хабарландыру алу';

  @override
  String get medicineAlerts => 'Дәрі туралы хабарландырулар';

  @override
  String get medicineAlertsDescription => 'Дәрі қабылдау туралы еске салулар';

  @override
  String get support => 'Қолдау';

  @override
  String get helpFaq => 'Көмек және FAQ';

  @override
  String get helpFaqDescription => 'Жиі қойылатын сұрақтар';

  @override
  String get contactUs => 'Бізге хабарласыңыз';

  @override
  String get reportProblem => 'Мәселе туралы хабарлау';

  @override
  String get reportProblemDescription => 'Бірдеңе жұмыс істемесе, бізге хабарлаңыз';

  @override
  String get reportProblemHint => 'Кездескен мәселені сипаттаңыз...';

  @override
  String get reportSent => 'Рахмет! Хабарламаңыз жіберілді.';

  @override
  String get sendReport => 'Есепті жіберу';

  @override
  String get aboutMedica => 'Medica туралы';

  @override
  String get aboutMedicaDescription => 'Біздің қосымша және миссия туралы біліңіз';

  @override
  String get aboutMedicaFullDescription => 'Medica — науқастарды медицина мамандарымен байланыстыратын заманауи медициналық қосымша. Қабылдауға жазылыңыз, дәрігерлермен сөйлесіңіз, дәрілерді басқарыңыз және медициналық ақпаратқа бір жерден қол жеткізіңіз.';

  @override
  String get madeInKazakhstan => 'Мария мен Назерке жасалған';

  @override
  String get privacyPolicy => 'Құпиялылық саясаты';

  @override
  String get privacyPolicyDescription => 'Деректеріңізді қалай өңдейміз';

  @override
  String get termsOfService => 'Пайдалану шарттары';

  @override
  String get termsOfServiceDescription => 'Қолдану ережелері мен шарттары';

  @override
  String get appVersion => 'Қосымша нұсқасы';

  @override
  String get phone => 'Телефон';

  @override
  String get supportHours => 'Қолдау уақыты';

  @override
  String get supportHoursValue => 'Дс–Жм, 9:00–18:00';

  @override
  String get address => 'Мекенжайы';

  @override
  String get faqQuestion1 => 'Қабылдауға қалай жазылуға болады?';

  @override
  String get faqAnswer1 => '\"Дәрігерлер\" бөліміне өтіп, дәрігерді таңдап, \"Қабылдауға жазылу\" түймесін басыңыз. Күн мен уақытты таңдаңыз.';

  @override
  String get faqQuestion2 => 'Дәрігерге қалай хат жазуға болады?';

  @override
  String get faqAnswer2 => 'Дәрігердің профилін ашып, \"Дәрігерге жазу\" түймесін басыңыз. Сіздің әңгімеңіз сақталады.';

  @override
  String get faqQuestion3 => 'Қосымшаны офлайн режимде пайдалануға бола ма?';

  @override
  String get faqAnswer3 => 'Иә! Firestore кэштеуі арқасында негізгі функциялар офлайн жұмыс істейді. Интернет болмаса баннер пайда болады.';

  @override
  String get faqQuestion4 => 'Дәрі туралы еске салуларды қалай орнатуға болады?';

  @override
  String get faqAnswer4 => 'Профиль → Дәрі туралы еске салулар немесе басты экраннан \"Еске салулар\" түймесін басыңыз. Еске салу қосу үшін + басыңыз.';

  @override
  String get faqQuestion5 => 'Қосымша тілін қалай өзгертуге болады?';

  @override
  String get faqAnswer5 => 'Баптаулар → Тіл бөліміне өтіп, ағылшын, орыс немесе қазақ тілін таңдаңыз.';

  @override
  String get privacyDataCollect => 'Біз қандай деректерді жинаймыз';

  @override
  String get privacyDataCollectBody => 'Біз сіздің атыңызды, электрондық поштаңызды, берген медициналық ақпаратыңызды, жазылу тарихыңызды және қосымшаны қолдану деректерін жинаймыз.';

  @override
  String get privacyDataUse => 'Деректеріңізді қалай пайдаланамыз';

  @override
  String get privacyDataUseBody => 'Деректеріңіз жазылу қызметтерін ұсыну, дәрігерлермен байланыс орнату және жекелендіру үшін қолданылады. Біз сіздің деректеріңізді үшінші тұлғаларға сатпаймыз.';

  @override
  String get privacyDataSecurity => 'Деректер қауіпсіздігі';

  @override
  String get privacyDataSecurityBody => 'Барлық деректер Firebase арқылы шифрланып, қауіпсіз сақталады. Авторизация токендері құрылғыңыздағы қорғалған жадта сақталады.';

  @override
  String get privacyYourRights => 'Сіздің құқықтарыңыз';

  @override
  String get privacyYourRightsBody => 'Сіз кез келген уақытта support@medica.kz арқылы аккаунтыңызды және деректеріңізді жоюды сұрай аласыз.';

  @override
  String get termsAcceptance => 'Шарттарды қабылдау';

  @override
  String get termsAcceptanceBody => 'Medica қолдану арқылы сіз осы шарттарды қабылдайсыз. Қосымша ақпараттық мақсаттарда және жазылуды жеңілдету үшін арналған, кәсіби медициналық кеңес орнына емес.';

  @override
  String get termsMedicalDisclaimer => 'Медициналық жауапкершіліктен бас тарту';

  @override
  String get termsMedicalDisclaimerBody => 'Medica медициналық диагноз қоймайды. Медициналық шешімдер үшін әрқашан білікті дәрігерге жүгініңіз. Төтенше жағдайда 103-ке қоңырау шалыңыз.';

  @override
  String get termsUserResponsibilities => 'Пайдаланушы міндеттері';

  @override
  String get termsUserResponsibilitiesBody => 'Сіз дәл ақпарат беру және аккаунт деректерін қауіпсіз сақтау үшін жауапты боласыз.';

  @override
  String get termsChanges => 'Шарттардағы өзгерістер';

  @override
  String get termsChangesBody => 'Біз осы шарттарды уақыт өте келе жаңарта аламыз. Өзгерістерден кейін қосымшаны пайдалануды жалғастыру жаңа шарттарды қабылдау дегенді білдіреді.';

  @override
  String get chatWithDoctor => 'Дәрігерге жазу';

  @override
  String get notAvailable => 'Қолжетімді емес';

  @override
  String get pleaseSignIn => 'Дәрігерлермен сөйлесу үшін кіріңіз';

  @override
  String get document => 'Құжат';

  @override
  String get healthTools => 'Денсаулық құралдары';

  @override
  String get bmiCalculator => 'ДМИ калькуляторы';

  @override
  String get bmiCalculatorDescription => 'Дене массасы индексін тексеріңіз';

  @override
  String get trackMedications => 'Дәрілерді қадағалаңыз';

  @override
  String get myReviewsDescription => 'Барлық пікірлеріңізді қараңыз';

  @override
  String get messages => 'Хабарламалар';

  @override
  String get emergency => 'Шұғыл көмек';

  @override
  String get articles => 'Мақалалар';

  @override
  String get sosNeedHelpNow => 'SOS — Көмек керек пе?';

  @override
  String get sosTapToFindDoctor => 'Қолжетімді дәрігерді табу үшін басыңыз';

  @override
  String get doctorsAvailableNow => 'Дәрігерлер қазір қолжетімді';

  @override
  String get callDoctorToLocation => 'Дәрігерді орналасқан жеріңізге шақырыңыз';

  @override
  String get callAmbulance => 'Жедел жәрдем шақыру';

  @override
  String get dial103ForEmergency => 'Жедел жәрдем үшін 103-ке қоңырау шалыңыз.';

  @override
  String get ok => 'Жарайды';

  @override
  String get lifeThreatening103 => 'Өмірге қауіп бар ма? 103-ке қоңырау шалыңыз';

  @override
  String get call => 'Қоңырау шалу';

  @override
  String callingDoctorToLocation(String doctorName) {
    return '$doctorName орналасқан жеріңізге шақырылуда...';
  }
}
