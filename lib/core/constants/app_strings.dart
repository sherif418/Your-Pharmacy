// app_strings.dart
// Responsible for: holding ALL text strings used across the app.
// Rule: Never write a string directly in a screen or widget — always use this file.

class AppStrings {
  // ── App General ──────────────────────────────────────────
  static const String appName = 'صيدليتك';
  static const String appTagline = 'دواؤك يوصلك لباب بيتك';

  // ── Splash ───────────────────────────────────────────────
  static const String splashLoading = 'جاري التحميل...';
  static const String splashVerifying = 'جاري التحقق...';
  static const String splashLoadingData = 'جاري تحميل البيانات...';
  static const String splashWelcome = 'أهلاً بك...';

  // ── Auth – Login ─────────────────────────────────────────
  static const String loginTitle = 'تسجيل الدخول';
  static const String loginWelcomeBack = 'أهلاً بعودتك';
  static const String loginSubtitle = 'سجّل الدخول لمتابعة استخدام التطبيق';
  static const String loginClientTitle = 'تسجيل دخول العميل';
  static const String loginPharmacistTitle = 'تسجيل دخول الصيدلي';
  static const String loginEmailHint = 'البريد الإلكتروني';
  static const String loginPasswordHint = 'كلمة المرور';
  static const String loginButton = 'تسجيل الدخول';
  static const String loginNoAccount = 'ليس لديك حساب؟ ';
  static const String loginRegisterLink = 'سجّل الآن';
  static const String loginForgotPassword = 'نسيت كلمة المرور؟';
  static const String loginOr = 'أو';
  static const String loginCreateAccount = 'إنشاء حساب جديد';
  static const String loginEnterCredentials = 'أدخل البريد والكلمة';
  static const String loginResendVerification = 'إعادة إرسال';
  static const String loginResendSuccess = 'تم إعادة إرسال بريد التحقق بنجاح';

  // ── Auth – Pharmacist Notice ──────────────────────────────
  /// Notice shown on the pharmacist login form confirming admin-only account creation
  /// for the single pharmacy — no self-registration possible.
  static const String pharmacistLoginNotice =
      'لا يوجد تسجيل حساب جديد للصيدلي، يتم إنشاء البريد الإلكتروني بواسطة مدير النظام.';

  // ── Auth – Register ──────────────────────────────────────
  static const String registerTitle = 'إنشاء حساب جديد';
  static const String registerNameHint = 'الاسم الكامل';
  static const String registerEmailHint = 'البريد الإلكتروني';
  static const String registerPhoneHint = 'رقم الهاتف';
  static const String registerPasswordHint = 'كلمة المرور';
  static const String registerConfirmPasswordHint = 'تأكيد كلمة المرور';
  static const String registerAccountTypeHint = 'نوع الحساب';
  static const String registerAccountTypeCustomer = 'عميل';
  static const String registerAccountTypePharmacist = 'صيدلي';
  static const String registerButton = 'إنشاء الحساب';
  static const String registerHaveAccount = 'لديك حساب بالفعل؟';
  static const String registerLoginLink = 'تسجيل الدخول';
  static const String registerSuccessTitle = 'تم التسجيل بنجاح!';
  static const String registerSuccessBody =
      'يمكنك الآن تسجيل الدخول بحسابك الجديد.';
  static const String registerVillageHint = 'اختر قريتك';
  static const String registerVillageLabel = 'القرية';
  static const String registerPersonalInfoTitle = 'البيانات الشخصية';
  static const String registerAccountInfoTitle = 'بيانات الحساب';
  static const String registerNameLabel = 'الاسم بالكامل';
  static const String registerPhoneLabel = 'رقم الهاتف';
  static const String registerEmailLabel = 'البريد الإلكتروني';
  static const String registerPasswordLabel = 'كلمة المرور';
  static const String registerConfirmPasswordLabel = 'تأكيد كلمة المرور';
  static const String registerPasswordHint8Chars = '8 أحرف على الأقل';
  static const String registerSelectVillage = 'من فضلك اختر قريتك';
  static const String registerWelcome = 'أهلاً بك! سجّل بياناتك للبدء';

