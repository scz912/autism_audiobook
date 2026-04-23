import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Pages
//import 'welcome_page.dart';
//import 'signup_page.dart';
//import 'home_page.dart';
//import 'profile_page.dart';
import 'audio_player_page.dart';
import 'content_management.dart';
import 'upload_content_page.dart';
//import 'settings_page.dart';
import 'story_list_page.dart';

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
        //'/': (context) => const WelcomePage(),
        //'/signup': (context) => const SignupPage(),
        //'/homepage': (context) => const Homepage(),
        //'/profile': (context) => const ProfilePage(),
        '/content-management': (context) => const ContentManagementPage(),
        '/upload-content': (context) => const UploadContentPage(),
        //'/settings': (context) => const SettingsPage(),
        '/stories': (context) => const StoryListPage(),
      },

      onGenerateRoute: (settings) {
        // Audio player route with audiobookId
        if (settings.name == '/audio-player') {
          final args = settings.arguments as Map<String, dynamic>?;

          return MaterialPageRoute(
            builder: (context) => AudioPlayerPage(
              audiobookId: args?['audiobookId'] ?? 2,
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