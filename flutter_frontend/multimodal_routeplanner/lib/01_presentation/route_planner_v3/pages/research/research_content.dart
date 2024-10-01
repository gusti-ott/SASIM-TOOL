import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/information_bottom_row.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/v3_scaffold.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/about_us/text_formating_helper.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/values.dart';
import 'package:url_launcher/url_launcher.dart';

class ResearchContent extends StatelessWidget {
  const ResearchContent({super.key, required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (!isMobile) SizedBox(height: headerHeight),
          researchTextContent(context),
          informationContainer(context),
        ],
      ),
    );
  }

  Widget researchTextContent(context) {
    AppLocalizations lang = AppLocalizations.of(context)!;

    final Locale locale = Localizations.localeOf(context);

    return Center(
      child: Padding(
          padding: EdgeInsets.only(left: mediumPadding, right: mediumPadding, top: mediumPadding, bottom: largePadding),
          child: SizedBox(
            width: contentMaxWidth,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  titleText(
                    context,
                    lang.research,
                  ),
                  newlineSpacer,
                  buildFormattedText(context, text: lang.research_content),
                  newlineSpacer,
                  headline1Text(
                    context,
                    lang.personal_costs,
                  ),
                  newlineSpacer,
                  buildFormattedText(context, text: lang.personal_costs_research_content, formatOptions: [
                    FormatOption(lang.personal_costs_research_content_hyperlink_1,
                        hyperlink:
                            "https://www.researchgate.net/publication/349034233_An_Overview_of_Parameter_and_Cost_for_Battery_Electric_Vehicles")
                  ]),
                  newlineSpacer,
                  SizedBox(
                    height: 300,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Image.asset(
                            (locale == const Locale('de'))
                                ? 'assets/research_data/personal_costs_data_de.png'
                                : 'assets/research_data/personal_costs_data_en.png',
                            fit: BoxFit.fitHeight,
                          ),
                        ],
                      ),
                    ),
                  ),
                  newlineSpacer,
                  headline1Text(context, lang.social_costs),
                  newlineSpacer,
                  buildFormattedText(context, text: lang.social_costs_research_content, formatOptions: [
                    FormatOption(lang.social_costs_research_content_hyperlink_1,
                        hyperlink:
                            "https://www.researchgate.net/publication/365451223_Ending_the_myth_of_mobility_at_zero_costs_An_external_cost_analysis"),
                  ]),
                  newlineSpacer,
                  SizedBox(
                    height: 500,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Image.asset(
                            (locale == const Locale('de'))
                                ? 'assets/research_data/social_costs_data_de.png'
                                : 'assets/research_data/social_costs_data_en.png',
                            fit: BoxFit.fitWidth,
                          ),
                        ],
                      ),
                    ),
                  ),
                  newlineSpacer,
                  headline1Text(context, lang.routing_research),
                  newlineSpacer,
                  buildFormattedText(context, text: lang.routing_research_content, formatOptions: [
                    FormatOption(lang.routing_research_content_hyperlink_1,
                        hyperlink: "https://www.opentripplanner.org/"),
                    FormatOption(lang.routing_research_content_hyperlink_2,
                        hyperlink: "https://mobilitaetsplattform.bayern/de/defas")
                  ]),
                ]),
          )),
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
