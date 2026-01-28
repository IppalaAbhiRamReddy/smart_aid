import 'package:flutter/material.dart';

class LocalizationService extends ChangeNotifier {
  String _currentLanguage;

  LocalizationService({String initialLanguage = 'en'})
    : _currentLanguage = initialLanguage;

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
      'home': 'Home',
      'login': 'Login',
      'signup': 'Sign Up',
      'create_account': 'Create Account',
      'full_name': 'Full Name',
      'enter_name': 'Enter your name',
      'age': 'Age',
      'enter_age': 'Enter your age',
      'already_user': 'Already have an account?',
      'new_user': 'New User?',
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
      'medical_id': 'Medical ID',
      'check_reminders_subtitle': 'Check your reminders',
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
      'years_old': 'years old',
      'no_contacts_yet': 'No contacts added yet',
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
      'double_tap_sos': 'Double Tap to Activate SOS',
      'sos_label': 'SOS',
      'double_tap_safe': 'Double Tap to Mark Safe',
      'emergency_services_title': 'Emergency Services',
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
      'repeat_once': 'Once',
      'save': 'Save',
      'cancel': 'Cancel',
      'delete': 'Delete',
      'delete_confirm': 'Delete this reminder?',
      'no_reminders': 'No reminders yet',
      'category_label': 'Category',
      'cat_medication': 'Medication',
      'cat_appointment': 'Appointment',
      'cat_checkup': 'Checkup',
      'cat_other': 'Other',

      // Hypothermia
      'hypothermia_title': 'Hypothermia',
      'step_hypothermia_1': 'Move the person to a warm, dry place.',
      'step_hypothermia_2':
          'Remove wet clothing and wrap them in dry blankets.',
      'step_hypothermia_3': 'Cover the head and neck to retain heat.',
      'step_hypothermia_4':
          'Give warm, sweet drinks if fully conscious (no alcohol).',
      'do_hypothermia_1': 'Warm the person gradually.',
      'do_hypothermia_2': 'Use body heat (skin-to-skin contact) if necessary.',
      'dont_hypothermia_1':
          'Do not rub their skin or use direct heat (hot water, heating pads).',
      'dont_hypothermia_2': 'Do not give alcohol or caffeine.',

      // Head Injury
      'head_injury_title': 'Head Injury',
      'step_head_1': 'Encourage the person to rest and minimize movement.',
      'step_head_2': 'Apply a cold pack to the injury site to reduce swelling.',
      'step_head_3':
          'Monitor for confusion, vomiting, or loss of consciousness.',
      'step_head_4': 'Call emergency services if symptoms worsen.',
      'do_head_1': 'Keep the person awake if they are drowsy.',
      'do_head_2': 'Treat any scalp bleeding with gentle pressure.',
      'dont_head_1': 'Do not leave them alone, especially the first 24 hours.',
      'dont_head_2': 'Do not delay medical help if they blacked out.',

      // Asthma
      'asthma_title': 'Asthma Attack',
      'step_asthma_1': 'Help the person sit upright and stay calm.',
      'step_asthma_2':
          'Help them take one puff of their blue reliever inhaler.',
      'step_asthma_3':
          'Wait 1 minute. If no improvement, take another puff (up to 10 puffs).',
      'do_asthma_1': 'Loosen tight clothing.',
      'do_asthma_2': 'Call emergency services if symptoms don\'t improve.',
      'dont_asthma_1': 'Do not let them lie down (makes breathing harder).',
      'tool_inhaler': 'Inhaler',

      // Sprain
      'sprain_title': 'Sprain',
      'step_sprain_1': 'Rest the injured limb.',
      'step_sprain_2': 'Apply ice for 20 minutes every 2-3 hours.',
      'step_sprain_3': 'Compress with a bandage to support the injury.',
      'step_sprain_4': 'Elevate the limb above the level of the heart.',
      'do_sprain_1': 'Monitor for numbness or loss of circulation.',
      'do_sprain_2': 'Seek medical advice if unable to bear weight.',
      'dont_sprain_1': 'Do not apply heat in the first 48 hours.',
      'dont_sprain_2': 'Do not massage the area immediately.',
      'tool_ice_pack': 'Ice Pack',

      // Eye Injury
      'eye_injury_title': 'Eye Injury',
      'step_eye_1': 'Do not rub the eye.',
      'step_eye_2': 'Wash out the eye with clean water or saline solution.',
      'step_eye_3': 'Blink repeatedly to help remove small particles.',
      'step_eye_4': 'Cover the eye with a sterile pad if the injury is severe.',
      'do_eye_1': 'Keep the person calm and discourage movement.',
      'do_eye_2': 'Seek medical help for embedded objects or chemical burns.',
      'dont_eye_1': 'Do not try to remove objects embedded in the eye.',
      'dont_eye_2': 'Do not use eye drops unless prescribed.',
      // Tips
      'tip_total_count': '20',
      'tip_1': 'Keep a first aid kit in your car and home.',
      'tip_2': 'Learn CPR – it can save lives.',
      'tip_3': 'Check smoke detector batteries twice a year.',
      'tip_4': 'Save emergency numbers on your phone.',
      'tip_5': 'Drink enough water, especially in hot weather.',
      'tip_6': 'Do not ignore chest pain or breathing problems.',
      'tip_7': 'Wear a helmet while riding a two-wheeler.',
      'tip_8': 'Wash your hands before eating.',
      'tip_9': 'Keep medicines out of children’s reach.',
      'tip_10': 'Do not use expired medicines.',
      'tip_11': 'Keep emergency contacts updated.',
      'tip_12': 'Avoid walking alone at night in unsafe areas.',
      'tip_13': 'Install a torch or emergency light at home.',
      'tip_14': 'Learn basic first aid for burns and cuts.',
      'tip_15': 'Do not overload electrical sockets.',
      'tip_16': 'Store important documents safely.',
      'tip_17': 'Check gas stove and cylinders regularly.',
      'tip_18': 'Wear seat belts while driving.',
      'tip_19': 'Keep your phone charged during travel.',
      'tip_20': 'Teach children how to call emergency services.',

