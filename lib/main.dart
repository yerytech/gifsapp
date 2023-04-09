import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gifsapp/provider/gifs_providerstate.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gif App',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Gif App'),
            ),
            body: Container(
              child: const Titulos(),
            )));
  }
}

class Titulos extends ConsumerWidget {
  const Titulos({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final titulo = ref.watch(gifsProvider);

    return titulo.when(
        data: ((data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  color: Colors.deepPurple,
                  child: Column(
                    children: [
                      FadeInImage(
                          placeholder: const AssetImage('assets/loading.gif'),
                          image: NetworkImage(
                              titulo.value![index].images.downsized.url)),
                      Text(
                        titulo.value![index].title,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ));
            },
          );
        }),
        error: ((error, stackTrace) => const Center(child: Text('error'))),
        loading: (() => const Center(
              child: CircularProgressIndicator(),
            )));
  }
}
