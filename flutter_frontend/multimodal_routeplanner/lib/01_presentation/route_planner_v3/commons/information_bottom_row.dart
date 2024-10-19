import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/about_us/data_protection_screen.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/about_us/imprint_screen.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/values.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';

class InformationContainer extends StatelessWidget {
  const InformationContainer({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    AppLocalizations lang = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      color: primaryColorV3,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: mediumPadding),
          child: SizedBox(
            width: contentMaxWidth,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: largePadding),
              child: Row(
                children: [
                  Expanded(
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(lang.contact, style: textTheme.headlineMedium!.copyWith(color: customWhite100)),
                          Text('sasim@mcube-cluster.com', style: textTheme.bodyLarge!.copyWith(color: customWhite100))
                        ]),
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(lang.information, style: textTheme.headlineMedium!.copyWith(color: customWhite100)),
                          InkWell(
                              child: Text(lang.imprint.toUpperCase(),
                                  style: textTheme.bodyLarge!.copyWith(color: customWhite100)),
                              onTap: () {
                                context.goNamed(ImprintScreen.routeName);
                              }),
                          InkWell(
                              child: Text(lang.privacy_policy.toUpperCase(),
                                  style: textTheme.bodyLarge!.copyWith(color: customWhite100)),
                              onTap: () {
                                context.goNamed(DataProtectionScreen.routeName);
                              }),
                        ]),
                        Image.asset('assets/partners_logos/c4f_logo.png', width: 400),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
