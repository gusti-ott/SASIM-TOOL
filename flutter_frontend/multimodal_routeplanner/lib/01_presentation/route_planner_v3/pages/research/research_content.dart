import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/navigation_header.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:url_launcher/url_launcher.dart';

class ResearchContent extends StatelessWidget {
  const ResearchContent({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations lang = AppLocalizations.of(context)!;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        navigationHeaderRow(context),
        Center(
          child: Padding(
            padding: EdgeInsets.all(mediumPadding),
            child: SizedBox(
              width: 600,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    lang.research,
                    style: textTheme.headlineMedium!.copyWith(color: primaryColorV3),
                  ),
                  mediumVerticalSpacer,
                  Text(
                    lang.research_content,
                    style: textTheme.bodyLarge!.copyWith(color: primaryColorV3),
                    textAlign: TextAlign.left,
                  ),
                  smallVerticalSpacer,
                  buildPaperReferenceRow(
                    'Enhancing Sustainability in a Government-Contracted Mobility-as-a-Service Model',
                    'https://www.researchgate.net/publication/357929786_Enhancing_Sustainability_in_a_Government-Contracted_Mobility-as-a-Service_Model',
                    textTheme.bodyLarge!.copyWith(color: primaryColorV3),
                  ),
                  mediumVerticalSpacer,
                  buildPaperReferenceRow(
                    'Ending the myth of mobility at zero costs: An external cost analysis',
                    'https://www.researchgate.net/publication/365451223_Ending_the_myth_of_mobility_at_zero_costs_An_external_cost_analysis',
                    textTheme.bodyLarge!.copyWith(color: primaryColorV3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPaperReferenceRow(String title, String link, TextStyle style) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: style.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: smallPadding),
          child: IconButton(
            icon: Icon(Icons.launch, color: style.color),
            onPressed: () async {
              Uri uri = Uri.parse(link);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              } else {
                throw 'Could not launch $link';
              }
            },
          ),
        ),
      ],
    );
  }
}
