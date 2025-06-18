import 'package:dictionary/core/dependence_injector/injector.dart';
import 'package:dictionary/data/data_source/database_helper.dart';
import 'package:dictionary/data/models/word_models.dart';
import 'package:dictionary/domain/word_repositories.dart';
import 'package:dictionary/presentation/widgets/card/card.dart';
import 'package:dictionary/presentation/widgets/favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  var repository = locator.get<WordRepository>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'lista de favoritos',
          style: TextStyle(
            color: Color(0xff151419),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xfffbfbfb),
        elevation: 1,
      ),
      body: FutureBuilder<List<WordModels>>(
        future: repository.getWordsByFavorite(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xfff56E0f)),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Erro ao carregar Favoritos"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhuma palavra nos Favoritos"));
          }

          final listwords = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
            child: GridView.builder(
              itemCount: listwords.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 100,
                crossAxisSpacing: 10,
                mainAxisSpacing: 15,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final words = listwords[index];
                return CustomCard(
                  word: words.word,
                  trailing: FavoriteButton(
                    word: words.word,
                    isFavorite: words.favorite,
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        backgroundColor: const Color(0xff151419),
        tooltip: 'Increment',
        onPressed: () {
          repository.cleanList(DatabaseHelper.columnFavorite);
          setState(() {});
        },
        child: const Icon(
          Icons.delete_outline,
          color: Color(0xfff56E0f),
          size: 28,
        ),
      ),
    );
  }
}
