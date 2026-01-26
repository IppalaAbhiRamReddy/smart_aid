import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/first_aid_item.dart';
import '../../services/localization_service.dart';
import '../../services/tts_service.dart';
import '../../theme/app_colors.dart';

class FirstAidDetailScreen extends StatefulWidget {
  final FirstAidItem item;

  const FirstAidDetailScreen({super.key, required this.item});

  @override
  State<FirstAidDetailScreen> createState() => _FirstAidDetailScreenState();
}

class _FirstAidDetailScreenState extends State<FirstAidDetailScreen>
    with SingleTickerProviderStateMixin {
  final TtsService _ttsService = TtsService();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _ttsService.stop();
    _tabController.dispose();
    super.dispose();
  }

  void _speakSteps(LocalizationService loc) async {
    final steps = widget.item.steps.map((key) => loc.translate(key)).join('. ');
    await _ttsService.speak(steps, loc.currentLanguage);
  }

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationService>(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.translate(widget.item.titleKey),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const Text(
              'First Aid Instructions',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.volume_up_outlined),
            onPressed: () => _speakSteps(loc),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey[600],
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                tabs: const [
                  Tab(text: 'Steps', icon: Icon(Icons.flash_on, size: 18)),
                  Tab(
                    text: "Do & Don't",
                    icon: Icon(Icons.info_outline, size: 18),
                  ),
                  Tab(
                    text: 'Tools',
                    icon: Icon(Icons.medical_services_outlined, size: 18),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildStepsTab(loc),
                _buildDoDontTab(loc),
                _buildToolsTab(loc),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepsTab(LocalizationService loc) {
    if (widget.item.steps.isEmpty)
      return const Center(child: Text("No steps available."));
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.item.steps.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: AppColors.primaryBlue,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  loc.translate(widget.item.steps[index]),
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDoDontTab(LocalizationService loc) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (widget.item.dos.isNotEmpty) ...[
            _buildSectionCard(
              title: 'Do This',
              icon: Icons.check,
              items: widget.item.dos,
              isPositive: true,
              loc: loc,
            ),
            const SizedBox(height: 16),
          ],
          if (widget.item.donts.isNotEmpty)
            _buildSectionCard(
              title: 'Avoid This',
              icon: Icons.close,
              items: widget.item.donts,
              isPositive: false,
              loc: loc,
            ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<String> items,
    required bool isPositive,
    required LocalizationService loc,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isPositive ? Icons.check : Icons.close,
                color: isPositive ? Colors.green : Colors.red,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...items.map(
            (key) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    isPositive ? Icons.check : Icons.close,
                    size: 16,
                    color: isPositive ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      loc.translate(key),
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolsTab(LocalizationService loc) {
    if (widget.item.tools.isEmpty)
      return const Center(child: Text("No specific tools required."));
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: widget.item.tools.length,
      itemBuilder: (context, index) {
        final tool = widget.item.tools[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  tool.iconData,
                  color: AppColors.primaryBlue,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                loc.translate(tool.nameKey),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
