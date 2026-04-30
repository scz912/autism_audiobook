import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Pages
import 'pages/audio_player_page.dart';
import 'pages/content_management.dart';
import 'pages/upload_content_page.dart';
import 'pages/story_list_page.dart';

// Optional navigation service
class AppNavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();
}

void main() {
  runApp(const AudiobookApp());
}

class AudiobookApp extends StatelessWidget {
  const AudiobookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Autism Audiobook',
      debugShowCheckedModeBanner: false,
      navigatorKey: AppNavigationService.navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.interTextTheme(),
        scaffoldBackgroundColor: const Color(0xFFF2F4F7),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFFF2F4F7),
          elevation: 0,
          iconTheme: const IconThemeData(color: Color(0xFF4B5C78)),
          titleTextStyle: GoogleFonts.inter(
            color: const Color(0xFF4B5C78),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: const Color(0xFFAFC8EA),
            foregroundColor: const Color(0xFF314A6E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      initialRoute: '/stories',
      routes: {
        '/content-management': (context) => const ContentManagementPage(),
        '/upload-content': (context) => const UploadContentPage(),
        '/stories': (context) => const StoryListPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/audio-player') {
          final args = settings.arguments as Map<String, dynamic>?;

          return MaterialPageRoute(
            builder: (context) => AudioPlayerPage(
              audiobookId: args?['audiobookId'] ?? '',
            ),
          );
        }

        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
      },
    );
  }
}