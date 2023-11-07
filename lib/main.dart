import 'package:flutter/material.dart';
import './questao.dart';

main() => runApp(PerguntaApp());

class QuestionNavigation extends StatelessWidget {

  final void Function() onNextPressed;
  final void Function() onPreviousPressed;

  const QuestionNavigation(this.onNextPressed, this.onPreviousPressed, {super.key});

  @override
  Widget build(BuildContext context) => Row(children: [
    ElevatedButton(onPressed: onPreviousPressed, child: const Text('Previous')),
    ElevatedButton(onPressed: onNextPressed, child: const Text('Next'))
  ]);
}

class QuestionList extends StatelessWidget {

  final List<Map<String, dynamic>> questions;
  final int questionIndex;

  const QuestionList(this.questions, {this.questionIndex = 0, super.key});

  int get _lastIndex => questions.length - 1;

  int _adjustIndex(int index) => index >= _lastIndex ? _lastIndex : (index <= 0 ? 0 : index);

  List<Color> _getColorShade() => [
    Colors.amber.shade900,
    Colors.amber.shade800,
    Colors.amber.shade700,
    Colors.amber.shade600,
    Colors.amber.shade500
  ];

  List<Widget> getAnswers(int questionIndex, void Function(int a, int b) onPressed) => (questions[_adjustIndex(questionIndex)]['respostas'] as List<String>).asMap().entries.map((r) =>
    Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => onPressed.call(questionIndex, r.key),
        child: Text(r.value.toString(), style: TextStyle(fontSize: 20),),
        style: ElevatedButton.styleFrom(backgroundColor: _getColorShade().elementAt(r.key))
      )
    )
  ).toList();

  @override
  Widget build(BuildContext context) => Column(children: questions.asMap().entries.map((e) => Column(
    children: [
      Questao(
        '${e.key + 1}. ${e.value['texto']}', isSelected: questionIndex == e.key
      ),
      Text('R: ${questions[e.key]['selected'] == null ? '' : questions[e.key]['respostas'][questions[e.key]['selected']]}',
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18))
    ],
  ),).toList());
}

class _PerguntaAppState extends State<PerguntaApp> {

  final perguntas = [
    {
      'texto': 'Qual é a sua cor favorita?',
      'respostas': ['Azul', 'Verde', 'Vermelho', 'Amarelo', 'Preto'],
      'selected': null
    },
    {
      'texto': 'Qual é o seu animal favorito?',
      'respostas': ['Cachorro', 'Gato', 'Lontra', 'Papagaio'],
      'selected': null
    },
    {
      'texto': 'Qual seu time do coração?',
      'respostas': ['Corinthians', 'Palmeiras', 'São Paulo', 'Santos'],
      'selected': null
    }
  ];

  int count = 0;
  int questionIndex = 0;
  QuestionList? _questionList;

  void setAnswer(int questionIndex, int answerIndex) => 
  setState(() {
    perguntas[questionIndex]['selected'] = answerIndex;
  });

  void _incrementar() => setState(() {
    count++;
    print(perguntas.map((p) => p['selected']).join(', '));
  });

  void next() => setState(() {
    questionIndex = (questionIndex >= perguntas.length - 1 ? 0 : questionIndex + 1);
  });

  void previous() => setState(() {
    questionIndex = (questionIndex <= 0 ? perguntas.length - 1 : questionIndex - 1);
  });

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
          (_questionList = QuestionList(perguntas, questionIndex: questionIndex)),
          ..._questionList!.getAnswers(questionIndex, (q, a) => setState(() => perguntas[q]['selected'] = a)),
          QuestionNavigation(next, previous),
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