      // First Aid UI
      'fa_subtitle': 'Find emergency guides quickly',
      'tap_instructions': 'Tap for instructions',
      'category_all': 'All',
      'category_common': 'Common',
      'category_critical': 'Critical',
      'category_outdoor': 'Outdoor',
      'fa_instructions': 'First Aid Instructions',
      'tab_steps': 'Steps',
      'tab_do_dont': "Do & Don't",
      'tab_tools': 'Tools',
      'no_steps': 'No steps available.',
      'do_this': 'Do This',
      'avoid_this': 'Avoid This',
      'no_tools': 'No specific tools required.',

      // Auth Keys
      'email': 'Email',
      'password': 'Password',
      'confirm_password': 'Confirm Password',
      'forgot_password': 'Forgot Password?',
      'reset_password': 'Reset Password',
      'reset_password_desc':
          'Enter your email to receive a password reset link.',
      'enter_email': 'Enter your email',
      'enter_password': 'Enter password',
      'welcome_back': 'Welcome Back',
      'send': 'Send',
      'email_sent': 'Email Sent',
      'password_reset_sent': 'Password reset instructions have been sent to',
      'error': 'Error',
      'ok': 'OK',
      'cancel': 'Cancel',
      'account_created': 'Account Created',
      'verification_email_sent':
          'A verification email has been sent to your email. Please check your inbox.',
      'go_to_login': 'Go to Login',
      'passwords_do_not_match': 'Passwords do not match',
      'password_too_short': 'Password must be at least 6 characters',
      'valid_email_error': 'Please enter a valid email',
      'fill_all_fields': 'Please fill all fields',
      'auth_email_not_registered': 'Email is not registered',
      'auth_user_not_found': 'User not found',
      'auth_invalid_credentials': 'Invalid credentials',
      'auth_email_in_use': 'Email is already in use',
      'auth_invalid_email': 'Invalid email address',
      'auth_weak_password': 'Password is too weak',
      'auth_unknown_error': 'Authentication error occurred',
      'add': 'Add',
      'guest': 'Guest',
      'english': 'English',
      'telugu': 'Telugu',
      'emergency_mode': 'EMERGENCY',
      'sos_active_msg': 'SOS Mode Active!',
      'sos_active_toast': 'S.O.S Mode Active',
      'did_you_know': 'Did You Know?',
      'sms_open_error': 'Could not open SMS app',