  // ── Auth – Email Verification ─────────────────────────────
  static const String emailVerificationTitle = 'تحقق من بريدك الإلكتروني';
  static const String emailVerificationBody =
      'تم إرسال رابط التحقق إلى بريدك الإلكتروني. افتح بريدك واضغط على الرابط ثم عد هنا.';
  static const String emailVerificationButton = 'تحققت ✓';
  static const String emailVerificationResend = 'إعادة إرسال البريد';
  static const String emailVerificationNotVerified =
      'لم يتم التحقق بعد، تحقق من بريدك أولاً';
  static const String emailVerificationResendSuccess =
      'تم إعادة إرسال بريد التحقق بنجاح';
  static const String emailVerificationOpenApp = 'افتح تطبيق البريد';
  static const String errorEmailNotVerified =
      'يرجى تأكيد بريدك الإلكتروني أولاً';
  static const String emailVerificationChecking = 'جاري التحقق...';
  static const String emailVerificationStep1 = 'افتح تطبيق البريد الإلكتروني';
  static const String emailVerificationStep2 = 'ابحث عن بريد من "صيدليتك"';
  static const String emailVerificationStep3 = 'اضغط على رابط التحقق في البريد';
  static const String emailVerificationStep4 = 'عد هنا واضغط "تحققت ✓"';
  static const String emailVerificationOpenMailFailed =
      'تعذر فتح تطبيق البريد الإلكتروني. حاول لاحقاً.';

  // ── Home ─────────────────────────────────────────────────
  static const String homeWelcome = 'مرحباً،';
  static const String homeOrderMedicine = 'طلب دواء';
  static const String homeUploadPrescription = 'رفع روشتة';
  static const String homeMyOrders = 'طلباتي';
  static const String homeChronicMeds = 'أدويتي المزمنة';
  static const String homeQuickServices = 'خدمات سريعة';
  static const String homeServices = 'الخدمات';
  static const String homeProductCategories = 'تصنيفات المنتجات';
  static const String homeBestSellers = 'الأكثر طلباً';
  static const String homeViewAll = 'عرض الكل';
  static const String homePrescriptionPrompt = 'لديك روشتة؟';
  static const String homePrescriptionDescription =
      'ارفع صورة الروشتة وسنقوم بتحضير طلبك';
  static const String homeUploadNow = 'رفع الآن';
  static const String homeHealthAssistantTitle = 'مساعدك الصحي';
  static const String homeHealthAssistantPrompt = 'هل تناولت جرعة الصباح؟';
  static const String homeTalkToAssistant = 'تحدث مع المساعد';
  static const String homeWaterTrackerTitle = 'شرب الماء';
  static const String homeWaterCupCount = 'أكواب';
  static const String homeLogWaterCup = 'سجل كوب ماء';
  static const String homeTipOfTheDayTitle = 'نصيحة اليوم';
  static const String homeShowMore = 'عرض المزيد';
  static const String homeReminderEnabled = 'تذكير مفعل';
  static const String homeManageReminders = 'إدارة التذكيرات';
  static const String homeChronicDiseaseTitle = 'متابعة الأمراض المزمنة';
  static const String homeHealthSummaryTitle = 'ملخص حالتك الصحية';
  static const String homeTodayScheduleTitle = 'جدول أدوية اليوم';
  static const String homeComingSoon = 'قريباً...';
  static const String profile = 'الملف الشخصي';
  static const String settings = 'الإعدادات';

  /// Quick-service button label that shows the single pharmacy's location/address.
  /// Replaces the old "أقرب صيدلية" label which incorrectly implied multiple branches.
  static const String homePharmacyLocation = 'موقع الصيدلية';

  // ── Orders ───────────────────────────────────────────────
  static const String ordersTitle = 'طلباتي';
  static const String orderDetailTitle = 'تفاصيل الطلب';
  static const String orderMedicineTitle = 'طلب دواء';
  static const String uploadPrescriptionTitle = 'رفع روشتة';
  static const String orderStatusPending = 'قيد الانتظار';
  static const String orderStatusPreparing = 'جاري التحضير';
  static const String orderStatusReady = 'جاهز للتسليم';
  static const String orderStatusDelivered = 'تم التسليم';
  static const String orderStatusCancelled = 'ملغي';
  static const String orderPlaceButton = 'إرسال الطلب';
  static const String orderEmptyMessage = 'لا توجد طلبات بعد';

