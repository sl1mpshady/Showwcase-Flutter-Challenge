import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class FormController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final typeController = TextEditingController();

  @override
  void onClose() {
    nameController.dispose();
    typeController.dispose();
    debugPrint('onclose');
    super.onClose();
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }

  void onSubmit() {
    if (formKey.currentState!.validate()) {
      clear();
      Get.back();
    }
  }

  void clear() {
    nameController.clear();
    typeController.clear();
  }
}
