import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: MediaEscolarPage(),
    );
  }
}

class MediaEscolarPage extends StatefulWidget {
  const MediaEscolarPage({super.key});

  @override
  State<MediaEscolarPage> createState() => _MediaEscolarPageState();
}

class _MediaEscolarPageState extends State<MediaEscolarPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController nota1Controller = TextEditingController();
  final TextEditingController nota2Controller = TextEditingController();
  final TextEditingController nota3Controller = TextEditingController();
  final TextEditingController nota4Controller = TextEditingController();
  final TextEditingController frequenciaController = TextEditingController();

  String nomeAluno = '';
  String situacao = '';
  double media = 0;
  double pontosFaltantes = 0;
  double frequencia = 0;

  // Adicionado para os desafios
  double maiorNota = 0;
  double menorNota = 0;

  void calcularMedia() {
    String nome = nomeController.text.trim();

    double? nota1 = double.tryParse(nota1Controller.text.replaceAll(",", "."));
    double? nota2 = double.tryParse(nota2Controller.text.replaceAll(",", "."));
    double? nota3 = double.tryParse(nota3Controller.text.replaceAll(",", "."));
    double? nota4 = double.tryParse(nota4Controller.text.replaceAll(",", "."));

    double? frequenciaDigitada = double.tryParse(
      frequenciaController.text.replaceAll(",", "."),
    );

    if (nome.isEmpty ||
        nota1 == null ||
        nota2 == null ||
        nota3 == null ||
        nota4 == null ||
        frequenciaDigitada == null) {
      mostrarMensagem('Preencha todos os campos corretamente');
      return;
    }

    if (nota1 < 0 ||
        nota1 > 10 ||
        nota2 < 0 ||
        nota2 > 10 ||
        nota3 < 0 ||
        nota3 > 10 ||
        nota4 < 0 ||
        nota4 > 10) {
      mostrarMensagem('As notas devem estar entre 0 e 10.');
      return;
    }

    if (frequenciaDigitada < 0 || frequenciaDigitada > 100) {
      mostrarMensagem('A frequência deve estar entre 0% e 100%.');
      return;
    }

    double mediaCalculada = (nota1 + nota2 + nota3 + nota4) / 4;

    // Encontrar a maior nota
    double maior = nota1;

    if (nota2 > maior) {
      maior = nota2;
    }

    if (nota3 > maior) {
      maior = nota3;
    }

    if (nota4 > maior) {
      maior = nota4;
    }

    // Encontrar a menor nota
    double menor = nota1;

    if (nota2 < menor) {
      menor = nota2;
    }

    if (nota3 < menor) {
      menor = nota3;
    }

    if (nota4 < menor) {
      menor = nota4;
    }

    String situacaoCalculada;

    if (frequenciaDigitada < 75) {
      situacaoCalculada = 'REPROVADO POR FALTA';
    } else if (mediaCalculada >= 7) {
      situacaoCalculada = 'APROVADO';
    } else if (mediaCalculada >= 5) {
      situacaoCalculada = 'RECUPERAÇÃO';
    } else {
      situacaoCalculada = 'REPROVADO';
    }

    setState(() {
      nomeAluno = nome;
      media = mediaCalculada;
      frequencia = frequenciaDigitada;
      situacao = situacaoCalculada;

      // Salva a maior e a menor nota
      maiorNota = maior;
      menorNota = menor;

      if (mediaCalculada < 7) {
        pontosFaltantes = 7 - mediaCalculada;
      } else {
        pontosFaltantes = 0;
      }
    });
  }

  void mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensagem)));
  }

  void limpar() {
    nomeController.clear();
    nota1Controller.clear();
    nota2Controller.clear();
    nota3Controller.clear();
    nota4Controller.clear();
    frequenciaController.clear();

    setState(() {
      nomeAluno = '';
      media = 0;
      frequencia = 0;
      situacao = '';
      pontosFaltantes = 0;

      // Limpa também a maior e menor nota
      maiorNota = 0;
      menorNota = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de Média"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.school, size: 80),

            const SizedBox(height: 10),

            const Text(
              'Média Escolar',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            const Text(
              'Digite o nome e as quatro notas do aluno',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 25),

            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do aluno',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
                hintText: 'Exemplo: Henry',
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: nota1Controller,
              decoration: const InputDecoration(
                labelText: 'Nota 1',
                hintText: 'Digite uma nota de 0 a 10',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: nota2Controller,
              decoration: const InputDecoration(
                labelText: 'Nota 2',
                hintText: 'Digite uma nota de 0 a 10',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: nota3Controller,
              decoration: const InputDecoration(
                labelText: 'Nota 3',
                hintText: 'Digite uma nota de 0 a 10',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: nota4Controller,
              decoration: const InputDecoration(
                labelText: 'Nota 4',
                hintText: 'Digite uma nota de 0 a 10',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: frequenciaController,
              decoration: const InputDecoration(
                labelText: 'Frequência (%)',
                hintText: 'Digite de 0 a 100',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.percent),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: calcularMedia,
              icon: const Icon(Icons.calculate),
              label: const Text('Calcular média'),
            ),

            const SizedBox(height: 15),

            OutlinedButton.icon(
              onPressed: limpar,
              icon: const Icon(Icons.clear),
              label: const Text('Limpar'),
            ),

            if (situacao.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        nomeAluno,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Média: ${media.toStringAsFixed(1)}',
                        style: const TextStyle(fontSize: 20),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Frequência: ${frequencia.toStringAsFixed(1)}%',
                        style: const TextStyle(fontSize: 20),
                      ),

                      // Maior nota
                      const SizedBox(height: 10),

                      Text(
                        'Maior nota: ${maiorNota.toStringAsFixed(1)}',
                        style: const TextStyle(fontSize: 20),
                      ),

                      // Menor nota
                      const SizedBox(height: 10),

                      Text(
                        'Menor nota: ${menorNota.toStringAsFixed(1)}',
                        style: const TextStyle(fontSize: 20),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        situacao,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      if (frequencia < 75 && media < 7)
                        const Text(
                          'Aluno reprovado por falta e por média. '
                          'A frequência mínima é 75% e a média mínima é 7,0.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      else if (frequencia < 75)
                        const Text(
                          'Aluno reprovado por falta. '
                          'A frequência mínima é 75%.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      else if (media < 7)
                        Text(
                          'Faltaram ${pontosFaltantes.toStringAsFixed(1)} '
                          'pontos para a aprovação.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      else
                        const Text(
                          'Não faltaram pontos. Aluno aprovado!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
