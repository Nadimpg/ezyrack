import 'package:ezyrack/view/screen/web_view/web_view_screen.dart';
import 'package:get/get.dart';
import 'package:ezyrack/view/screen/Authentication/authentication_screen.dart';
import 'package:ezyrack/view/screen/about_us/about_us_screen.dart';
import 'package:ezyrack/view/screen/box_details/box_details_screen.dart';
import 'package:ezyrack/view/screen/create_box/create_box_screen.dart';
import 'package:ezyrack/view/screen/edit_box/edit_box_screen.dart';
import 'package:ezyrack/view/screen/edit_profile/edit_profile_screen.dart';
import 'package:ezyrack/view/screen/email_verification/email_verification_screen.dart';
import 'package:ezyrack/view/screen/generate_qr_code/generate_qr_code_screen.dart';
import 'package:ezyrack/view/screen/product_review/ezyrack_product_review/ezyrack_product_review_screen.dart';
import 'package:ezyrack/view/screen/product_review/product_list/products_list_screen.dart';
import 'package:ezyrack/view/screen/forget_password/forget_password_screen.dart';
import 'package:ezyrack/view/screen/greeting/greeting_screen.dart';
import 'package:ezyrack/view/screen/home/home_screen.dart';
import 'package:ezyrack/view/screen/password_change/password_change_screen.dart';
import 'package:ezyrack/view/screen/privacy_policy/privacy_policy_screen.dart';
import 'package:ezyrack/view/screen/profile/profile_screen.dart';
import 'package:ezyrack/view/screen/profile_details/profile_details_screen.dart';
import 'package:ezyrack/view/screen/qr_scan/qr_scan_screen.dart';
import 'package:ezyrack/view/screen/reset_password/reset_password_screen.dart';
import 'package:ezyrack/view/screen/settings/settings_screen.dart';
import 'package:ezyrack/view/screen/splash/splash_screen.dart';
import 'package:ezyrack/view/screen/terms_of_service/terms_of_service_screen.dart';

class AppRoute{

  static const String splashScreen = "/splash_screen";
  static const String authenticationScreen = "/authentication_screen";
  static const String forgetPasswordScreen = "/forget_password_screen";
  static const String emailVerificationScreen = "/email_verification_screen";
  static const String resetPasswordScreen = "/new_password_screen";
  static const String successful = "/successful_screen";
  static const String homeScreen = "/home_screen";
  static const String qrScanScreen = "/qr_scan_screen";
  static const String createBoxScreen = "/create_box_screen";
  static const String boxDetailsScreen = "/box_details_screen";

  static const String profileScreen = "/profile_screen";
  static const String profileDetailsScreen = "/update_profile_details_screen";
  static const String editProfileScreen = "/edit_profile_screen";
  static const String aboutUsScreen = "/about_us_screen";

  static const String settingScreen = "/setting_screen";
  static const String privacyPolicyScreen = "/privacy_policy_screen";
  static const String passwordChangeScreen = "/password_change_screen";
  static const String deleteAccountScreen = "/delete_account";

  static const String productListScreen = "/product_list_screen";
  static const String ezyRackProductReviewScreen = "/ezy_rack_product_review_screen";

  static const String noDataFound = "/no_data_found_screen";
  static const String errorScreen = "/error_screen";
  static const String noInternetScreen = "/no_internet_screen";
  static const String greetingScreen = "/greeting_screen";
  static const String termsOfServiceScreen = "/terms_of_service_screen";
  static const String editBoxScreen = "/edit_box_screen";

  static const String generateQrCodeScreen = "/generate_qr_code_screen";
  static const String webViewScreen = "/generate_qr_code_screen";

  static List<GetPage> routes = [

    GetPage(name: splashScreen, page: () => const SplashScreen()),

    GetPage(name: authenticationScreen, page: () =>  const AuthenticationScreen()),
    GetPage(name: forgetPasswordScreen, page: () => const ForgetPasswordScreen()),
    GetPage(name: emailVerificationScreen, page: () => const VerificationCode()),
    GetPage(name: resetPasswordScreen, page: () => const ResetPasswordScreen()),

    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: boxDetailsScreen, page: () => const BoxDetailsScreen()),
    GetPage(name: qrScanScreen, page: () => const QrScanScreen()),
    GetPage(name: createBoxScreen, page: () => const CreateBoxScreen()),

    GetPage(name: profileScreen, page: () => const ProfileScreen()),
    GetPage(name: profileDetailsScreen, page: () => const ProfileDetailsScreen()),
    GetPage(name: editProfileScreen, page: () => const EditProfileScreen()),
    GetPage(name: aboutUsScreen, page: () => const AboutUsScreen()),

    GetPage(name: settingScreen, page: () => const SettingsScreen()),
    GetPage(name: privacyPolicyScreen, page: () => const PrivacyPolicyScreen()),
    GetPage(name: passwordChangeScreen, page: () => const PasswordChangeScreen()),

    GetPage(name: generateQrCodeScreen, page: () => const GenerateQRCodeScreen()),

    GetPage(name: productListScreen, page: () => const ProductListScreen()),
    GetPage(name: ezyRackProductReviewScreen, page: () => const EzyRackProductReviewScreen()),
    GetPage(name: greetingScreen, page: () => const GreetingScreen()),
    GetPage(name: termsOfServiceScreen, page: () => const TermsOfServiceScreen()),
    GetPage(name: editBoxScreen, page: () => const EditBoxScreen()),

    GetPage(name: webViewScreen, page: () => const WebViewScreen()),
  ];
}
