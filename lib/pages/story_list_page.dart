import 'package:flutter/material.dart';
import '../services/database_service.dart';
import 'audio_player_page.dart';
import '../models/content_item.dart';
class StoryListPage extends StatefulWidget {
  const StoryListPage({super.key});

  @override
  State<StoryListPage> createState() => _StoryListPageState();
}

class _StoryListPageState extends State<StoryListPage> {
  final TextEditingController _searchController = TextEditingController();

  final Color _bgColor = const Color(0xFFF2F4F7);
  final Color _cardColor = Colors.white;
  final Color _primaryText = const Color(0xFF4B5C78);
  final Color _secondaryText = const Color(0xFF7D8CA5);
  final Color _selectedBlue = const Color(0xFFAFC8EA);
  final Color _selectedGreen = const Color(0xFFC9E6C7);
  final Color _chipBg = const Color(0xFFF0ECE6);
  final Color _borderColor = const Color(0xFFD9DEE7);

  bool _isLoading = true;
  bool _showFilters = false;

  String selectedCategory = 'All';
  String selectedAgeRange = 'All';

  List<ContentItem> _allStories = [];
  List<ContentItem> _filteredStories = [];

  List<String> categories = ['All'];
  final List<String> ageRanges = ['All', '7-9', '8-11', '9-12'];

