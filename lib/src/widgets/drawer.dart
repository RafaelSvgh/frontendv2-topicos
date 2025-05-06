import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Drawer drawer(ThemeData theme, BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: theme.primaryColor),
          child: const Text(
            'Asistente Legal',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.chat_bubble_outline),
          title: const Text('Chat'),
          onTap: () {
            context.go('/ia-chat');
          },
        ),
        ListTile(
          leading: const Icon(Icons.auto_stories_outlined),
          title: const Text('Búsqueda Offline'),
          onTap: () {
            context.go('/busqueda-offline');
          },
        ),
      ],
    ),
  );
}
