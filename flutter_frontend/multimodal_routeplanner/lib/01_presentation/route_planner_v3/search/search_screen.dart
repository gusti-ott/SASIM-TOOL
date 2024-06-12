import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/search/search_content.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/search/search_cubit.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/search/widgets/custom_switch.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/config/setup_dependencies.dart';

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
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
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
    TextTheme textTheme = Theme.of(context).textTheme;

    SearchCubit cubit = sl<SearchCubit>();

    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    return BlocBuilder<SearchCubit, SearchState>(
        bloc: cubit,
        builder: (context, state) {
          return Scaffold(
              key: _scaffoldKey,
              appBar: isMobile
                  ? AppBar(
                      leading: Padding(
                          padding: EdgeInsets.all(smallPadding),
                          child: Image.asset('assets/mobiscore_logos/logo_with_text_primary.png')),
                      actions: [
                        const CustomSwitch(),
                        IconButton(
                          icon: Icon(Icons.menu, color: primaryColorV3),
                          onPressed: () {
                            _scaffoldKey.currentState!.openDrawer();
                          },
                        ),
                      ],
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.white,
                    )
                  : null,
              drawer: buildDrawer(context),
              floatingActionButton: !started && !isMobile
                  ? FloatingActionButton.extended(
                      label: Text(
                        'Get Started',
                        style: textTheme.bodyMedium!.copyWith(color: onPrimaryColorV3),
                      ),
                      backgroundColor: primaryColorV3,
                      onPressed: () {
                        setState(() {
                          started = true;
                          _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeOut,
                          );
                        });
                      },
                    )
                  : null,
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              backgroundColor: backgroundColorV3,
              body: SearchContent(state, isMobile: isMobile, scrollController: _scrollController));
        });
  }

  Widget buildDrawer(BuildContext context) {
    AppLocalizations lang = AppLocalizations.of(context)!;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Drawer(
      backgroundColor: backgroundColorV3,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset('assets/mobiscore_logos/logo_with_text_primary.png', width: 70)),
          ),
          ListTile(
            title: Text(lang.research, style: textTheme.headlineLarge!.copyWith(color: primaryColorV3)),
            onTap: () {
              // Handle the navigation to the Home page
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            title: Text(lang.about_us, style: textTheme.headlineLarge!.copyWith(color: primaryColorV3)),
            onTap: () {
              // Handle the navigation to the Settings page
              Navigator.pop(context); // Close the drawer
            },
          ),
        ],
      ),
    );
  }
}
