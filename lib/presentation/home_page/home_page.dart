import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/model/page_data.dart';
import 'package:river_pod/presentation/home_page/provider/home_page_provider.dart';
import 'package:river_pod/widgets/pokamon_list_tile.dart';
import 'package:riverpod/riverpod.dart';

import '../../model/pokamon.dart';

// call that controller class or provider what ever you call and update the notifier
// and then call the state change notify function to notify the provider that the state has changed
// and use the type of data is coming
final homePageProvider =
    StateNotifierProvider<HomePageProvider, HomePageData>((ref) {
  return HomePageProvider(HomePageData.initial());
});

// this is the provider class and statefull provider
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  // create the homepage controller instance variable
  late HomePageProvider _homePageProvider;
  late HomePageData _homePageData;
  ScrollController _allPokemonListScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _allPokemonListScrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    _allPokemonListScrollController.removeListener(scrollListener);
    _allPokemonListScrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
// here is check the screen actual size to lisen the loading for pagination
    if (_allPokemonListScrollController.offset >=
            _allPokemonListScrollController.position.maxScrollExtent * 1 &&
        _allPokemonListScrollController.position.outOfRange) {
      _homePageProvider.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    // here the provider watch the value and update the state
    _homePageProvider = ref.watch(homePageProvider.notifier);
    _homePageData = ref.watch(homePageProvider);

    return Scaffold(
      body: buildUi(context),
    );
  }

  Widget buildUi(context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _allPokamonList(context),
          ],
        ),
      ),
    );
  }

  Widget _allPokamonList(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "All Pokamon",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.60,
            child: ListView.builder(
              controller: _allPokemonListScrollController,
              itemCount: _homePageData.data!.results!.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                PokemonListResult result = _homePageData.data!.results![index];
                return PokamonListTile(pokamonUrl: result.url.toString());
              },
            ),
          )
        ],
      ),
    );
  }
}
