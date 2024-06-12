import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/decorations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/search/search_cubit.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/search/widgets/calculate_button.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/config/setup_dependencies.dart';

Widget addressInputRow(BuildContext context, SearchState state,
    {required bool isMobile,
    required TextEditingController startController,
    required TextEditingController endController,
    required Function onStartChanged,
    required Function onEndChanged,
    required Function swapInputs}) {
  SearchCubit cubit = sl<SearchCubit>();

  return (!isMobile)
      ? desktopAddressInputRow(context, state,
          cubit: cubit,
          startController: startController,
          endController: endController,
          onStartChanged: onStartChanged,
          onEndChanged: onEndChanged,
          swapInputs: swapInputs)
      : mobileAddressInputContainer(context, state,
          cubit: cubit,
          startController: startController,
          endController: endController,
          onStartChanged: onStartChanged,
          onEndChanged: onEndChanged,
          swapInputs: swapInputs);
}

Column mobileAddressInputContainer(BuildContext context, SearchState state,
    {required SearchCubit cubit,
    required startController,
    required endController,
    required Function onStartChanged,
    required Function onEndChanged,
    required Function swapInputs}) {
  AppLocalizations lang = AppLocalizations.of(context)!;
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: textInputField(
              context,
              controller: startController,
              hintText: lang.from,
              onChanged: (value) {
                onStartChanged(value);
              },
            ),
          ),
          SizedBox(
            width: 50,
            child: IconButton(
              icon: const Icon(Icons.swap_horiz, color: Colors.grey),
              onPressed: () {
                swapInputs();
              },
            ),
          ),
        ],
      ),
      smallVerticalSpacer,
      textInputField(
        context,
        controller: endController,
        hintText: lang.to,
        onChanged: (value) {
          onEndChanged(value);
        },
      ),
      largeVerticalSpacer,
      statefulCalculateButton(context, state,
          cubit: cubit, startAddress: startController.text, endAddress: endController.text),
    ],
  );
}

Row desktopAddressInputRow(BuildContext context, SearchState state,
    {required SearchCubit cubit,
    required startController,
    required endController,
    required Function onStartChanged,
    required Function onEndChanged,
    required Function swapInputs}) {
  AppLocalizations lang = AppLocalizations.of(context)!;
  return Row(
    children: [
      Expanded(
        child: textInputField(
          context,
          controller: startController,
          hintText: lang.from,
          onChanged: (value) {
            onStartChanged(value);
          },
        ),
      ),
      const SizedBox(width: 8),
      IconButton(
        icon: const Icon(Icons.swap_horiz, color: Colors.grey),
        onPressed: () {
          swapInputs();
        },
      ),
      const SizedBox(width: 8),
      Expanded(
        child: textInputField(
          context,
          controller: endController,
          hintText: lang.to,
          onChanged: (value) {
            onEndChanged(value);
          },
        ),
      ),
      smallHorizontalSpacer,
      statefulCalculateButton(context, state,
          cubit: cubit, startAddress: startController.text, endAddress: endController.text),
    ],
  );
}

Widget textInputField(
  BuildContext context, {
  required TextEditingController controller,
  required String hintText,
  required ValueChanged<String> onChanged,
}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return Container(
    decoration: boxDecorationWithShadow(),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        prefixIcon: const Icon(Icons.search, color: Colors.black),
        suffixIcon: Icon(Icons.location_on, color: tertiaryColorV3),
        hintText: hintText,
        hintStyle: textTheme.labelMedium!.copyWith(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none, // No visible border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.transparent), // Transparent border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: secondaryColorV3), // Border when the TextField is focused
        ),
      ),
      onChanged: onChanged,
    ),
  );
}
