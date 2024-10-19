import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/buttons.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/information_bottom_row.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/search_content.dart';
import 'package:multimodal_routeplanner/01_presentation/values/dimensions.dart';

class SearchScreenV3 extends StatefulWidget {
  const SearchScreenV3({super.key});

  static const String routeName = 'v2-search';
  static const String path = 'search';

  @override
  State<SearchScreenV3> createState() => _SearchScreenV3State();
}

class _SearchScreenV3State extends State<SearchScreenV3> {
  bool started = false;
  late ScrollController _scrollController;

  final GlobalKey _searchHeaderKey = GlobalKey();
  double _searchHeaderHeight = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    // Add a post-frame callback to get the height of the container after layout
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getSearchHeaderHeight();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _getSearchHeaderHeight() {
    final RenderBox? renderBox = _searchHeaderKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        _searchHeaderHeight = renderBox.size.height;
      });
    }
  }

  void _scrollListener() {
    if (_scrollController.offset <= 300) {
      setState(() {
        started = false;
      });
    } else {
      setState(() {
        started = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isMobile = screenWidth < mobileScreenWidthMinimum;

    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              SearchContent(isMobile: isMobile, searchHeaderKey: _searchHeaderKey),
              largeVerticalSpacer,
              const InformationContainer(),
            ],
          ),
        ),
        if (!started && (screenWidth / screenHeight) > 1)
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(padding: EdgeInsets.only(bottom: largePadding), child: _floatingStartButton(context))),
      ],
    );
  }

  Widget _floatingStartButton(BuildContext context) {
    AppLocalizations lang = AppLocalizations.of(context)!;
    TextTheme textTheme = Theme.of(context).textTheme;

    return V3CustomButton(
      height: 60,
      width: 240,
      label: lang.get_started,
      textStyle: textTheme.bodyLarge,
      onTap: () {
        setState(() {
          _getSearchHeaderHeight();
          _scrollController.animateTo(
            _searchHeaderHeight - 100,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        });
      },
    );
  }
}
