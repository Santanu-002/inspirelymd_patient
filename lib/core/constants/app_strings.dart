class AppStrings {
  const AppStrings._();

  static const common = CommonStrings();
  static const status = StatusStrings();
  static const auth = AuthStrings();
  static const dashboard = DashboardStrings();
  static const programs = ProgramsStrings();
  static const messages = MessagesStrings();
  static const pharmacy = PharmacyStrings();
  static const account = AccountStrings();
  static const notifications = NotificationsStrings();
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

  // Navigation tabs
  String get navHome => 'Home';
  String get navPrograms => 'Programs';
  String get navMessages => 'Messages';
  String get navPharmacy => 'Pharmacy';
  String get navAccount => 'Account';
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
  String get welcomeSubtitle =>
      'Sign in to manage your care, messages and prescriptions.';
  String get phoneInputLabel => 'Mobile Number';
  String get phoneInputHint => 'Enter mobile number';
  String get sendOtpButton => 'Send OTP';
  String get googleSignIn => 'Continue with Google';
  String get appleSignIn => 'Continue with Apple';
  String get orDivider => 'or';
  String get selectCountry => 'Select Country';
  String get searchCountry => 'Search country...';

  // OTP Verification
  String get verifyMobileTitle => 'Verify Mobile';
  String verifyMobileSubtitle(String phone) =>
      'Enter the 6-digit code sent to $phone';
  String get verifyAndProceed => 'Verify & Proceed';
  String get didNotReceiveCode => "Didn't receive the code? ";
  String get resendLimitReached => 'Resend limit reached';
  String get resend => 'Resend';
  String resendIn(int seconds) => 'Resend in ${seconds}s';
}

class DashboardStrings {
  const DashboardStrings();

  String get title => 'Patient Dashboard';
  String get welcomeBack => 'Good morning';
  String get localDbStatus => 'Local database: Offline & Secure';
  String get quickActions => 'Quick Actions';
  String get bookAppt => 'Book';
  String get bookApptSub => 'Appointment';
  String get recordVitals => 'Record';
  String get recordVitalsSub => 'Health Vitals';
  String get latestVitals => 'Latest Vitals';
  String get noVitals => 'No vitals recorded yet.';
  String get heartRate => 'Heart Rate';
  String get bloodPressure => 'Blood Pressure';
  String get bodyTemp => 'Body Temp';
  String get weight => 'Weight';
  String get upcomingAppts => 'Upcoming Appointments';
  String get noUpcomingAppts => 'No upcoming appointments.';
  String get bookNow => 'Book Appointment Now';
  String get activePrescriptions => 'Active Prescriptions';
  String get noPrescriptions => 'No prescriptions found.';
  String get prescribedBy => 'Prescribed by';
  String get on => 'on';
  String get signOut => 'Signed out successfully.';

  // Bottom sheets
  String get bookApptTitle => 'Book Appointment';
  String get recordVitalsTitle => 'Record Health Vitals';
  String get doctorNameLabel => 'Doctor Name*';
  String get doctorNameHint => 'e.g. Dr. Robert Carter';
  String get specialtyLabel => 'Specialty*';
  String get specialtyHint => 'e.g. Neurologist';
  String get dateLabel => 'Date*';
  String get timeLabel => 'Time*';
  String get confirmBookingButton => 'Confirm Booking';
  String get heartRateInputLabel => 'Heart Rate (bpm)*';
  String get heartRateInputHint => 'e.g. 72';
  String get bpInputLabel => 'Blood Pressure*';
  String get bpInputHint => 'e.g. 120/80';
  String get tempInputLabel => 'Temperature (°F)*';
  String get tempInputHint => 'e.g. 98.6';
  String get weightInputLabel => 'Weight (lbs)*';
  String get weightInputHint => 'e.g. 150.2';
  String get saveVitalsButton => 'Save Vitals';
  String get fillRequiredFields => 'Please fill in all required fields.';
  String get enterValidVitals => 'Please enter valid vital measurements.';
  String get apptBookedSuccess => 'Appointment booked successfully!';
  String get vitalsRecordedSuccess => 'Vitals recorded successfully!';
}

class ProgramsStrings {
  const ProgramsStrings();

  String get sectionTitle => 'YOUR PROGRAM';
  String get programTitle => 'GLP-1 Weight Loss';
  String get programName => 'GLP-1 Weight Loss';
  String get assignedProvider => 'Dr. Alana Reyes';
  String get assignedProviderSub => 'Internal Medicine · Lic. TX';
  String get weightProgress => 'Weight progress';
  String get week4Tag => 'Week 4';
  String get startWeight => 'Start 212';
  String get goalWeight => 'Goal 180';
  String get planTitle => 'This week\'s plan';
  String get taskDose => 'Take your weekly dose';
  String get taskDoseSub => 'Due Sunday · 0.5mg';
  String get taskWeight => 'Log your weight';
  String get taskWeightSub => 'Weekly check-in';
  String get taskLesson => 'Week 2 lesson: managing nausea';
  String get taskLessonSub => '3 min read';
  String get taskHydration => 'Hydration goal';
  String get taskHydrationSub => '64 oz daily';
  String get careTeamTag => 'Care team';
  String drAlanaReyes(String name) => name;
  String get drSpecialty => 'Internal Medicine · Lic. TX';
}

