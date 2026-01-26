import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/first_aid_data.dart';
import '../../models/first_aid_item.dart';
import '../../services/localization_service.dart';
import '../../theme/app_colors.dart';
import 'first_aid_detail_screen.dart';

class FirstAidScreen extends StatefulWidget {
  const FirstAidScreen({super.key});

  @override
  State<FirstAidScreen> createState() => _FirstAidScreenState();
}

class _FirstAidScreenState extends State<FirstAidScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  List<FirstAidItem> _filteredItems = [];

  final List<String> _categories = ['All', 'Common', 'Critical', 'Outdoor'];

  @override
  void initState() {
    super.initState();
    _filteredItems = FirstAidData.items;
    _searchController.addListener(_filterItems);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    final loc = Provider.of<LocalizationService>(context, listen: false);

    setState(() {
      _filteredItems = FirstAidData.items.where((item) {
        final title = loc.translate(item.titleKey).toLowerCase();
        final matchesSearch = title.contains(query);
        final matchesCategory =
            _selectedCategory == 'All' || item.category == _selectedCategory;
        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
      _filterItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationService>(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.translate('first_aid'),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const Text(
              'Find emergency guides quickly',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: loc.translate('fa_search'),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primaryBlue),
                ),
              ),
            ),
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: _categories.map((category) {
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      _onCategorySelected(category);
                    },
                    backgroundColor: Colors.grey[200],
                    selectedColor: AppColors.primaryBlue,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.primaryBlue
                            : Colors.transparent,
                      ),
                    ),
                    showCheckmark: false,
                  ),
                );
              }).toList(),
            ),
          ),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredItems.length,
              separatorBuilder: (c, i) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
                return _buildFirstAidCard(context, item, loc);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFirstAidCard(
    BuildContext context,
    FirstAidItem item,
    LocalizationService loc,
  ) {
    Color severityColor;
    Color severityBg;

    switch (item.severity.toLowerCase()) {
      case 'critical':
      case 'high':
        severityColor = Colors.orange;
        severityBg = Colors.orange.withOpacity(0.1);
        break;
      case 'medium':
        severityColor = Colors.orange.shade300;
        severityBg = Colors.orange.shade50;
        break;
      case 'low':
        severityColor = Colors.grey;
        severityBg = Colors.grey.shade100;
        break;
      default:
        severityColor = Colors.grey;
        severityBg = Colors.grey.shade100;
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => FirstAidDetailScreen(item: item),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade100),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            if (item.iconData != null)
              Container(
                margin: const EdgeInsets.only(right: 16),
                child: Icon(item.iconData, size: 28, color: Colors.black87),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.translate(item.titleKey),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Tap for instructions',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: severityBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                item.severity.toLowerCase(),
                style: TextStyle(
                  color: severityColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }
}
