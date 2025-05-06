import 'package:flutter/material.dart';
import 'package:front_ia/src/widgets/appbar.dart';
import 'package:front_ia/src/widgets/drawer.dart';
import '../models/articulo_model.dart';
import '../widgets/articulo.dart';
import '../services/db_helper.dart';

class OfflineSearchPage extends StatefulWidget {
  const OfflineSearchPage({super.key});

  @override
  State<OfflineSearchPage> createState() => _OfflineSearchPageState();
}

class _OfflineSearchPageState extends State<OfflineSearchPage> {
  // ignore: unused_field
  List<LegalSearchResult> _todos = [];
  List<LegalSearchResult> _filtrados = [];

  @override
  void initState() {
    super.initState();
    _loadLeyes();
  }

  Future<void> _loadLeyes() async {
    final query = await DBHelper.getArticulosAleatorios(10);
    if (!mounted) return;
    final lista =
        query
            .map(
              (e) => LegalSearchResult.legalSearchResult(
                documento: e['documento'],

                articuloNumero: e['articuloNumero'].toString(),
                articuloNombre: e['articuloNombre'] ?? '',
                fragmento: e['fragmento'] ?? '',
                coincidencia: '',
                tituloNumero: e['tituloNumero'] ?? '',
                tituloNombre: e['tituloNombre'] ?? '',
                capituloNumero: e['capituloNumero'] ?? '',
                capituloNombre: e['capituloNombre'] ?? '',
              ),
            )
            .toList();
    setState(() {
      _todos = lista;
      _filtrados = lista;
    });
  }

  String quitarTildes(String texto) {
    const withAccent = 'áéíóúÁÉÍÓÚ';
    const withoutAccent = 'aeiouAEIOU';

    for (int i = 0; i < withAccent.length; i++) {
      texto = texto.replaceAll(withAccent[i], withoutAccent[i]);
    }
    return texto;
  }

  void _buscar(String query) async {
    if (query.isEmpty) {
      _loadLeyes();
      return;
    }

    final results = await DBHelper.getArticulosAleatorios(500);
    final queryNormalizado = quitarTildes(query.toLowerCase());
    if (!mounted) return;
    final filtrados =
        results
            .where((e) {
              final contenidoNormalizado = quitarTildes(
                e['fragmento']?.toLowerCase() ?? '',
              );
              return contenidoNormalizado.contains(queryNormalizado);
            })
            .map(
              (e) => LegalSearchResult.legalSearchResult(
                documento: e['documento'],

                articuloNumero: e['articuloNumero'].toString(),
                articuloNombre: e['articuloNombre'] ?? '',
                fragmento: e['fragmento'] ?? '',
                coincidencia: query,
                tituloNumero: e['tituloNumero'] ?? '',
                tituloNombre: e['tituloNombre'] ?? '',
                capituloNumero: e['capituloNumero'] ?? '',
                capituloNombre: e['capituloNombre'] ?? '',
              ),
            )
            .toList();

    setState(() {
      _filtrados = filtrados;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: appBar(theme, 'Normativa de Tránsito'),
      drawer: drawer(theme, context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(Icons.search, color: Colors.white54),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: _buscar,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Buscar...',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.mic, color: Colors.white54),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: ArticuloResultsWidget(resultados: _filtrados)),
        ],
      ),
    );
  }
}