class MessagesStrings {
  const MessagesStrings();

  String get encryptedNotice =>
      '🔒 Encrypted · messages go to your InspirelyMD care team';
  String get inputHint => 'Message your provider...';
  String get initialMsg =>
      'Hi Jordan — I reviewed your week-2 check-in. Your progress looks great. I\'m bumping you to 0.5mg this week.';
  String get sentMsg => 'Thank you! Any tips for the nausea?';
  String get replyMsg =>
      'Eat smaller meals and stay hydrated. It usually settles within a few days of a dose change. I\'ll check in next week.';
  String get videoCallConnecting => 'Telehealth video · connecting...';
  String get videoCallDoctorName => 'Dr. Alana Reyes, MD';
  String get videoCallAvatarInitials => 'AR';
  String get videoCallCallEnded => 'Telehealth video call ended';
  String get videoCallToggleCamera => 'Toggle camera';
  String get videoCallToggleMute => 'Toggle mute';
}

class PharmacyStrings {
  const PharmacyStrings();

  String get headerTitle => 'PHARMACY & RECORDS';
  String get rxManagementSubtitle => 'PHARMACY & RECORDS';
  String get ordersTitle => 'Your orders';
  String get orderId => 'Order INSP-7841';
  String get inTransit => 'In transit';
  String get planApproved => 'Plan approved';
  String get planApprovedSub => 'Dr. Reyes · Jun 2';
  String get paymentCharged => 'Payment charged';
  String get paymentChargedSub => '\$299 · Jun 2';
  String get sentToPharmacy => 'Sent to pharmacy';
  String get sentToPharmacySub => 'Hallandale 503A, FL';
  String get preparedFilled => 'Prepared & filled';
  String get preparedFilledSub => 'Quality checked';
  String get shipped => 'Shipped';
  String get shippedSub => 'FedEx · arrives Jun 12';
  String get reorderButton => 'Reorder / request refill';

  String get documentVault => 'Document vault';
  String get documentCount => '4 files';
  String get semaglutideRx => 'Semaglutide Prescription';
  String get semaglutideRxSub => 'Rx · Jun 2, 2026 · PDF';
  String get visitSummary => 'Visit Summary — Week 2';
  String get visitSummarySub => 'Note · Jun 2 · PDF';
  String get hormonePanel => 'Hormone Panel Results';
  String get hormonePanelSub => 'Lab · May 20 · PDF';
  String get signedConsents => 'Signed Consents (×3)';
  String get signedConsentsSub => 'HIPAA · Telehealth · Treatment';

  String get recommendedTitle => 'Recommended for you';
  String get tirzepatide => 'Tirzepatide';
  String get tirzepatideSub => 'Upgrade your GLP-1 · from \$449/mo';
  String get nauseaKit => 'Nausea Relief Kit';
  String get nauseaKitSub => 'Add-on · from \$29/mo';
  String get longevityPeptides => 'Longevity Peptides';
  String get longevityPeptidesSub => 'New program · from \$159/mo';
  String get addButton => 'Add';

  // Request Refill Screen
  String get requestRefillTitle => 'Request refill';
  String get semaglutideMedication => 'Semaglutide';
  String get semaglutideDosageAndPrice => '0.5 mg / week · \$299/mo';
  String get refillNotice =>
      'We\'ll send a quick refill visit to your provider for clinical review. You\'re only charged once they approve.';
  String get confirmRefillRequest => 'Confirm refill request';
  String get refillRequestSuccess =>
      'Refill request sent for clinical review.';
}

class AccountStrings {
  const AccountStrings();

  String get title => 'Account';
  String get email => 'jordan@email.com';
  String get memberTag => 'us Texas · Member since 2026';
  String get personalProfile => 'Personal & medical profile';
  String get personalProfileSub => 'Jordan Avery · 34 · TX';
  String get paymentBilling => 'Payment & billing';
  String get paymentBillingSub => 'Visa ···· 4242 · USD';
  String get subscriptions => 'Subscriptions';
  String get subscriptionsSub => 'Semaglutide · \$299/mo';
  String get medicalRecords => 'Medical records';
  String get medicalRecordsSub => 'Intake, visits & Rx';
  String get consents => 'Consents on file';
  String get consentsSub => 'HIPAA · Telehealth · Treatment';
  String get notifications => 'Notifications';
  String get notificationsSub => 'Push · SMS · Email';
  String get helpSupport => 'Help & support';
  String get helpSupportSub => 'Chat, FAQ, tickets';
  String get signOut => 'Sign out';
  String get footerPhysician => 'InspirelyMD · Physician-guided care';
  String get footerLicensed => 'Licensed providers · Compounded in USA';
}

class NotificationsStrings {
  const NotificationsStrings();

  String get title => 'Notifications';
  String get timeForDose => 'Time for your dose';
  String get timeForDoseSub => 'Take your 0.5mg Semaglutide today';
  String get orderShipped => 'Your order shipped';
  String get orderShippedSub => 'FedEx · arrives Jun 12';
  String get drReyesReplied => 'Dr. Reyes replied';
  String get drReyesRepliedSub => 'Eat smaller meals and stay hydrated...';
  String get lessonUnlocked => 'New lesson unlocked';
  String get lessonUnlockedSub => 'Week 4: Building lasting habits';
}
