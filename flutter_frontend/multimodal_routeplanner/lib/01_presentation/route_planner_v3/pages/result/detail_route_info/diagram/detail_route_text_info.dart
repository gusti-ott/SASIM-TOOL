import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
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
      return buildCollapsibleSections(
        description: lang.detail_social_time_description,
        sections: [
          DescriptionExpansionTile(
              title: lang.what_are_congestion_costs, content: lang.detail_social_time_description_congestion),
          DescriptionExpansionTile(
            title: lang.what_are_barrier_costs,
            content: lang.detail_social_time_description_barrier,
          )
        ],
      );

    case DiagramType.detailSocialHealth:
      return buildCollapsibleSections(
        description: lang.detail_social_health_description,
        sections: [
          DescriptionExpansionTile(
            title: lang.what_are_noise_costs,
            content: lang.detail_social_health_description_noise,
          ),
          DescriptionExpansionTile(
            title: lang.what_are_accident_costs,
            content: lang.detail_social_health_description_accidents,
          ),
          DescriptionExpansionTile(
            title: lang.what_are_air_costs,
            content: lang.detail_social_health_description_air,
          ),
        ],
      );

    case DiagramType.detailSocialEnvironment:
      return buildCollapsibleSections(
        description: lang.detail_social_environment_description,
        sections: [
          DescriptionExpansionTile(
            title: lang.what_are_climate_costs,
            content: lang.detail_social_environment_description_climate,
          ),
          DescriptionExpansionTile(
            title: lang.what_are_space_costs,
            content: lang.detail_social_environment_description_space,
          ),
        ],
      );

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

Widget buildCollapsibleSections({
  required String description,
  required List<DescriptionExpansionTile> sections, // List of maps containing title and content pairs
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(description, style: mapLegendTextStyle, textAlign: TextAlign.left),
      smallVerticalSpacer,

      // Dynamically build ExpansionTiles from the list of sections
      ...sections.map((section) {
        return Column(
          children: [
            ExpansionTile(
              title: Text(
                section.title, // Title for the ExpansionTile
                style: textTheme.titleSmall,
                textAlign: TextAlign.left,
              ),
              tilePadding: EdgeInsets.zero, // Remove the default left padding
              childrenPadding:
                  const EdgeInsets.only(left: 0, right: 0), // Adjust padding inside the expanded section if needed
              collapsedIconColor: Colors.black, // Optionally adjust icon color when collapsed
              iconColor: Colors.black, // Optionally adjust icon color when expanded
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0),
                  child: Text(
                    section.content, // Content for the expanded area
                    style: mapLegendTextStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
                smallVerticalSpacer,
              ],
            ),
          ],
        );
      }).toList(),

      largeVerticalSpacer,
    ],
  );
}

class DescriptionExpansionTile {
  final String title;
  final String content;

  DescriptionExpansionTile({required this.title, required this.content});
}
