import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:toastification/toastification.dart';
import 'package:wallpaper_app/core/constants/app_constants.dart';
import 'package:wallpaper_app/core/routes/app_router_constants.dart';
import 'package:wallpaper_app/features/get_started/presentation/widget/gradient_button.dart';
import 'package:wallpaper_app/main.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey();
    final TextEditingController nameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        minimum: EdgeInsets.all(10),
        child: ValueListenableBuilder(
          valueListenable: themeNotifier,
          builder: (ctx, theme, _) => Form(
            key: formKey,
            child: Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter your\n Name.',

                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 50),
                TextFormField(
                  enableInteractiveSelection: true,
                  enabled: true,
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(LucideIcons.user),
                    border: OutlineInputBorder(),
                    hintText: 'Name',
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  spacing: 30,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Prefered Theme',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    ToggleButtons(
                      fillColor: Theme.of(context).cardColor,
                      selectedColor: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      isSelected: [
                        !themeNotifier.isDarkMode,
                        themeNotifier.isDarkMode,
                      ],
                      onPressed: (index) {
                        themeNotifier.toggleTheme();
                      },
                      children: [
                        Icon(Icons.wb_sunny),
                        Icon(Icons.nightlight_round),
                      ],
                    ),
                  ],
                ),

                GradientButton(
                  label: 'Continue',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final box = Hive.box(AppConstants.user);
                      box.put('name', nameController.text.trim());
                      context.goNamed(AppRouterConstants.homeScreen);
                    } else {
                      toastification.show(
                        title: Text('Please fill the details'),
                        type: ToastificationType.warning,
                        style: ToastificationStyle.flat,
                        showProgressBar: true,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
