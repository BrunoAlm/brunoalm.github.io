import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../services/pdf_functions.dart';

class ViewPrint extends StatelessWidget {
  const ViewPrint({
    super.key,
    required this.title,
    required this.nomeVolume,
    required this.intQtd,
    required this.larguraEtiqueta,
    required this.alturaEtiqueta,
  });
  final String title;
  final String nomeVolume;
  final int intQtd;
  final double larguraEtiqueta;
  final double alturaEtiqueta;
  @override
  Widget build(BuildContext context) {
    var pdf = PdfFunctions();
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxHeight: 563.5,
            maxWidth: 643.5,
          ),
          child: PdfPreview(
            build: (format) => pdf.generatePdf(format,
                alturaEtiqueta: alturaEtiqueta,
                larguraEtiqueta: larguraEtiqueta,
                nomeVolume: nomeVolume,
                qtd: intQtd),
          ),
        ),
      ),
    );
  }
}
