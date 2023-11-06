import 'package:flutter/material.dart';
import './questao.dart';

main() => runApp(PerguntaApp());

class _PerguntaAppState extends State<PerguntaApp> {

  final perguntas = [
    {
      'texto': 'Qual é a sua cor favorita?',
      'respostas': ['Azul', 'Verde', 'Vermelho', 'Amarelo']
    },
    {
      'texto': 'Qual é o seu animal favorito?',
      'respostas': ['Cachorro', 'Gato', 'Lontra', 'Papagaio']
    },
    {
      'texto': 'Qual seu time do coração?',
      'respostas': ['Corinthians', 'Palmeiras', 'São Paulo', 'Santos']
    }
  ];

  int count = 0;
  int questionIndex = 0;

  void _incrementar() {
    setState(() {
      count++;
    });
    print('Count: $count');
  }

  _printQuestionIndex() => print(questionIndex);

  void next() {
    setState(() {
      questionIndex = (questionIndex >= perguntas.length - 1 ? 0 : questionIndex + 1);
    });
    _printQuestionIndex();
  }

  void previous() {
    setState(() {
      questionIndex = (questionIndex <= 0 ? perguntas.length - 1 : questionIndex - 1);
    });
    _printQuestionIndex();
  }

List<Questao> _questionList() => perguntas.asMap().entries.map((e) => Questao(
  '${e.key + 1}. ${e.value['texto']}', isSelected: e.key == questionIndex
),).toList();

List<Color> _getColorShade() => [
  Colors.amber.shade800,
  Colors.amber.shade700,
  Colors.amber.shade600,
  Colors.amber.shade500
];

List<Widget> _answerList(int index) => (perguntas[index]['respostas'] as List<String>).asMap().entries.map((r) =>
  Container(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {},
      child: Text(r.value.toString(), style: TextStyle(fontSize: 20),),
      style: ElevatedButton.styleFrom(backgroundColor: _getColorShade().elementAt(r.key))
    )
  )).toList();

Widget _questionNavButtons() => Row(children: [
  ElevatedButton(onPressed: previous, child: Text('Previous')),
  ElevatedButton(onPressed: next, child: Text('Next'))
]);

Widget _incrementWidget() => Row(children: [
  ElevatedButton(onPressed: _incrementar, child: Text('Incrementar')),
  Text((count + 1).toString(), style: TextStyle(fontSize: 20),)
]);

@override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Perguntas'),
        ),
        body: Column(children: <Widget>[
          ..._questionList(),
          ..._answerList(questionIndex),
          _questionNavButtons(),
          _incrementWidget()
        ])
      )
    );
  }
}

class PerguntaApp extends StatefulWidget {

@override
  _PerguntaAppState createState() => _PerguntaAppState();
}
