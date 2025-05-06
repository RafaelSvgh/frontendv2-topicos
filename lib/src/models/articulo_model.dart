class LegalSearchResult {
  final String documento;

  final String articuloNumero;
  final String articuloNombre;
  final String fragmento;
  final String coincidencia;

  final String tituloNumero;
  final String tituloNombre;
  final String capituloNumero;
  final String capituloNombre;

  LegalSearchResult.legalSearchResult({
    required this.documento,

    required this.articuloNumero,
    required this.articuloNombre,
    required this.fragmento,
    required this.coincidencia,
    required this.tituloNumero,
    required this.tituloNombre,
    required this.capituloNumero,
    required this.capituloNombre,
  });

  factory LegalSearchResult.fromJson(Map<String, dynamic> json) {
    return LegalSearchResult.legalSearchResult(
      documento: json['documento'],

      articuloNumero: json['articuloNumero'],
      articuloNombre: json['articuloNombre'],
      fragmento: json['fragmento'],
      coincidencia: json['coincidencia'],
      tituloNumero: json['tituloNumero'],
      tituloNombre: json['tituloNombre'],
      capituloNumero: json['capituloNumero'],
      capituloNombre: json['capituloNombre'],
    );
  }
}
