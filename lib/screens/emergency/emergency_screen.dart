import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import '../../services/localization_service.dart';
import '../../services/safety_service.dart';
import '../../services/auth_service.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_styles.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  Future<void> _activateSOS() async {
    HapticFeedback.heavyImpact();
    Provider.of<SafetyService>(context, listen: false).setSosActive(true);
    await _sendSmsIntent(isEmergency: true);
  }

  Future<void> _markSafe() async {
    final loc = Provider.of<LocalizationService>(context, listen: false);
    HapticFeedback.lightImpact();
    Provider.of<SafetyService>(context, listen: false).setSosActive(false);
    await _sendSmsIntent(isEmergency: false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.translate('marked_safe_message')),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _sendSmsIntent({required bool isEmergency}) async {
    try {
      final userData = Provider.of<AuthService>(
        context,
        listen: false,
      ).userProfile;

      if (userData == null || userData.emergencyContacts.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No emergency contacts found!')),
          );
        }
        return;
      }

      String locationStr = '';
      try {
        Position position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
          ),
        );
        locationStr =
            ' https://maps.google.com/?q=${position.latitude},${position.longitude}';
      } catch (e) {
        debugPrint('Location error: $e');
      }

      final loc = Provider.of<LocalizationService>(context, listen: false);
      final String body = isEmergency
          ? 'SOS! I need help. My current location is:$locationStr'
          : '${loc.translate('safe_sms_body')}$locationStr';

      final String recipients = userData.emergencyContacts
          .map((c) => c.phone)
          .join(',');

      final Uri smsUri = Uri(
        scheme: 'sms',
        path: recipients,
        queryParameters: <String, String>{'body': body},
      );

      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not open SMS app')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
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

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD32F2F), Color(0xFFB71C1C)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.translate('emergency_sos_title'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        loc.translate('quick_access_help'),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                if (Provider.of<SafetyService>(context).isSosActive)
                  _buildActivatedState(loc)
                else
                  _buildHoldButton(loc),
                const SizedBox(height: 40),
                _buildServicesGrid(loc),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHoldButton(LocalizationService loc) {
    return Column(
      children: [
        Text(
          loc.translate('double_tap_sos'),
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
        const SizedBox(height: 40),
        GestureDetector(
          onDoubleTap: _activateSOS,
          child: Stack(
            alignment: Alignment.center,
            children: [
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 1.0, end: 1.2),
                duration: const Duration(seconds: 1),
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  );
                },
              ),
              Container(
                width: 130,
                height: 130,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.white,
                      size: 48,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      loc.translate('sos_label'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivatedState(LocalizationService loc) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Colors.white,
                size: 40,
              ),
              const SizedBox(height: 8),
              Text(
                loc.translate('sos_activated'),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                loc.translate('sos_sent_msg'),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Text(
          loc.translate('double_tap_safe'),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onDoubleTap: _markSafe,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.verified_user_outlined,
                      color: Colors.white,
                      size: 40,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      loc.translate('im_safe'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServicesGrid(LocalizationService loc) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.phone_in_talk, color: AppColors.error),
              const SizedBox(width: 8),
              Text(
                loc.translate('emergency_services_title'),
                style: AppTextStyles.cardTitle.copyWith(color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.4,
            children: [
              _buildServiceCard(
                '1090',
                loc.translate('women_safety'),
                Icons.shield,
                Colors.pink,
              ),
              _buildServiceCard(
                '108',
                loc.translate('ambulance'),
                Icons.medical_services,
                Colors.red,
              ),
              _buildServiceCard(
                '100',
                loc.translate('police'),
                Icons.local_police,
                Colors.blue,
              ),
              _buildServiceCard(
                '101',
                loc.translate('fire'),
                Icons.local_fire_department,
                Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
    String number,
    String label,
    IconData icon,
    Color color,
  ) {
    return Material(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () => _callNumber(number),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              number,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
