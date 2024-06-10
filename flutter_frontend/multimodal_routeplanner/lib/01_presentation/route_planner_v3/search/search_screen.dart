import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/search/search_content.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/search/search_cubit.dart';
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

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    SearchCubit cubit = sl<SearchCubit>();

    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    _scrollController.addListener(() {
      if (_scrollController.offset <= 300) {
        setState(() {
          started = false;
        });
      } else {
        setState(() {
          started = true;
        });
      }
    });

    return BlocBuilder<SearchCubit, SearchState>(
        bloc: cubit,
        builder: (context, state) {
          return Scaffold(
              floatingActionButton: !started
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
              backgroundColor: backgroundSearchPage,
              body: SearchContent(isMobile: isMobile, scrollController: _scrollController));
        });
  }
}
