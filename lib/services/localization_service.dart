import 'package:flutter/material.dart';

class LocalizationService extends ChangeNotifier {
  String _currentLanguage = 'en';

  String get currentLanguage => _currentLanguage;

  void changeLocale(String languageCode) {
    if (_currentLanguage != languageCode) {
      _currentLanguage = languageCode;
      notifyListeners();
    }
  }

  String translate(String key) {
    // Basic mock translation map
    if (_translations[_currentLanguage] != null &&
        _translations[_currentLanguage]!.containsKey(key)) {
      return _translations[_currentLanguage]![key]!;
    }
    return key; // Fallback to key
  }

  final Map<String, Map<String, String>> _translations = {
    'en': {
      'app_title': 'Smart Aid',
      'login': 'Login',
      'signup': 'Sign Up',
      'create_account': 'Create Account',
      'full_name': 'Full Name',
      'enter_name': 'Enter your name',
      'age': 'Age',
      'enter_age': 'Enter your age',
      'already_user': 'Already have an account?',
      'new_user': 'New User?',
      'fill_all_fields': 'Please fill all fields',
      'greeting_morning': 'Good Morning',
      'greeting_afternoon': 'Good Afternoon',
      'greeting_evening': 'Good Evening',
      'your_status': 'Your Status',
      'all_systems_normal': 'All Systems Normal',
      'quick_actions': 'Quick Actions',
      'first_aid': 'First Aid',
      'flashlight': 'Flashlight',
      'emergency': 'Emergency',
      'next_reminder': 'Next Reminder',
      'medications': 'Medications',
      'tip_of_day': 'Safety Tip of the Day',
      'profile': 'Profile',
      'medical_info': 'Medical Information',
      'emergency_contacts': 'Emergency Contacts',
      'preferences': 'Preferences',
      'sign_out': 'Sign Out',
      'blood_group': 'Blood Group',
      'allergies': 'Allergies',
      'conditions': 'Medical Conditions',
      'add_contact': 'Add Contact',
      'mobile_number': 'Mobile Number',
      'language': 'Language',
      'font_size': 'Font Size',
      'save_changes': 'Changes saved successfully',
      'fa_search': 'Search conditions...',
      'emergency_sos_title': 'Emergency SOS',
      'quick_access_help': 'Quick access to help',
      'sos_activated': 'SOS Activated',
      'sos_sent_msg': 'Emergency alerts sent to contacts with location',
      'im_safe': 'I\'m Safe',
      'marked_safe_message': 'Marked as Safe',
      'safe_sms_body': 'I am safe. My location:',
      'women_safety': 'Women Safety',
      'ambulance': 'Ambulance',
      'police': 'Police',
      'fire': 'Fire',
      // First Aid Items
      'cpr_title': 'CPR (Cardiopulmonary Resuscitation)',
      'burns_title': 'Burns',
      'cuts_title': 'Cuts & Scrapes',
      'choking_title': 'Choking',
      'heart_attack_title': 'Heart Attack',
      'stroke_title': 'Stroke',
      'drowning_title': 'Drowning',
      'shock_title': 'Electric Shock',
      'fainting_title': 'Fainting',
      'poisoning_title': 'Poisoning',
      'seizure_title': 'Seizure',
      'allergy_title': 'Allergic Reaction',
      'nose_bleed_title': 'Nose Bleed',
      'heat_stroke_title': 'Heat Stroke',
      'bee_sting_title': 'Bee Sting',

      // Heart Attack
      'step_heart_1': 'Call emergency services immediately.',
      'step_heart_2': 'Have the person sit down, stay calm, and rest.',
      'step_heart_3': 'Loosen any tight clothing.',
      'step_heart_4':
          'If they have prescribed chest pain medication, help them take it.',
      'do_heart_1': 'Keep the person calm and reassured.',
      'do_heart_2': 'Monitor their breathing and pulse.',
      'do_heart_3': 'Begin CPR if they become unconscious and stop breathing.',
      'dont_heart_1': 'Do not leave the person alone.',
      'dont_heart_2':
          'Do not give them anything to eat or drink unless it\'s aspirin (if not allergic).',

      // Stroke
      'step_stroke_1':
          'Use FAST: Face drooping? Arms weak? Speech slurred? Time to call.',
      'step_stroke_2': 'Call emergency services immediately.',
      'step_stroke_3': 'Note the time when symptoms started.',
      'do_stroke_1': 'Keep the person comfortable and supported.',
      'do_stroke_2': 'Check if their airway is clear.',
      'dont_stroke_1': 'Do not let them sleep or talk you out of calling help.',
      'dont_stroke_2':
          'Do not give them food or water (swallowing might be impaired).',

      // CPR
      'step_cpr_1': 'Check for response. Shake shoulders lightly.',
      'step_cpr_2': 'Call emergency services immediately.',
      'step_cpr_3': 'Place hands one on top of the other in center of chest.',
      'step_cpr_4': 'Push hard and fast (100-120 beats per minute).',
      'step_cpr_5':
          'Give rescue breaths if trained, otherwise continue compressions.',
      'do_cpr_1': 'Keep elbows straight and lock your arms.',
      'do_cpr_2': 'Allow chest to fully recoil between compressions.',
      'dont_cpr_1': 'Do not stop unless you are exhausted or help arrives.',
      'dont_cpr_2': 'Do not be afraid to push hard.',

      // Choking
      'step_choking_1': 'Encourage them to cough.',
      'step_choking_2': 'Give 5 back blows between shoulder blades.',
      'step_choking_3': 'Give 5 abdominal thrusts (Heimlich Maneuver).',
      'do_choking_1': 'Alternate between back blows and abdominal thrusts.',
      'do_choking_2': 'Call emergency if obstruction doesn\'t clear.',
      'dont_choking_1': 'Do not interfere if they are coughing forcefully.',

      // Cuts
      'step_cuts_1': 'Wash your hands to avoid infection.',
      'step_cuts_2':
          'Apply gentle pressure with a clean cloth to stop bleeding.',
      'step_cuts_3': 'Rinse the wound with clean water.',
      'step_cuts_4': 'Cover with a sterile bandage.',
      'do_cuts_1': 'Keep the wound clean and dry.',
      'do_cuts_2': 'Change the dressing daily.',
      'dont_cuts_1': 'Do not remove embedded objects; seek professional help.',
      'tool_bandage': 'Bandage',
      'tool_antiseptic': 'Antiseptic',
      'tool_water': 'Clean Water',

      // Burns
      'step_burns_1':
          'Cool the burn with cool running water for 10-20 minutes.',
      'step_burns_2': 'Remove tight items/jewelry before area swells.',
      'step_burns_3': 'Cover with a sterile, non-fluffy dressing.',
      'step_burns_4': 'Take pain reliever if necessary.',
      'do_burns_1': 'Keep the person warm.',
      'do_burns_2': 'Sit them upright if face is burnt.',
      'dont_burns_1': 'Do not use ice, iced water, or creams.',
      'dont_burns_2': 'Do not burst blisters.',
      'dont_burns_3': 'Do not remove clothing stuck to the skin.',
      'tool_cloth': 'Clean Cloth',

      // Drowning
      'step_drowning_1': 'Get the person onto dry land safely.',
      'step_drowning_2': 'Check for breathing and responsiveness.',
      'step_drowning_3': 'Start CPR immediately if not breathing.',
      'do_drowning_1': 'Remove wet clothes and keep them warm.',
      'dont_drowning_1':
          'Do not jump in water unless trained; minimize danger to yourself.',

      // Electric Shock
      'step_shock_1': 'Turn off the power source safely if possible.',
      'step_shock_2':
          'Do not touch the person if they are still in contact with power.',
      'step_shock_3': 'Call emergency services.',
      'step_shock_4': 'Check breathing and start CPR if needed.',
      'do_shock_1': 'Stand on dry material (rubber/wood) if approaching.',
      'do_shock_2': 'Treat any burns found.',
      'dont_shock_1': 'Do not touch with bare hands while current is active.',
      'dont_shock_2': 'Do not go near high-voltage wires.',

      // Fainting
      'step_fainting_1': 'Lay the person down on their back.',
      'step_fainting_2': 'Raise their legs slightly above heart level.',
      'step_fainting_3': 'Loosen tight clothing (belts, collars).',
      'do_fainting_1': 'Check their airway and breathing.',
      'do_fainting_2': 'Place in recovery position if they vomit.',
      'dont_fainting_1': 'Do not splash water on their face.',
      'dont_fainting_2': 'Do not let them stand up too quickly.',

      // Poisoning
      'step_poison_1': 'Identify what was swallowed/inhaled.',
      'step_poison_2': 'Call Poison Control or emergency services immediately.',
      'step_poison_3': 'Follow specific instructions from professionals.',
      'do_poison_1': 'Monitor breathing constantly.',
      'do_poison_2': 'Save the container of the poison.',
      'dont_poison_1': 'Do not induce vomiting unless instructed.',
      'dont_poison_2': 'Do not give anything to eat or drink.',

      // Seizure
      'step_seizure_1': 'Ease the person to the floor.',
      'step_seizure_2': 'Turn them onto their side to help breathing.',
      'step_seizure_3': 'Clear the area of hard or sharp objects.',
      'do_seizure_1': 'Put something soft under their head.',
      'do_seizure_2': 'Time the seizure length.',
      'dont_seizure_1': 'Do not hold them down or try to stop movements.',
      'dont_seizure_2': 'Do not put anything in their mouth.',

      // Allergic Reaction
      'step_allergy_1': 'Call emergency services if breathing is difficult.',
      'step_allergy_2': 'Ask if they have an auto-injector (EpiPen).',
      'step_allergy_3': 'Help them use the injector if needed.',
      'do_allergy_1': 'Lay them flat with legs raised (if possible).',
      'dont_allergy_1': 'Do not wait to see if symptoms get worse.',
      'tool_epipen': 'EpiPen',

      // Nose Bleed
      'step_nose_1': 'Sit upright and lean forward slightly.',
      'step_nose_2': 'Pinch the soft part of the nose just below the bridge.',
      'step_nose_3': 'Hold pressure for 10-15 minutes without checking.',
      'do_nose_1': 'Breathe through the mouth.',
      'do_nose_2': 'Apply a cold pack to the bridge of the nose.',
      'dont_nose_1': 'Do not lean back (blood may flow down throat).',
      'dont_nose_2': 'Do not blow nose immediately after bleeding stops.',

      // Heat Stroke
      'step_heat_1': 'Move to a cool, shaded place.',
      'step_heat_2': 'Remove excess clothing.',
      'step_heat_3': 'Cool with fan, spray, or wet cloths.',
      'step_heat_4': 'Give small sips of water if conscious.',
      'do_heat_1': 'Apply ice packs to armpits/groin/neck.',
      'do_heat_2': 'Call emergency services if confused or unconscious.',
      'dont_heat_1': 'Do not give fluids if unconscious.',

      // Bee Sting
      'step_bee_1': 'Remove the stinger by scraping with a flat edge.',
      'step_bee_2': 'Wash the area with soap and water.',
      'step_bee_3': 'Apply a cold pack to reduce swelling.',
      'do_bee_1': 'Watch for signs of allergic reaction.',
      'do_bee_2': 'Elevate the area if possible.',
      'dont_bee_1':
          'Do not squeeze the stinger with tweezers (may release more venom).',
      'dont_bee_2': 'Do not scratch the sting area.',

      // Snake Bite
      'snake_bite_title': 'Snake Bite',
      'step_snake_1': 'Call emergency services immediately.',
      'step_snake_2': 'Keep the person calm and still to slow venom spread.',
      'step_snake_3':
          'Remove jewelry or tight clothing before swelling starts.',
      'do_snake_1': 'Keep the bite area below heart level.',
      'do_snake_2':
          'Clean the wound with water and cover with a clean dressing.',
      'dont_snake_1': 'Do not cut the wound or try to suck out the venom.',
      'dont_snake_2': 'Do not apply ice or a tourniquet.',
      'dont_snake_3': 'Do not let the person walk or move around.',

      // Dog Bite
      'dog_bite_title': 'Dog Bite',
      'step_dog_1': 'Wash the wound gently with warm water and soap.',
      'step_dog_2': 'Apply pressure with a clean cloth to stop bleeding.',
      'step_dog_3': 'Apply antibiotic ointment and a sterile bandage.',
      'step_dog_4': 'Seek medical attention (risk of infection/rabies).',
      'do_dog_1': 'Report the bite to local authorities if the dog is unknown.',
      'do_dog_2': 'Keep the wound elevated.',
      'dont_dog_1':
          'Do not ignore puncture wounds; they are prone to infection.',

      // Fractures
      'fracture_title': 'Fractures (Broken Bone)',
      'step_fracture_1':
          'Stop any bleeding using gentle pressure with sterile bandages.',
      'step_fracture_2':
          'Immobilize the injured area; do not try to realign the bone.',
      'step_fracture_3':
          'Apply ice packs to limit swelling and help relieve pain.',
      'do_fracture_1': 'Treat for shock if the person feels faint.',
      'do_fracture_2':
          'Call emergency services for deformities or open wounds.',
      'dont_fracture_1': 'Do not massage the affected area.',
      'dont_fracture_2':
          'Do not let the person eat or drink (in case surgery is needed).',

      // Reminders
      'reminders_title': 'Reminders',
      'morning': 'Morning',
      'afternoon': 'Afternoon',
      'evening': 'Evening',
      'add_reminder': 'Add Reminder',
      'edit_reminder': 'Edit Reminder',
      'label': 'Label',
      'repeat': 'Repeat',
      'every_day': 'Every Day',
      'weekdays_only': 'Weekdays',
      'weekends_only': 'Weekends',
      'save': 'Save',
      'cancel': 'Cancel',
      'delete_confirm': 'Delete this reminder?',
      // Tips
      'tip_total_count': '3',
      'tip_1': 'Keep a first aid kit in your car and home.',
      'tip_2': 'Learn CPR - it saves lives.',
      'tip_3': 'Check smoke detector batteries twice a year.',
    },
    // Add other languages as needed
  };
}
