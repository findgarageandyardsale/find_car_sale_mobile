import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CustomYearPicker extends StatefulWidget {
  final String name;
  final String hintText;
  final String labelText;
  final List<FormFieldValidator<String>>? validator;
  final TextEditingController? controller;
  final String? initialValue;

  const CustomYearPicker({
    Key? key,
    required this.name,
    required this.hintText,
    required this.labelText,
    this.validator,
    this.controller,
    this.initialValue,
  }) : super(key: key);

  @override
  State<CustomYearPicker> createState() => _CustomYearPickerState();
}

class _CustomYearPickerState extends State<CustomYearPicker> {
  late TextEditingController _controller;
  String? _selectedYear;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _selectedYear = widget.initialValue;
    if (_selectedYear != null) {
      _controller.text = _selectedYear!;
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  Future<void> _showYearPicker() async {
    final DateTime currentDate = DateTime.now();
    final int currentYear = currentDate.year;

    // Generate list of years from 1900 to current year + 1
    final List<int> years = List.generate(
      currentYear - 1900 + 2, // +2 to include current year + 1
      (index) => currentYear + 1 - index,
    );

    // Show year picker dialog
    final int? selectedYear = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Year'),
          content: SizedBox(
            width: 200,
            height: 300,
            child: ListView.builder(
              itemCount: years.length,
              itemBuilder: (context, index) {
                final year = years[index];
                final isSelected =
                    _selectedYear != null && int.parse(_selectedYear!) == year;

                return ListTile(
                  title: Text(
                    year.toString(),
                    style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Theme.of(context).primaryColor : null,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(year);
                  },
                  selected: isSelected,
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );

    if (selectedYear != null) {
      setState(() {
        _selectedYear = selectedYear.toString();
        _controller.text = _selectedYear!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: widget.name,
      controller: _controller,
      readOnly: true,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: _showYearPicker,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
      validator:
          widget.validator != null
              ? FormBuilderValidators.compose(widget.validator!)
              : null,
    );
  }
}
