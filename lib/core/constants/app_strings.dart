class AppStrings {
  const AppStrings._();

  static const common = CommonStrings();
  static const status = StatusStrings();
  static const auth = AuthStrings();
}

class CommonStrings {
  const CommonStrings();

  String get appName => 'InspirelyMD - Patient';
  String get loading => 'Loading...';
  String get cancel => 'Cancel';
  String get confirm => 'Confirm';
  String get done => 'Done';
  String get save => 'Save';
  String get edit => 'Edit';
  String get retry => 'Retry';
  String get searchPlaceholder => 'Search...';
  String get noResultsFound => 'No results found';
  String get copied => 'Copied to clipboard';
}

class StatusStrings {
  const StatusStrings();

  String get success => 'Success';
  String get error => 'Error';
  String get warning => 'Warning';
  String get info => 'Info';
}

class AuthStrings {
  const AuthStrings();

  String get welcomeTitle => 'Welcome to InspirelyMD';
  String get welcomeSubtitle => 'Sign in to manage your care, messages and prescriptions.';
  String get phoneInputLabel => 'Mobile Number';
  String get phoneInputHint => 'Enter mobile number';
  String get sendOtpButton => 'Send OTP';
  String get googleSignIn => 'Continue with Google';
  String get appleSignIn => 'Continue with Apple';
  String get orDivider => 'or';
  String get selectCountry => 'Select Country';
  String get searchCountry => 'Search country...';
}
