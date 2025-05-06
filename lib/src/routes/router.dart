import 'package:flutter/material.dart';
import 'package:front_ia/src/pages/chat_page.dart';
import 'package:front_ia/src/pages/offline_search_page.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  initialLocation: '/busqueda-offline',
  errorBuilder: (_, __) => const Scaffold(body: Center(child: Text('Error'))),
  routes: [
    GoRoute(path: '/ia-chat', builder: (context, state) => const ChatPage()),
  GoRoute(
        path: '/busqueda-offline',
        builder: (context, state) => const OfflineSearchPage(),
      ),
  ],

);
