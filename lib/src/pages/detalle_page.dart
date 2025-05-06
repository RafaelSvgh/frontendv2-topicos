import 'package:flutter/material.dart';
import '../models/articulo_model.dart';
import '../services/text_to_speech.dart';

class DetallePage extends StatefulWidget {
  final LegalSearchResult resultado;

  const DetallePage({super.key, required this.resultado});

  @override
  State<DetallePage> createState() => _DetallePageState();
}

class _DetallePageState extends State<DetallePage> {
  final TTSService _ttsService = TTSService();

  @override
  void initState() {
    super.initState();
    _ttsService.onSpeakingStateChanged = (isSpeaking) {};
  }

  @override
  void dispose() {
    _ttsService.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resultado = widget.resultado;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              'Normativa de Tránsito de Bolivia',
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 18,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        titleSpacing: -12,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resultado.documento.trim(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    if (resultado.tituloNumero != 'SN')
                      Text(
                        resultado.tituloNumero.trim(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                        ),
                      ),
                    if (resultado.tituloNombre != 'SN')
                      Text(
                        resultado.tituloNombre.trim(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    const SizedBox(height: 12),
                    if (resultado.capituloNumero != 'SN')
                      Text(
                        resultado.capituloNumero.trim(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                        ),
                      ),
                    if (resultado.capituloNombre != 'SN')
                      Text(
                        resultado.capituloNombre.trim(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    const SizedBox(height: 15),
                    Text(
                      '${resultado.articuloNumero}: ${resultado.articuloNombre}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      resultado.fragmento.trim(),
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.white70,
                      ),
                      //textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_ttsService.isSpeaking) {
            _ttsService.stop();
          } else {
            _ttsService.speak(
              'Documento: ${resultado.documento} ${resultado.articuloNumero} ${resultado.articuloNombre} ${resultado.fragmento}',
            );
          }
        },
        backgroundColor: Colors.grey[600],
        shape: const CircleBorder(),
        child: Icon(
          _ttsService.isSpeaking ? Icons.stop : Icons.volume_up,
          color: Colors.white,
        ),
      ),
    );
  }
}
