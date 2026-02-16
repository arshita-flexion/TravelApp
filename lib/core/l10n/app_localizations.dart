import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

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
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @lbl_emptyVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter verification code'**
  String get lbl_emptyVerificationCode;

  /// No description provided for @lbl_emptyPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter phone number'**
  String get lbl_emptyPhoneNumber;

  /// No description provided for @lbl_invalidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid Phone Number'**
  String get lbl_invalidPhoneNumber;

  /// No description provided for @lbl_emptyName.
  ///
  /// In en, this message translates to:
  /// **'Name should not be empty'**
  String get lbl_emptyName;

  /// No description provided for @lbl_emptyPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter password'**
  String get lbl_emptyPassword;

  /// No description provided for @lbl_emptyConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter confirm password'**
  String get lbl_emptyConfirmPassword;

  /// No description provided for @lbl_passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get lbl_passwordMismatch;

  /// No description provided for @lbl_invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter an valid email address'**
  String get lbl_invalidEmail;

  /// No description provided for @lbl_emptyEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter an email address'**
  String get lbl_emptyEmail;

  /// No description provided for @lbl_onboard_title_1.
  ///
  /// In en, this message translates to:
  /// **'SMARTER TRACKING FOR A HEALTHIER YOU'**
  String get lbl_onboard_title_1;

  /// No description provided for @lbl_onboard_desc_1.
  ///
  /// In en, this message translates to:
  /// **'Log meals instantly, stay motivated and move closer to your fitness goals every day.'**
  String get lbl_onboard_desc_1;

  /// No description provided for @lbl_onboard_title_2.
  ///
  /// In en, this message translates to:
  /// **'AI THAT UNDERSTANDS YOUR FOOD'**
  String get lbl_onboard_title_2;

  /// No description provided for @lbl_onboard_desc_2.
  ///
  /// In en, this message translates to:
  /// **'Scan meals in seconds and get accurate calorie and nutrition details effortlessly.'**
  String get lbl_onboard_desc_2;

  /// No description provided for @lbl_onboard_title_3.
  ///
  /// In en, this message translates to:
  /// **'START TODAY, TRANSFORM YOUR ROUTINE'**
  String get lbl_onboard_title_3;

  /// No description provided for @lbl_onboard_desc_3.
  ///
  /// In en, this message translates to:
  /// **'Build healthy habits with guided tracking, insights and personalized daily nutrition tips.'**
  String get lbl_onboard_desc_3;

  /// No description provided for @lbl_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get lbl_skip;

  /// No description provided for @lbl_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get lbl_next;

  /// No description provided for @lbl_login.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get lbl_login;

  /// No description provided for @lbl_welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back - enter your details to continue.'**
  String get lbl_welcomeBack;

  /// No description provided for @lbl_emailId.
  ///
  /// In en, this message translates to:
  /// **'Email Id'**
  String get lbl_emailId;

  /// No description provided for @lbl_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get lbl_password;

  /// No description provided for @lbl_forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get lbl_forgotPassword;

  /// No description provided for @lbl_dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get lbl_dontHaveAccount;

  /// No description provided for @lbl_signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get lbl_signUp;

  /// No description provided for @lbl_or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get lbl_or;

  /// No description provided for @lbl_google.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get lbl_google;

  /// No description provided for @lbl_apple.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get lbl_apple;

  /// No description provided for @lbl_createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get lbl_createAccount;

  /// No description provided for @lbl_createAccountDesc.
  ///
  /// In en, this message translates to:
  /// **'You\'re new here - let\'s create your account.'**
  String get lbl_createAccountDesc;

  /// No description provided for @lbl_fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get lbl_fullName;

  /// No description provided for @lbl_confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get lbl_confirmPassword;

  /// No description provided for @lbl_alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get lbl_alreadyHaveAccount;

  /// No description provided for @lbl_logIn.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get lbl_logIn;

  /// No description provided for @lbl_forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get lbl_forgotPasswordTitle;

  /// No description provided for @lbl_forgotPasswordDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to receive reset instructions.'**
  String get lbl_forgotPasswordDesc;

  /// No description provided for @lbl_submitNow.
  ///
  /// In en, this message translates to:
  /// **'Submit Now'**
  String get lbl_submitNow;

  /// No description provided for @lbl_backTo.
  ///
  /// In en, this message translates to:
  /// **'Back to'**
  String get lbl_backTo;

  /// No description provided for @lbl_verifyCode.
  ///
  /// In en, this message translates to:
  /// **'Verify Code'**
  String get lbl_verifyCode;

  /// No description provided for @lbl_verifyCodeDesc.
  ///
  /// In en, this message translates to:
  /// **'Please enter the code we just sent to your email'**
  String get lbl_verifyCodeDesc;

  /// No description provided for @lbl_verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get lbl_verify;

  /// No description provided for @lbl_dontReceiveOTP.
  ///
  /// In en, this message translates to:
  /// **'Don\'t receive OTP?'**
  String get lbl_dontReceiveOTP;

  /// No description provided for @lbl_resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get lbl_resendCode;

  /// No description provided for @lbl_verifyYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Verify Your Email'**
  String get lbl_verifyYourEmail;

  /// No description provided for @lbl_verifyEmailDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter the 4 digit verification code.'**
  String get lbl_verifyEmailDesc;

  /// No description provided for @lbl_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get lbl_continue;

  /// No description provided for @lbl_didntReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t you receive any code?'**
  String get lbl_didntReceiveCode;

  /// No description provided for @lbl_resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get lbl_resetPassword;

  /// No description provided for @lbl_resetPasswordDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter the 4 digit verification code.'**
  String get lbl_resetPasswordDesc;

  /// No description provided for @lbl_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get lbl_cancel;

  /// No description provided for @lbl_basicPersonalDetails.
  ///
  /// In en, this message translates to:
  /// **'Basic Personal Details'**
  String get lbl_basicPersonalDetails;

  /// No description provided for @lbl_basicPersonalDetailsDesc.
  ///
  /// In en, this message translates to:
  /// **'This helps us calculate your personalized calorie goal.'**
  String get lbl_basicPersonalDetailsDesc;

  /// No description provided for @lbl_balancedAndClean.
  ///
  /// In en, this message translates to:
  /// **'Balanced & Clean'**
  String get lbl_balancedAndClean;

  /// No description provided for @lbl_balancedAndCleanDesc.
  ///
  /// In en, this message translates to:
  /// **'This helps us set accurate goals for your fitness journey.'**
  String get lbl_balancedAndCleanDesc;

  /// No description provided for @lbl_motivational.
  ///
  /// In en, this message translates to:
  /// **'Motivational'**
  String get lbl_motivational;

  /// No description provided for @lbl_motivationalDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter your height to unlock your personalized wellness journey.'**
  String get lbl_motivationalDesc;

  /// No description provided for @lbl_defineFitnessGoal.
  ///
  /// In en, this message translates to:
  /// **'Define Fitness Goal'**
  String get lbl_defineFitnessGoal;

  /// No description provided for @lbl_defineFitnessGoalDesc.
  ///
  /// In en, this message translates to:
  /// **'We will use this data to give you a better diet type for you.'**
  String get lbl_defineFitnessGoalDesc;

  /// No description provided for @lbl_chooseTransformationSpeed.
  ///
  /// In en, this message translates to:
  /// **'Change Speed'**
  String get lbl_chooseTransformationSpeed;

  /// No description provided for @lbl_chooseTransformationSpeedDesc.
  ///
  /// In en, this message translates to:
  /// **'Your choice sets calorie and macro targets you can adjust anytime.'**
  String get lbl_chooseTransformationSpeedDesc;

  /// No description provided for @lbl_workoutFrequency.
  ///
  /// In en, this message translates to:
  /// **'Workout Frequency'**
  String get lbl_workoutFrequency;

  /// No description provided for @lbl_workoutFrequencyDesc.
  ///
  /// In en, this message translates to:
  /// **'To personalize your plan, tell us how often you work out.'**
  String get lbl_workoutFrequencyDesc;

  /// No description provided for @lbl_selectTargetWeight.
  ///
  /// In en, this message translates to:
  /// **'Select Target Weight'**
  String get lbl_selectTargetWeight;

  /// No description provided for @lbl_selectTargetWeightDesc.
  ///
  /// In en, this message translates to:
  /// **'Choose target weight to personalize your calories and daily diet.'**
  String get lbl_selectTargetWeightDesc;

  /// No description provided for @lbl_personalNutritionalPlan.
  ///
  /// In en, this message translates to:
  /// **'Your Nutritional Plan'**
  String get lbl_personalNutritionalPlan;

  /// No description provided for @lbl_male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get lbl_male;

  /// No description provided for @lbl_female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get lbl_female;

  /// No description provided for @lbl_chooseYourGender.
  ///
  /// In en, this message translates to:
  /// **'Choose your gender'**
  String get lbl_chooseYourGender;

  /// No description provided for @lbl_chooseYourBirthday.
  ///
  /// In en, this message translates to:
  /// **'Choose your birthday'**
  String get lbl_chooseYourBirthday;

  /// No description provided for @lbl_dateFormat.
  ///
  /// In en, this message translates to:
  /// **'DD/MM/YYYY'**
  String get lbl_dateFormat;

  /// No description provided for @lbl_metric.
  ///
  /// In en, this message translates to:
  /// **'Metric'**
  String get lbl_metric;

  /// No description provided for @lbl_imperial.
  ///
  /// In en, this message translates to:
  /// **'Imperial'**
  String get lbl_imperial;

  /// No description provided for @lbl_kg.
  ///
  /// In en, this message translates to:
  /// **'KG'**
  String get lbl_kg;

  /// No description provided for @lbl_lbs.
  ///
  /// In en, this message translates to:
  /// **'LBS'**
  String get lbl_lbs;

  /// No description provided for @lbl_whatsYourCurrentWeight.
  ///
  /// In en, this message translates to:
  /// **'What\'s your current weight?'**
  String get lbl_whatsYourCurrentWeight;

  /// No description provided for @lbl_enterYourWeight.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Weight'**
  String get lbl_enterYourWeight;

  /// No description provided for @lbl_fastResults.
  ///
  /// In en, this message translates to:
  /// **'Fast Results'**
  String get lbl_fastResults;

  /// No description provided for @lbl_fastResultsDesc.
  ///
  /// In en, this message translates to:
  /// **'Aggressive targets for quicker, more demanding progress.'**
  String get lbl_fastResultsDesc;

  /// No description provided for @lbl_balancedConsistent.
  ///
  /// In en, this message translates to:
  /// **'Balanced & Consistent'**
  String get lbl_balancedConsistent;

  /// No description provided for @lbl_balancedConsistentDesc.
  ///
  /// In en, this message translates to:
  /// **'A sustainable, steady pace for long - term, consistent results.'**
  String get lbl_balancedConsistentDesc;

  /// No description provided for @lbl_flexibleLifestyle.
  ///
  /// In en, this message translates to:
  /// **'Flexible / Lifestyle'**
  String get lbl_flexibleLifestyle;

  /// No description provided for @lbl_flexibleLifestyleDesc.
  ///
  /// In en, this message translates to:
  /// **'A relaxed approach that easily integrates with your lifestyle.'**
  String get lbl_flexibleLifestyleDesc;

  /// No description provided for @lbl_loseWeight.
  ///
  /// In en, this message translates to:
  /// **'Lose weight'**
  String get lbl_loseWeight;

  /// No description provided for @lbl_gainWeight.
  ///
  /// In en, this message translates to:
  /// **'Gain weight'**
  String get lbl_gainWeight;

  /// No description provided for @lbl_toneUp.
  ///
  /// In en, this message translates to:
  /// **'Tone up'**
  String get lbl_toneUp;

  /// No description provided for @lbl_maintainWeight.
  ///
  /// In en, this message translates to:
  /// **'Maintain weight'**
  String get lbl_maintainWeight;

  /// No description provided for @lbl_whatsYourCurrentHeight.
  ///
  /// In en, this message translates to:
  /// **'What\'s your current height?'**
  String get lbl_whatsYourCurrentHeight;

  /// No description provided for @lbl_enterHeightMetric.
  ///
  /// In en, this message translates to:
  /// **'Enter Height (e.g., 170)'**
  String get lbl_enterHeightMetric;

  /// No description provided for @lbl_enterHeightImperial.
  ///
  /// In en, this message translates to:
  /// **'Enter Height (e.g., 6.6)'**
  String get lbl_enterHeightImperial;

  /// No description provided for @lbl_cm.
  ///
  /// In en, this message translates to:
  /// **'CM'**
  String get lbl_cm;

  /// No description provided for @lbl_ftIn.
  ///
  /// In en, this message translates to:
  /// **'FT/IN'**
  String get lbl_ftIn;

  /// No description provided for @lbl_dailyCalorie.
  ///
  /// In en, this message translates to:
  /// **'Daily Calorie'**
  String get lbl_dailyCalorie;

  /// No description provided for @lbl_kcal.
  ///
  /// In en, this message translates to:
  /// **'kcal'**
  String get lbl_kcal;

  /// No description provided for @lbl_macronutrientGoals.
  ///
  /// In en, this message translates to:
  /// **'Macronutrient Goals'**
  String get lbl_macronutrientGoals;

  /// No description provided for @lbl_protein.
  ///
  /// In en, this message translates to:
  /// **'Protein'**
  String get lbl_protein;

  /// No description provided for @lbl_carbs.
  ///
  /// In en, this message translates to:
  /// **'Carbs'**
  String get lbl_carbs;

  /// No description provided for @lbl_fat.
  ///
  /// In en, this message translates to:
  /// **'Fat'**
  String get lbl_fat;

  /// No description provided for @lbl_sampleMealPlan.
  ///
  /// In en, this message translates to:
  /// **'Sample Meal Plan'**
  String get lbl_sampleMealPlan;

  /// No description provided for @lbl_breakfast.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get lbl_breakfast;

  /// No description provided for @lbl_breakfastDesc.
  ///
  /// In en, this message translates to:
  /// **'Oatmeal with berries & nuts'**
  String get lbl_breakfastDesc;

  /// No description provided for @lbl_lunch.
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get lbl_lunch;

  /// No description provided for @lbl_lunchDesc.
  ///
  /// In en, this message translates to:
  /// **'Grilled chicken salad'**
  String get lbl_lunchDesc;

  /// No description provided for @lbl_dinner.
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get lbl_dinner;

  /// No description provided for @lbl_dinnerDesc.
  ///
  /// In en, this message translates to:
  /// **'Salmon with quinoa & asparagus'**
  String get lbl_dinnerDesc;

  /// No description provided for @lbl_snack.
  ///
  /// In en, this message translates to:
  /// **'Snack'**
  String get lbl_snack;

  /// No description provided for @lbl_snackDesc.
  ///
  /// In en, this message translates to:
  /// **'Greek yogurt'**
  String get lbl_snackDesc;

  /// No description provided for @lbl_hydrationGoal.
  ///
  /// In en, this message translates to:
  /// **'Hydration Goal'**
  String get lbl_hydrationGoal;

  /// No description provided for @lbl_dailyGoal.
  ///
  /// In en, this message translates to:
  /// **'Daily Goal'**
  String get lbl_dailyGoal;

  /// No description provided for @lbl_kgLowercase.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get lbl_kgLowercase;

  /// No description provided for @lbl_lbsLowercase.
  ///
  /// In en, this message translates to:
  /// **'lbs'**
  String get lbl_lbsLowercase;

  /// No description provided for @lbl_targetWeight.
  ///
  /// In en, this message translates to:
  /// **'Target Weight'**
  String get lbl_targetWeight;

  /// No description provided for @lbl_currentWeight.
  ///
  /// In en, this message translates to:
  /// **'Current Weight'**
  String get lbl_currentWeight;

  /// No description provided for @lbl_workout0to1Days.
  ///
  /// In en, this message translates to:
  /// **'0-1 days/week'**
  String get lbl_workout0to1Days;

  /// No description provided for @lbl_workout2to4Days.
  ///
  /// In en, this message translates to:
  /// **'2-4 days/week'**
  String get lbl_workout2to4Days;

  /// No description provided for @lbl_workout5PlusDays.
  ///
  /// In en, this message translates to:
  /// **'5+ days/week'**
  String get lbl_workout5PlusDays;

  /// No description provided for @lbl_personalNutritionalPlanDesc.
  ///
  /// In en, this message translates to:
  /// **'Smart recommendations to help you stay on track and reach your goals faster.'**
  String get lbl_personalNutritionalPlanDesc;

  /// No description provided for @lbl_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get lbl_home;

  /// No description provided for @lbl_countYourDailyCalories.
  ///
  /// In en, this message translates to:
  /// **'Count Your Daily Calories'**
  String get lbl_countYourDailyCalories;

  /// No description provided for @lbl_calories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get lbl_calories;

  /// No description provided for @lbl_todaysMeals.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Meals'**
  String get lbl_todaysMeals;
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
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
