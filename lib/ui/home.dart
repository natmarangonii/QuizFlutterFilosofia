import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> questoes = [];
  int indice = 0;
  int pontuacao = 0;
  bool respondeu = false;
  int? selecionada;

  @override
  void initState() {
    super.initState();
    carregarMockupJSON();
  }

  Future<void> carregarMockupJSON() async {
    String dados =
        await rootBundle.loadString('assets/mockup/perguntas.json');

    setState(() {
      questoes = json.decode(dados);
    });
  }

  void responder(int escolha) {
    if (respondeu) return;

    setState(() {
      respondeu = true;
      selecionada = escolha;

      if (escolha == questoes[indice]['resposta']) {
        pontuacao++;
      }
    });
  }

  void proxima() {
    setState(() {
      indice++;
      respondeu = false;
      selecionada = null;
    });
  }

  Color corBotao(int i) {
    if (!respondeu) return const Color(0xFF6D4C41); 

    if (i == questoes[indice]['resposta']) {
      return Colors.green;
    }

    if (i == selecionada) {
      return const Color(0xFF8D6E63); 
    }

    return const Color(0xFF6D4C41);
  }

  @override
  Widget build(BuildContext context) {
    if (questoes.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFFEFEBE9),
        body: Center(child: CircularProgressIndicator(color: Color(0xFF3E2723))),
      );
    }

    if (indice >= questoes.length) {
      return Scaffold(
        backgroundColor: const Color(0xFFEFEBE9),
        appBar: AppBar(
          title: const Text("Resultado"),
          backgroundColor: const Color(0xFF3E2723),
          foregroundColor: const Color(0xFFD7CCC8),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/info/logo.png',
                height: 120,
              ),

              const SizedBox(height: 20),

              const Text(
                "Quiz Finalizado!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3E2723),
                ),
              ),

              const SizedBox(height: 15),

              Text(
                "Pontuação: $pontuacao / ${questoes.length}",
                style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xFF3E2723),
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6D4C41),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                onPressed: () {
                  setState(() {
                    indice = 0;
                    pontuacao = 0;
                    respondeu = false;
                    selecionada = null;
                  });
                },
                child: const Text("Jogar Novamente"),
              ),
            ],
          ),
        ),
      );
    }

    var q = questoes[indice];

    return Scaffold(
      backgroundColor: const Color(0xFFEFEBE9),
      appBar: AppBar(
        title: const Text("Quiz de Filosofia"),
        backgroundColor: const Color(0xFF3E2723),
        foregroundColor: const Color(0xFFD7CCC8),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              Text(
                "Questão ${indice + 1} de ${questoes.length}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3E2723),
                ),
              ),

              const SizedBox(height: 20),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      
                      // ignore: deprecated_member_use
                      color: const Color(0xFF3E2723).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFFEFEBE9),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          q['imagem'],
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      q['pergunta'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF3E2723),
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 15),

                   ...List.generate(
                      q['alternativas'].length,
                      (i) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: corBotao(i),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => responder(i),
                            child: Text(
                              q['alternativas'][i],
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6D4C41),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: indice > 0
                       ? () => setState(() {
                              indice--;
                              respondeu = false;
                              selecionada = null;
                            })
                        : null,
                    child: const Text("Anterior"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6D4C41),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: respondeu? proxima : null,
                    child: const Text("Próxima"),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}