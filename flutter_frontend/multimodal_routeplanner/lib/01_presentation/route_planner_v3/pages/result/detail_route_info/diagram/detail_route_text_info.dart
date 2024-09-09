import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/detail_route_info/detail_route_info_content.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/typography.dart';

Widget detailRouteTextInfo(BuildContext context, {required DiagramType diagramType}) {
  AppLocalizations lang = AppLocalizations.of(context)!;

  String text = '';

  switch (diagramType) {
    case DiagramType.total:
      text = lang.total_description;
      break;
    case DiagramType.social:
      text = lang.social_description;
      break;

    case DiagramType.personal:
      text = lang.personal_description;
      break;

    case DiagramType.detailSocial:
      text = lang.detail_social_description;
      break;

    case DiagramType.detailSocialTime:
      text = lang.detail_social_time_description;
      break;

    case DiagramType.detailSocialHealth:
      text = lang.detail_social_health_description;
      break;

    case DiagramType.detailSocialEnvironment:
      text = lang.detail_social_environment_description;
      break;

    case DiagramType.detailPersonal:
      text = lang.detail_personal_description;
      break;
    case DiagramType.detailPersonalFixed:
      text = lang.detail_personal_fixed_description;
      break;
    case DiagramType.detailPersonalVariable:
      text = lang.detail_personal_variable_description;
      break;

    default:
      text = '';
  }

  return Text(text, style: mapLegendTextStyle, textAlign: TextAlign.left);
}
