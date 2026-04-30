import 'package:flutter/material.dart';

class UploadContentPage extends StatefulWidget {
  const UploadContentPage({super.key});

  @override
  State<UploadContentPage> createState() => _UploadContentPageState();
}

class _UploadContentPageState extends State<UploadContentPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();

  String _difficulty = 'Easy';
  bool _aiGeneration = false;

  final Color _softBackground = const Color(0xFFF2F4F7);
  final Color _primaryText = const Color(0xFF4B5C78);
  final Color _secondaryText = const Color(0xFF7D8CA5);
  final Color _accentBlue = const Color(0xFFAFC8EA);
  final Color _softBeige = const Color(0xFFF0ECE6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _softBackground,
      appBar: AppBar(
        backgroundColor: _softBackground,
        elevation: 0,
        iconTheme: IconThemeData(color: _primaryText),
        title: Text(
          'Upload New Content',
          style: TextStyle(
            color: _primaryText,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Upload File',
                style: TextStyle(
                  color: _primaryText,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                )),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 18),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFD9DEE7)),
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Icon(Icons.upload_outlined, size: 48, color: _secondaryText),
                  const SizedBox(height: 10),
                  Text(
                    'Drop files here or click to browse',
                    style: TextStyle(
                      color: _primaryText,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Supports: PDF, TXT, MP3, WAV',
                    style: TextStyle(
                      color: _secondaryText,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _label('Title'),
            _textField(_titleController, 'Enter content title'),
            const SizedBox(height: 16),
            _label('Topic'),
            _textField(_topicController, 'e.g., Science, Math, Social Skills'),
            const SizedBox(height: 16),
            _label('Difficulty Level'),
            Row(
              children: ['Easy', 'Medium', 'Hard'].map((level) {
                final selected = _difficulty == level;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                      onTap: () => setState(() => _difficulty = level),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: selected ? _accentBlue : _softBeige,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Text(
                            level,
                            style: TextStyle(
                              color: _primaryText,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            _label('Tags (comma separated)'),
            _textField(_tagsController, 'e.g., Educational, Interactive, Visual'),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFECEFF6),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.auto_awesome_outlined, color: _primaryText),
                      const SizedBox(width: 10),
                      Text(
                        'AI Audiobook Generation',
                        style: TextStyle(
                          color: _primaryText,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'If you\'re uploading a text file, we can automatically convert it to an audiobook using AI voice synthesis.',
                    style: TextStyle(
                      color: _secondaryText,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 14),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _aiGeneration = !_aiGeneration;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: _accentBlue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        _aiGeneration ? 'AI Generation Enabled' : 'Enable AI Generation',
                        style: TextStyle(
                          color: _primaryText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: _softBeige,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: _primaryText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Upload function can be connected next')),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: _accentBlue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          'Upload Content',
                          style: TextStyle(
                            color: _primaryText,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          color: _primaryText,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _textField(TextEditingController controller, String hint) {
    return Container(
      decoration: BoxDecoration(
        color: _softBeige,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: _secondaryText),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),
      ),
    );
  }
}