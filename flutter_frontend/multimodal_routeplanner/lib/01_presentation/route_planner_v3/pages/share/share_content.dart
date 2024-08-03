import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/buttons.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/decorations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/navigation_header.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/values.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';

class ShareContent extends StatelessWidget {
  const ShareContent({super.key, required this.isMobile, required this.startAddress, required this.endAddress});

  final String startAddress;
  final String endAddress;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isMobile) navigationHeaderRow(context),
        SizedBox(
            width: contentMaxWidth + mediumPadding,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: mediumPadding),
              child: (!isMobile) ? desktopShare(context) : mobileShare(context),
            )),
      ],
    );
  }

  Container desktopShare(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
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
                    'Do you like Mobi-Score? Tell a friend!',
                    style: textTheme.headlineSmall,
                    textAlign: TextAlign.left,
                  ),
                  V3CustomButton(
                    label: 'Copy URL',
                    leadingIcon: Icons.link,
                    textColor: primaryColorV3,
                    color: primaryColorV3,
                    reverseColors: true,
                    onTap: () {
                      Clipboard.setData(ClipboardData(
                              text: 'https://sasim.mcube-cluster.de/web/#/result?'
                                  'startAddress=$startAddress&endAddress=$endAddress'))
                          .then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('URL copied to clipboard')),
                        );
                      });
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mediumPadding, vertical: largePadding),
      child: Container(
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
                        Clipboard.setData(ClipboardData(
                                text: 'https://sasim.mcube-cluster.de/web/#/result?'
                                    'startAddress=$startAddress&endAddress=$endAddress'))
                            .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(lang.url_copied)),
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
