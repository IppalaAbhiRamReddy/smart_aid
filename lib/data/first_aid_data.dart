import 'package:flutter/material.dart';
import '../models/first_aid_item.dart';

class FirstAidData {
  static final List<FirstAidItem> items = [
    // 1. CPR
    FirstAidItem(
      id: 'cpr',
      titleKey: 'cpr_title',
      iconData: Icons.favorite,
      severity: 'Critical',
      category: 'Critical',
      steps: [
        'step_cpr_1',
        'step_cpr_2',
        'step_cpr_3',
        'step_cpr_4',
        'step_cpr_5',
      ],
      dos: ['do_cpr_1', 'do_cpr_2'],
      donts: ['dont_cpr_1', 'dont_cpr_2'],
    ),

    // 2. Heart Attack
    FirstAidItem(
      id: 'heart_attack',
      titleKey: 'heart_attack_title',
      iconData: Icons.heart_broken,
      severity: 'Critical',
      category: 'Critical',
      steps: ['step_heart_1', 'step_heart_2', 'step_heart_3', 'step_heart_4'],
      dos: ['do_heart_1', 'do_heart_2', 'do_heart_3'],
      donts: ['dont_heart_1', 'dont_heart_2'],
    ),

    // 3. Stroke
    FirstAidItem(
      id: 'stroke',
      titleKey: 'stroke_title',
      iconData: Icons.psychology, // Brain icon
      severity: 'Critical',
      category: 'Critical',
      steps: ['step_stroke_1', 'step_stroke_2', 'step_stroke_3'],
      dos: ['do_stroke_1', 'do_stroke_2'],
      donts: ['dont_stroke_1', 'dont_stroke_2'],
    ),

    // 4. Choking
    FirstAidItem(
      id: 'choking',
      titleKey: 'choking_title',
      iconData: Icons.air,
      severity: 'High',
      category: 'Critical',
      steps: ['step_choking_1', 'step_choking_2', 'step_choking_3'],
      dos: ['do_choking_1', 'do_choking_2'],
      donts: ['dont_choking_1'],
    ),

    // 5. Cuts & Scrapes
    FirstAidItem(
      id: 'cuts',
      titleKey: 'cuts_title',
      iconData: Icons.content_cut,
      severity: 'Low',
      category: 'Common',
      steps: ['step_cuts_1', 'step_cuts_2', 'step_cuts_3', 'step_cuts_4'],
      tools: [
        ToolItem(nameKey: 'tool_bandage', iconData: Icons.healing),
        ToolItem(nameKey: 'tool_antiseptic', iconData: Icons.sanitizer),
        ToolItem(nameKey: 'tool_water', iconData: Icons.water_drop),
      ],
      dos: ['do_cuts_1', 'do_cuts_2'],
      donts: ['dont_cuts_1'],
    ),

    // 6. Burns
    FirstAidItem(
      id: 'burns',
      titleKey: 'burns_title',
      iconData: Icons.local_fire_department,
      severity: 'Medium',
      category: 'Common',
      steps: ['step_burns_1', 'step_burns_2', 'step_burns_3', 'step_burns_4'],
      tools: [
        ToolItem(nameKey: 'tool_water', iconData: Icons.water_drop),
        ToolItem(
          nameKey: 'tool_cloth',
          iconData: Icons.check_box_outline_blank,
        ),
      ],
      dos: ['do_burns_1', 'do_burns_2'],
      donts: ['dont_burns_1', 'dont_burns_2', 'dont_burns_3'],
    ),

    // 7. Drowning
    FirstAidItem(
      id: 'drowning',
      titleKey: 'drowning_title',
      iconData: Icons.pool,
      severity: 'Critical',
      category: 'Outdoor',
      steps: ['step_drowning_1', 'step_drowning_2', 'step_drowning_3'],
      dos: ['do_drowning_1'],
      donts: ['dont_drowning_1'],
    ),

    // 8. Electric Shock
    FirstAidItem(
      id: 'electric_shock',
      titleKey: 'shock_title',
      iconData: Icons.electric_bolt,
      severity: 'Critical',
      category: 'Common',
      steps: ['step_shock_1', 'step_shock_2', 'step_shock_3', 'step_shock_4'],
      dos: ['do_shock_1', 'do_shock_2'],
      donts: ['dont_shock_1', 'dont_shock_2'],
    ),

    // 9. Fainting
    FirstAidItem(
      id: 'fainting',
      titleKey: 'fainting_title',
      iconData: Icons.visibility_off,
      severity: 'Medium',
      category: 'Common',
      steps: ['step_fainting_1', 'step_fainting_2', 'step_fainting_3'],
      dos: ['do_fainting_1', 'do_fainting_2'],
      donts: ['dont_fainting_1', 'dont_fainting_2'],
    ),

    // 10. Poisoning
    FirstAidItem(
      id: 'poisoning',
      titleKey: 'poisoning_title',
      iconData: Icons.science, // Flask icon
      severity: 'High',
      category: 'Common',
      steps: ['step_poison_1', 'step_poison_2', 'step_poison_3'],
      dos: ['do_poison_1', 'do_poison_2'],
      donts: ['dont_poison_1', 'dont_poison_2'],
    ),

    // 11. Seizure
    FirstAidItem(
      id: 'seizure',
      titleKey: 'seizure_title',
      iconData: Icons.waves,
      severity: 'High',
      category: 'Common',
      steps: ['step_seizure_1', 'step_seizure_2', 'step_seizure_3'],
      dos: ['do_seizure_1', 'do_seizure_2'],
      donts: ['dont_seizure_1', 'dont_seizure_2'],
    ),

    // 12. Allergic Reaction
    FirstAidItem(
      id: 'allergy',
      titleKey: 'allergy_title',
      iconData: Icons.coronavirus,
      severity: 'High',
      category: 'Common',
      steps: ['step_allergy_1', 'step_allergy_2', 'step_allergy_3'],
      tools: [ToolItem(nameKey: 'tool_epipen', iconData: Icons.vaccines)],
      dos: ['do_allergy_1'],
      donts: ['dont_allergy_1'],
    ),

    // 13. Nose Bleed
    FirstAidItem(
      id: 'nose_bleed',
      titleKey: 'nose_bleed_title',
      iconData: Icons.water_drop_outlined,
      severity: 'Low',
      category: 'Common',
      steps: ['step_nose_1', 'step_nose_2', 'step_nose_3'],
      dos: ['do_nose_1', 'do_nose_2'],
      donts: ['dont_nose_1', 'dont_nose_2'],
    ),

    // 14. Heat Stroke
    FirstAidItem(
      id: 'heat_stroke',
      titleKey: 'heat_stroke_title',
      iconData: Icons.wb_sunny,
      severity: 'High',
      category: 'Outdoor',
      steps: ['step_heat_1', 'step_heat_2', 'step_heat_3', 'step_heat_4'],
      dos: ['do_heat_1', 'do_heat_2'],
      donts: ['dont_heat_1'],
    ),

    // 15. Bee Sting
    FirstAidItem(
      id: 'bee_sting',
      titleKey: 'bee_sting_title',
      iconData: Icons.bug_report,
      severity: 'Low',
      category: 'Outdoor',
      steps: ['step_bee_1', 'step_bee_2', 'step_bee_3'],
      dos: ['do_bee_1', 'do_bee_2'],
      donts: ['dont_bee_1', 'dont_bee_2'],
    ),

    // 16. Snake Bite
    FirstAidItem(
      id: 'snake_bite',
      titleKey: 'snake_bite_title',
      iconData: Icons.gesture, // Resembles a snake
      severity: 'Critical',
      category: 'Outdoor',
      steps: ['step_snake_1', 'step_snake_2', 'step_snake_3'],
      dos: ['do_snake_1', 'do_snake_2'],
      donts: ['dont_snake_1', 'dont_snake_2', 'dont_snake_3'],
    ),

    // 17. Dog Bite
    FirstAidItem(
      id: 'dog_bite',
      titleKey: 'dog_bite_title',
      iconData: Icons.pets,
      severity: 'High',
      category: 'Outdoor',
      steps: ['step_dog_1', 'step_dog_2', 'step_dog_3', 'step_dog_4'],
      dos: ['do_dog_1', 'do_dog_2'],
      donts: ['dont_dog_1'],
    ),

    // 18. Fractures
    FirstAidItem(
      id: 'fracture',
      titleKey: 'fracture_title',
      iconData: Icons.personal_injury,
      severity: 'High',
      category: 'Common',
      steps: ['step_fracture_1', 'step_fracture_2', 'step_fracture_3'],
      dos: ['do_fracture_1', 'do_fracture_2'],
      donts: ['dont_fracture_1', 'dont_fracture_2'],
    ),
  ];
}
