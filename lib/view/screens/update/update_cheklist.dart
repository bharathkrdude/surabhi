import 'package:flutter/material.dart';
import 'package:surabhi/view/widgets/primary_button_widget.dart';

class UpdateChecklist extends StatefulWidget {
  const UpdateChecklist({Key? key}) : super(key: key);

  @override
  _UpdateChecklistState createState() => _UpdateChecklistState();
}

class _UpdateChecklistState extends State<UpdateChecklist> {
  List<bool> _isChecked = List.generate(6, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checklist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxListTile(
              title: Text('Is the wasroom clean?'),
              value: _isChecked[0],
              onChanged: (bool? value) {
                setState(() {
                  _isChecked[0] = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('is the property broken or damaged'),
              value: _isChecked[1],
              onChanged: (bool? value) {
                setState(() {
                  _isChecked[1] = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Do you find this checklist helpful?'),
              value: _isChecked[2],
              onChanged: (bool? value) {
                setState(() {
                  _isChecked[2] = value!;
                });
              },
            ),
             CheckboxListTile(
              title: Text('Is the wasroom clean?'),
              value: _isChecked[3],
              onChanged: (bool? value) {
                setState(() {
                  _isChecked[3] = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('is the property broken or damaged'),
              value: _isChecked[4],
              onChanged: (bool? value) {
                setState(() {
                  _isChecked[4] = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Do you find this checklist helpful?'),
              value: _isChecked[5],
              onChanged: (bool? value) {
                setState(() {
                  _isChecked[5] = value!;
                });
              },
            ),
            SizedBox(height: 20),
            PrimaryButtonWidget(title: "Submit", onPressed: (){})
          ],
        ),
      ),
    );
  }
}
