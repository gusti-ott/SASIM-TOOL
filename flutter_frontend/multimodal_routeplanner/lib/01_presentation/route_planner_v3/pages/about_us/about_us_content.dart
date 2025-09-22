import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/information_bottom_row.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/v3_scaffold.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/about_us/text_formating_helper.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/values.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';

class AboutUsContent extends StatelessWidget {
  const AboutUsContent({super.key, required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (!isMobile) SizedBox(height: headerHeight),
          aboutUsTextContent(context, isMobile: isMobile),
          const InformationContainer(),
        ],
      ),
    );
  }

  Center aboutUsTextContent(BuildContext context, {bool isMobile = false}) {
    AppLocalizations lang = AppLocalizations.of(context)!;
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
                lang.about_us,
              ),
              newlineSpacer,
              headline1Text(
                context,
                lang.the_project,
              ),
              newlineSpacer,
              buildFormattedText(context, text: lang.the_project_content, formatOptions: [
                FormatOption(lang.the_project_content_bold_1,
                    isBold: true, hyperlink: "https://mcube-cluster.de/projekt/sasim/"),
                FormatOption(lang.the_project_content_bold_2, isBold: true, hyperlink: "https://mcube-cluster.de"),
                FormatOption(lang.the_project_content_bold_3, isBold: true),
                FormatOption(lang.the_project_content_bold_4, isBold: true),
                FormatOption(lang.the_project_content_bold_5, isBold: true),
                FormatOption(lang.the_project_content_bold_6, isBold: true),
              ]),
              newlineSpacer,
              headline1Text(
                context,
                lang.the_web_app,
              ),
              newlineSpacer,
              buildFormattedText(context, text: lang.the_web_app_content, formatOptions: [
                FormatOption(lang.the_web_app_content_bold_1, isBold: true),
                FormatOption(lang.the_web_app_content_bold_2, isBold: true),
                FormatOption(lang.the_web_app_content_bold_3, isBold: true),
              ]),
              newlineSpacer,
              headline1Text(
                context,
                lang.the_mobi_score,
              ),
              newlineSpacer,
              buildFormattedText(context, text: lang.the_mobi_score_content, formatOptions: [
                FormatOption(lang.the_mobi_score_content_bold_1, isBold: true),
              ]),
              newlineSpacer,
              bulletPointText(context, lang.the_mobi_score_content_bullet_1),
              bulletPointText(context, lang.the_mobi_score_content_bullet_2),
              newlineSpacer,
              headline1Text(
                context,
                lang.the_team_behind,
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: largePadding,
                runSpacing: mediumPadding,
                children: [
                  Image.asset('assets/partners_logos/bayrisches_ministerium_logo.png', height: 100),
                  Image.asset('assets/partners_logos/muenchen_logo.png', height: 60),
                ],
              ),
              newlineSpacer,
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: largePadding,
                runSpacing: mediumPadding,
                children: [
                  Image.asset('assets/partners_logos/bmw_logo.png', height: 70),
                  Image.asset('assets/partners_logos/mvv_logo.png', height: 90),
                  Image.asset('assets/partners_logos/tum_logo.png', height: 70),
                ],
              ),
              largeVerticalSpacer,
              buildFormattedText(context,
                  text: '${lang.ui_by} anelli studio',
                  formatOptions: [FormatOption('anelli studio', isBold: true, hyperlink: "https://anelli.studio/")]),
              buildFormattedText(context, text: '${lang.illustrations_by} Chiara Vercesi', formatOptions: [
                FormatOption('Chiara Vercesi', isBold: true, hyperlink: "https://www.chiaravercesi.com/")
              ]),
              buildFormattedText(context, text: '${lang.development_by} Gusztáv Ottrubay', formatOptions: [
                FormatOption('Gusztáv Ottrubay', isBold: true, hyperlink: "https://github.com/gusti-ott")
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Row bulletPointText(BuildContext context, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.arrow_forward, color: primaryColorV3),
        smallHorizontalSpacer,
        Expanded(child: bodyText(context, text, isBold: true))
      ],
    );
  }
}
