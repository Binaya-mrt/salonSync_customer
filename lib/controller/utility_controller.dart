
import 'package:get/get.dart';


class UtilityController extends GetxController{

 RxBool isObscure = true.obs;
  RxBool isLoading = false.obs;
 void toggleObscure() {
    isObscure.value = !isObscure.value;
  }
}