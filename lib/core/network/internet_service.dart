import 'package:get/get.dart';

class InternetService extends GetxController {
  static InternetService get to => Get.find();

  final RxBool hasInternet = true.obs;
}