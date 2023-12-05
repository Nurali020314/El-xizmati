import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField({
    Key? key,
    this.hint,
    this.controller,
    this.inputType,
    this.obscureText = false,
    this.readOnly = false,
    this.minLines,
    this.maxLines = 1,
    this.enabled = true,
    this.disabledColor,
    this.label,
    this.onChanged,
    this.inputFormatters,
    this.textInputAction,
    this.maxLength = 1000,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  final String? hint;
  final String? label;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final bool obscureText;
  final bool readOnly;
  final int? minLines;
  final int? maxLines;
  final bool enabled;
  final int maxLength;
  final TextAlign textAlign;
  final Color? disabledColor;
  final TextInputAction? textInputAction;
  final TextInputFormatter? inputFormatters;
  final Function(String text)? onChanged;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool _passwordVisible = true;

  @override
  void initState() {
    super.initState();
    _passwordVisible = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      textAlign: widget.textAlign,
      textAlignVertical: TextAlignVertical.center,
      maxLength: widget.maxLength,
      style: TextStyle(),
      controller: widget.controller,
      keyboardType: widget.inputType,
      minLines: widget.minLines,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      enabled: widget.enabled,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      inputFormatters: [
        if (widget.inputFormatters != null) widget.inputFormatters!
      ],
      decoration: InputDecoration(
        filled: true,
        focusColor: Colors.white,
        fillColor: Color(0xFFFAF9FF),
        hintText: widget.hint,
        isDense: false,
        counter: Offstage(),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelText: widget.label,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: context.colors.primary),
          borderRadius: BorderRadius.circular(8),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.colors.iconGrey),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.colors.buttonPrimary),
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: !widget.obscureText
            ? null
            : IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
      obscureText: _passwordVisible,
    );
  }
}
