// app_strings.dart
// Responsible for: holding ALL text strings used across the app.
// Rule: Never write a string directly in a screen or widget — always use this file.

class AppStrings {
  // ── App General ──────────────────────────────────────────
  static const String appName = 'صيدليتك';
  static const String appTagline = 'دواؤك يوصلك لباب بيتك';

  // ── Splash ───────────────────────────────────────────────
  static const String splashLoading = 'جاري التحميل...';

  // ── Auth – Login ─────────────────────────────────────────
  static const String loginTitle = 'تسجيل الدخول';
  static const String loginEmailHint = 'البريد الإلكتروني';
  static const String loginPasswordHint = 'كلمة المرور';
  static const String loginButton = 'دخول';
  static const String loginNoAccount = 'ليس لديك حساب؟';
  static const String loginRegisterLink = 'سجّل الآن';
  static const String loginForgotPassword = 'نسيت كلمة المرور؟';

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
  static const String registerSuccessBody = 'يمكنك الآن تسجيل الدخول بحسابك الجديد.';

  // ── Home ─────────────────────────────────────────────────
  static const String homeWelcome = 'مرحباً،';
  static const String homeOrderMedicine = 'طلب دواء';
  static const String homeUploadPrescription = 'رفع روشتة';
  static const String homeMyOrders = 'طلباتي';
  static const String homeChronicMeds = 'أدويتي المزمنة';

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

  // ── General Errors & Feedback ────────────────────────────
  static const String errorGeneral = 'حدث خطأ، حاول مرة أخرى';
  static const String errorInvalidEmail = 'البريد الإلكتروني غير صحيح';
  static const String errorWeakPassword = 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
  static const String errorPasswordMismatch = 'كلمتا المرور غير متطابقتين';
  static const String errorEmptyField = 'هذا الحقل مطلوب';
  static const String errorShortName = 'الاسم يجب أن يكون 3 أحرف على الأقل';
  static const String errorInvalidPhone = 'رقم الهاتف يجب أن يكون 11 رقمًا ويبدأ بـ 01';
  static const String errorSelectAccountType = 'من فضلك اختر نوع الحساب';
  static const String errorLoginFailed = 'فشل تسجيل الدخول، تحقق من البيانات';
  static const String successOrderPlaced = 'تم إرسال طلبك بنجاح';

  // ── Home ─────────────────────────────────────────────────
  static const String logout = 'تسجيل الخروج';
  static const String homeGreeting = 'أهلاً،';
  static const String homeRoleCustomer = 'عميل';
  static const String homeRolePharmacist = 'صيدلي';
}

