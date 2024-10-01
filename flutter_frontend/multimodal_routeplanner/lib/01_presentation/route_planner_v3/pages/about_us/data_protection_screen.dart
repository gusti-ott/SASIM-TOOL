import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/v3_scaffold.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/about_us/text_formating_helper.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/values.dart';
import 'package:multimodal_routeplanner/01_presentation/values/dimensions.dart';

class DataProtectionScreen extends StatelessWidget {
  const DataProtectionScreen({super.key});

  static const String routeName = 'data_protection';
  static const String path = 'data-protection';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < mobileScreenWidthMinimum;

    AppLocalizations lang = AppLocalizations.of(context)!;

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
                      lang.privacy_policy,
                    ),
                    newlineSpacer,
                    headline1Text(
                      context,
                      lang.general_information,
                    ),
                    newlineSpacer,
                    bodyText(
                      context,
                      lang.privacy_general_content,
                    ),
                    newlineSpacer,
                    headline1Text(
                      context,
                      lang.responsible_person,
                    ),
                    newlineSpacer,
                    bodyText(
                      context,
                      lang.privacy_responsible_content,
                    ),
                    newlineSpacer,
                    headline1Text(
                      context,
                      lang.collection_and_processing_personal_data,
                    ),
                    newlineSpacer,
                    bodyText(
                      context,
                      lang.privacy_collection_content,
                    ),
                    newlineSpacer,
                    headline1Text(
                      context,
                      lang.processing_user_data,
                    ),
                    newlineSpacer,
                    bodyText(
                      context,
                      lang.privacy_processing_content,
                    ),
                    newlineSpacer,
                    headline1Text(
                      context,
                      lang.third_party_services,
                    ),
                    newlineSpacer,
                    headline2Text(
                      context,
                      lang.photon_header,
                    ),
                    newlineSpacer,
                    bodyText(
                      context,
                      lang.privacy_photon_content,
                    ),
                    newlineSpacer,
                    headline2Text(
                      context,
                      lang.efa_header,
                    ),
                    newlineSpacer,
                    bodyText(
                      context,
                      lang.privacy_efa_content,
                    ),
                    newlineSpacer,
                    headline1Text(
                      context,
                      lang.data_security,
                    ),
                    newlineSpacer,
                    bodyText(
                      context,
                      lang.privacy_security_content,
                    ),
                    newlineSpacer,
                    headline1Text(
                      context,
                      lang.cookies,
                    ),
                    newlineSpacer,
                    bodyText(
                      context,
                      lang.privacy_cookies_content,
                    ),
                    newlineSpacer,
                    headline1Text(
                      context,
                      lang.your_rights,
                    ),
                    newlineSpacer,
                    bodyText(
                      context,
                      lang.privacy_rights_content,
                    ),
                    newlineSpacer,
                    headline1Text(
                      context,
                      lang.changes_to_privacy_policy,
                    ),
                    newlineSpacer,
                    bodyText(
                      context,
                      lang.privacy_changes_content,
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
