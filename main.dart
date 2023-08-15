import 'package:flutter/material.dart';

void main() {
  runApp(IMC());
}

class IMC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PessoaIMCState();
  }
}

class PessoaIMCState extends State<IMC> {
  // Variáveis
  String? nome;
  String? texto;

  double alturaPaciente = 0.0;
  double pesoPaciente = 0.0;

  bool aceito = false;

  double calcularIMC(double altura, double peso) {
    double imc = peso / (altura * altura);
    return imc;
  }

  String obterResultadoIMC(double imc) {
    if (imc < 18.6) {
      return 'Abaixo do Peso';
    } else if (imc < 24.9) {
      return 'Peso Ideal';
    } else if (imc < 29.9) {
      return 'Levemente Acima do Peso';
    } else if (imc < 34.9) {
      return 'Obesidade Grau I';
    } else if (imc < 39.9) {
      return 'Obesidade Grau II';
    } else {
      return 'Obesidade Grau III';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora de IMC'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  setState(() {
                    nome = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    pesoPaciente = double.tryParse(value) ?? 0.0;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Peso (kg)'),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    alturaPaciente = double.tryParse(value) ?? 0.0;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Altura (m)'),
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: aceito,
                    onChanged: (valor) {
                      setState(() {
                        aceito = valor!;
                      });
                    },
                  ),
                  Text("Concorda com os dados informados?"),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (aceito) {
                    double imc = calcularIMC(alturaPaciente, pesoPaciente);
                    String resultadoIMC = obterResultadoIMC(imc);

                    setState(() {
                      texto =
                          '$nome, seu IMC é ${imc.toStringAsFixed(2)} ($resultadoIMC)';
                    });
                  } else {
                    setState(() {
                      texto =
                          "Por favor, concorde com os dados antes de calcular.";
                    });
                  }
                },
                child: Text('Calcular'),
              ),
              Text(
                texto ?? '',
                style: const TextStyle(fontSize: 15.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
