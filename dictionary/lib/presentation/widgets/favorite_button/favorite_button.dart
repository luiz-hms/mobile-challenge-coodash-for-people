import 'package:dictionary/core/dependence_injector/injector.dart';
import 'package:dictionary/domain/word_repositories.dart';
import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  final bool isFavorite;
  final String word;

  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.word,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late final ValueNotifier<bool> _isFavoriteNotifier;
  final repository = locator.get<WordRepository>();

  @override
  void initState() {
    super.initState();
    _isFavoriteNotifier = ValueNotifier<bool>(widget.isFavorite);
  }

  @override
  void dispose() {
    _isFavoriteNotifier.dispose();
    super.dispose();
  }

  void _toggleFavorite() async {
    final newValue = !_isFavoriteNotifier.value;
    _isFavoriteNotifier.value = newValue;
    await repository.updateWord(widget.word, newValue);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isFavoriteNotifier,
      builder: (context, isFavorite, _) {
        return IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.redAccent,
          ),
          onPressed: () {
            _toggleFavorite();
          },
        );
      },
    );
  }
}
