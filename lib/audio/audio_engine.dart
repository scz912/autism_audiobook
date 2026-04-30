import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';

class AudioEngine {
  final AudioPlayer _player = AudioPlayer();

  // Streams for UI
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  Stream<Duration> get positionStream => _player.positionStream;

  // Initialize audio session
  Future<void> init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
  }

  // Load audio
  Future<void> loadAudio(String url) async {
    try {
      await _player.setUrl(url); // network
      // OR: await _player.setAsset('assets/audio/story.mp3');
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  // Controls
  Future<void> play() async => _player.play();
  Future<void> pause() async => _player.pause();
  Future<void> stop() async => _player.stop();

  // Seek
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  // Volume (0.0 - 1.0)
  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume);
  }

  // Speed (0.5 - 2.0 recommended)
  Future<void> setSpeed(double speed) async {
    await _player.setSpeed(speed);
  }

  // Dispose
  void dispose() {
    _player.dispose();
  }
}