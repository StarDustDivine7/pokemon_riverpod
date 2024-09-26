import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:river_pod/model/page_data.dart';
import 'package:river_pod/services/http_services.dart';
import 'package:riverpod/riverpod.dart';
import '../../../model/pokamon.dart';

// class HomePageProvider extends StateNotifier<HomePageData> {
//   // Now create a constracter
//   HomePageProvider(super.state);
//    final GetIt getIt = GetIt.instance;
//    final  HttpServices httpServices;
//    httpServices = getIt.get<HttpServices>();

// }

class HomePageProvider extends StateNotifier<HomePageData> {
  final GetIt getIt = GetIt.instance;
  late HttpServices httpServices;
  // Constructor
  HomePageProvider(super.state) {
    // Initialize httpServices here
    httpServices = getIt.get<HttpServices>();
    setUp();
  }

  Future<void> setUp() async {
    loadData();
  }

  Future<void> loadData() async {
    if (state.data == null) {
      Response? response = await httpServices
          .get("https://pokeapi.co/api/v2/pokemon?limit=20&offset=0");
      // print(response!.data);
      if (response!.data != null) {
        PokemonListData responseData = PokemonListData.fromJson(response.data);
        // Now update the data from the api
        state = state.copyWith(data: responseData);
        print(state.data!.results!.first);
      }
    } else {
      // here is the pagination data
      if (state.data!.next != null) {
        Response? response = await httpServices.get(state.data!.next!);
        if (response!.data != null) {
          PokemonListData responseData =
              PokemonListData.fromJson(response.data);
          state = state.copyWith(
              data: responseData.copyWith(results: [
            ...state.data!.results!,
            ...responseData.results!
          ]));
        }
      }
    }
  }
}
