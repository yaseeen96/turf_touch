import 'package:flutter/material.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';

class MakeInput extends StatelessWidget {
  final String label;
  final bool obscureText;
  final Function(String? value) validator;
  final Function(String? value)? onChanged;
  final Function(String? value) onSaved;
  final String? prefixText;
  final TextInputType? textInputType;
  final String? value;
  final bool isReadOnly;
  const MakeInput({
    super.key,
    required this.label,
    this.obscureText = false,
    required this.validator,
    required this.onSaved,
    this.prefixText,
    this.onChanged,
    this.textInputType,
    this.value,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: CTheme.of(context).theme.label,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          readOnly: isReadOnly,
          initialValue: value,
          keyboardType: textInputType,
          onChanged: (value) {
            if (onChanged != null) {
              onChanged!(value);
            }
          },
          onSaved: (value) {
            if (value!.isNotEmpty) {
              onSaved(value);
            }
          },
          validator: (value) {
            return validator(value);
          },
          style: CTheme.of(context).theme.bodyText,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixText: prefixText,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: CTheme.of(context).theme.backgroundInverse,
            )),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
