import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onInfoPressed;

  //final bool showBack;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onInfoPressed,
    /*this.showBack = false*/
    });

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());

    return AppBar(
      automaticallyImplyLeading: false,
      // backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 0,
      centerTitle: true,
      /*   leading: showBack
          ? IconButton(
        icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
        onPressed: () => Navigator.of(context).pop(),
      )
          : null,*/
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0,bottom: 8,top: 10),
        child: Image.asset(
          'assets/githublogo.png',
          fit: BoxFit.contain,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).textTheme.titleLarge?.color,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.info),
          // use Icon widget, not IconData directly
          color: Theme.of(context).iconTheme.color,
          onPressed: onInfoPressed
        ),
        Obx(
          () => IconButton(
            icon: Icon(
              themeController.isDarkMode.value
                  ? Icons.dark_mode
                  : Icons.light_mode,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: themeController.toggleTheme,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
