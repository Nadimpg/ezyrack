import 'package:ezyrack/view/screen/authentication/authentication_controller.dart';
import 'package:ezyrack/view/screen/box_details/box_details_controller/box_details_controller.dart';
import 'package:ezyrack/view/screen/create_box/create_box_controller/create_box_controller.dart';
import 'package:ezyrack/view/screen/edit_box/edit_box_controller/edit_box_controller.dart';
import 'package:ezyrack/view/screen/forget_password/forget_password_controller/forget_password_controller.dart';
import 'package:ezyrack/view/screen/home/home_controller/home_controller.dart';
import 'package:ezyrack/view/screen/profile/profile_controller/profile_controller.dart';
import 'package:get/get.dart';

Future<void> initDependency() async {

  Get.lazyPut(() => AuthenticationController(), fenix: true);
  Get.lazyPut(() => ForgetPasswordController(), fenix: true);
  Get.lazyPut(() => HomeController(), fenix: true);
  Get.lazyPut(() => CreateBoxController(), fenix: true);
  Get.lazyPut(() => BoxDetailsController(), fenix: true);
  Get.lazyPut(() => EditBoxController(), fenix: true);
  Get.lazyPut(() => ProfileController(), fenix: true);
}