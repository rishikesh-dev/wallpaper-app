import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({
    super.key,
    required this.label,
    required this.onPressed,
  }) : assert(label.length == onPressed.length);
  final List<String> label;
  final List<VoidCallback> onPressed;
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {
        context.pop();
      },
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 40.0, top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              label.length,
              (index) => TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).cardColor,
                ),
                onPressed: onPressed[index],
                child: Text(label[index]),
              ),
            ),
          ),
        );
      },
    );
  }
}
