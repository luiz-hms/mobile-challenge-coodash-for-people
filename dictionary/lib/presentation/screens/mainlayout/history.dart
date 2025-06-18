import 'package:dictionary/core/dependence_injector/injector.dart';
import 'package:dictionary/data/data_source/database_helper.dart';
import 'package:dictionary/data/models/word_models.dart';
import 'package:dictionary/domain/word_repositories.dart';
import 'package:dictionary/presentation/widgets/app_bar/custom_app_bar.dart';
import 'package:dictionary/presentation/widgets/card/card.dart';
import 'package:dictionary/presentation/widgets/favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  var repository = locator.get<WordRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffbfbfb),
      appBar: CustomAppBar(context, "lista de histórico"),
      body: FutureBuilder<List<WordModels>>(
        future: repository.getWordsByHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xfff56E0f)),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Erro ao carregar histórico"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhuma palavra no histórico"));
          }

          final listwords = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
            child: GridView.builder(
              itemCount: listwords.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 100,
                crossAxisSpacing: 5,
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
        onPressed: () {
          repository.cleanList(DatabaseHelper.columnHistory);
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
