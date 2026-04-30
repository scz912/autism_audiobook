# Autism Audiobook (Frontend)

A Flutter mobile application designed to provide an **autism-friendly audiobook experience**.  
The app focuses on **simple UI, low cognitive load, and smooth interaction** for children and caregivers.

---

## 📌 Project Status

🚧 Still under development  
Some features are functional, while some modules are still in progress.

---

## 🛠 Tech Stack

- Flutter
- Dart
- Android Studio
- Google Fonts
- just_audio (audio playback)
- audio_session
- HTTP API integration

---

## 🚀 Features Overview

### Story Library
- Fetch stories from API
- Search (local filtering)
- Filter by category & age
- Navigate to audio player  
📄 `pages/story_list_page.dart`

---

### Audio Player
- Load audiobook from API
- Play / Pause
- Seek
- Volume control
- Speed control
- Display story info  
📄 `pages/audio_player_page.dart`  
📄 `audio/audio_engine.dart`

---

### Content Management
- View content summary
- View content list
- Search & filter
- Navigate to upload  
📄 `pages/content_management.dart`

---

### Upload Content (UI)
- Title, topic, difficulty
- Tags
- AI toggle (future)  
📄 `pages/upload_content_page.dart`

---

### API Layer
- API configuration
- HTTP requests
- Response handling  
📄 `config/app_config.dart`  
📄 `services/api_service.dart`  
📄 `services/database_service.dart`

---

# 📁 Complete Project Structure

```
autism_audiobook/
│
├── .dart_tool/                      
├── .idea/                            
├── build/                          
│
├── android/                            # Android platform-specific code
│   ├── app/
│   │   ├── src/
│   │   │   ├── debug/
│   │   │   ├── main/
│   │   │   │   ├── java/              
│   │   │   │   ├── res/              
│   │   │   │   └── AndroidManifest.xml # App permissions & configuration
│   │   │   └── profile/
│   │   └── build.gradle.kts
│   │
│   ├── gradle/
│   ├── build.gradle.kts
│   ├── gradle.properties
│   ├── gradlew
│   ├── gradlew.bat
│   ├── local.properties
│   └── settings.gradle.kts
│
├── ios/                                # iOS platform-specific code (Not important)
│   ├── Flutter/
│   ├── Runner/
│   ├── Runner.xcodeproj/
│   ├── Runner.xcworkspace/
│   ├── RunnerTests/
│   └── .gitignore
│
├── lib/                                # Main Flutter source code
│   │
│   ├── main.dart                       # Entry point of the app
│   │
│   ├── audio/                          # Audio logic
│   │   └── audio_engine.dart           # Audio playback (play, pause, seek, volume, speed)
│   │
│   ├── config/                         # App configuration
│   │   └── app_config.dart             # API base URL & global settings
│   │
│   ├── models/                         # Data models
│   │   ├── audiobook.dart              # Audiobook model
│   │   ├── content_item.dart           # Content list model
│   │   └── content_summary.dart        # Summary model
│   │
│   ├── pages/                          # UI screens
│   │   ├── audio_player_page.dart      # Audiobook player UI
│   │   ├── content_management.dart     # Content management screen
│   │   ├── story_list_page.dart        # Story library (search & filter)
│   │   └── upload_content_page.dart    # Upload content UI
│   │
│   ├── services/                       # API & backend communication
│   │   ├── api_service.dart            # API response wrapper
│   │   └── database_service.dart       # API calls (HTTP requests)
│   │
│   └── test/                          
│
├── .flutter-plugins-dependencies       
├── .gitignore                        
├── .metadata                          
├── analysis_options.yaml               
├── autism_audiobook.iml             
├── pubspec.yaml                        # Dependencies & assets
├── pubspec.lock                  
└── README.md                           # Project documentation


---

## 📄 Key File Examples

### main.dart
```dart
void main() {
  runApp(const AudiobookApp());
}
```

---

### app_config.dart
```dart
class AppConfig {
  static const String databaseApiUrl = 'http://10.0.2.2:8000/api';
}
```

---

### api_service.dart
```dart
class ApiResponse {
  final bool success;
  final String message;
  final dynamic data;
  final String? error;
}
```

---

### database_service.dart
```dart
static Future<ApiResponse> getAudiobookData(String id) async {
  final response = await http.get(
    Uri.parse('${AppConfig.databaseApiUrl}/audiobooks/$id'),
  );
}
```

---

### audio_engine.dart
```dart
final AudioPlayer _player = AudioPlayer();

Future<void> loadAudio(String url) async {
  await _player.setUrl(url);
}
```

---

### audio_player_page.dart
```dart
await engine.loadAudio(audiobook.audioFile!);
await engine.play();
```

---

### story_list_page.dart
```dart
ListView.builder(
  itemCount: stories.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text(stories[index].title),
    );
  },
);
```

---

### AndroidManifest.xml
```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

---

### pubspec.yaml
```yaml
dependencies:
  flutter:
    sdk: flutter
  http:
  just_audio:
  audio_session:
  google_fonts:
```

---

## ⚙️ Setup

```bash
git clone https://github.com/scz912/autism_audiobook.git
cd autism_audiobook
flutter pub get
flutter run
```

---

## 🌐 API Config

Android Emulator:
```
http://10.0.2.2:8000/api
```

Physical Device:
```
http://YOUR_IP:8000/api
```

---

## ⚠️ Notes

- Use `10.0.2.2` instead of `localhost` for emulator
- Audio must be public URL

---

## 🚧 Limitations

- Backend not fully complete
- No authentication
- AI feature not implemented

---

## 🔮 Future Work

- AI audiobook generation
- Recommendation system
- User profile
- Progress tracking

---

## 🎓 FYP Purpose

To build a **calm, accessible audiobook system** for autistic children.
