import 'package:flutter/material.dart';
import 'package:surabhi/view/widgets/primary_button_widget.dart';

class UpdateChecklist extends StatefulWidget {
  const UpdateChecklist({Key? key}) : super(key: key);

  @override
  _UpdateChecklistState createState() => _UpdateChecklistState();
}

class _UpdateChecklistState extends State<UpdateChecklist> {
  // Store answers for each question (null, 'yes', 'no')
  List<String?> _answers = List.generate(6, (_) => null);

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
              _buildQuestionCard(0, 'Is the wasroom clean?'),
              _buildQuestionCard(1, 'Is the property broken or damaged?'),
              _buildQuestionCard(2, 'Do you find this checklist helpful?'),
              _buildQuestionCard(3, 'Are all lights working?'),
              _buildQuestionCard(4, 'Is the floor clean?'),
              _buildQuestionCard(5, 'Is the furniture in good condition?'),
              const SizedBox(height: 20),
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

  // Build each question with Yes/No buttons
  Widget _buildQuestionCard(int index, String question) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16), // Adds space between questions
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildAnswerButton(index, 'Yes', _answers[index] == 'yes'),
              const SizedBox(width: 10),
              _buildAnswerButton(index, 'No', _answers[index] == 'no'),
            ],
          ),
        ],
      ),
    );
  }

  // Build Yes/No button with selected state
  Widget _buildAnswerButton(int index, String label, bool isSelected) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _answers[index] = label.toLowerCase(); // Set the answer to yes or no
        });
      },
      style: ElevatedButton.styleFrom(
        primary: isSelected ? Colors.green : Colors.grey[300],
        onPrimary: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(label),
    );
  }

  // Submit checklist and ensure all questions are answered
  void _submitChecklist() {
    bool allAnswered = _answers.every((answer) => answer != null);

    if (allAnswered) {
      // Proceed with submission logic (e.g., send data to API)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Checklist submitted successfully!')),
      );
    } else {
      // Show error if not all questions are answered
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please answer all questions.')),
      );
    }
  }
}
