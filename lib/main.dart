import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:river_pod/services/http_services.dart';
import 'presentation/home_page/home_page.dart';

void main() async {
  await _setUpServices();
  runApp(const MyApp());
}

Future<void> _setUpServices() async {
  GetIt.instance.registerSingleton<HttpServices>(HttpServices());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokamon',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          // textTheme: TextTheme(
          //     bodyMedium: GoogleFonts.poppins(color: Colors.black87))
        ),
        home: const HomePage(),
      ),
    );
  }
}
