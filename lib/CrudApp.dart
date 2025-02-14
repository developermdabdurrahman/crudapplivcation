// ignore: unused_import
import 'package:crudapplivcation/ui/model/Product.dart';
import 'package:crudapplivcation/ui/screens/Add_Product_screen.dart';
import 'package:crudapplivcation/ui/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'ui/screens/Update_Product_Screen.dart';
import 'ui/theme/app_theme.dart';
import 'ui/controllers/theme_controller.dart';
import 'ui/screens/main_screen.dart';
import 'ui/controllers/product_controller.dart';
import 'ui/controllers/language_controller.dart';
import 'ui/translations/messages.dart';

class CRUDApp extends StatelessWidget {
  const CRUDApp({super.key});

  Future<String> _getInitialRoute() async {
    final prefs = await SharedPreferences.getInstance();
    final showHome = prefs.getBool('showHome') ?? false;
    return showHome ? '/' : OnboardingScreen.name;
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());
    final languageController = Get.put(LanguageController());
    
    return GetMaterialApp(
      title: 'CRUD App',
      theme: AppTheme.themes[themeController.currentTheme],
      translations: Messages(),
      locale: languageController.locale,
      fallbackLocale: const Locale('en', 'US'),
      initialRoute: '/',
      initialBinding: BindingsBuilder(() {
        Get.put(ThemeController());
        Get.put(ProductController());
      }),
      getPages: [
        GetPage(name: '/', page: () => FutureBuilder<String>(
          future: _getInitialRoute(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return snapshot.data == '/' 
                ? const MainScreen() 
                : const OnboardingScreen();
          },
        )),
        GetPage(name: OnboardingScreen.name, page: () => const OnboardingScreen()),
        GetPage(name: MainScreen.name, page: () => const MainScreen()),
        GetPage(name: AddNewProductScreen.name, page: () => const AddNewProductScreen()),
        GetPage(
          name: UpdateProductScreen.name, 
          page: () => UpdateProductScreen(product: Get.arguments),
        ),
      ],
    );
  }
}