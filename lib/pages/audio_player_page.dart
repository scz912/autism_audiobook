import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../audio/audio_engine.dart';
import '../models/audiobook.dart';
import '../services/api_service.dart';
import '../services/database_service.dart';

class AudioPlayerPage extends StatefulWidget {
  final String audiobookId;

  const AudioPlayerPage({
    super.key,
    required this.audiobookId,
  });

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  final AudioEngine engine = AudioEngine();

  double volume = 1.0;
  double speed = 1.0;
  bool _isLoading = true;
  String _errorMessage = '';

  Audiobook? _currentAudiobook;

  @override
  void initState() {
    super.initState();
    _loadAudiobook();
  }

  Future<void> _loadAudiobook() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      await engine.init();

      ApiResponse response = await DatabaseService.getAudiobookData(
        widget.audiobookId,
      );

      if (response.success && response.data is Audiobook) {
        _currentAudiobook = response.data as Audiobook;

        await engine.setVolume(volume);
        await engine.setSpeed(speed);

        if (_currentAudiobook?.audioFile != null &&
            _currentAudiobook!.audioFile!.isNotEmpty) {
          await engine.loadAudio(_currentAudiobook!.audioFile!);
        }

        setState(() {});
      } else {
        setState(() {
          _errorMessage = response.message;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load audiobook data';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  String getDisplayDuration() {
    if (_currentAudiobook?.durationMinutes != null) {
      return "${_currentAudiobook!.durationMinutes} min";
    }
    return "0 min";
  }

  @override
  void dispose() {
    engine.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFFEAF0F5);
    const cardColor = Colors.white;
    const primaryText = Color(0xFF314A6E);
    const secondaryText = Color(0xFF7B89A3);
    const accentBlue = Color(0xFFAFC8EA);
    const softGrey = Color(0xFFE9E6DF);
    const successBg = Color(0xFFE7EFE9);
    const successText = Color(0xFF5C7A69);

    if (_isLoading) {
      return const Scaffold(
        backgroundColor: bgColor,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return Scaffold(
        backgroundColor: bgColor,
        body: Center(
          child: Text(
            _errorMessage,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        children: const [
                          Icon(Icons.arrow_back_ios_new, size: 18, color: primaryText),
                          SizedBox(width: 6),
                          Text(
                            "Back",
                            style: TextStyle(
                              color: primaryText,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: (_currentAudiobook?.coverImage != null &&
                                _currentAudiobook!.coverImage!.isNotEmpty)
                                ? Image.network(
                              _currentAudiobook!.coverImage!,
                              height: 240,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 240,
                                  width: double.infinity,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.menu_book, size: 80),
                                );
                              },
                            )
                                : Container(
                              height: 240,
                              width: double.infinity,
                              color: Colors.grey[300],
                              child: const Icon(Icons.menu_book, size: 80),
                            ),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            _currentAudiobook?.title ?? 'Unknown Title',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: primaryText,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "by ${_currentAudiobook?.author ?? 'Unknown Author'}",
                            style: const TextStyle(
                              color: Color(0xFF6E7FA3),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${getDisplayDuration()} • ${_currentAudiobook?.category ?? 'General'}",
                            style: const TextStyle(
                              color: secondaryText,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 18),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            decoration: BoxDecoration(
                              color: successBg,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.shield_outlined, color: successText, size: 22),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Sensory Protection Active",
                                        style: TextStyle(
                                          color: successText,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        "AI monitoring for sudden changes",
                                        style: TextStyle(
                                          color: successText,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          StreamBuilder<Duration>(
                            stream: engine.positionStream,
                            builder: (context, posSnap) {
                              final position = posSnap.data ?? Duration.zero;

                              return StreamBuilder<Duration?>(
                                stream: engine.durationStream,
                                builder: (context, durSnap) {
                                  final duration = durSnap.data ??
                                      Duration(
                                        minutes: _currentAudiobook?.durationMinutes ?? 0,
                                      );

                                  final maxSeconds = duration.inSeconds > 0
                                      ? duration.inSeconds.toDouble()
                                      : 1.0;

                                  final currentValue = position.inSeconds
                                      .clamp(0, maxSeconds.toInt())
                                      .toDouble();

                                  return Column(
                                    children: [
                                      SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          trackHeight: 6,
                                          thumbShape: const RoundSliderThumbShape(
                                            enabledThumbRadius: 10,
                                          ),
                                          overlayShape: SliderComponentShape.noOverlay,
                                          activeTrackColor: accentBlue,
                                          inactiveTrackColor: softGrey,
                                          thumbColor: accentBlue,
                                        ),
                                        child: Slider(
                                          value: currentValue,
                                          max: maxSeconds,
                                          onChanged: (value) {
                                            engine.seek(Duration(seconds: value.toInt()));
                                          },
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            formatDuration(position),
                                            style: const TextStyle(
                                              color: primaryText,
                                              fontSize: 13,
                                            ),
                                          ),
                                          Text(
                                            formatDuration(duration),
                                            style: const TextStyle(
                                              color: primaryText,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 18),
                          StreamBuilder<PlayerState>(
                            stream: engine.playerStateStream,
                            builder: (context, snapshot) {
                              final playerState = snapshot.data;
                              final isPlaying = playerState?.playing ?? false;

                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildSideButton(
                                    icon: Icons.replay_10_rounded,
                                    onTap: () async {
                                      final currentPosition =
                                      await engine.positionStream.first;
                                      final newPosition = currentPosition - const Duration(seconds: 10);
                                      await engine.seek(
                                        newPosition >= Duration.zero
                                            ? newPosition
                                            : Duration.zero,
                                      );
                                    },
                                  ),
                                  _buildMainPlayButton(
                                    isPlaying: isPlaying,
                                    onTap: () async {
                                      if (isPlaying) {
                                        await engine.pause();
                                      } else {
                                        await engine.play();
                                      }
                                    },
                                  ),
                                  _buildSideButton(
                                    icon: Icons.forward_10_rounded,
                                    onTap: () async {
                                      final currentPosition =
                                      await engine.positionStream.first;
                                      await engine.seek(
                                        currentPosition + const Duration(seconds: 10),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 22),
                          Row(
                            children: [
                              const Icon(Icons.volume_down_outlined,
                                  color: primaryText, size: 20),
                              const SizedBox(width: 8),
                              const Text(
                                "Volume",
                                style: TextStyle(
                                  color: primaryText,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "${(volume * 100).round()}%",
                                style: const TextStyle(
                                  color: primaryText,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 6,
                              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 9),
                              overlayShape: SliderComponentShape.noOverlay,
                              activeTrackColor: const Color(0xFFB9DBB8),
                              inactiveTrackColor: softGrey,
                              thumbColor: const Color(0xFFB9DBB8),
                            ),
                            child: Slider(
                              value: volume,
                              min: 0,
                              max: 1,
                              onChanged: (value) async {
                                setState(() => volume = value);
                                await engine.setVolume(value);
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.speed_rounded,
                                  color: primaryText, size: 20),
                              const SizedBox(width: 8),
                              const Text(
                                "Speed",
                                style: TextStyle(
                                  color: primaryText,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "${speed.toStringAsFixed(1)}x",
                                style: const TextStyle(
                                  color: primaryText,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 6,
                              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 9),
                              overlayShape: SliderComponentShape.noOverlay,
                              activeTrackColor: const Color(0xFFD2C4B2),
                              inactiveTrackColor: softGrey,
                              thumbColor: const Color(0xFFD2C4B2),
                            ),
                            child: Slider(
                              value: speed,
                              min: 0.5,
                              max: 2,
                              divisions: 10,
                              onChanged: (value) {
                                setState(() => speed = value);
                              },
                              onChangeEnd: (value) async {
                                await engine.setSpeed(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Color(0xFFE5E8EF)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  _BottomItem(icon: Icons.home_outlined, label: "Home"),
                  _BottomItem(icon: Icons.menu_book_outlined, label: "Stories"),
                  _BottomItem(icon: Icons.settings_outlined, label: "Settings"),
                  _BottomItem(icon: Icons.logout_outlined, label: "Exit"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSideButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: const Color(0xFFF1EEE8),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: SizedBox(
          width: 64,
          height: 64,
          child: Icon(
            icon,
            color: const Color(0xFF4B5D7A),
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget _buildMainPlayButton({
    required bool isPlaying,
    required VoidCallback onTap,
  }) {
    return Material(
      color: const Color(0xFFAFC8EA),
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: SizedBox(
          width: 92,
          height: 92,
          child: Icon(
            isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
            color: const Color(0xFF334C6E),
            size: 48,
          ),
        ),
      ),
    );
  }
}

class _BottomItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _BottomItem({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFF6D7E9A);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 26),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}