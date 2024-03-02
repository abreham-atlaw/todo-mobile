import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:todo/common/forms/field.dart' as fields;
import 'package:todo/common/widgets/forms/field_widget.dart';

import 'package:flutter/material.dart';
import 'package:todo/common/widgets/forms/text_field_widget.dart';

class DateTimePickerWidget extends StatefulWidget {
  final IconData? iconData;
  final bool autofocus;
  final String? hintText;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime> onChanged;

  DateTimePickerWidget({
    this.iconData,
    this.autofocus = false,
    this.hintText,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onChanged,
  });

  @override
  _DateTimePickerWidgetState createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: widget.initialDate,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
        );
        if (date != null) {
          setState(() {
            selectedDate = date;
          });
          widget.onChanged(date);
        }
      },
      child: AbsorbPointer(
        child: RawTextInputWidget(
          iconData: Icons.calendar_month,
          controller: TextEditingController(text: DateFormat('yyyy-MM-dd').format(selectedDate)),
          autofocus: widget.autofocus,
        ),
      ),
    );
  }
}



class DateTimeFieldWidget extends FieldWidget<DateTime> {
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final IconData? iconData;
  final bool autoFocus;
  final String? hintText;

  DateTimeFieldWidget(
      {Key? key,
        required fields.Field<DateTime> field,
        Function(DateTime)? onChanged,
        this.initialDate,
        this.firstDate,
        this.lastDate,
        this.autoFocus = false,
        this.iconData,
        this.hintText
      })
      : super(key: key, field: field, onChanged: onChanged);

  @override
  Widget constructInputNode(DateTime? value, Function(DateTime) callback) {
    return DateTimePickerWidget(
        autofocus: autoFocus,
        iconData: iconData,
        onChanged: callback,
        initialDate: value ?? initialDate ?? DateTime.now(),
        firstDate: firstDate ?? DateTime(1900),
        lastDate: lastDate ?? DateTime(2100),
        hintText: hintText);
  }
}
