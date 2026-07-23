import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final VoidCallback? onBack;
  final Widget? action;


  const CommonAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.onBack,
    this.action,

  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      toolbarHeight: 56,
      titleSpacing: 15,

      centerTitle: false,

      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,

      backgroundColor:
          theme.appBarTheme.backgroundColor ?? theme.scaffoldBackgroundColor,

      foregroundColor: theme.colorScheme.onSurface,

      iconTheme: IconThemeData(color: theme.colorScheme.onSurface),

      title: Text(
        title,

        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.onSurface,
        ),
      ),
      actions: [
        if (action != null)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: action!,
          ),
      ],

      // leading: showBack
      //     ? Padding(
      //         padding: const EdgeInsets.only(left: 20.0,),
      //         child: IconButton(
      //           icon: const Icon(Icons.arrow_back_ios, size: 18),
      //
      //           onPressed: onBack ?? () => Navigator.pop(context),
      //         ),
      //       )
      //     : null,
      leading: showBack
          ? Padding(
        padding: const EdgeInsets.only(left: 20),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
          onPressed: () async {
            // Hide keyboard
            FocusScope.of(context).unfocus();

            // Wait for keyboard animation to finish
            await Future.delayed(const Duration(milliseconds: 150));

            if (onBack != null) {
              onBack!();
            } else {
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              }
            }
          },
        ),
      )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
