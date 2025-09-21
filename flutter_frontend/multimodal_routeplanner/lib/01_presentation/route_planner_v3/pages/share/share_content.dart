import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multimodal_routeplanner/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/buttons.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/decorations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/v3_scaffold.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/result_screen_v3.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/values.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/search_screen_v3.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareContent extends StatelessWidget {
  const ShareContent(
      {super.key,
      required this.isMobile,
      required this.startAddress,
      this.startCoordinates,
      required this.endAddress,
      this.endCoordinates});

  final String startAddress;
  final String? startCoordinates;
  final String endAddress;
  final String? endCoordinates;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    AppLocalizations lang = AppLocalizations.of(context)!;
    TextTheme textTheme = Theme.of(context).textTheme;

    final Uri surveyUrl = Uri.parse('https://tummgmt.eu.qualtrics.com/jfe/form/SV_0vtCdPrMuQAqEqq');

    Future<void> launchSurveyUrl() async {
      if (!await launchUrl(surveyUrl)) {
        throw Exception('Could not launch $surveyUrl');
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mediumPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (!isMobile) SizedBox(height: headerHeight),
            if (isMobile) ...[
              mediumVerticalSpacer,
              Align(
                alignment: Alignment.centerLeft,
                child: V3CustomButton(
                  label: lang.back_to_results,
                  leadingIcon: Icons.arrow_back,
                  color: primaryColorV3,
                  textColor: primaryColorV3,
                  onTap: () {
                    context.goNamed(
                      ResultScreenV3.routeName,
                      queryParameters: {
                        'startAddress': startAddress,
                        'startCoordinates': startCoordinates,
                        'endAddress': endAddress,
                        'endCoordinates': endCoordinates,
                      },
                    );
                  },
                  reverseColors: true,
                ),
              ),
            ],
            SizedBox(width: contentMaxWidth, child: (!isMobile) ? desktopShare(context) : mobileShare(context)),
            mediumVerticalSpacer,
            Container(
              width: contentMaxWidth,
              decoration: customBoxDecorationWithShadow(),
              child: Padding(
                padding: EdgeInsets.all(largePadding),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.start,
                  spacing: largePadding,
                  runSpacing: largePadding,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 320,
                          child: Column(
                            children: [
                              Text(
                                lang.want_to_help_us,
                                style: textTheme.headlineSmall,
                                textAlign: TextAlign.left,
                              ),
                              smallVerticalSpacer,
                              Text(
                                lang.want_to_help_us_explanation,
                                style: textTheme.bodyLarge,
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/research_data/survey_qr.png', width: 200, height: 200),
                        mediumVerticalSpacer,
                        V3CustomButton(
                            leadingIcon: Icons.star,
                            label: lang.to_the_survey,
                            onTap: () {
                              launchSurveyUrl();
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (isMobile) ...[
              mediumVerticalSpacer,
              V3CustomButton(
                  label: lang.start_new_route,
                  leadingIcon: Icons.restart_alt,
                  onTap: () {
                    context.goNamed(SearchScreenV3.routeName);
                  }),
              largeVerticalSpacer
            ],
            if (!isMobile) ...[
              extraLargeVerticalSpacer,
              SizedBox(
                width: contentMaxWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    V3CustomButton(
                      label: lang.back_to_results,
                      leadingIcon: Icons.arrow_back,
                      color: primaryColorV3,
                      textColor: primaryColorV3,
                      onTap: () {
                        context.goNamed(
                          ResultScreenV3.routeName,
                          queryParameters: {
                            'startAddress': startAddress,
                            'startCoordintes': startCoordinates,
                            'endAddress': endAddress,
                            'endCoordinates': endCoordinates
                          },
                        );
                      },
                      reverseColors: true,
                    ),
                    V3CustomButton(
                        label: lang.start_new_route,
                        leadingIcon: Icons.keyboard_double_arrow_left,
                        onTap: () {
                          context.goNamed(SearchScreenV3.routeName);
                        }),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Container desktopShare(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    AppLocalizations lang = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      height: 270,
      decoration: customBoxDecorationWithShadow(),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
              child: Image.asset(
                'assets/title_image/mobiscore_header_1.png',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SizedBox(
            width: 350,
            child: Padding(
              padding: EdgeInsets.all(largePadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    lang.tell_a_friend,
                    style: textTheme.headlineSmall,
                    textAlign: TextAlign.left,
                  ),
                  V3CustomButton(
                    label: lang.copy_url,
                    leadingIcon: Icons.link,
                    textColor: primaryColorV3,
                    color: primaryColorV3,
                    reverseColors: true,
                    onTap: () {
                      copyLinkToClipboard(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget mobileShare(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    AppLocalizations lang = AppLocalizations.of(context)!;
    return Column(
      children: [
        mediumVerticalSpacer,
        Container(
          width: double.infinity,
          decoration: customBoxDecorationWithShadow(),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                child: Image.asset(
                  'assets/title_image/mobiscore_header_1.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: EdgeInsets.all(largePadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        lang.tell_a_friend,
                        style: textTheme.headlineSmall,
                        textAlign: TextAlign.left,
                      ),
                      largeVerticalSpacer,
                      V3CustomButton(
                        label: lang.copy_url,
                        leadingIcon: Icons.link,
                        textColor: primaryColorV3,
                        color: primaryColorV3,
                        reverseColors: true,
                        onTap: () {
                          copyLinkToClipboard(context);
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void copyLinkToClipboard(BuildContext context) {
    AppLocalizations lang = AppLocalizations.of(context)!;
    String link = 'https://sasim.mcube-cluster.de/web/#/result?'
        'startAddress=$startAddress&endAddress=$endAddress';
    if (startCoordinates != null) {
      link += '&startCoordinates=$startCoordinates';
    }
    if (endCoordinates != null) {
      link += '&endCoordinates=$endCoordinates';
    }
    Clipboard.setData(ClipboardData(text: link)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(lang.copy_url)),
      );
    });
  }
}
