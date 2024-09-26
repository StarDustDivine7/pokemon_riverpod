import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/model/pokamon.dart';
import 'package:river_pod/providers/pokamon_data_providers.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokamonListTile extends ConsumerWidget {
  final String pokamonUrl;

  const PokamonListTile({super.key, required this.pokamonUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(pokamonDataProvider(pokamonUrl));
    // Here is implement in the future provider
    return pokemon.when(data: (data) {
      return _tile(context, false, data);
    }, error: (error, stackTrace) {
      return Text('Error: $error');
    }, loading: () {
      return _tile(context, true, null);
    });
  }

  Widget _tile(
    BuildContext context,
    bool isLoading,
    Pokemon? pokemon,
  ) {
    return Skeletonizer(
      enabled: isLoading,
      child: ListTile(
        leading:
            CircleAvatar(child: Image.network(pokemon!.sprites!.frontDefault!)),
        title: Text(pokemon.name!.toUpperCase()),
        subtitle: Text("Has a ${pokemon.moves!.length.toString()} moves"),
        trailing: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_border_outlined,
              size: 18,
            )),
      ),
    );
  }
}
