import 'package:flutter/material.dart';
import 'package:todo/configs/ui_configs.dart';
import 'package:todo/common/forms/field.dart' as fields;
import 'package:todo/common/widgets/forms/field_widget.dart';

class RawTextInputWidget extends TextField {
  RawTextInputWidget(
      {super.onTap,
      super.autofocus,
      IconData? iconData,
      super.onChanged,
      super.obscureText,
      super.controller,
      super.focusNode,
        String? hintText
      })
      : super(
      decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.all(SpacingConfigs.spacing3),
          fillColor: ColorsConfigs.light,
          filled: true,
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorsConfigs.primary, width: 2),
              borderRadius: BorderRadius.circular(SpacingConfigs.spacing1)),
          prefixIcon: Icon(iconData),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorsConfigs.grey, width: 2),
              borderRadius: BorderRadius.circular(
                SpacingConfigs.spacing1,
              ))));
}

class TextFieldWidget extends FieldWidget<String> {
  final bool emptyAsNull;
  final TextEditingController _controller = TextEditingController();
  final IconData? iconData;
  final bool obsecureText;
  final void Function()? onTap;
  final bool autoFocus;
  final String? hintText;

  TextFieldWidget(
      {Key? key,
      required fields.Field<String> field,
      Function(String)? onChanged,
      this.emptyAsNull = true,
      this.obsecureText = false,
      this.onTap,
      this.autoFocus = false,
      this.iconData,
      this.hintText
      })
      : super(key: key, field: field, onChanged: onChanged);

  @override
  Widget constructInputNode(String? value, Function(String) callback) {
    if (_controller.text != value) {
      _controller.text = value ?? "";
    }
    return RawTextInputWidget(
        onTap: onTap,
        autofocus: autoFocus,
        iconData: iconData,
        onChanged: callback,
        obscureText: obsecureText,
        hintText: hintText,
        controller: _controller);
  }
}
