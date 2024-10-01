import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/v3_scaffold.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/about_us/text_formating_helper.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/values.dart';
import 'package:multimodal_routeplanner/01_presentation/values/dimensions.dart';

class ImprintScreen extends StatelessWidget {
  const ImprintScreen({super.key});

  static const String routeName = 'imprint';
  static const String path = 'imprint';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < mobileScreenWidthMinimum;

    AppLocalizations lang = AppLocalizations.of(context)!;

    Widget newlineSpacer = mediumVerticalSpacer;

    return SingleChildScrollView(
      child: Column(
        children: [
          if (!isMobile) SizedBox(height: headerHeight),
          Center(
            child: Padding(
              padding:
                  EdgeInsets.only(left: mediumPadding, right: mediumPadding, top: mediumPadding, bottom: largePadding),
              child: SizedBox(
                width: contentMaxWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    titleText(
                      context,
                      lang.imprint,
                    ),
                    newlineSpacer,
                    headline1Text(
                      context,
                      lang.contact_details,
                    ),
                    newlineSpacer,
                    bodyText(
                      context,
                      lang.imprint_contact_details_content,
                    ),
                    newlineSpacer,
                    headline1Text(
                      context,
                      lang.authorized_to_represent,
                    ),
                    newlineSpacer,
                    bodyText(
                      context,
                      lang.imprint_authorized_content,
                    ),
                    newlineSpacer,
                    headline1Text(
                      context,
                      lang.supervisory_authority,
                    ),
                    newlineSpacer,
                    bodyText(
                      context,
                      lang.imprint_supervisory_content,
                    ),
                    newlineSpacer,
                    headline1Text(
                      context,
                      lang.vat_id,
                    ),
                    newlineSpacer,
                    bodyText(
                      context,
                      lang.imprint_vat_content,
                    ),
                    newlineSpacer,
                    headline1Text(
                      context,
                      lang.responsible_for_content,
                    ),
                    newlineSpacer,
                    bodyText(
                      context,
                      lang.imprint_responsible_content,
                    ),
                    newlineSpacer,
                    headline1Text(
                      context,
                      lang.disclaimer,
                    ),
                    newlineSpacer,
                    bodyText(
                      context,
                      lang.imprint_disclaimer_content,
                    ),
                    extraLargeVerticalSpacer,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
