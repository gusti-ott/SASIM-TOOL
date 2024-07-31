import 'package:multimodal_routeplanner/03_domain/entities/costs/Costs.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/ExternalCosts.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/InternalCosts.dart';

Map<SocialCostsCategory, Map<String, String>> socialCostsAssetPaths = {
  SocialCostsCategory.time: {
    'A': 'assets/icons/social_time/social_time_A.png',
    'B': 'assets/icons/social_time/social_time_B.png',
    'C': 'assets/icons/social_time/social_time_C.png',
    'D': 'assets/icons/social_time/social_time_D.png',
    'E': 'assets/icons/social_time/social_time_E.png',
    'null': 'assets/icons/social_time/social_time_null.png'
  },
  SocialCostsCategory.health: {
    'A': 'assets/icons/social_air/social_air_A.png',
    'B': 'assets/icons/social_air/social_air_B.png',
    'C': 'assets/icons/social_air/social_air_C.png',
    'D': 'assets/icons/social_air/social_air_D.png',
    'E': 'assets/icons/social_air/social_air_E.png',
    'null': 'assets/icons/social_air/social_air_null.png'
  },
  SocialCostsCategory.environment: {
    'A': 'assets/icons/social_space/social_space_A.png',
    'B': 'assets/icons/social_space/social_space_B.png',
    'C': 'assets/icons/social_space/social_space_C.png',
    'D': 'assets/icons/social_space/social_space_D.png',
    'E': 'assets/icons/social_space/social_space_E.png',
    'null': 'assets/icons/social_space/social_space_null.png'
  },
};

Map<PersonalCostsCategory, Map<String, String>> personalCostsAssetPaths = {
  PersonalCostsCategory.fixed: {
    'A': 'assets/icons/personal_fixed/personal_fixed_A.png',
    'B': 'assets/icons/personal_fixed/personal_fixed_B.png',
    'C': 'assets/icons/personal_fixed/personal_fixed_C.png',
    'D': 'assets/icons/personal_fixed/personal_fixed_D.png',
    'E': 'assets/icons/personal_fixed/personal_fixed_E.png',
    'null': 'assets/icons/personal_fixed/personal_fixed_null.png'
  },
  PersonalCostsCategory.variable: {
    'A': 'assets/icons/personal_variable/personal_variable_A.png',
    'B': 'assets/icons/personal_variable/personal_variable_B.png',
    'C': 'assets/icons/personal_variable/personal_variable_C.png',
    'D': 'assets/icons/personal_variable/personal_variable_D.png',
    'E': 'assets/icons/personal_variable/personal_variable_E.png',
    'null': 'assets/icons/personal_variable/personal_variable_null.png'
  },
};

String getSocialCostsImagePath({required SocialCostsCategory socialCostsCategory, String? mobiScore}) {
  String? path = socialCostsAssetPaths[socialCostsCategory]?[mobiScore ?? 'null'];
  path ??= socialCostsAssetPaths[socialCostsCategory]?['null'] ?? '';

  return path;
}

String getPersonalCostsImagePath({required PersonalCostsCategory personalCostsCategory, String? mobiScore}) {
  return personalCostsAssetPaths[personalCostsCategory]?[mobiScore ?? 'null'] ??
      personalCostsAssetPaths[personalCostsCategory]?['null'] ??
      '';
}

String getImagePathFromCostsCategoryAndMobiScore(
    {required CostsType costsType,
    required String mobiScore,
    SocialCostsCategory? socialCostsCategory,
    PersonalCostsCategory? personalCostsCategory}) {
  String path = '';
  if (costsType == CostsType.social && socialCostsCategory != null) {
    path = getSocialCostsImagePath(socialCostsCategory: socialCostsCategory, mobiScore: mobiScore);
  }
  if (costsType == CostsType.personal && personalCostsCategory != null) {
    // no mobiScore parameter, because Mobi-Score is (for now) not dependent on personal costs
    path = getPersonalCostsImagePath(personalCostsCategory: personalCostsCategory);
  }
  return path;
}
