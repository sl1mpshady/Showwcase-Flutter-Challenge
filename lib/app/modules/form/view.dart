import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/app/modules/form/controller.dart';

class CustomForm extends StatelessWidget {
  CustomForm({Key? key}) : super(key: key);
  final controller = Get.put(FormController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add Pokemon',
              style: GoogleFonts.ubuntu(
                  fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 10,
          ),
          Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: controller.nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: controller.validator,
                  ),
                  TextFormField(
                    controller: controller.typeController,
                    decoration: const InputDecoration(labelText: 'Type'),
                    validator: controller.validator,
                    obscureText: true,
                  ),
                  ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: controller.onSubmit,
                  )
                ],
              )),
        ],
      ),
    );
  }
}
