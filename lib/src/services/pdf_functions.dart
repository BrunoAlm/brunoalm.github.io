import 'dart:typed_data';
import 'package:agora_vai_imprimir/src/widgets/meu_erro_dialog.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:barcode_image/barcode_image.dart';
import 'package:printing/printing.dart';
import 'package:asuka/asuka.dart' as asuka;

class PdfFunctions {
  PdfFunctions();

  Future<Uint8List> generatePdf(
    PdfPageFormat format, {
    required String nomeVolume,
    required int qtd,
    required double larguraEtiqueta,
    required double alturaEtiqueta,
  }) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    String buildBarcode(Barcode bc, String data) {

      /// Create the Barcode
      final svg = bc.toSvg(
        data,
        width: larguraEtiqueta * 0.164,
        height: alturaEtiqueta * 0.164,
        // width: width ?? 200,
        // height: height ?? 80,
      );

      // Save the image
      // filename ??= bc.name.replaceAll(RegExp(r'\s'), '-').toLowerCase();
      // File('$filename.svg').writeAsStringSync(svg);
      return svg;
      // return base64Decode(svg);
    }

    minhaPage() {
      // PdfPageFormat customFormato = PdfPageFormat(
      //   larguraEtiqueta,
      //   alturaEtiqueta,
      //   // 143.5,
      //   // 220.5,
      //   // marginAll: 10,
      //   // marginLeft: 1.0,
      // );

      for (var i = 1; i <= qtd; i++) {
        pdf.addPage(
          pw.Page(
            orientation: pw.PageOrientation.landscape,
            pageFormat: format,
            build: (pw.Context context) {
              return pw.Container(
                width: larguraEtiqueta * .246,
                height: alturaEtiqueta * .246,
                // child:
                // pw.GridPaper.millimeter(
                //   color: PdfColor.fromRYB(1, 0, 0),
                child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    // pw.Center(
                    //     child: pw.Text('$nomeVolume$i',
                    //         style: pw.TextStyle(font: font))),
                    // pw.SizedBox(height: 10),
                    pw.SvgImage(
                        svg: buildBarcode(Barcode.code93(), '$nomeVolume$i')),
                  ],
                ),

                // ),
              );
            },
          ),
        );
      }
    }

    minhaPage();

    return pdf.save();
  }

  void imprimir({
    required String nomeVolume,
    required String qtd,
    required String larguraEtiqueta,
    required String alturaEtiqueta,
  }) async {
    var regex = RegExp('^[0-9]*\$');

    var matchQtd = regex.hasMatch(qtd);
    var matchLarg = regex.hasMatch(larguraEtiqueta);
    var matchAlt = regex.hasMatch(alturaEtiqueta);
    if (matchQtd && nomeVolume.isNotEmpty && matchLarg && matchAlt) {
      var tempQtd = regex.stringMatch(qtd);
      var tempLarg = regex.stringMatch(larguraEtiqueta);
      var tempAlt = regex.stringMatch(alturaEtiqueta);
      if (tempQtd!.isEmpty ||
          tempQtd == '0' ||
          tempLarg!.isEmpty ||
          tempAlt!.isEmpty) {
        // se não digitar nada vira '0' ou for '0' mostra o dialog

        tempQtd = '0';
        tempLarg = '0';
        tempAlt = '0';
        asuka.showDialog(
          builder: (context) => const MeuErroDialog(),
        );
      } else {
        qtd = tempQtd;
        larguraEtiqueta = tempLarg;
        alturaEtiqueta = tempAlt;
        int intQtd = int.parse(qtd);
        double dLarguraEtiqueta = double.parse(larguraEtiqueta);
        double dAlturaEtiqueta = double.parse(alturaEtiqueta);

        PdfPageFormat customFormato = PdfPageFormat(
          dLarguraEtiqueta * .246,
          dAlturaEtiqueta * .246,
          // 143.5,
          // 220.5,
          // marginAll: 10,
          // marginLeft: 1.0,
        );

        await Printing.layoutPdf(
          onLayout: (_) => generatePdf(
            customFormato,
            nomeVolume: nomeVolume,
            qtd: intQtd,
            larguraEtiqueta: dLarguraEtiqueta,
            alturaEtiqueta: dAlturaEtiqueta,
          ),
        );
      }
      // tem numero
    } else {
      // se não for numero mostra o dialog
      asuka.showDialog(
        builder: (context) => const MeuErroDialog(),
      );
    }
  }
}
