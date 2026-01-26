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
      // Tips
      'tip_total_count': '3',
      'tip_1': 'Keep a first aid kit in your car and home.',
      'tip_2': 'Learn CPR - it saves lives.',
      'tip_3': 'Check smoke detector batteries twice a year.',

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
    },
    // Add other languages as needed
    'te': {
      'app_title': 'స్మార్ట్ ఎయిడ్',
      'home': 'హోమ్',
      'login': 'లాగిన్',
      'signup': 'సైన్ అప్',
      'create_account': 'ఖాతాను సృష్టించండి',
      'full_name': 'పూర్తి పేరు',
      'enter_name': 'మీ పేరు రాయండి',
      'age': 'వయస్సు',
      'enter_age': 'మీ వయస్సు నమోదు చేయండి',
      'already_user': 'ఖాతా ఉందా?',
      'new_user': 'కొత్త వాడుకరా?',
      'fill_all_fields': 'దయచేసి అన్ని వివరాలను పూరించండి',
      'greeting_morning': 'శుభోదయం',
      'greeting_afternoon': 'శుభ మధ్యాహ్నం',
      'greeting_evening': 'శుభ సాయంత్రం',
      'your_status': 'మీ స్థితి',
      'all_systems_normal': 'అంతా బాగుంది',
      'quick_actions': 'త్వరిత చర్యలు',
      'first_aid': 'ప్రథమ చికిత్స',
      'flashlight': 'ఫ్లాష్‌లైట్',
      'emergency': 'అత్యవసర పరిస్థితి',
      'next_reminder': 'తదుపరి రిమైండర్',
      'medications': 'మందులు',
      'medical_id': 'మెడికల్ ID',
      'check_reminders_subtitle': 'మీ రిమైండర్‌లను తనిఖీ చేయండి',
      'tip_of_day': 'ఈ రోజు భద్రతా చిట్కా',
      'profile': 'ప్రొఫైల్',
      'medical_info': 'వైద్య సమాచారం',
      'emergency_contacts': 'అత్యవసర పరిచయాలు',
      'preferences': 'ప్రాధాన్యతలు',
      'sign_out': 'సైన్ అవుట్',
      'blood_group': 'రక్త వర్గం',
      'allergies': 'అలెర్జీలు',
      'conditions': 'వైద్య పరిస్థితులు',
      'add_contact': 'కాంటాక్ట్‌ని జోడించండి',
      'mobile_number': 'మొబైల్ నంబర్',
      'language': 'భాష',
      'font_size': 'ఫాంట్ సైజు',
      'save_changes': 'మార్పులు సేవ్ చేయబడ్డాయి',
      'years_old': 'సంవత్సరాల వయస్సు',
      'no_contacts_yet': 'ఇంకా కాంటాక్ట్‌లు జోడించలేదు',
      'fa_search': 'పరిస్థితులను శోధించండి...',
      'emergency_sos_title': 'అత్యవసర SOS',
      'quick_access_help': 'సహాయానికి త్వరిత యాక్సెస్',
      'sos_activated': 'SOS యాక్టివేట్ చేయబడింది',
      'sos_sent_msg': 'లొకేషన్‌తో అత్యవసర హెచ్చరికలు పంపబడ్డాయి',
      'im_safe': 'నేను క్షేమంగా ఉన్నాను',
      'marked_safe_message': 'క్షేమంగా ఉన్నట్లు గుర్తించారు',
      'safe_sms_body': 'నేను క్షేమంగా ఉన్నాను. నా స్థానం:',
      'women_safety': 'మహిళా భద్రత',
      'ambulance': 'అంబులెన్స్',
      'police': 'పోలీసు',
      'fire': 'ఫైర్',
      'double_tap_sos': 'SOS కోసం రెండుసార్లు నొక్కండి',
      'sos_label': 'SOS',
      'double_tap_safe': 'సేఫ్ అని మార్క్ చేయడానికి రెండుసార్లు నొక్కండి',
      'emergency_services_title': 'అత్యవసర సేవలు',
      // First Aid Items
      'cpr_title': 'CPR (సిపిఆర్)',
      'burns_title': 'కాలిన గాయాలు',
      'cuts_title': 'కోతలు & గాయాలు',
      'choking_title': 'గొంతులో ఇరుక్కుపోవడం',
      'heart_attack_title': 'గుండెపోటు',
      'stroke_title': 'పక్షవాతం',
      'drowning_title': 'నీట మునుగుట',
      'shock_title': 'విద్యుత్ ఘాతం',
      'fainting_title': 'మూర్ఛ',
      'poisoning_title': 'విషం',
      'seizure_title': 'వణుకు/సీజర్',
      'allergy_title': 'అలెర్జీ రియాక్షన్',
      'nose_bleed_title': 'ముక్కు నుండి రక్తం కారడం',
      'heat_stroke_title': 'వడదెబ్బ',
      'bee_sting_title': 'తేనెటీగ కాటు',
      'snake_bite_title': 'పాము కాటు',
      'dog_bite_title': 'కుక్క కాటు',
      'fracture_title': 'ఎముకలు విరుగుట',

      // CPR
      'step_cpr_1': 'స్పందన కోసం చూడండి. భుజాలను నెమ్మదిగా కదిలించండి.',
      'step_cpr_2': 'వెంటనే అత్యవసర సేవలకు కాల్ చేయండి.',
      'step_cpr_3': 'ఛాతీ మధ్యలో చేతులు ఒకదానిపై ఒకటి ఉంచండి.',
      'step_cpr_4':
          'గట్టిగా మరియు వేగంగా నెట్టండి (నిమిషానికి 100-120 సార్లు).',
      'step_cpr_5':
          'శిక్షణ ఉంటే శ్వాస ఇవ్వండి, లేకపోతే ఛాతీని మాత్రమే నెట్టండి.',
      'do_cpr_1': 'మోచేతులు నేరుగా ఉంచండి.',
      'do_cpr_2': 'ప్రతి ఒత్తిడి తర్వాత ఛాతీని పైకి రానివ్వండి.',
      'dont_cpr_1': 'మీరు అలసిపోయే వరకు లేదా సహాయం వచ్చే వరకు ఆపవద్దు.',
      'dont_cpr_2': 'గట్టిగా నెట్టడానికి భయపడవద్దు.',

      // Heart Attack
      'step_heart_1': 'వెంటనే అత్యవసర సేవలకు కాల్ చేయండి.',
      'step_heart_2': 'వ్యక్తిని కూర్చోబెట్టి, ప్రశాంతంగా ఉంచండి.',
      'step_heart_3': 'బిగుతుగా ఉన్న దుస్తులను వదులు చేయండి.',
      'step_heart_4':
          'ఛాతీ నొప్పి మందులు ఉంటే, వాటిని తీసుకోవడానికి సహాయం చేయండి.',
      'do_heart_1': 'వ్యక్తిని ప్రశాంతంగా ఉంచండి.',
      'do_heart_2': 'శ్వాస మరియు నాడిని గమనించండి.',
      'do_heart_3': 'స్పృహ కోల్పోయి శ్వాస ఆగిపోతే CPR ప్రారంభించండి.',
      'dont_heart_1': 'వ్యక్తిని ఒంటరిగా వదిలివేయవద్దు.',
      'dont_heart_2':
          'ఆస్పిరిన్ తప్ప (అలెర్జీ లేకపోతే) తినడానికి లేదా త్రాగడానికి ఏమీ ఇవ్వవద్దు.',

      // Snake Bite
      'step_snake_1': 'వెంటనే అత్యవసర సేవలకు కాల్ చేయండి.',
      'step_snake_2': 'విషం వ్యాపించకుండా ఉండటానికి వ్యక్తిని కదలకుండా ఉంచండి.',
      'step_snake_3':
          'వాపు రాకముందే ఆభరణాలు లేదా బిగుతుగా ఉన్న బట్టలు తొలగించండి.',
      'do_snake_1': 'కాటు వేసిన ప్రదేశాన్ని గుండె కంటే తక్కువ ఎత్తులో ఉంచండి.',
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
      'do_fracture_1':
          'వ్యక్తి కళ్లు తిరుగుతున్నట్లు అనిపిస్తే షాక్ చికిత్స చేయండి.',
      'do_fracture_2': 'ఎముక బయటకు కనిపిస్తే వెంటనే డాక్టర్‌కు కాల్ చేయండి.',
      'dont_fracture_1': 'గాయపడిన ప్రదేశాన్ని మసాజ్ చేయవద్దు.',
      'dont_fracture_2': 'వ్యక్తికి తినడానికి లేదా త్రాగడానికి ఏమీ ఇవ్వవద్దు.',

      // Burns
      'step_burns_1': 'కాలిన గాయాన్ని 10-20 నిమిషాలు చల్లని నీటిలో ఉంచండి.',
      'step_burns_2': 'వాపు రాకముందే బిగుతుగా ఉన్న వస్తువులను తొలగించండి.',
      'step_burns_3': 'శుభ్రమైన డ్రెస్సింగ్‌తో కప్పండి.',
      'step_burns_4': 'నొప్పి నివారణ మందులు తీసుకోండి.',
      'do_burns_1': 'వ్యక్తిని వెచ్చగా ఉంచండి.',
      'do_burns_2': 'ముఖం కాలిపోతే నిటారుగా కూర్చోబెట్టండి.',
      'dont_burns_1': 'ఐస్ లేదా క్రీమ్లు వాడవద్దు.',
      'dont_burns_2': 'పొక్కులను పగలగొట్టవద్దు.',
      'dont_burns_3': 'చర్మానికి అంటుకున్న దుస్తులను తొలగించవద్దు.',
      'tool_cloth': 'శుభ్రమైన గుడ్డ',

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
      'step_choking_2': 'వీపు మీద 5 సార్లు కొట్టండి.',
      'step_choking_3': '5 సార్లు పొట్టపై ఒత్తిడి (Heimlich Maneuver) చేయండి.',
      'do_choking_1': 'వీపు దెబ్బలు మరియు పొట్ట ఒత్తిడి మార్చి మార్చి చేయండి.',
      'do_choking_2': 'అడ్డంకి తొలగకపోతే ఎమర్జెన్సీకి కాల్ చేయండి.',
      'dont_choking_1': 'వారు గట్టిగా దగ్గుతుంటే జోక్యం చేసుకోవద్దు.',

      // Stroke
      'step_stroke_1':
          'FAST ఉపయోగించండి: ముఖం వాలిపోవడం? చేతులు బలహీనంగా ఉన్నాయా? మాట తడబడుతుందా? కాల్ చేయండి.',
      'step_stroke_2': 'వెంటనే ఎమర్జెన్సీకి కాల్ చేయండి.',
      'step_stroke_3': 'లక్షణాలు ఎప్పుడు మొదలయ్యాయో గమనించండి.',
      'do_stroke_1': 'వ్యక్తిని సౌకర్యవంతంగా ఉంచండి.',
      'do_stroke_2': 'శ్వాస మార్గం సరిగ్గా ఉందో లేదో చూడండి.',
      'dont_stroke_1': 'వారిని నిద్రపోనివ్వవద్దు.',
      'dont_stroke_2': 'ఆహారం లేదా నీరు ఇవ్వవద్దు.',

      // Drowning
      'step_drowning_1': 'వ్యక్తిని సురక్షితంగా బయటకు తీసుకురండి.',
      'step_drowning_2': 'శ్వాసను పరీక్షించండి.',
      'step_drowning_3': 'శ్వాస లేకపోతే వెంటనే CPR ప్రారంభించండి.',
      'do_drowning_1': 'తడి బట్టలు తీసివేసి వెచ్చగా ఉంచండి.',
      'dont_drowning_1': 'మీకు శిక్షణ లేకపోతే నీటిలోకి దూకవద్దు.',

      // Electric Shock
      'step_shock_1': 'పవర్ ఆఫ్ చేయండి.',
      'step_shock_2': 'కరెంట్ సరఫరాలో ఉన్నప్పుడు వ్యక్తిని తాకవద్దు.',
      'step_shock_3': 'ఎమర్జెన్సీకి కాల్ చేయండి.',
      'step_shock_4': 'CPR అవసరమైతే చేయండి.',
      'do_shock_1': 'ఎండిన చెక్క లేదా రబ్బరుపై నిల్చోండి.',
      'do_shock_2': 'కాలిన గాయాలకు చికిత్స చేయండి.',
      'dont_shock_1': 'కరెంట్ ఉన్నప్పుడు చేతులతో తాకవద్దు.',
      'dont_shock_2': 'హై-వోల్టేజ్ వైర్ల దగ్గరకు వెళ్లవద్దు.',

      // Fainting
      'step_fainting_1': 'వ్యక్తిని వెల్లకిలా పడుకోబెట్టండి.',
      'step_fainting_2': 'కాళ్ళను కొంచెం ఎత్తులో ఉంచండి.',
      'step_fainting_3': 'బిగుతుగా ఉన్న బట్టలు వదులు చేయండి.',
      'do_fainting_1': 'శ్వాసను గమనించండి.',
      'do_fainting_2': 'వాంతులు చేసుకుంటే పక్కకు తిప్పండి.',
      'dont_fainting_1': 'ముఖంపై నీళ్లు చల్లవద్దు.',
      'dont_fainting_2': 'వెంటనే నిలబడనివ్వవద్దు.',

      // Poisoning
      'step_poison_1': 'ఏమి మింగారో గుర్తించండి.',
      'step_poison_2': 'వెంటనే పాయిజన్ కంట్రోల్‌కు కాల్ చేయండి.',
      'step_poison_3': 'నిపుణుల సలహాలు పాటించండి.',
      'do_poison_1': 'శ్వాసను గమనిస్తూ ఉండండి.',
      'do_poison_2': 'విషం డబ్బాను భద్రపరచండి.',
      'dont_poison_1': 'చెప్పకపోతే వాంతులు చేయించవద్దు.',
      'dont_poison_2': 'ఏమీ తినడానికి లేదా తాగడానికి ఇవ్వవద్దు.',

      // Seizure
      'step_seizure_1': 'వ్యక్తిని నేలపై పడుకోబెట్టండి.',
      'step_seizure_2': 'శ్వాస కోసం పక్కకు తిప్పండి.',
      'step_seizure_3': 'చుట్టూ ఉన్న గట్టి వస్తువులను తొలగించండి.',
      'do_seizure_1': 'తల కింద మెత్తటి వస్త్రాన్ని ఉంచండి.',
      'do_seizure_2': 'సీజర్ ఎంత సేపు ఉందో గమనించండి.',
      'dont_seizure_1': 'వారిని గట్టిగా పట్టుకోవద్దు.',
      'dont_seizure_2': 'నోట్లో ఏమీ పెట్టవద్దు.',

      // Allergic Reaction
      'step_allergy_1':
          'శ్వాస తీసుకోవడం కష్టంగా ఉంటే ఎమర్జెన్సీకి కాల్ చేయండి.',
      'step_allergy_2': 'EpiPen ఉందో లేదో అడగండి.',
      'step_allergy_3': 'వాడటానికి సహాయం చేయండి.',
      'do_allergy_1': 'కాళ్ళను ఎత్తులో ఉంచి పడుకోబెట్టండి.',
      'dont_allergy_1': 'లక్షణాలు ఎక్కువయ్యే వరకు వేచి ఉండవద్దు.',
      'tool_epipen': 'ఎపిపెన్ (EpiPen)',

      // Nose Bleed
      'step_nose_1': 'నిటారుగా కూర్చుని ముందుకు వంగండి.',
      'step_nose_2': 'ముక్కు మెత్తటి భాగాన్ని గట్టిగా పట్టుకోండి.',
      'step_nose_3': '10-15 నిమిషాలు వదలకుండా పట్టుకోండి.',
      'do_nose_1': 'నోటి ద్వారా గాలి పీల్చుకోండి.',
      'do_nose_2': 'ముక్కు పైన ఐస్ ప్యాక్ పెట్టండి.',
      'dont_nose_1': 'వెనక్కి వంగవద్దు (రక్తం గొంతులోకి వెళ్తుంది).',
      'dont_nose_2': 'రక్తం ఆగిన వెంటనే ముక్కు చీదవద్దు.',

      // Heat Stroke
      'step_heat_1': 'చల్లని ప్రదేశానికి తీసుకెళ్లండి.',
      'step_heat_2': 'అదనపు బట్టలు తొలగించండి.',
      'step_heat_3': 'శరీరాన్ని చల్లబరచండి.',
      'step_heat_4': 'స్పృహ ఉంటే కొంచెం నీరు ఇవ్వండి.',
      'do_heat_1': 'చంకలు/మెడ దగ్గర ఐస్ ప్యాక్ పెట్టండి.',
      'do_heat_2': 'స్పృహ కోల్పోతే ఎమర్జెన్సీకి కాల్ చేయండి.',
      'dont_heat_1': 'స్పృహ లేనప్పుడు నీరు ఇవ్వవద్దు.',

      // Bee Sting
      'step_bee_1': 'ముల్లును నెమ్మదిగా తొలగించండి.',
      'step_bee_2': 'సబ్బు మరియు నీటితో కడగండి.',
      'step_bee_3': 'వాపు తగ్గడానికి ఐస్ పెట్టండి.',
      'do_bee_1': 'అలెర్జీ లక్షణాలు గమనించండి.',
      'do_bee_2': 'సాధ్యమైతే చేతిని/కాలుని ఎత్తులో ఉంచండి.',
      'dont_bee_1': 'ముల్లును గట్టిగా నొక్కవద్దు.',
      'dont_bee_2': 'గోకవద్దు.',

      // Reminders
      'reminders_title': 'రిమైండర్లు',
      'morning': 'ఉదయం',
      'afternoon': 'మధ్యాహ్నం',
      'evening': 'సాయంత్రం',
      'add_reminder': 'రిమైండర్ జోడించు',
      'edit_reminder': 'రిమైండర్ సవరించు',
      'label': 'పేరు',
      'repeat': 'మళ్ళీ',
      'every_day': 'ప్రతి రోజు',
      'weekdays_only': 'వారపు రోజులు',
      'weekends_only': 'వారాంతాలు',
      'repeat_once': 'ఒకసారి',
      'save': 'సేవ్',
      'cancel': 'రద్దు',
      'delete': 'తొలగించు',
      'delete_confirm': 'ఈ రిమైండర్‌ని తొలగించాలా?',
      'no_reminders': 'ఇంకా రిమైండర్‌లు లేవు',
      'category_label': 'వర్గం',
      'cat_medication': 'మందులు',
      'cat_appointment': 'అపాయింట్‌మెంట్',
      'cat_checkup': 'చెకప్',
      'cat_other': 'ఇతర',

      // Tips
      'tip_total_count': '3',
      'tip_1': 'కారులో మరియు ఇంట్లో ప్రథమ చికిత్స కిట్ ఉంచండి.',
      'tip_2': 'CPR నేర్చుకోండి - అది ప్రాణాలను కాపాడుతుంది.',
      'tip_3':
          'స్మోక్ డిటెక్టర్ బ్యాటరీలను సంవత్సరానికి రెండుసార్లు తనిఖీ చేయండి.',

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
    },
  };
}
