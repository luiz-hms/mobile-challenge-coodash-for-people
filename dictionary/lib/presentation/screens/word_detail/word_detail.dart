import 'package:dictionary/data/models/api_dictionary_models.dart';
import 'package:dictionary/presentation/widgets/audio_player/audio_player.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../services/api.dart';

class WordDetail extends StatefulWidget {
  const WordDetail({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WordDetailState createState() => _WordDetailState();
}

class _WordDetailState extends State<WordDetail> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          args.toString(),
          style: TextStyle(
            color: Color(0xff151419),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xfffbfbfb),
        elevation: 1,
      ),
      body: FutureBuilder<List<ApiDictionaryModels>>(
        future: ApiService().fetchWordDetails(args.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xfff56E0f)),
            );
          }
          if (snapshot.hasError) {
            // ALGUMAS PALAVRAS NÃO ESTÃO SENDO ENCONTRADAS
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset('assets/404.json', height: 400, width: 300),
                  Text('Palavra não encontrada'),
                ],
              ),
            );
          }
          final data = snapshot.data!;
          final wordDetails = data.first;
          String? audioUrl;
          bool hasAudioUrl = false;
          for (var item in data) {
            if (item.phonetics.contains("audio") || item.phonetics.isNotEmpty) {
              for (var phonetic in item.phonetics) {
                // alguns campos "audio" vem vazio da api
                // percorre as listas phonetics e verifica qual campo está preenchido
                //porém algumas palavras NÃO TEM ÁUDIO como por exemplo a plavra aaa

                if (phonetic.audio != null &&
                    phonetic.audio.toString().isNotEmpty) {
                  audioUrl = phonetic.audio!;
                  hasAudioUrl;
                  break;
                }
              }
              if (audioUrl != null) {
                hasAudioUrl = true;
                break;
              }
            } else {
              hasAudioUrl = false;
              break;
            }
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              spacing: 6,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 250,
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      spacing: 5,
                      children: [
                        Text(audioUrl.toString()),
                        Text(
                          wordDetails.word,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),

                        Text(
                          'text: ${wordDetails.phonetics.first.text ?? ''}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  child: CustomAudio(urlAudio: audioUrl.toString()),
                  visible: false,
                ),
                // CustomAudio(urlAudio: audioUrl.toString()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    spacing: 5,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'meanings',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                      Text(
                        'definition - ${wordDetails.meanings.first.definitions.first.definition}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
