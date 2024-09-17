import 'package:flutter/material.dart';
import 'package:surabhi/view/widgets/custom_textfield.dart';
 final _formKey = GlobalKey<FormState>();
  final _formData = <String, dynamic>{};
class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100,),
              Form(
                child: CustomTextField(label: "full name", icon: Icons.abc, onSaved: (String? value) {
                    // Handle the saved value
                    if (value != null) {
                    // Do something with the value
                    print("Saved value: $value");
                    }
                  }),
              )
            ],
          ),
        ),
      ),
    );
  }
}