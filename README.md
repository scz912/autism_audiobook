# Autism Audiobook (Frontend)

A Flutter mobile application designed to provide an **autism-friendly audiobook experience**.  
The app focuses on simple UI, low cognitive load, and smooth interaction for children and caregivers.

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

---

## 🛠 Flutter Setup Guide (Link)
### How to setup flutter in Android Studio
https://www.youtube.com/watch?v=mMeQhLGD-og&t=561s


---

## 🚀 Features Overview

### 1. Story Library
Displays available audiobook content.

**Functions:**
- Fetch story list from API
- Search stories (local filtering)
- Filter by category
- Filter by age range
- Tap story → open audio player

📄 File: `story_list_page.dart`

---

### 2. Audio Player
Plays audiobook content.

**Functions:**
- Load audiobook using `audiobook_id`
- Play / Pause audio
- Adjust volume
- Adjust playback speed
- Seek audio position
- Display story info (title, author, duration)

📄 Files:
- `audio_player_page.dart`
- `audio_engine.dart`

---

### 3. Content Management
Displays uploaded content overview.

**Functions:**
- View total content summary
- View content list
- Search content
- Filter content locally
- Navigate to upload page

📄 File: `content_management.dart`

---

### 4. Upload Content (UI Only)
Form for uploading new content.

**Functions:**
- Input title, topic, difficulty
- Add tags
- Enable AI audiobook toggle (future feature)

📄 File: `upload_content_page.dart`

---

### 5. API Service Layer
Handles communication between frontend and backend.

📄 Files:
- `app_config.dart`
- `api_service.dart`
- `database_service.dart`

---

## 📁 Project Structure

```
lib/
│
├── main.dart
├── app_config.dart
├── api_service.dart
├── database_service.dart
├── story_list_page.dart
├── audio_player_page.dart
├── audio_engine.dart
├── content_management.dart
├── upload_content_page.dart
```

---

## 📄 File Responsibilities

### `main.dart`
- Entry point of the app
- Defines theme and routes

---

### `app_config.dart`
- Stores API base URL
- Central configuration file

---

### `api_service.dart`
- Standard API response wrapper
- Ensures consistent response handling

---

### `database_service.dart`
- Handles API calls
- Converts JSON into models

---

### `story_list_page.dart`
- Displays story list
- Handles search and filters
- Navigates to player page

---

### `audio_player_page.dart`
- Loads audiobook data
- Displays UI for playback
- Controls audio

---

### `audio_engine.dart`
- Core audio logic
- Handles play, pause, seek, volume, speed

---

### `content_management.dart`
- Displays content summary
- Lists uploaded content
- Handles filtering

---

### `upload_content_page.dart`
- Upload UI form
- Future backend integration

---

## 📄 Code Examples

### `main.dart`
```dart
void main() {
  runApp(const AudiobookApp());
}
```

---

### `app_config.dart`
```dart
class AppConfig {
  static const String databaseApiUrl = 'http://10.0.2.2:8000/api';
}
```

---

### `api_service.dart`
```dart
class ApiResponse {
  final bool success;
  final String message;
  final dynamic data;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
  });
}
```

---

### `database_service.dart`
```dart
static Future<ApiResponse> getAudiobookData(String id) async {
  final response = await http.get(
    Uri.parse('${AppConfig.databaseApiUrl}/audiobooks/$id'),
  );

  final data = json.decode(response.body);

  return ApiResponse(
    success: response.statusCode == 200,
    message: data['message'],
    data: data['data'],
  );
}
```

---

### `audio_engine.dart`
```dart
final AudioPlayer _player = AudioPlayer();

Future<void> loadAudio(String url) async {
  await _player.setUrl(url);
}
```

---

### `story_list_page.dart`
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

### `audio_player_page.dart`
```dart
await engine.loadAudio(audiobook.audioFile!);
await engine.play();
```

---

### `content_management.dart`
```dart
TextField(
  onChanged: (value) => filterContent(value),
)
```

---

### `upload_content_page.dart`
```dart
TextField(
  decoration: InputDecoration(hintText: 'Enter title'),
)
```

---

### `AndroidManifest.xml`
```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

---

### `pubspec.yaml`
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

## ⚙️ Setup Instructions

### 1. Clone Repository
```bash
git clone https://github.com/scz912/autism_audiobook.git
cd autism_audiobook
```

---

### 2. Install Dependencies
```bash
flutter pub get
```

---

### 3. Check Environment
```bash
flutter doctor
```

---

### 4. Run App
```bash
flutter run
```

---

## 🌐 API Configuration

Update API URL in `app_config.dart`

### Android Emulator:
```dart
http://10.0.2.2:8000/api
```

### Physical Device:
```dart
http://YOUR_IP:8000/api
```

### Windows Desktop:
```dart
http://127.0.0.1:8000/api
```

---

## ⚠️ Important Notes

### Emulator Localhost Issue
Use:
```
10.0.2.2
```
instead of:
```
127.0.0.1
```

---

### Audio Playback
- Audio must be public URL
- Cannot be protected by authentication

---

## 🚧 Current Limitations

- Upload backend not complete
- No authentication system
- AI feature not implemented yet
- UI still improving

---

## 🔮 Future Improvements

- AI audiobook generation
- Caregiver recommendation system
- User profiles
- Favorites & bookmarks
- Listening history
- Progress tracking

---

## 🎓 Project Purpose

This project is developed as a **Final Year Project (FYP)**.

The goal is to provide:
- A **calm UI**
- An **accessible audiobook system**
- A **supportive tool for autistic children**
