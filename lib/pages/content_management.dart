import 'package:flutter/material.dart';
import 'upload_content_page.dart';
import '../services/database_service.dart';
import '../models/content_item.dart';
import '../models/content_summary.dart';

class ContentManagementPage extends StatefulWidget {
  const ContentManagementPage({super.key});

  @override
  State<ContentManagementPage> createState() => _ContentManagementPageState();
}

class _ContentManagementPageState extends State<ContentManagementPage> {
  final TextEditingController _searchController = TextEditingController();

  bool _isLoading = true;
  String _selectedFilter = 'All';

  ContentSummary? _summary;

  List<ContentItem> _allItems = [];
  List<ContentItem> _filteredItems = [];

  final List<String> _filters = [
    'All',
    'Audio',
    'Text',
    'AI Generated',
    'User Uploaded',
  ];

  final Color _softBackground = const Color(0xFFF2F4F7);
  final Color _cardBackground = Colors.white;
  final Color _primaryText = const Color(0xFF4B5C78);
  final Color _secondaryText = const Color(0xFF7D8CA5);
  final Color _accentBlue = const Color(0xFFAFC8EA);
  final Color _softBeige = const Color(0xFFF0ECE6);
  final Color _softGreen = const Color(0xFFDCEBDD);

  @override
  void initState() {
    super.initState();
    _loadContentData();

    _searchController.addListener(() {
      _applyLocalFilter();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadContentData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final summaryResponse = await DatabaseService.getContentSummary();
      final listResponse = await DatabaseService.getContentList();

      if (summaryResponse.success && summaryResponse.data is ContentSummary) {
        _summary = summaryResponse.data as ContentSummary;
      }

      if (listResponse.success && listResponse.data is List<ContentItem>) {
        _allItems = listResponse.data as List<ContentItem>;
        _applyLocalFilter();
      }
    } catch (e) {
      debugPrint('Error loading content data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _applyLocalFilter() {
    final query = _searchController.text.trim().toLowerCase();

    List<ContentItem> result = List.from(_allItems);

    // filter chip
    if (_selectedFilter == 'Audio') {
      result = result.where((item) {
        return (item.type ?? '').toLowerCase() == 'audio';
      }).toList();
    } else if (_selectedFilter == 'Text') {
      result = result.where((item) {
        return (item.type ?? '').toLowerCase() == 'text';
      }).toList();
    } else if (_selectedFilter == 'AI Generated') {
      result = result.where((item) => item.isGenerated).toList();
    } else if (_selectedFilter == 'User Uploaded') {
      result = result.where((item) => item.isUserUploaded).toList();
    }

    // search bar
    if (query.isNotEmpty) {
      result = result.where((item) {
        final title = (item.title).toLowerCase();
        final topic = (item.topic ?? '').toLowerCase();
        final tags = (item.tags ?? '').toLowerCase();
        final category = (item.category ?? '').toLowerCase();
        final difficulty = (item.difficulty ?? '').toLowerCase();

        return title.contains(query) ||
            topic.contains(query) ||
            tags.contains(query) ||
            category.contains(query) ||
            difficulty.contains(query);
      }).toList();
    }

    setState(() {
      _filteredItems = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _softBackground,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
          onRefresh: _loadContentData,
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
                        'Back to Dashboard',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Content Management',
                            style: TextStyle(
                              color: _primaryText,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Upload and organize educational materials',
                            style: TextStyle(
                              color: _secondaryText,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    _uploadButton(),
                  ],
                ),
                const SizedBox(height: 22),
                _summaryCard(
                  icon: Icons.menu_book_outlined,
                  iconBg: const Color(0xFFECEFF6),
                  title: '${_summary?.totalItems ?? 0}',
                  subtitle: 'Total Items',
                ),
                const SizedBox(height: 14),
                _summaryCard(
                  icon: Icons.headphones_outlined,
                  iconBg: _softGreen,
                  title: '${_summary?.audioFiles ?? 0}',
                  subtitle: 'Audio Files',
                ),
                const SizedBox(height: 14),
                _summaryCard(
                  icon: Icons.description_outlined,
                  iconBg: _softBeige,
                  title: '${_summary?.textFiles ?? 0}',
                  subtitle: 'Text Files',
                ),
                const SizedBox(height: 14),
                _summaryCard(
                  icon: Icons.auto_awesome_outlined,
                  iconBg: const Color(0xFFECEFF6),
                  title: '${_summary?.aiGenerated ?? 0}',
                  subtitle: 'AI Generated',
                ),
                const SizedBox(height: 18),
                _searchAndFilterCard(),
                const SizedBox(height: 18),
                if (_filteredItems.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        'No content found',
                        style: TextStyle(
                          color: _secondaryText,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                else
                  ..._filteredItems.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _contentCard(item),
                  )),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _bottomNav(),
    );
  }

  Widget _uploadButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const UploadContentPage(),
          ),
        ).then((_) => _loadContentData());
      },
      child: Container(
        width: 120,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        decoration: BoxDecoration(
          color: _accentBlue,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(Icons.upload_outlined, color: _primaryText, size: 20),
            const SizedBox(height: 6),
            Text(
              'Upload\nContent',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _primaryText,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard({
    required IconData icon,
    required Color iconBg,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _cardBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD9DEE7)),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: _primaryText),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: _primaryText,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: _secondaryText,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _searchAndFilterCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _cardBackground,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFD9DEE7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: _softBeige,
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                _applyLocalFilter();
              },
              decoration: InputDecoration(
                hintText: 'Search content by title, topic, or tags...',
                hintStyle: TextStyle(color: _secondaryText),
                prefixIcon: Icon(Icons.search, color: _secondaryText),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Icon(Icons.filter_alt_outlined, color: _secondaryText, size: 18),
              const SizedBox(width: 8),
              Text(
                'Filter by type',
                style: TextStyle(
                  color: _secondaryText,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _filters.map((filter) {
              final isSelected = _selectedFilter == filter;
              return ChoiceChip(
                label: Text(filter),
                selected: isSelected,
                onSelected: (_) {
                  setState(() {
                    _selectedFilter = filter;
                  });
                  _applyLocalFilter();
                },
                selectedColor: _accentBlue,
                backgroundColor: _softBeige,
                labelStyle: TextStyle(
                  color: _primaryText,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                  side: BorderSide.none,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _contentCard(ContentItem item) {
    final bool isAudio = (item.type ?? '').toLowerCase() == 'audio';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBackground,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFD9DEE7)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: isAudio ? _softGreen : _softBeige,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              isAudio ? Icons.headphones_outlined : Icons.description_outlined,
              color: _primaryText,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: TextStyle(
                          color: _primaryText,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (item.isGenerated)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFECEFF6),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.auto_awesome_outlined,
                                size: 14, color: _primaryText),
                            const SizedBox(width: 4),
                            Text(
                              'AI Generated',
                              style: TextStyle(
                                color: _primaryText,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: _infoItem('Topic', item.topic ?? '-')),
                    Expanded(child: _infoItem('Difficulty', item.difficulty ?? '-')),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: _infoItem('Type', item.type ?? '-')),
                    Expanded(child: _infoItem('Upload Date', item.createdAt ?? '-')),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: item.tagList
                      .map(
                        (tag) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: _softBeige,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          color: _primaryText,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              _actionButton(Icons.edit_outlined, const Color(0xFFEFECE6)),
              const SizedBox(height: 10),
              _actionButton(Icons.delete_outline, const Color(0xFFF5E8E8)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: _secondaryText,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            color: _primaryText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _actionButton(IconData icon, Color bg) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: _primaryText, size: 20),
    );
  }

  Widget _bottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFD9DEE7))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home_outlined, false),
          _navItem(Icons.people_outline, false),
          _navItem(Icons.upload_outlined, true),
          _navItem(Icons.bar_chart_outlined, false),
          _navItem(Icons.settings_outlined, false),
          _navItem(Icons.logout_outlined, false),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, bool selected) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFE8DCC0) : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(
        icon,
        color: _primaryText,
        size: 24,
      ),
    );
  }
}