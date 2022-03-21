import 'package:get/get.dart';

class NavController extends GetxController {
  var _selectBtn = 0.obs;

  int get selectBtn => _selectBtn.value;

  setSelecBtn(val) {
    _selectBtn.value = val;
  }
}