      'time_picker_select': 'Select Time',
      'cancel': 'Cancel',
      'ok': 'OK',
      'enter_time': 'Enter time',
      'hour': 'Hour',
      'minute': 'Minute',
    },
    // Add other languages as needed
    'te': {
      'app_title': 'స్మార్ట్ ఎయిడ్',
      'home': 'హోమ్',
      'login': 'లాగిన్',
      'signup': 'సైన్ అప్',
      'create_account': 'ఖాతా సృష్టించండి',
      'current_medications': 'Current Medications',
      'full_name': 'Full Name',
      'enter_name': 'మీ పూర్తి పేరు నమోదు చేయండి',
      'age': 'వయస్సు',
      'enter_age': 'మీ వయస్సు నమోదు చేయండి',
      'already_user': 'ఖాతా ఉందా?',
      'new_user': 'కొత్త వినియోగదారా?',
      'greeting_morning': 'శుభోదయం',
      'greeting_afternoon': 'శుభ మధ్యాహ్నం',
      'greeting_evening': 'శుభ సాయంత్రం',
      'your_status': 'మీ స్థితి',
      'all_systems_normal': 'అన్నీ సవ్యంగా ఉన్నాయి',
      'quick_actions': 'త్వరిత చర్యలు',
      'first_aid': 'ప్రథమ చికిత్స',
      'flashlight': 'టార్చ్ లైట్',
      'emergency': 'అత్యవసరం',
      'next_reminder': 'తదుపరి రిమైండర్',
      'medications': 'మందులు',
      'medical_id': 'వైద్య ఐడీ',
      'check_reminders_subtitle': 'మీ రిమైండర్‌లను తనిఖీ చేయండి',
      'tip_of_day': 'ఈ రోజు భద్రతా చిట్కా',
      'profile': 'ప్రొఫైల్',
      'medical_info': 'వైద్య సమాచారం',
      'emergency_contacts': 'అత్యవసర సంప్రదింపులు',
      'preferences': 'అభిరుచులు',
      'sign_out': 'లాగ్ అవుట్',
      'blood_group': 'రక్త వర్గం',
      'allergies': 'అలెర్జీలు',
      'conditions': 'వైద్య పరిస్థితులు',
      'add_contact': 'సంప్రదింపు జోడించండి',
      'mobile_number': 'మొబైల్ నంబర్',
      'language': 'భాష',
      'font_size': 'అక్షర పరిమాణం',
      'save_changes': 'మార్పులు సేవ్ చేయబడ్డాయి',
      'years_old': 'సంవత్సరాల వయస్సు',
      'no_contacts_yet': 'ఇంకా సంప్రదింపులు లేవు',
      'fa_search': 'పరిస్థితులను శోధించండి...',
      'emergency_sos_title': 'అత్యవసర SOS',
      'quick_access_help': 'సహాయానికి త్వరిత ప్రాప్యత',
      'sos_activated': 'SOS సక్రియమైంది',
      'sos_sent_msg': 'లొకేషన్‌తో అత్యవసర హెచ్చరికలు పంపబడ్డాయి',
      'im_safe': 'నేను క్షేమంగా ఉన్నాను',
      'marked_safe_message': 'క్షేమంగా ఉన్నట్లు గుర్తించబడింది',
      'safe_sms_body': 'నేను క్షేమంగా ఉన్నాను. నా స్థానం:',
      'women_safety': 'మహిళా భద్రత',
      'ambulance': 'అంబులెన్స్',
      'police': 'పోలీస్',
      'fire': 'అగ్నిమాపక శాఖ',
      'double_tap_sos': 'SOS కోసం రెండుసార్లు నొక్కండి',
      'sos_label': 'SOS',
      'double_tap_safe': 'సేఫ్‌గా గుర్తించేందుకు రెండుసార్లు నొక్కండి',
      'emergency_services_title': 'అత్యవసర సేవలు',

      // First Aid Items
      'cpr_title': 'సీపీఆర్ (CPR)',
      'burns_title': 'కాలిన గాయాలు',
      'cuts_title': 'కోతలు & గాయాలు',
      'choking_title': 'గొంతులో ఇరుక్కుపోవడం',
      'heart_attack_title': 'గుండెపోటు',
      'stroke_title': 'పక్షవాతం',
      'drowning_title': 'నీట మునగడం',
      'shock_title': 'విద్యుత్ ఘాతం',
      'fainting_title': 'మూర్ఛ',
      'poisoning_title': 'విషం',
      'seizure_title': 'సీజర్ / వణుకు',
      'allergy_title': 'అలెర్జీ ప్రతిచర్య',
      'nose_bleed_title': 'ముక్కు రక్తస్రావం',
      'heat_stroke_title': 'వడదెబ్బ',
      'bee_sting_title': 'తేనెటీగ కాటు',
      'snake_bite_title': 'పాము కాటు',
      'dog_bite_title': 'కుక్క కాటు',
      'fracture_title': 'ఎముక విరుగుట',

      // CPR
      'step_cpr_1': 'స్పందన ఉందో లేదో చూడండి. భుజాలను నెమ్మదిగా కదిలించండి.',
      'step_cpr_2': 'వెంటనే అత్యవసర సేవలకు కాల్ చేయండి.',
      'step_cpr_3': 'ఛాతీ మధ్యలో చేతులు ఒకదానిపై ఒకటి ఉంచండి.',
      'step_cpr_4':
          'గట్టిగా మరియు వేగంగా నొక్కండి (నిమిషానికి 100–120 సార్లు).',
      'step_cpr_5':
          'శిక్షణ ఉంటే శ్వాస ఇవ్వండి, లేకపోతే ఛాతీ నొక్కడం కొనసాగించండి.',
      'do_cpr_1': 'మోచేతులు నేరుగా ఉంచండి.',
      'do_cpr_2': 'ప్రతి ఒత్తిడి తర్వాత ఛాతీని పైకి రానివ్వండి.',
      'dont_cpr_1': 'సహాయం వచ్చే వరకు ఆపవద్దు.',
      'dont_cpr_2': 'గట్టిగా నొక్కడానికి భయపడవద్దు.',

      // Heart Attack
      'step_heart_1': 'వెంటనే అత్యవసర సేవలకు కాల్ చేయండి.',
      'step_heart_2': 'వ్యక్తిని కూర్చోబెట్టి ప్రశాంతంగా ఉంచండి.',
      'step_heart_3': 'బిగుతుగా ఉన్న దుస్తులను వదులుగా చేయండి.',
      'step_heart_4': 'మందులు ఉంటే వాటిని తీసుకోవడంలో సహాయం చేయండి.',
      'do_heart_1': 'వ్యక్తిని ప్రశాంతంగా ఉంచండి.',
      'do_heart_2': 'శ్వాస మరియు నాడిని గమనించండి.',
      'do_heart_3': 'స్పృహ కోల్పోతే CPR ప్రారంభించండి.',
      'dont_heart_1': 'వ్యక్తిని ఒంటరిగా వదలవద్దు.',
      'dont_heart_2': 'ఆహారం లేదా నీరు ఇవ్వవద్దు.',

      // Burns
      'step_burns_1': 'కాలిన గాయాన్ని 10–20 నిమిషాలు చల్లని నీటిలో ఉంచండి.',
      'step_burns_2': 'బిగుతుగా ఉన్న వస్తువులను తొలగించండి.',
      'step_burns_3': 'శుభ్రమైన డ్రెస్సింగ్‌తో కప్పండి.',
      'step_burns_4': 'నొప్పి నివారణ మందులు తీసుకోండి.',
      'do_burns_1': 'వ్యక్తిని వెచ్చగా ఉంచండి.',
      'do_burns_2': 'ముఖం కాలితే నిటారుగా కూర్చోబెట్టండి.',
      'dont_burns_1': 'ఐస్ లేదా క్రీమ్ వాడవద్దు.',
      'dont_burns_2': 'పొక్కులను పగలగొట్టవద్దు.',
      'dont_burns_3': 'చర్మానికి అంటుకున్న దుస్తులు తీసివేయవద్దు.',
      'tool_cloth': 'శుభ్రమైన గుడ్డ',

      // Snake Bite
      'step_snake_1': 'వెంటనే అత్యవసర సేవలకు కాల్ చేయండి.',
      'step_snake_2': 'విషం వ్యాపించకుండా వ్యక్తిని కదలకుండా ఉంచండి.',
      'step_snake_3':
          'వాపు రాకముందే ఆభరణాలు లేదా బిగుతుగా ఉన్న బట్టలను తొలగించండి.',
      'do_snake_1': 'కాటు వేసిన భాగాన్ని గుండె కంటే తక్కువ ఎత్తులో ఉంచండి.',
      'do_snake_2': 'గాయాన్ని నీటితో శుభ్రం చేసి కట్టు కట్టండి.',
      'dont_snake_1':
          'గాయాన్ని కోయవద్దు లేదా విషం పీల్చడానికి ప్రయత్నించవద్దు.',
      'dont_snake_2': 'ఐస్ పెట్టవద్దు.',
      'dont_snake_3': 'వ్యక్తిని నడవనివ్వవద్దు.',

      // Dog Bite
      'step_dog_1': 'గాయాన్ని సబ్బు మరియు నీటితో శుభ్రం చేయండి.',
      'step_dog_2': 'రక్తస్రావం ఆపడానికి శుభ్రమైన గుడ్డతో నొక్కండి.',
      'step_dog_3': 'యాంటీబయాటిక్ ఆయింట్‌మెంట్ రాసి బ్యాండేజ్ వేయండి.',
      'step_dog_4': 'వైద్యుడిని సంప్రదించండి (రాబిస్ ప్రమాదం ఉంది).',
      'do_dog_1': 'కుక్క తెలియనిదైతే అధికారులకు ఫిర్యాదు చేయండి.',
      'do_dog_2': 'గాయాన్ని ఎత్తులో ఉంచండి.',
      'dont_dog_1':
          'గాయాలను నిర్లక్ష్యం చేయవద్దు; ఇన్ఫెక్షన్ వచ్చే అవకాశం ఉంది.',

      // Fractures
      'step_fracture_1': 'రక్తస్రావం ఉంటే ఆపడానికి ప్రయత్నించండి.',
      'step_fracture_2': 'గాయపడిన భాగాన్ని కదల్చకండి.',
      'step_fracture_3': 'వాపు తగ్గించడానికి ఐస్ ప్యాక్ పెట్టండి.',
      'do_fracture_1': 'కళ్లుతిరుగుతున్నట్లు అనిపిస్తే షాక్ చికిత్స చేయండి.',
      'do_fracture_2': 'ఎముక బయటకు కనిపిస్తే వెంటనే డాక్టర్‌కు కాల్ చేయండి.',
      'dont_fracture_1': 'గాయపడిన ప్రదేశాన్ని మసాజ్ చేయవద్దు.',
      'dont_fracture_2': 'వ్యక్తికి తినడానికి లేదా త్రాగడానికి ఏమీ ఇవ్వవద్దు.',

      // Cuts
      'step_cuts_1': 'ఇన్ఫెక్షన్ రాకుండా చేతులు కడుక్కోండి.',
      'step_cuts_2': 'రక్తం ఆపడానికి శుభ్రమైన గుడ్డతో నొక్కండి.',
      'step_cuts_3': 'గాయాన్ని శుభ్రమైన నీటితో కడగండి.',
      'step_cuts_4': 'శుభ్రమైన బ్యాండేజ్ వేయండి.',
      'do_cuts_1': 'గాయాన్ని పొడిగా మరియు శుభ్రంగా ఉంచండి.',
      'do_cuts_2': 'ప్రతిరోజూ డ్రెస్సింగ్ మార్చండి.',
      'dont_cuts_1': 'లోపల ఇరుక్కున్న వస్తువులను తీయవద్దు.',
      'tool_bandage': 'బ్యాండేజ్',
      'tool_antiseptic': 'యాంటిసెప్టిక్',
      'tool_water': 'శుభ్రమైన నీరు',

      // Choking
      'step_choking_1': 'దగ్గమని చెప్పండి.',
      'step_choking_2': 'వీపుపై 5 సార్లు కొట్టండి.',
      'step_choking_3': '5 సార్లు పొట్టపై ఒత్తిడి (హైమ్లిక్ పద్ధతి) చేయండి.',
      'do_choking_1': 'వీపుదెబ్బలు మరియు పొట్ట ఒత్తిడిని మారుమారుగా చేయండి.',
      'do_choking_2': 'అడ్డంకి తొలగకపోతే అత్యవసర సేవలకు కాల్ చేయండి.',
      'dont_choking_1': 'వారు బలంగా దగ్గుతుంటే జోక్యం చేసుకోవద్దు.',

      // Stroke
      'step_stroke_1':
          'FAST పద్ధతి ఉపయోగించండి: ముఖం వాలిపోవడం? చేతులు బలహీనమా? మాట తడబడుతోందా? వెంటనే కాల్ చేయండి.',
      'step_stroke_2': 'వెంటనే అత్యవసర సేవలకు కాల్ చేయండి.',
      'step_stroke_3': 'లక్షణాలు ఎప్పుడు మొదలయ్యాయో గమనించండి.',
      'do_stroke_1': 'వ్యక్తిని సౌకర్యవంతంగా ఉంచండి.',
      'do_stroke_2': 'శ్వాస మార్గం సరిగా ఉందో లేదో చూడండి.',
      'dont_stroke_1': 'వారిని నిద్రపోనివ్వవద్దు.',
      'dont_stroke_2': 'ఆహారం లేదా నీరు ఇవ్వవద్దు.',

      // Drowning
      'step_drowning_1': 'వ్యక్తిని సురక్షితంగా బయటకు తీసుకురండి.',
      'step_drowning_2': 'శ్వాస ఉందో లేదో పరీక్షించండి.',
      'step_drowning_3': 'శ్వాస లేకపోతే వెంటనే CPR ప్రారంభించండి.',
      'do_drowning_1': 'తడి బట్టలు తీసివేసి వెచ్చగా ఉంచండి.',
      'dont_drowning_1': 'శిక్షణ లేకపోతే నీటిలోకి దూకవద్దు.',

      // Electric Shock
      'step_shock_1': 'పవర్ ఆఫ్ చేయండి.',
      'step_shock_2': 'కరెంట్ ఉన్నప్పుడు వ్యక్తిని తాకవద్దు.',
      'step_shock_3': 'అత్యవసర సేవలకు కాల్ చేయండి.',
      'step_shock_4': 'అవసరమైతే CPR చేయండి.',
      'do_shock_1': 'ఎండిన చెక్క లేదా రబ్బరు మీద నిల్చోండి.',
      'do_shock_2': 'కాలిన గాయాలకు చికిత్స చేయండి.',
      'dont_shock_1': 'కరెంట్ ఉన్నప్పుడు చేతులతో తాకవద్దు.',
      'dont_shock_2': 'హై వోల్టేజ్ వైర్ల దగ్గరకు వెళ్లవద్దు.',

      // Fainting
      'step_fainting_1': 'వ్యక్తిని వెల్లకిలా పడుకోబెట్టండి.',
      'step_fainting_2': 'కాళ్లను కొంచెం ఎత్తులో ఉంచండి.',
      'step_fainting_3': 'బిగుతుగా ఉన్న బట్టలు వదులు చేయండి.',
      'do_fainting_1': 'శ్వాసను గమనించండి.',
      'do_fainting_2': 'వాంతులు వస్తే పక్కకు తిప్పండి.',
      'dont_fainting_1': 'ముఖంపై నీళ్లు చల్లవద్దు.',
      'dont_fainting_2': 'వెంటనే నిలబడనివ్వవద్దు.',

      // Poisoning
      'step_poison_1': 'ఏమి మింగారో గుర్తించండి.',
      'step_poison_2': 'వెంటనే పాయిజన్ కంట్రోల్‌కు కాల్ చేయండి.',
      'step_poison_3': 'నిపుణుల సూచనలు పాటించండి.',
      'do_poison_1': 'శ్వాసను గమనిస్తూ ఉండండి.',
      'do_poison_2': 'విషం డబ్బాను భద్రపరచండి.',
      'dont_poison_1': 'చెప్పకపోతే వాంతులు చేయించవద్దు.',
      'dont_poison_2': 'ఏమీ తినడానికి లేదా తాగడానికి ఇవ్వవద్దు.',

      // Seizure
      'step_seizure_1': 'వ్యక్తిని నేలపై పడుకోబెట్టండి.',
      'step_seizure_2': 'శ్వాస కోసం పక్కకు తిప్పండి.',
      'step_seizure_3': 'చుట్టూ ఉన్న గట్టి వస్తువులను తొలగించండి.',
      'do_seizure_1': 'తల కింద మెత్తటి వస్త్రాన్ని ఉంచండి.',
      'do_seizure_2': 'సీజర్ ఎంతసేపు ఉందో గమనించండి.',
      'dont_seizure_1': 'వారిని గట్టిగా పట్టుకోవద్దు.',
      'dont_seizure_2': 'నోట్లో ఏమీ పెట్టవద్దు.',

      // Allergic Reaction
      'step_allergy_1':
          'శ్వాస తీసుకోవడం కష్టంగా ఉంటే అత్యవసర సేవలకు కాల్ చేయండి.',
      'step_allergy_2': 'ఎపిపెన్ ఉందో లేదో అడగండి.',
      'step_allergy_3': 'వాడటానికి సహాయం చేయండి.',
      'do_allergy_1': 'కాళ్లను ఎత్తులో ఉంచి పడుకోబెట్టండి.',
      'dont_allergy_1': 'లక్షణాలు పెరగే వరకు వేచి ఉండవద్దు.',
      'tool_epipen': 'ఎపిపెన్',

      // Nose Bleed
      'step_nose_1': 'నిటారుగా కూర్చుని ముందుకు వంగండి.',
      'step_nose_2': 'ముక్కు మెత్తటి భాగాన్ని గట్టిగా పట్టుకోండి.',
      'step_nose_3': '10–15 నిమిషాలు వదలకుండా పట్టుకోండి.',
      'do_nose_1': 'నోటి ద్వారా గాలి పీల్చుకోండి.',
      'do_nose_2': 'ముక్కుపై ఐస్ ప్యాక్ పెట్టండి.',
      'dont_nose_1': 'వెనక్కి వంగవద్దు.',
      'dont_nose_2': 'రక్తం ఆగిన వెంటనే ముక్కు చీదవద్దు.',

      // Heat Stroke
      'step_heat_1': 'చల్లని ప్రదేశానికి తీసుకెళ్లండి.',
      'step_heat_2': 'అదనపు బట్టలు తొలగించండి.',
      'step_heat_3': 'శరీరాన్ని చల్లబరచండి.',
      'step_heat_4': 'స్పృహ ఉంటే కొంచెం నీరు ఇవ్వండి.',
      'do_heat_1': 'చంకలు లేదా మెడ దగ్గర ఐస్ ప్యాక్ పెట్టండి.',
      'do_heat_2': 'స్పృహ కోల్పోతే అత్యవసర సేవలకు కాల్ చేయండి.',
      'dont_heat_1': 'స్పృహ లేనప్పుడు నీరు ఇవ్వవద్దు.',

      // Bee Sting
      'step_bee_1': 'ముల్లును నెమ్మదిగా తొలగించండి.',
      'step_bee_2': 'సబ్బు మరియు నీటితో కడగండి.',
      'step_bee_3': 'వాపు తగ్గడానికి ఐస్ పెట్టండి.',
      'do_bee_1': 'అలెర్జీ లక్షణాలు గమనించండి.',
      'do_bee_2': 'సాధ్యమైతే చేతిని లేదా కాలును ఎత్తులో ఉంచండి.',
      'dont_bee_1': 'ముల్లును గట్టిగా నొక్కవద్దు.',
      'dont_bee_2': 'గోకవద్దు.',

      // Reminders
      'reminders_title': 'రిమైండర్లు',
      'morning': 'ఉదయం',
      'afternoon': 'మధ్యాహ్నం',
      'evening': 'సాయంత్రం',
      'add_reminder': 'రిమైండర్ జోడించండి',
      'edit_reminder': 'రిమైండర్ సవరించండి',
      'label': 'పేరు',
      'repeat': 'పునరావృతం',
      'every_day': 'ప్రతి రోజు',
      'weekdays_only': 'వారపు రోజులు',
      'weekends_only': 'వారాంతాలు',
      'repeat_once': 'ఒకసారి',
      'save': 'సేవ్',
      'cancel': 'రద్దు',
      'delete': 'తొలగించండి',
      'delete_confirm': 'ఈ రిమైండర్‌ను తొలగించాలా?',
      'no_reminders': 'ఇంకా రిమైండర్‌లు లేవు',
      'category_label': 'వర్గం',
      'cat_medication': 'మందులు',
      'cat_appointment': 'అపాయింట్‌మెంట్',
      'cat_checkup': 'చెకప్',
      'cat_other': 'ఇతర',

      // Hypothermia
      'hypothermia_title': 'హైపోథర్మియా (అతి చలి వల్ల శరీరం చల్లబడడం)',
      'step_hypothermia_1':
          'వ్యక్తిని వెచ్చగా మరియు పొడిగా ఉన్న ప్రదేశానికి తీసుకెళ్లండి.',
      'step_hypothermia_2': 'తడి బట్టలు తీసివేసి వెచ్చని దుప్పట్లలో చుట్టండి.',
      'step_hypothermia_3': 'వేడి బయటకు పోకుండా తల మరియు మెడను కప్పండి.',
      'step_hypothermia_4': 'స్పృహలో ఉంటే వెచ్చని, తీపి పానీయాలు ఇవ్వండి.',
      'do_hypothermia_1': 'శరీరాన్ని నెమ్మదిగా వేడి చేయండి.',
      'do_hypothermia_2': 'అవసరమైతే మీ శరీర ఉష్ణోగ్రతను పంచుకోండి.',
      'dont_hypothermia_1':
          'చర్మాన్ని గట్టిగా రుద్దవద్దు లేదా నేరుగా వేడి ఉపయోగించవద్దు.',
      'dont_hypothermia_2': 'మద్యం లేదా కెఫిన్ ఉన్న పానీయాలు ఇవ్వవద్దు.',

      // Head Injury
      'head_injury_title': 'తల గాయం',
      'step_head_1': 'విశ్రాంతి తీసుకోమని చెప్పి కదలకుండా ఉండమని సూచించండి.',
      'step_head_2': 'వాపు తగ్గించడానికి ఐస్ ప్యాక్ పెట్టండి.',
      'step_head_3':
          'గందరగోళం, వాంతులు లేదా స్పృహ కోల్పోవడం ఉన్నాయా గమనించండి.',
      'step_head_4': 'లక్షణాలు తీవ్రమైతే వెంటనే అత్యవసర సేవలకు కాల్ చేయండి.',
      'do_head_1': 'నిద్ర వస్తుంటే మేల్కొని ఉంచండి.',
      'do_head_2': 'తలపై రక్తస్రావం ఉంటే మెత్తగా నొక్కండి.',
      'dont_head_1': 'మొదటి 24 గంటలు వారిని ఒంటరిగా వదలవద్దు.',
      'dont_head_2': 'స్పృహ కోల్పోతే వైద్య సహాయం ఆలస్యం చేయవద్దు.',

      // Asthma
      'asthma_title': 'ఆస్తమా',
      'step_asthma_1': 'నిటారుగా కూర్చోబెట్టి ప్రశాంతంగా ఉండమని చెప్పండి.',
      'step_asthma_2': 'వారి ఇన్హేలర్ నుంచి ఒక పఫ్ తీసుకునేందుకు సహాయం చేయండి.',
      'step_asthma_3':
          '1 నిమిషం వేచి ఉండండి. మెరుగుదల లేకపోతే మరో పఫ్ ఇవ్వండి.',
      'do_asthma_1': 'బిగుతుగా ఉన్న బట్టలు వదులుగా చేయండి.',
      'do_asthma_2': 'లక్షణాలు తగ్గకపోతే వెంటనే ఎమర్జెన్సీకి కాల్ చేయండి.',
      'dont_asthma_1': 'పడుకోనివ్వవద్దు (శ్వాస మరింత కష్టమవుతుంది).',
      'tool_inhaler': 'ఇన్హేలర్',

      // Sprain
      'sprain_title': 'బెణుకు',
      'step_sprain_1': 'గాయపడిన కాలు లేదా చేతికి విశ్రాంతి ఇవ్వండి.',
      'step_sprain_2': 'ప్రతి 2–3 గంటలకు 20 నిమిషాలు ఐస్ పెట్టండి.',
      'step_sprain_3': 'సపోర్ట్ కోసం బ్యాండేజ్ కట్టండి.',
      'step_sprain_4': 'గాయాన్ని గుండె స్థాయి కంటే ఎత్తులో ఉంచండి.',
      'do_sprain_1': 'రక్త ప్రసరణ ఆగిపోకుండా జాగ్రత్త వహించండి.',
      'do_sprain_2': 'నడవలేకపోతే వైద్యుడిని సంప్రదించండి.',
      'dont_sprain_1': 'మొదటి 48 గంటలు వేడి ప్యాక్ వాడవద్దు.',
      'dont_sprain_2': 'వెంటనే మసాజ్ చేయవద్దు.',
      'tool_ice_pack': 'ఐస్ ప్యాక్',

      // Eye Injury
      'eye_injury_title': 'కంటి గాయం',
      'step_eye_1': 'కన్ను నలపవద్దు.',
      'step_eye_2': 'శుభ్రమైన నీటితో కన్ను కడగండి.',
      'step_eye_3': 'చిన్న దుమ్ము తొలగేందుకు కళ్ళు రెప్పవేయండి.',
      'step_eye_4': 'గాయం తీవ్రమైతే శుభ్రమైన ప్యాడ్‌తో కప్పండి.',
      'do_eye_1': 'వ్యక్తిని ప్రశాంతంగా ఉంచండి.',
      'do_eye_2': 'రసాయనాలు పడితే వెంటనే డాక్టర్‌ను కలవండి.',
      'dont_eye_1': 'కంటిలో ఇరుక్కున్న వస్తువులను తీయవద్దు.',
      'dont_eye_2': 'డాక్టర్ సూచన లేకుండా ఐ డ్రాప్స్ వాడవద్దు.',

      // Tips
      'tip_total_count': '20',
      'tip_1': 'కారు మరియు ఇంట్లో ప్రథమ చికిత్స కిట్ ఉంచండి.',
      'tip_2': 'CPR నేర్చుకోండి – అది ప్రాణాలను కాపాడుతుంది.',
      'tip_3':
          'స్మోక్ డిటెక్టర్ బ్యాటరీలను సంవత్సరానికి రెండుసార్లు తనిఖీ చేయండి.',
      'tip_4': 'మీ ఫోన్‌లో అత్యవసర నంబర్లను సేవ్ చేసుకోండి.',
      'tip_5': 'ఎండాకాలంలో ముఖ్యంగా తగినంత నీరు త్రాగండి.',
      'tip_6': 'ఛాతీ నొప్పి లేదా శ్వాస సమస్యలను నిర్లక్ష్యం చేయవద్దు.',
      'tip_7': 'ద్విచక్ర వాహనం నడుపుతున్నప్పుడు హెల్మెట్ ధరించండి.',
      'tip_8': 'తినే ముందు చేతులు కడుక్కోండి.',
      'tip_9': 'మందులను పిల్లలకు అందకుండా ఉంచండి.',
      'tip_10': 'గడువు ముగిసిన మందులను వాడవద్దు.',
      'tip_11': 'అత్యవసర సంప్రదింపులను ఎప్పటికప్పుడు నవీకరించండి.',
      'tip_12': 'రాత్రిపూట అసురక్షిత ప్రదేశాల్లో ఒంటరిగా నడవకండి.',
      'tip_13': 'ఇంట్లో టార్చ్ లేదా ఎమర్జెన్సీ లైట్ ఉంచుకోండి.',
      'tip_14': 'కాలిన గాయాలు మరియు కోతలకు ప్రాథమిక చికిత్స నేర్చుకోండి.',
      'tip_15': 'ఎలక్ట్రిక్ సాకెట్లను ఎక్కువగా లోడ్ చేయవద్దు.',
      'tip_16': 'ముఖ్యమైన పత్రాలను భద్రంగా భద్రపరచండి.',
      'tip_17': 'గ్యాస్ స్టౌవ్ మరియు సిలిండర్లను క్రమం తప్పకుండా తనిఖీ చేయండి.',
      'tip_18': 'డ్రైవింగ్ చేస్తున్నప్పుడు సీట్ బెల్ట్ ధరించండి.',
      'tip_19': 'ప్రయాణ సమయంలో మీ ఫోన్ చార్జ్ ఉండేలా చూసుకోండి.',
      'tip_20': 'అత్యవసర సేవలకు ఎలా కాల్ చేయాలో పిల్లలకు నేర్పండి.',

      // First Aid UI
      'fa_subtitle': 'అత్యవసర చిట్కాలను త్వరగా కనుగొనండి',
      'tap_instructions': 'సూచనల కోసం నొక్కండి',
      'category_all': 'అన్నీ',
      'category_common': 'సాధారణ',
      'category_critical': 'అత్యవసర',
      'category_outdoor': 'బయట',
      'fa_instructions': 'ప్రథమ చికిత్స సూచనలు',
      'tab_steps': 'దశలు',
      'tab_do_dont': 'చేయవలసినవి & చేయకూడనివి',
      'tab_tools': 'పరికరాలు',
      'no_steps': 'దశలు అందుబాటులో లేవు.',
      'do_this': 'ఇది చేయండి',
      'avoid_this': 'ఇది నివారించండి',
      'no_tools': 'ప్రత్యేక పరికరాలు అవసరం లేదు.',

      // Auth Keys
      'email': 'ఈమెయిల్',
      'password': 'పాస్‌వర్డ్',
      'confirm_password': 'పాస్‌వర్డ్ నిర్ధారించండి',

      'forgot_password': 'పాస్‌వర్డ్ మర్చిపోయారా?',
      'reset_password': 'పాస్‌వర్డ్ రీసెట్',
      'reset_password_desc': 'రీసెట్ లింక్ పొందడానికి మీ ఈమెయిల్ నమోదు చేయండి.',

      'enter_email': 'మీ ఈమెయిల్ నమోదు చేయండి',
      'enter_password': 'పాస్‌వర్డ్ నమోదు చేయండి',

      'welcome_back': 'తిరిగి స్వాగతం',

      'send': 'పంపండి',
      'email_sent': 'ఈమెయిల్ పంపబడింది',
      'password_reset_sent': 'పాస్‌వర్డ్ రీసెట్ సూచనలు పంపబడ్డాయి',

      'error': 'లోపం',
      'ok': 'సరే',
      'cancel': 'రద్దు',

      'account_created': 'ఖాతా విజయవంతంగా సృష్టించబడింది',
      'verification_email_sent':
          'ధృవీకరణ ఈమెయిల్ పంపబడింది. దయచేసి మీ ఇన్‌బాక్స్‌ను తనిఖీ చేయండి.',

      'go_to_login': 'లాగిన్‌కి వెళ్లండి',

      'passwords_do_not_match': 'పాస్‌వర్డ్‌లు సరిపోలడం లేదు',
      'password_too_short': 'పాస్‌వర్డ్ కనీసం 6 అక్షరాలు ఉండాలి',
      'valid_email_error': 'దయచేసి సరైన ఈమెయిల్ నమోదు చేయండి',
      'fill_all_fields': 'దయచేసి అన్ని వివరాలను పూరించండి',

      'auth_email_not_registered': 'ఈమెయిల్ నమోదు కాలేదు',
      'auth_user_not_found': 'వినియోగదారు కనుగొనబడలేదు',
      'auth_invalid_credentials': 'సరికాని లాగిన్ వివరాలు',
      'auth_email_in_use': 'ఈమెయిల్ ఇప్పటికే వాడుకలో ఉంది',
      'auth_invalid_email': 'చెల్లని ఈమెయిల్ చిరునామా',
      'auth_weak_password': 'పాస్‌వర్డ్ చాలా బలహీనంగా ఉంది',
      'auth_unknown_error': 'ధృవీకరణలో అనుకోని లోపం జరిగింది',

      'emergency_mode': 'అత్యవసర మోడ్',

      'sos_active_msg': 'SOS మోడ్ ప్రస్తుతం సక్రియంగా ఉంది!',
      'sos_active_toast': 'SOS మోడ్ సక్రియంగా ఉంది',

      'did_you_know': 'మీకు తెలుసా?',
      'sms_open_error': 'SMS యాప్ తెరవలేకపోయింది',

      'time_picker_select': 'సమయాన్ని ఎంచుకోండి',
      'enter_time': 'సమయం నమోదు చేయండి',

      'hour': 'గంట',
      'minute': 'నిమిషం',

      'cancel': 'రద్దు',
      'ok': 'సరే',
    },
  };
}
