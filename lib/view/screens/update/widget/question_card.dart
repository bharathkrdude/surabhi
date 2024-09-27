import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  final String? answer;
  final void Function(String) onAnswerSelected;

  const QuestionCard({
    Key? key,
    required this.question,
    required this.answer,
    required this.onAnswerSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              _buildAnswerButton('Yes', answer == 'yes'),
              const SizedBox(width: 10),
              _buildAnswerButton('No', answer == 'no'),
            ],
          ),
        ],
      ),
    );
  }

  // Build Yes/No button with selected state
  Widget _buildAnswerButton(String label, bool isSelected) {
    return ElevatedButton(
      onPressed: () {
        onAnswerSelected(label.toLowerCase()); // Notify parent of answer selection
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: isSelected ? Colors.white : Colors.black, backgroundColor: isSelected ? Colors.green : Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(label),
    );
  }
}
