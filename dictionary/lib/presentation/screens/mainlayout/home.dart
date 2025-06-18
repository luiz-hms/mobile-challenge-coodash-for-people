import 'dart:convert';
import 'package:dictionary/presentation/widgets/card/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();

  List<String> _allWords = []; // Lista completa do JSON
  List<String> _visibleWords = []; // Lista paginada para exibição
  int _currentPage = 0;
  final int _itemsPerPage = 50;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _loadPalavrasFromJson();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore) {
      _loadNextPage();
    }
  }

  // Carrega o JSON e inicia a primeira página
  Future<void> _loadPalavrasFromJson() async {
    final String response = await rootBundle.loadString(
      'assets/words_dictionary.json',
    );
    final data = json.decode(response);

    _allWords = List<String>.from(data['wordsJson']);
    _loadNextPage(); // carrega a primeira página
  }

  // Carrega a próxima página de dados
  void _loadNextPage() {
    if (_isLoadingMore) return;
    _isLoadingMore = true;

    Future.delayed(const Duration(milliseconds: 300), () {
      final start = _currentPage * _itemsPerPage;
      final end = start + _itemsPerPage;
      final nextItems = _allWords.sublist(
        start,
        end > _allWords.length ? _allWords.length : end,
      );

      setState(() {
        _visibleWords.addAll(nextItems);
        _currentPage++;
      });

      _isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'lista de palavras',
          style: TextStyle(
            color: Color(0xff151419),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xfffbfbfb),
        elevation: 1,
      ),
      body:
          _allWords.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 10,
                ),
                child: GridView.builder(
                  controller: _scrollController,
                  itemCount: _visibleWords.length + 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 100,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 15,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    if (index < _visibleWords.length) {
                      final palavra = _visibleWords[index];
                      return CustomCard(word: palavra);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xfff56E0f),
                        ),
                      );
                    }
                  },
                ),
              ),
    );
  }
}
