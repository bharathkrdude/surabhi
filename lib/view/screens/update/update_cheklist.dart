import 'package:flutter/material.dart';
import 'package:surabhi/view/screens/update/widget/complaint_card-widget.dart';
import 'package:surabhi/view/screens/update/widget/question_card.dart';
import 'package:surabhi/view/widgets/primary_button_widget.dart';

class UpdateChecklist extends StatefulWidget {
  const UpdateChecklist({Key? key, required int toiletId}) : super(key: key);

  @override
  _UpdateChecklistState createState() => _UpdateChecklistState();
}

class _UpdateChecklistState extends State<UpdateChecklist> {
  // Store answers for each question (null, 'yes', 'no')
  final List<String?> _answers = List.generate(6, (_) => null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checklist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QuestionCard(
                question: 'Is the wasroom clean?',
                answer: _answers[0],
                onAnswerSelected: (answer) => _setAnswer(0, answer),
              ),
              QuestionCard(
                question: 'Is the property broken or damaged?',
                answer: _answers[1],
                onAnswerSelected: (answer) => _setAnswer(1, answer),
              ),
              QuestionCard(
                question: 'Do you find this checklist helpful?',
                answer: _answers[2],
                onAnswerSelected: (answer) => _setAnswer(2, answer),
              ),
              QuestionCard(
                question: 'Are all lights working?',
                answer: _answers[3],
                onAnswerSelected: (answer) => _setAnswer(3, answer),
              ),
              QuestionCard(
                question: 'Is the floor clean?',
                answer: _answers[4],
                onAnswerSelected: (answer) => _setAnswer(4, answer),
              ),
              QuestionCard(
                question: 'Is the furniture in good condition?',
                answer: _answers[5],
                onAnswerSelected: (answer) => _setAnswer(5, answer),
              ),
              const SizedBox(height: 20),
              const ComplaintCard(complaintText: "Pipe Not Working", date: "9/10/2024"),
              PrimaryButtonWidget(
                title: "Submit",
                onPressed: _submitChecklist, // Ensure all questions are answered
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to set answers
  void _setAnswer(int index, String answer) {
    setState(() {
      _answers[index] = answer;
    });
  }

  // Submit checklist and ensure all questions are answered
  void _submitChecklist() {
    bool allAnswered = _answers.every((answer) => answer != null);

    if (allAnswered) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Checklist submitted successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please answer all questions.')),
      );
    }
  }
}

