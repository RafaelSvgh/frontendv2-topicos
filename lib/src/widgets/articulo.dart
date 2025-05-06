import 'package:flutter/material.dart';
import 'package:front_ia/src/pages/detalle_page.dart';
import '../models/articulo_model.dart';

class ArticuloResultsWidget extends StatelessWidget {
  final List<LegalSearchResult> resultados;

  const ArticuloResultsWidget({super.key, required this.resultados});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: resultados.length,
      itemBuilder: (context, index) {
        final r = resultados[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetallePage(resultado: r),
              ),
            );
          },
          child: Card(
            color: Colors.grey[900],
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // doc y artículo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          _limitarTexto(r.documento),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          r.articuloNumero,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // fragmento de articulo
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: _resaltarCoincidencia(r.fragmento, r.coincidencia),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

// esto para truncar el texto a 30 caracteres
  String _limitarTexto(String texto) {
    if (texto.length > 35) {
      return texto.substring(0, 30) + '...';
    }
    return texto;
  }

  String quitarTildes(String texto) {
    const withAccent = 'áéíóúÁÉÍÓÚ';
    const withoutAccent = 'aeiouAEIOU';

    for (int i = 0; i < withAccent.length; i++) {
      texto = texto.replaceAll(withAccent[i], withoutAccent[i]);
    }
    return texto;
  }

  // esto para resaltar coincidencia en el fragmento - probar después
  Widget _resaltarCoincidencia(String texto, String palabraClave) {
    if (palabraClave.isEmpty) {
      return Text(
        texto,
        style: const TextStyle(color: Colors.white),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.justify,
      );
    }

// Convertir tanto el texto como la palabra clave a minúsculas y quitar tildes para la comparación
    final textoSinTildes = quitarTildes(texto.toLowerCase());
    final palabraClaveSinTildes = quitarTildes(palabraClave.toLowerCase());

    final spans = <TextSpan>[];
    final regex =
        RegExp(RegExp.escape(palabraClaveSinTildes), caseSensitive: false);
    int start = 0;

    for (final match in regex.allMatches(textoSinTildes)) {
      if (match.start > start) {
        spans.add(TextSpan(
          text: texto.substring(start, match.start),
          style: const TextStyle(color: Colors.white),
        ));
      }

      // Coincidencia resaltada
      spans.add(TextSpan(
        text: texto.substring(match.start, match.end),
        style: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.grey[700],
          fontWeight: FontWeight.bold,
        ),
      ));

      start = match.end;
    }

    // Parte restante después de la última coincidencia
    if (start < texto.length) {
      spans.add(TextSpan(
        text: texto.substring(start),
        style: const TextStyle(color: Colors.white),
      ));
    }

    return Text.rich(
      TextSpan(children: spans),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.justify,
    );
  }
}
