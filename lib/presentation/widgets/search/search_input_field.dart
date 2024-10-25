import 'dart:async';

import 'package:flutter/material.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';

class SearchInputField extends StatefulWidget {
  final String hintText;
  final Function(String? query) onQueryChanged;

  const SearchInputField({
    super.key,
    required this.hintText,
    required this.onQueryChanged,
  });

  @override
  _SearchInputFieldState createState() => _SearchInputFieldState();
}

class _SearchInputFieldState extends State<SearchInputField> {
  final _controller = TextEditingController();
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(Duration(milliseconds: 250), () {
      widget.onQueryChanged(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: ShapeDecoration(
        color: context.inputBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autofocus: false,
              controller: _controller,
              onChanged: (value) {
                _onSearchChanged(value);
              },
              onSubmitted: (value) {
                // _onSearchChanged(value);
              },
              style: TextStyle(
                color: context.textPrimary,
                fontSize: 14,
              ),
              decoration: InputDecoration.collapsed(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: context.textSecondary,
                  fontSize: 12,
                ),
              ),
              keyboardType: TextInputType.text,
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                _controller.clear();
                _onSearchChanged(_controller.text);
              },
              child: Assets.images.icClose.svg(width: 24, height: 24),
            ),
          )
        ],
      ),
    );
  }
}
