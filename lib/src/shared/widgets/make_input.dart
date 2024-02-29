import 'package:flutter/material.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';

class MakeInput extends StatelessWidget {
  final String label;
  final bool obscureText;
  final Function(String? value) validator;
  final Function(String? value)? onChanged;
  final Function(String? value) onSaved;
  const MakeInput({
    super.key,
    required this.label,
    this.obscureText = false,
    required this.validator,
    required this.onSaved,
    this.onChanged,
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
