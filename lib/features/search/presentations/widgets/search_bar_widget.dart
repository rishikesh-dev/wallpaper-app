import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
    this.hintText = '',
    required this.controller,
    required this.onChange,
    required this.onEditingComplete,
  });
  final String hintText;
  final ValueChanged<String> onChange;
  final Function onEditingComplete;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, _) {
        return TextFormField(
          controller: controller,
          onEditingComplete: () => onEditingComplete.call(),
          onChanged: (query) async {
            Timer(Duration(seconds: 2), () {
              onChange(query);
            });
          },
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: value.text.isNotEmpty
                ? IconButton(
                    icon: Icon(LucideIcons.circleX),
                    onPressed: () {
                      controller.clear();
                      onChange('');
                    },
                  )
                : null,
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
        );
      },
    );
  }
}
