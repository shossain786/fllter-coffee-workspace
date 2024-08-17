// ignore_for_file: must_be_immutable

import 'package:filtercoffee/global/utils/utillity_section.dart';
import 'package:filtercoffee/global/widgets/form_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputField extends StatelessWidget {
  TextInputField({
    super.key,
    required this.context,
    required this.districtController,
    required this.icon,
    required this.keyboardType,
    required this.labelText,
    required this.regExp,
    required this.maxLength,
  });

  BuildContext context;
  final TextEditingController districtController;
  final Icon icon;
  final TextInputType keyboardType;
  final String labelText;
  final RegExp regExp;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: context.screenWidth * 0.05,
          vertical: context.screenHeight * 0.01),
      child: FormWidgets.buildTextFormField(
        context,
        controller: districtController,
        keyboardType: keyboardType,
        maxLength: maxLength,
        inputFormatters: [FilteringTextInputFormatter.allow(regExp)],
        onChanged: () {},
        labelText: labelText,
        prefixIcon: icon,
        errorText: null,
      ),
    );
  }
}
