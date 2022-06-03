import 'package:agora_vai_imprimir/src/services/pdf_functions.dart';
import 'package:flutter/material.dart';

import '../widgets/meu_text_form_field.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var pdf = PdfFunctions();
  TextEditingController? volumeEC;
  TextEditingController? qtdEC;
  TextEditingController? alturaEC;
  TextEditingController? larguraEC;

  @override
  void initState() {
    volumeEC = TextEditingController(text: '');
    qtdEC = TextEditingController(text: '');
    alturaEC = TextEditingController(text: '');
    larguraEC = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 320,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Text('Volume'),
                  const SizedBox(width: 10),
                  MeuTextFormField(
                    controller: volumeEC!,
                    label: 'Nome do volume desejado',
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Quantidade'),
                  const SizedBox(width: 10),
                  MeuTextFormField(
                    label: 'Quantidade de etiquetas',
                    controller: qtdEC!,
                    largura: 200,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Altura'),
                  const SizedBox(width: 10),
                  MeuTextFormField(
                    label: 'Altura das etiquetas',
                    controller: alturaEC!,
                    largura: 200,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Largura'),
                  const SizedBox(width: 10),
                  MeuTextFormField(
                    controller: larguraEC!,
                    label: 'Largura das etiquetas',
                  ),
                ],
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  pdf.imprimir(
                    qtd: qtdEC!.text,
                    nomeVolume: volumeEC!.text,
                    alturaEtiqueta: alturaEC!.text,
                    larguraEtiqueta: larguraEC!.text,
                  );
                },
                child: const Text(
                  'IMPRIMIR',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // ElevatedButton(
              //   onPressed: () {
              //     pdf.exibir(volumeEC!.text, qtdEC!.text);
              //   },
              //   child: const Text(
              //     'VISUALIZAR',
              //     style: TextStyle(
              //       fontWeight: FontWeight.w900,
              //       fontSize: 15,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
