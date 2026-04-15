// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'Medica';

  @override
  String get login => 'Войти';

  @override
  String get register => 'Регистрация';

  @override
  String get email => 'Email';

  @override
  String get password => 'Пароль';

  @override
  String get confirmPassword => 'Подтвердите пароль';

  @override
  String get fullName => 'Полное имя';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get dontHaveAccount => 'Нет аккаунта?';

  @override
  String get alreadyHaveAccount => 'Уже есть аккаунт?';

  @override
  String get signIn => 'Войти';

  @override
  String get signUp => 'Зарегистрироваться';

  @override
  String get logout => 'Выйти';

  @override
  String get home => 'Главная';

  @override
  String get doctors => 'Врачи';

  @override
  String get appointments => 'Записи';

  @override
  String get profile => 'Профиль';

  @override
  String get settings => 'Настройки';

  @override
  String get upcoming => 'Предстоящие';

  @override
  String get past => 'Прошедшие';

  @override
  String get upcomingAppointments => 'Предстоящие записи';

  @override
  String get pastAppointments => 'Прошедшие записи';

  @override
  String get myAppointments => 'Мои записи';

  @override
  String get noUpcomingAppointments => 'Предстоящих записей нет';

  @override
  String get noPastAppointments => 'Прошедших записей нет';

  @override
  String get cancelAppointmentTitle => 'Отменить запись?';

  @override
  String get cannotUndo => 'Это действие нельзя отменить.';

  @override
  String get yesCancel => 'Да, отменить';

  @override
  String get no => 'Нет';

  @override
  String get bookAppointment => 'Записаться';

  @override
  String get confirmAppointment => 'Подтвердить запись';

  @override
  String get selectDate => 'Выберите дату';

  @override
  String get selectTime => 'Выберите время';

  @override
  String get chooseTimeSlot => 'Выберите время';

  @override
  String get patientCard => 'Карточка пациента';

  @override
  String get personalInfo => 'Личные данные';

  @override
  String get medicalInformation => 'Медицинская информация';

  @override
  String get bloodType => 'Группа крови';

  @override
  String get notSet => 'Не указано';

  @override
  String get allergies => 'Аллергии';

  @override
  String get none => 'Нет';

  @override
  String get addAllergy => 'Добавить аллергию';

  @override
  String get allergyHint => 'напр. Пенициллин';

  @override
  String get allergyExample => 'напр. Пенициллин';

  @override
  String get documents => 'Документы';

  @override
  String get noDocuments => 'Документы не загружены';

  @override
  String get uploadDocument => 'Загрузить документ';

  @override
  String get profileSaved => 'Профиль сохранён';

  @override
  String get documentUploaded => 'Документ загружен';

  @override
  String get save => 'Сохранить';

  @override
  String get edit => 'Изменить';

  @override
  String get add => 'Добавить';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get specialties => 'Специальности';

  @override
  String get topDoctors => 'Лучшие врачи';

  @override
  String get seeAll => 'Все';

  @override
  String get findDoctor => 'Найти врача';

  @override
  String get myRecords => 'Мои записи';

  @override
  String get nextAppointment => 'Ближайшая запись';

  @override
  String get darkMode => 'Тёмная тема';

  @override
  String get language => 'Язык';

  @override
  String get bookYourFirst => 'Запишитесь на первую консультацию';

  @override
  String get searchDoctor => 'Поиск по имени или специальности...';

  @override
  String get available => 'Доступен';

  @override
  String get busy => 'Занят';

  @override
  String get about => 'О приложении';

  @override
  String get consultationFee => 'Стоимость приёма';

  @override
  String get appointmentBooked => 'Запись создана!';

  @override
  String get viewAppointments => 'Мои записи';

  @override
  String get confirmed => 'ПОДТВЕРЖДЕНО';

  @override
  String get pending => 'ОЖИДАЕТ';

  @override
  String get completed => 'ЗАВЕРШЕНО';

  @override
  String get cancelled => 'ОТМЕНЕНО';

  @override
  String get offlineBanner => 'Нет интернета. Отображаются кэшированные данные.';

  @override
  String get errorOccurred => 'Произошла ошибка';

  @override
  String get retry => 'Повторить';

  @override
  String get fieldRequired => 'Обязательное поле';

  @override
  String get invalidEmail => 'Введите корректный email';

  @override
  String get passwordTooShort => 'Пароль должен быть не менее 6 символов';

  @override
  String get passwordsNotMatch => 'Пароли не совпадают';

  @override
  String get unknown => 'Неизвестно';

  @override
  String appointmentWith(String name) {
    return 'Запись к Др. $name';
  }

  @override
  String get rating => 'Рейтинг';

  @override
  String get reviews => 'Отзывов';

  @override
  String get experience => 'лет';

  @override
  String get experienceLabel => 'Опыт';

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
  String get currency => 'тенге';

  @override
  String get selectLanguage => 'Выберите язык';

  @override
  String get welcomeBack => 'Добро пожаловать';

  @override
  String get signInToAccount => 'Войдите в свой аккаунт';

  @override
  String get createAccount => 'Создать аккаунт';

  @override
  String get fillDetails => 'Заполните данные для регистрации';

  @override
  String get dontHaveAccountQuestion => 'Нет аккаунта?';

  @override
  String get alreadyHaveAccountQuestion => 'Уже есть аккаунт?';

  @override
  String get requiredField => 'Обязательное поле';

  @override
  String get incorrectEmailFormat => 'Неверный формат email.';

  @override
  String get minSixChars => 'Минимум 6 символов';

  @override
  String get passwordsDoNotMatch => 'Пароли не совпадают';

  @override
  String get firstName => 'Имя';

  @override
  String get lastName => 'Фамилия';

  @override
  String get good_morning => 'Доброе утро';

  @override
  String get good_afternoon => 'Добрый день';

  @override
  String get good_evening => 'Добрый вечер';

  @override
  String get see_all => 'Все';

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
  String get pharmacy => 'Аптека';

  @override
  String get darkModeDescription => 'Переключение между светлой и тёмной темой';

  @override
  String get account => 'Аккаунт';

  @override
  String get viewEditProfile => 'Просмотр и редактирование профиля пациента';

  @override
  String get myReviews => 'Мои отзывы';

  @override
  String get reviewsDescription => 'Отзывы, которые вы оставили о врачах';

  @override
  String get medicineReminders => 'Напоминания о лекарствах';

  @override
  String get medicineRemindersDescription => 'Управление расписанием приёма лекарств';

  @override
  String get comingSoon => 'Скоро появится';

  @override
  String get notifications => 'Уведомления';

  @override
  String get appointmentReminders => 'Напоминания о записях';

  @override
  String get appointmentRemindersDescription => 'Получать уведомления перед приёмами';

  @override
  String get medicineAlerts => 'Уведомления о лекарствах';

  @override
  String get medicineAlertsDescription => 'Напоминания о приёме лекарств';

  @override
  String get support => 'Поддержка';

  @override
  String get helpFaq => 'Помощь и FAQ';

  @override
  String get helpFaqDescription => 'Часто задаваемые вопросы';

  @override
  String get contactUs => 'Связаться с нами';

  @override
  String get reportProblem => 'Сообщить о проблеме';

  @override
  String get reportProblemDescription => 'Сообщите нам, если что-то не работает';

  @override
  String get reportProblemHint => 'Опишите проблему, с которой вы столкнулись...';

  @override
  String get reportSent => 'Спасибо! Ваше сообщение отправлено.';

  @override
  String get sendReport => 'Отправить отчёт';

  @override
  String get aboutMedica => 'О приложении Medica';

  @override
  String get aboutMedicaDescription => 'Узнайте больше о нашем приложении и миссии';

  @override
  String get aboutMedicaFullDescription => 'Medica — это современное медицинское приложение, соединяющее пациентов с медицинскими специалистами. Записывайтесь на приём, общайтесь с врачами, управляйте приёмом лекарств и получайте доступ к медицинской информации в одном месте.';

  @override
  String get madeInKazakhstan => 'Сделано Марией и Назерке';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get privacyPolicyDescription => 'Как мы обрабатываем ваши данные';

  @override
  String get termsOfService => 'Условия использования';

  @override
  String get termsOfServiceDescription => 'Правила и условия использования';

  @override
  String get appVersion => 'Версия приложения';

  @override
  String get phone => 'Телефон';

  @override
  String get supportHours => 'Часы поддержки';

  @override
  String get supportHoursValue => 'Пн–Пт, 9:00–18:00';

  @override
  String get address => 'Адрес';

  @override
  String get faqQuestion1 => 'Как записаться на приём?';

  @override
  String get faqAnswer1 => 'Перейдите во вкладку \"Врачи\", выберите врача и нажмите \"Записаться на приём\". Выберите дату и время.';

  @override
  String get faqQuestion2 => 'Как написать врачу?';

  @override
  String get faqAnswer2 => 'Откройте профиль врача и нажмите \"Написать врачу\". Ваш разговор сохраняется.';

  @override
  String get faqQuestion3 => 'Можно ли использовать приложение офлайн?';

  @override
  String get faqAnswer3 => 'Да! Основные функции работают офлайн благодаря кэшированию Firestore. При отсутствии интернета появится баннер.';

  @override
  String get faqQuestion4 => 'Как установить напоминания о лекарствах?';

  @override
  String get faqAnswer4 => 'Перейдите в Профиль → Напоминания о лекарствах или нажмите на \"Напоминания\" на главном экране. Нажмите +, чтобы добавить напоминание.';

  @override
  String get faqQuestion5 => 'Как изменить язык приложения?';

  @override
  String get faqAnswer5 => 'Перейдите в Настройки → Язык и выберите английский, русский или казахский.';

  @override
  String get privacyDataCollect => 'Какие данные мы собираем';

  @override
  String get privacyDataCollectBody => 'Мы собираем ваше имя, email, медицинскую информацию, которую вы предоставляете, историю записей и данные об использовании приложения для улучшения сервиса.';

  @override
  String get privacyDataUse => 'Как мы используем ваши данные';

  @override
  String get privacyDataUseBody => 'Ваши данные используются для предоставления услуг записи на приём, связи с врачами и персонализации. Мы никогда не продаём ваши данные третьим лицам.';

  @override
  String get privacyDataSecurity => 'Безопасность данных';

  @override
  String get privacyDataSecurityBody => 'Все данные зашифрованы и хранятся безопасно с помощью Firebase. Токены авторизации хранятся в защищённом хранилище на вашем устройстве.';

  @override
  String get privacyYourRights => 'Ваши права';

  @override
  String get privacyYourRightsBody => 'Вы можете запросить удаление своего аккаунта и данных в любое время, связавшись с нами по адресу support@medica.kz.';

  @override
  String get termsAcceptance => 'Принятие условий';

  @override
  String get termsAcceptanceBody => 'Используя Medica, вы соглашаетесь с этими условиями. Приложение предназначено для информационных целей и упрощения записи на приём, а не в качестве замены профессиональной медицинской консультации.';

  @override
  String get termsMedicalDisclaimer => 'Медицинский отказ от ответственности';

  @override
  String get termsMedicalDisclaimerBody => 'Medica не предоставляет медицинские диагнозы. Всегда консультируйтесь с квалифицированным врачом. В экстренных случаях звоните 103.';

  @override
  String get termsUserResponsibilities => 'Обязанности пользователя';

  @override
  String get termsUserResponsibilitiesBody => 'Вы несёте ответственность за предоставление точной информации и сохранность учётных данных.';

  @override
  String get termsChanges => 'Изменения в условиях';

  @override
  String get termsChangesBody => 'Мы можем время от времени обновлять эти условия. Продолжение использования приложения означает принятие новых условий.';

  @override
  String get chatWithDoctor => 'Написать врачу';

  @override
  String get notAvailable => 'Недоступен';

  @override
  String get pleaseSignIn => 'Войдите, чтобы общаться с врачами';

  @override
  String get document => 'Документ';

  @override
  String get healthTools => 'Инструменты здоровья';

  @override
  String get bmiCalculator => 'Калькулятор ИМТ';

  @override
  String get bmiCalculatorDescription => 'Проверьте индекс массы тела';

  @override
  String get trackMedications => 'Отслеживайте приём лекарств';

  @override
  String get myReviewsDescription => 'Просмотр всех ваших отзывов';

  @override
  String get messages => 'Сообщения';

  @override
  String get emergency => 'Экстренная помощь';

  @override
  String get articles => 'Статьи';

  @override
  String get sosNeedHelpNow => 'SOS — Нужна помощь?';

  @override
  String get sosTapToFindDoctor => 'Нажмите, чтобы найти доступного врача';

  @override
  String get doctorsAvailableNow => 'Врачи доступны сейчас';

  @override
  String get callDoctorToLocation => 'Вызовите врача на ваше местоположение';

  @override
  String get callAmbulance => 'Вызвать скорую';

  @override
  String get dial103ForEmergency => 'Наберите 103 для вызова скорой помощи.';

  @override
  String get ok => 'ОК';

  @override
  String get lifeThreatening103 => 'Угроза жизни? Звоните 103';

  @override
  String get call => 'Позвонить';

  @override
  String callingDoctorToLocation(String doctorName) {
    return 'Вызываем $doctorName к вашему местоположению...';
  }
}
