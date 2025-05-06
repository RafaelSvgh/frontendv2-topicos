import 'package:flutter/material.dart';
import 'package:front_ia/src/pages/chat_page.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  initialLocation: '/ia-chat',
  errorBuilder: (_, __) => const Scaffold(body: Center(child: Text('Error'))),
  routes: [
    GoRoute(path: '/ia-chat', builder: (context, state) => const ChatPage()),
  ],
);
