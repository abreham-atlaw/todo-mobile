import 'package:flutter/material.dart';
import 'package:todo/apps/core/data/models/category.dart';
import 'package:todo/common/widgets/forms/field_widget.dart';
import 'package:todo/common/forms/field.dart' as fields;
import 'package:todo/common/widgets/text/body.dart';
import 'package:todo/configs/ui_configs.dart';


class CategoryDropdown extends StatefulWidget {
  final List<Category> categories;
  final ValueChanged<Category> onCategorySelected;
  final Category? initialCategory;

  const CategoryDropdown({super.key, required this.categories, required this.onCategorySelected, this.initialCategory});

  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  Category? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;

  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownButton<Category>(
        value: _selectedCategory,
        icon: const Icon(Icons.keyboard_arrow_down_outlined),
        iconSize: FontSizeConfigs.size2,
        elevation: 16,
        isExpanded: true,
        underline: Container(
          height: 2,
          color: ColorsConfigs.primary,
        ),
        onChanged: (Category? newValue) {
          setState(() {
            _selectedCategory = newValue;
            widget.onCategorySelected(newValue!);
          });
        },
        items: widget.categories.map<DropdownMenuItem<Category>>((Category category) {
          return DropdownMenuItem<Category>(
            value: category,
            child: Expanded(child: BodyText(category.name)),
          );
        }).toList(),
      ),
    );
  }
}


class CategoryFieldWidget extends FieldWidget<Category> {
  final List<Category> categories;
  final IconData? iconData;
  final bool autoFocus;
  final String? hintText;

  const CategoryFieldWidget(
      {Key? key,
        required fields.Field<Category> field,
        Function(Category)? onChanged,
        required this.categories,
        this.autoFocus = false,
        this.iconData,
        this.hintText
      })
      : super(key: key, field: field, onChanged: onChanged);

  @override
  Widget constructInputNode(Category? value, Function(Category) callback) {
    return CategoryDropdown(
        categories: categories,
        onCategorySelected: callback,
      initialCategory: (value == null)?null:categories.firstWhere((element) => element.getPK() == value.getPK()),
    );
  }
}
