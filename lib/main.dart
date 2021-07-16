import 'package:flutter/material.dart';
import 'services/auth_service.dart';
import 'services/socket_service.dart';
import 'package:provider/provider.dart';

import 'routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => SocketService()),
        // ChangeNotifierProvider(create: (_) => ChatService()),
      ],
      child: MaterialApp(
        // debugShowCheckedModeBanner: false,
        title: 'Lifesaving App',
        initialRoute: 'splash',
        routes: appRoutes,
      ),
    );
  }
}
