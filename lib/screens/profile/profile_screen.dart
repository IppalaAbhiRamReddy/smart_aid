import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../services/auth_service.dart';
import '../../theme/app_colors.dart';
import '../../services/localization_service.dart';
import '../../services/preferences_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService =
      AuthService(); // Though Provider is better, we can invoke directly as per original

  bool _isLoading = true;
  bool _isEditing = false;

  late UserModel _userModel;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _medicalConditionsController =
      TextEditingController();
  final TextEditingController _currentMedicationsController =
      TextEditingController();

  String _selectedBloodGroup = 'O+';
  bool _notifications = true;

  @override
  void initState() {
    super.initState();
    _optionsLoadUserData();

    final authService = Provider.of<AuthService>(context, listen: false);
    authService.addListener(_optionsLoadUserData);
  }

  @override
  void dispose() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.removeListener(_optionsLoadUserData);
    _nameController.dispose();
    _ageController.dispose();
    _allergiesController.dispose();
    _medicalConditionsController.dispose();
    _currentMedicationsController.dispose();
    super.dispose();
  }

  void _optionsLoadUserData() {
    if (_isEditing) return;

    final user = Provider.of<AuthService>(context, listen: false).userProfile;
    if (user != null) {
      if (mounted) {
        setState(() {
          _userModel = user;
          _isLoading = false;

          _nameController.text = _userModel.name;
          _ageController.text = _userModel.age.toString();
          _medicalConditionsController.text =
              _userModel.medicalConditions ?? '';
          _currentMedicationsController.text =
              _userModel.currentMedications ?? '';
          _allergiesController.text = _userModel.allergies ?? '';
          _selectedBloodGroup = _userModel.bloodGroup ?? 'O+';
          _notifications = _userModel.preferences.notifications;
        });
      }
    }
  }

  Future<void> _saveProfile() async {
    final loc = Provider.of<LocalizationService>(context, listen: false);
    setState(() => _isLoading = true);

    try {
      final prefs = Provider.of<PreferencesService>(context, listen: false);
      final authService = Provider.of<AuthService>(context, listen: false);
      final currentUser = authService.currentUser;

      if (currentUser == null) throw 'No authenticated user found';

      final updatedUser = UserModel(
        id: currentUser.uid,
        name: _nameController.text,
        age: int.tryParse(_ageController.text) ?? _userModel.age,
        phone: _userModel.phone,
        email: _userModel.email,
        photoUrl: _userModel
            .photoUrl, // Keep existing URL if any, but we don't change it anymore
        bloodGroup: _selectedBloodGroup,
        medicalConditions: _medicalConditionsController.text,
        currentMedications: _currentMedicationsController.text,
        allergies: _allergiesController.text,
        emergencyContacts: _userModel.emergencyContacts,
        preferences: UserPreferences(
          language: prefs.languageCode,
          fontSize: prefs.fontSize,
          darkMode: false,
          notifications: _notifications,
        ),
        memberSince: _userModel.memberSince,
      );

      print('DEBUG: Current User ID: ${_userModel.id}');
      print('DEBUG: Attempting to update profile for ID: ${updatedUser.id}');

      await authService.updateProfile(updatedUser);

      if (mounted) {
        setState(() {
          _userModel = updatedUser;
          _isEditing = false;
          _isLoading = false;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(loc.translate('save_changes'))));
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _handleSignOut() async {
    await Provider.of<AuthService>(context, listen: false).signOut();
    if (mounted) context.go('/login');
  }

  void _addEmergencyContact() {
    final loc = Provider.of<LocalizationService>(context, listen: false);
    final nameCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loc.translate('add_contact')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(
                labelText: loc.translate('full_name'),
              ),
            ),
            TextField(
              controller: phoneCtrl,
              decoration: InputDecoration(
                labelText: loc.translate('mobile_number'),
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        // ... (rest of dialog actions same)
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameCtrl.text.isNotEmpty && phoneCtrl.text.isNotEmpty) {
                setState(() {
                  final updatedContacts = List<EmergencyContact>.from(
                    _userModel.emergencyContacts,
                  );
                  updatedContacts.add(
                    EmergencyContact(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: nameCtrl.text,
                      phone: phoneCtrl.text,
                    ),
                  );
                  _userModel = UserModel(
                    id: _userModel.id,
                    name: _userModel.name,
                    age: _userModel.age,
                    phone: _userModel.phone,
                    email: _userModel.email,
                    photoUrl: _userModel.photoUrl,
                    bloodGroup: _userModel.bloodGroup,
                    medicalConditions: _userModel.medicalConditions,
                    currentMedications: _userModel.currentMedications,
                    allergies: _userModel.allergies,
                    emergencyContacts: updatedContacts,
                    preferences: _userModel.preferences,
                    memberSince: _userModel.memberSince,
                  );
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _removeContact(String id) {
    setState(() {
      final updatedContacts = List<EmergencyContact>.from(
        _userModel.emergencyContacts,
      );
      updatedContacts.removeWhere((c) => c.id == id);
      _userModel = UserModel(
        id: _userModel.id,
        name: _userModel.name,
        age: _userModel.age,
        phone: _userModel.phone,
        email: _userModel.email,
        photoUrl: _userModel.photoUrl,
        bloodGroup: _userModel.bloodGroup,
        medicalConditions: _userModel.medicalConditions,
        currentMedications: _userModel.currentMedications,
        allergies: _userModel.allergies,
        emergencyContacts: updatedContacts,
        preferences: _userModel.preferences,
        memberSince: _userModel.memberSince,
      );
    });
  }

  Future<void> _callNumber(String number) async {
    final Uri launchUri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch dialer for $number')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationService>(context);

    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(loc.translate('profile')),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: _isEditing
                ? _saveProfile
                : () => setState(() => _isEditing = true),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileCard(loc),
            const SizedBox(height: 24),
            _buildSectionTitle(loc.translate('medical_info')),
            _buildMedicalInfoForm(loc),
            const SizedBox(height: 24),
            _buildSectionTitle(loc.translate('emergency_contacts')),
            _buildEmergencyContactsSection(loc),
            const SizedBox(height: 24),
            _buildSectionTitle(loc.translate('preferences')),
            _buildPreferencesSection(loc),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _handleSignOut,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  foregroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(loc.translate('sign_out')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildProfileCard(LocalizationService loc) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
            child: _userModel.name.isNotEmpty
                ? Text(
                    _userModel.name[0].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 30,
                      color: AppColors.primaryBlue,
                    ),
                  )
                : const Icon(
                    Icons.person,
                    size: 40,
                    color: AppColors.primaryBlue,
                  ),
          ),
          const SizedBox(height: 12),
          Text(
            _userModel.name.isEmpty ? 'User' : _userModel.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            '${_userModel.age} ${loc.translate('years_old')}',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 20),
          Center(
            child: _buildStatItem(
              loc.translate('blood_group'),
              _selectedBloodGroup,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBlue,
          ),
        ),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildMedicalInfoForm(LocalizationService loc) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField(
              loc.translate('full_name'),
              _nameController,
              enabled: _isEditing,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              loc.translate('age'),
              _ageController,
              enabled: _isEditing,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedBloodGroup,
              decoration: InputDecoration(
                labelText: loc.translate('blood_group'),
                border: const OutlineInputBorder(),
              ),
              items: [
                'A+',
                'A-',
                'B+',
                'B-',
                'AB+',
                'AB-',
                'O+',
                'O-',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: _isEditing
                  ? (val) => setState(() => _selectedBloodGroup = val!)
                  : null,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              loc.translate('allergies'),
              _allergiesController,
              maxLines: null, // Allow expanding
              enabled: _isEditing,
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              loc.translate('conditions'),
              _medicalConditionsController,
              maxLines: null, // Allow expanding
              enabled: _isEditing,
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              loc.translate('current_medications'),
              _currentMedicationsController,
              maxLines: null, // Allow expanding
              enabled: _isEditing,
              keyboardType: TextInputType.multiline,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    int? maxLines = 1,
    bool enabled = true,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      enabled: enabled,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      style: const TextStyle(color: Colors.black),
    );
  }

  Widget _buildEmergencyContactsSection(LocalizationService loc) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (_userModel.emergencyContacts.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  loc.translate('no_contacts_yet'),
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ..._userModel.emergencyContacts.map(
              (contact) => ListTile(
                onTap: _isEditing ? null : () => _callNumber(contact.phone),
                leading: const Icon(Icons.phone, color: Colors.green),
                title: Text(contact.name),
                subtitle: Text(contact.phone),
                trailing: _isEditing
                    ? IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeContact(contact.id),
                      )
                    : const Icon(Icons.call, color: AppColors.primaryBlue),
              ),
            ),
            if (_isEditing)
              TextButton.icon(
                onPressed: _userModel.emergencyContacts.length < 5
                    ? _addEmergencyContact
                    : null,
                icon: const Icon(Icons.add),
                label: Text(loc.translate('add_contact')),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferencesSection(LocalizationService loc) {
    final prefs = Provider.of<PreferencesService>(context);
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: Text(loc.translate('language')),
              trailing: DropdownButton<String>(
                value: prefs.languageCode,
                underline: Container(),
                items: const [
                  DropdownMenuItem(value: 'en', child: Text('English')),
                  DropdownMenuItem(value: 'te', child: Text('Telugu')),
                ],
                onChanged: (val) {
                  if (val != null) {
                    prefs.setLanguage(val);
                    Provider.of<LocalizationService>(
                      context,
                      listen: false,
                    ).changeLocale(val);
                  }
                },
              ),
            ),
            const Divider(),
            ListTile(
              title: Text(loc.translate('font_size')),
              subtitle: Slider(
                value: prefs.fontSize,
                min: 1.0,
                max: 1.5,
                divisions: 5,
                label: '${prefs.fontSize}x',
                onChanged: (val) => prefs.setFontSize(val),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