  @override
  void initState() {
    super.initState();
    _loadStories();

    _searchController.addListener(() {
      _applyFilters();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadStories() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await DatabaseService.getContentList();

      if (response.success && response.data is List<ContentItem>) {
        final items = response.data as List<ContentItem>;

        // Optional: only show content that has audio or is intended as story content
        _allStories = items.where((item) {
          final type = (item.type ?? '').toLowerCase();
          return type == 'audio' || type == 'text';
        }).toList();

        _buildDynamicCategories();
        _applyFilters();
      } else {
        _allStories = [];
        _filteredStories = [];
      }
    } catch (e) {
      debugPrint('Error loading stories: $e');
      _allStories = [];
      _filteredStories = [];
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _buildDynamicCategories() {
    final categorySet = <String>{'All'};

    for (final item in _allStories) {
      final category = (item.category ?? '').trim();
      if (category.isNotEmpty) {
        categorySet.add(category);
      }
    }

    categories = categorySet.toList();
  }

  void _applyFilters() {
    final query = _normalizeText(_searchController.text);

    List<ContentItem> result = List.from(_allStories);

    if (selectedCategory != 'All') {
      result = result.where((item) {
        return _normalizeText(item.category) == _normalizeText(selectedCategory);
      }).toList();
    }

    if (selectedAgeRange != 'All') {
      result = result.where((item) {
        return _normalizeText(item.ageGroup) == _normalizeText(selectedAgeRange);
      }).toList();
    }

    if (query.isNotEmpty) {
      result = result.where((item) {
        final searchableText = [
          item.title,
          item.author,
          item.category,
          item.topic,
          item.tags,
          item.description,
          item.ageGroup,
        ].map(_normalizeText).join(' ');

        return searchableText.contains(query);
      }).toList();
    }

    setState(() {
      _filteredStories = result;
    });
  }

  String _normalizeText(dynamic value) {
    if (value == null) return '';
    return value
        .toString()
        .toLowerCase()
        .trim()
        .replaceAll(RegExp(r'\s+'), ' ');
  }

  String _displayDuration(ContentItem item) {
    if (item.durationMinutes != null) {
      return '${item.durationMinutes} min';
    }
    return '0 min';
  }

  String _displayAge(ContentItem item) {
    final age = (item.ageGroup ?? '').trim();
    return age.isEmpty ? '-' : age;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
          onRefresh: _loadStories,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, color: _primaryText, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Back',
                        style: TextStyle(
                          color: _primaryText,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Story Library',
                            style: TextStyle(
                              color: _primaryText,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Find your next favorite story',
                            style: TextStyle(
                              color: _secondaryText,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: _selectedBlue.withOpacity(0.45),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Text(
                          '🌸',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: _cardColor,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: _borderColor),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for stories...',
                      hintStyle: TextStyle(color: _secondaryText),
                      prefixIcon: Icon(Icons.search, color: _secondaryText),
                      border: InputBorder.none,
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // FILTER BUTTON
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filters',
                      style: TextStyle(
                        color: _primaryText,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _showFilters = !_showFilters;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _selectedBlue.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.filter_alt_outlined, size: 16, color: _primaryText),
                            const SizedBox(width: 6),
                            Text(
                              _showFilters ? 'Hide' : 'Show',
                              style: TextStyle(color: _primaryText),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

// FILTER SECTION (TOGGLE)
                if (_showFilters)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: _cardColor,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: _borderColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // CATEGORY
                        Text(
                          'Category',
                          style: TextStyle(
                            color: _secondaryText,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),

                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: categories.map((category) {
                            final isSelected = selectedCategory == category;
                            return ChoiceChip(
                              label: Text(category),
                              selected: isSelected,
                              onSelected: (_) {
                                setState(() {
                                  selectedCategory = category;
                                });
                                _applyFilters();
                              },
                              selectedColor: _selectedBlue,
                              backgroundColor: _chipBg,
                              labelStyle: TextStyle(
                                color: _primaryText,
                                fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w500,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide.none,
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 18),

                        // AGE RANGE
                        Text(
                          'Age Range',
                          style: TextStyle(
                            color: _secondaryText,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),

                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: ageRanges.map((age) {
                            final isSelected = selectedAgeRange == age;
                            return ChoiceChip(
                              label: Text(age),
                              selected: isSelected,
                              onSelected: (_) {
                                setState(() {
                                  selectedAgeRange = age;
                                });
                                _applyFilters();
                              },
                              selectedColor: _selectedGreen,
                              backgroundColor: _chipBg,
                              labelStyle: TextStyle(
                                color: _primaryText,
                                fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w500,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide.none,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 22),
                Text(
                  '${_filteredStories.length} stories found',
                  style: TextStyle(
                    color: _secondaryText,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                if (_filteredStories.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Text(
                        'No stories found',
                        style: TextStyle(
                          color: _secondaryText,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                else
                  GridView.builder(
                    itemCount: _filteredStories.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.79,
                    ),
                    itemBuilder: (context, index) {
                      final story = _filteredStories[index];
                      return _storyCard(story);
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _bottomNav(),
    );
  }

  Widget _storyCard(ContentItem story) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () {
        if (story.audiobookId != null && story.audiobookId!.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AudioPlayerPage(
                audiobookId: story.audiobookId!,
              ),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _cardColor,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: _borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: (story.coverImage != null && story.coverImage!.isNotEmpty)
                  ? Image.network(
                story.coverImage!,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    height: 120,
                    width: double.infinity,
                    color: _chipBg,
                    child: Icon(Icons.menu_book,
                        color: _primaryText, size: 40),
                  );
                },
              )
                  : Container(
                height: 120,
                width: double.infinity,
                color: _chipBg,
                child: Icon(Icons.menu_book,
                    color: _primaryText, size: 40),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              story.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: _primaryText,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              story.author?.isNotEmpty == true ? story.author! : 'Unknown Author',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: _secondaryText,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  _displayDuration(story),
                  style: TextStyle(
                    color: _primaryText,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _chipBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _displayAge(story),
                    style: TextStyle(
                      color: _secondaryText,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget _bottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: _borderColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home_outlined, false, onTap: () {
            Navigator.pushNamed(context, '/homepage');
          }),
          _navItem(Icons.menu_book_outlined, true),
          _navItem(Icons.settings_outlined, false, onTap: () {
            Navigator.pushNamed(context, '/settings');
          }),
          _navItem(Icons.logout_outlined, false),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, bool selected, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selected ? _selectedGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(
          icon,
          color: _primaryText,
          size: 24,
        ),
      ),
    );
  }
}