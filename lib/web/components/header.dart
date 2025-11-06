// lib/web/components/header.dart
import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({
    super.key,
    required this.title,
    this.onNotificationsTap,
    this.notificationCount,
  });

  final String title;

  /// Callback opcional al tocar el ícono de notificaciones
  final VoidCallback? onNotificationsTap;

  /// Número opcional para mostrar en el badge (si es > 0 se muestra)
  final int? notificationCount;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 8.0,
      backgroundColor: const Color.fromARGB(255, 44, 4, 4),
      title: Text(title),
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          tooltip: 'Notificaciones',
          onPressed: onNotificationsTap,
          icon: (notificationCount != null && notificationCount! > 0)
              ? Badge(
                  alignment: Alignment.topRight,
                  label: Text('${notificationCount!}'),
                  child: const Icon(Icons.notifications_outlined),
                )
              : const Icon(Icons.notifications_outlined),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
