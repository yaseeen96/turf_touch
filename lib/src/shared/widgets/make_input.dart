import 'package:flutter/material.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';

class MakeInput extends StatefulWidget {
  final String label;
  final bool isPassword;
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
    this.isPassword = false,
    required this.validator,
    required this.onSaved,
    this.prefixText,
    this.onChanged,
    this.textInputType,
    this.value,
    this.isReadOnly = false,
  });

  @override
  State<MakeInput> createState() => _MakeInputState();
}

class _MakeInputState extends State<MakeInput> {
  bool isPasswordVisible = false;

  void onPasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: CTheme.of(context).theme.label,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          readOnly: widget.isReadOnly,
          initialValue: widget.value,
          keyboardType: widget.textInputType,
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          onSaved: (value) {
            if (value!.isNotEmpty) {
              widget.onSaved(value);
            }
          },
          validator: (value) {
            return widget.validator(value);
          },
          style: CTheme.of(context).theme.bodyText,
          obscureText: isPasswordVisible,
          decoration: InputDecoration(
            suffix: widget.isPassword
                ? IconButton(
                    onPressed: onPasswordVisibility,
                    icon: isPasswordVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off))
                : null,
            prefixText: widget.prefixText,
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
