import 'package:dictionary/core/dependence_injector/injector.dart';
import 'package:dictionary/core/routes/named_routes.dart';
import 'package:dictionary/domain/word_repositories.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final String word;
  final Widget? trailing;
  const CustomCard({super.key, required this.word, this.trailing});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    var repository = locator.get<WordRepository>();
    return Card(
      color: Color(0xfffbfbfb),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        title: Text(
          widget.word,
          style: TextStyle(
            color: Color(0xff151419),
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: widget.trailing,
        onTap: () async {
          final wordDetailArgument = widget.word;
          int id = await repository.insertWord(widget.word);
          if (id != 0) {
            Navigator.of(
              context,
            ).pushNamed(NamedRoute.wordDetail, arguments: wordDetailArgument);
          }
        },
      ),
    );
  }
}
