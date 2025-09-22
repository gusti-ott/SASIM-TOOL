import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/buttons.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/information_bottom_row.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/search_content.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
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

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getSearchHeaderHeight();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _startLoading();
  }

  Future<void> _startLoading() async {
    // Start both the image preloading and a minimum 3-second timer
    await Future.wait([
      _preloadImage(),
      Future.delayed(const Duration(seconds: 3)),
    ]);

    // Once both are complete, remove the loading screen
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _preloadImage() async {
    await precacheImage(
      const AssetImage('assets/title_image/mobiscore_header_1.png'),
      context,
    );
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

    Widget searchContent = SearchContent(isMobile: isMobile, searchHeaderKey: _searchHeaderKey);

    return Stack(
      children: [
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 1000),
          firstChild: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Column(
              children: [
                const Expanded(
                  child: LoadingScreen(),
                ),
                largeVerticalSpacer,
                const InformationContainer(),
              ],
            ),
          ),
          secondChild: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                searchContent,
                largeVerticalSpacer,
                const InformationContainer(),
              ],
            ),
          ),
          crossFadeState: isLoading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
        if (!started && !isLoading && (screenWidth / screenHeight) > 1)
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

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double sizeLogo = 105;

    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: SizedBox(height: sizeLogo + 8)),
          CircularProgressIndicator(
            color: primaryColorV3, // Indeterminate spinner
            strokeWidth: 5.0,
          ),
          mediumVerticalSpacer,
          Text(
            "... gleich geht's los!",
            style: textTheme.headlineMedium!.copyWith(color: primaryColorV3),
          ),
          smallVerticalSpacer,
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/mobiscore_logos/logo_with_text_primary.png',
                height: sizeLogo,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
