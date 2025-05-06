import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:front_ia/src/pages/pages.dart';

final goRouter = GoRouter(
  initialLocation: '/ia-chat',
  errorBuilder: (_, __) => const Scaffold(body: Center(child: Text('Error'))),
  routes: [
    GoRoute(
      path: '/ia-chat',
      name: 'chat-ia',
      builder: (context, state) => const ChatPage(),
    ),
    GoRoute(
      path: '/busqueda-offline',
      name: 'busqueda-offline',
      builder: (context, state) => const OfflineSearchPage(),
    ),
  ],
);