  // ── Chronic Meds ─────────────────────────────────────────
  static const String chronicMedsTitle = 'أدويتي المزمنة';
  static const String addChronicMedTitle = 'إضافة دواء مزمن';
  static const String chronicMedNameHint = 'اسم الدواء';
  static const String chronicMedDoseHint = 'الجرعة';
  static const String addMedButton = 'إضافة الدواء';
  static const String chronicMedsEmpty = 'لا توجد أدوية مزمنة مسجّلة';

  // ── Pharmacist ───────────────────────────────────────────
  static const String pharmacistDashboardTitle = 'لوحة التحكم';
  static const String pharmacistNewOrders = 'الطلبات الجديدة';
  static const String pharmacistPrepareOrder = 'تحضير الطلب';
  static const String pharmacistCustomers = 'العملاء';
  static const String pharmacistTotalOrders = 'إجمالي الطلبات';
  static const String pharmacistPendingOrders = 'طلبات قيد الانتظار';

  // ── Notifications ─────────────────────────────────────────
  static const String notificationsTitle = 'الإشعارات';
  static const String notificationsSubtitle = 'سنخبرك بكل ما يهم صحتك';

  // ── General Errors & Feedback ────────────────────────────
  static const String errorGeneral = 'حدث خطأ، حاول مرة أخرى';
  static const String errorInvalidEmail = 'البريد الإلكتروني غير صحيح';
  static const String errorWeakPassword =
      'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
  static const String errorPasswordMismatch = 'كلمتا المرور غير متطابقتين';
  static const String errorEmptyField = 'هذا الحقل مطلوب';
  static const String errorShortName = 'الاسم يجب أن يكون 3 أحرف على الأقل';
  static const String errorInvalidPhone =
      'رقم الهاتف يجب أن يكون 11 رقمًا ويبدأ بـ 01';
  static const String errorSelectAccountType = 'من فضلك اختر نوع الحساب';
  static const String errorLoginFailed = 'فشل تسجيل الدخول، تحقق من البيانات';
  static const String successOrderPlaced = 'تم إرسال طلبك بنجاح';
  static const String errorNetworkRequestFailed =
      'فشل الاتصال بالشبكة، يرجى التحقق من الاتصال بالإنترنت';
  static const String errorEmailAlreadyInUse =
      'هذا البريد الإلكتروني مسجل بالفعل لمستخدم آخر';
  static const String errorUserNotFound =
      'لم يتم العثور على حساب مسجل بهذه البيانات';
  static const String errorWrongPassword = 'كلمة المرور غير صحيحة';
  static const String errorAccountNotFound =
      'الحساب غير موجود في قاعدة البيانات، يرجى إنشاء حساب أولاً';
  static const String errorTooManyRequests =
      'لقد تم إرسال الكثير من الطلبات، يرجى المحاولة لاحقاً بعد قليل';
  static const String errorTooManyRequestsBlock =
      'تم حظر هذا الجهاز مؤقتاً بسبب كثرة محاولات الدخول الخاطئة';

  // ── Home ─────────────────────────────────────────────────
  static const String logout = 'تسجيل الخروج';
  static const String homeGreeting = 'أهلاً،';
  static const String homeRoleCustomer = 'عميل';
  static const String homeRolePharmacist = 'صيدلي';
  static const String homeMessagesTitle = 'الرسائل والتنبيهات';
  static const String clientMessage1 = 'لديك طلب جاهز للتوصيل أو الاستلام.';
  static const String clientMessage2 =
      'تذكير: موعد تناول جرعة الدواء المزمن يقترب.';
  static const String pharmacistMessage1 =
      'تنبيه: هناك طلبات جديدة تحتاج إلى مراجعة وتحضير.';
  static const String pharmacistMessage2 =
      'تحديث المخزون: يرجى التحقق من نواقص الأدوية الأكثر طلباً.';
}
