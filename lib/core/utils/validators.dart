/// Валидация email с проверкой на реальные домены
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) return 'Required';

  final trimmed = value.trim().toLowerCase();

  // 1. Базовая проверка формата
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  if (!emailRegex.hasMatch(trimmed)) {
    return 'Incorrect email format.';
  }

  // 2. Проверка на минимальную длину
  if (trimmed.length < 5) {
    return 'Email is too short.';
  }

  // 3. Проверка части до @
  final parts = trimmed.split('@');
  if (parts.length != 2) return 'Incorrect email format.';

  final localPart = parts[0];
  final domainPart = parts[1];

  // Локальная часть не должна начинаться/заканчиваться точкой
  if (localPart.startsWith('.') || localPart.endsWith('.')) {
    return 'Email cannot start or end with a dot.';
  }

  // Не должно быть двух точек подряд
  if (localPart.contains('..')) {
    return 'Email cannot contain consecutive dots.';
  }

  // 4. Проверка домена на реальность
  if (!_isValidDomain(domainPart)) {
    return 'Invalid email domain. Use a real email address.';
  }

  // 5. Проверка на одноразовые email
  if (_isDisposableEmail(domainPart)) {
    return 'Disposable email addresses are not allowed.';
  }

  return null;
}

/// Проверка на реальный домен
bool _isValidDomain(String domain) {
  // Список популярных доменов верхнего уровня
  final validTlds = [
    'com', 'org', 'net', 'edu', 'gov', 'mil', 'int',
    'ru', 'kz', 'by', 'ua', 'uz', 'kg', 'tj', 'am', 'ge', 'az',
    'io', 'co', 'info', 'biz', 'me', 'tv', 'cc', 'name',
    'dev', 'app', 'tech', 'online', 'site', 'website',
  ];

  // Проверяем, что домен содержит хотя бы одну точку
  if (!domain.contains('.')) return false;

  // Получаем TLD (последняя часть после точки)
  final tld = domain.split('.').last.toLowerCase();

  // Проверяем, что TLD в списке допустимых
  if (!validTlds.contains(tld)) return false;

  // Проверяем, что домен не слишком короткий (минимум 4 символа: a.co)
  if (domain.length < 4) return false;

  // Проверяем, что нет недопустимых символов
  final domainRegex = RegExp(r'^[a-zA-Z0-9.-]+$');
  if (!domainRegex.hasMatch(domain)) return false;

  // Не должно начинаться или заканчиваться точкой/дефисом
  if (domain.startsWith('.') ||
      domain.endsWith('.') ||
      domain.startsWith('-') ||
      domain.endsWith('-')) {
    return false;
  }

  return true;
}

/// Проверка на одноразовые email-сервисы
bool _isDisposableEmail(String domain) {
  final disposableDomains = [
    'tempmail.com',
    'guerrillamail.com',
    '10minutemail.com',
    'mailinator.com',
    'trashmail.com',
    'throwaway.email',
    'temp-mail.org',
    'yopmail.com',
    'maildrop.cc',
    'getnada.com',
  ];

  return disposableDomains.any((d) => domain.endsWith(d));
}

/// Валидация имени
String? validateName(String? value) {
  if (value == null || value.isEmpty) return 'Required';
  
  final trimmed = value.trim();
  
  if (trimmed.length < 2) return 'Name is too short';
  if (trimmed.length > 50) return 'Name is too long';

  // Проверка на недопустимые символы (латиница, кириллица, дефис, пробел)
  final nameRegex = RegExp(r'^[a-zA-Zа-яА-ЯёЁәіңғүұқөһӘІҢҒҮҰҚӨҺ\s\-]+$');
  if (!nameRegex.hasMatch(trimmed)) {
    return 'Name contains invalid characters';
  }

  return null;
}

/// Валидация фамилии (аналогично имени)
String? validateSurname(String? value) {
  if (value == null || value.isEmpty) return 'Required';
  
  final trimmed = value.trim();
  
  if (trimmed.length < 2) return 'Surname is too short';
  if (trimmed.length > 50) return 'Surname is too long';

  final surnameRegex = RegExp(r'^[a-zA-Zа-яА-ЯёЁәіңғүұқөһӘІҢҒҮҰҚӨҺ\s\-]+$');
  if (!surnameRegex.hasMatch(trimmed)) {
    return 'Surname contains invalid characters';
  }

  return null;
}

/// Валидация пароля
String? validatePassword(String? value) {
  if (value == null || value.isEmpty) return 'Required';
  if (value.length < 6) return 'Minimum 6 characters';
  return null;
}