import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:project_given_by_sayyam/features/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLogin = false;
  List<String> languages_list = ["Select language", "English", "Hindi"];
  String lang_selected = "Select language";
  String? gender_selected;

  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Register',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Create account',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                custom_text_field(
                  HintText: "Your Name",
                  controllerr: namecontroller,
                  label: 'Name',
                ),
                const SizedBox(height: 15),
                custom_text_field(
                  HintText: "Your Email",
                  controllerr: emailcontroller,
                  label: 'Email',
                ),
                const SizedBox(height: 15),
                custom_text_field(
                  HintText: "Your password",
                  controllerr: passcontroller,
                  label: 'Password',
                ),
                const SizedBox(height: 15),
                Text("Language"),
                SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: lang_selected,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),

                  items: languages_list.map((lang) {
                    return DropdownMenuItem<String>(
                      value: lang,
                      child: Text(lang),
                    );
                  }).toList(),
                  onChanged: (val) {
                    lang_selected = val!;
                  },
                ),
                const SizedBox(height: 15),
                Text('Gender: '),
                Row(
                  children: [
                    Radio(
                      value: 'male',
                      groupValue: gender_selected,
                      onChanged: (val) {
                        setState(() {});
                        gender_selected = val;
                      },
                    ),
                    const Text('Male'),
                    const SizedBox(width: 10),
                    Radio(
                      value: 'female',
                      groupValue: gender_selected,
                      onChanged: (val) {
                        setState(() {});
                        gender_selected = val;
                      },
                    ),
                    const Text('Female'),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // .push In this, name of route should be passed
                      // .replace
                      // .go
                      // These r 3 properties
                      onclickregister();
                      Fluttertoast.showToast(msg: "Registered successfully");
                      context.goNamed(routesname.home);
                    },
                    child: const Text('Register'),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Have an account? Login'),
                  ),
                ),

                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'By clicking Register, you agree to our Terms and Privacy Policy.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onclickregister() async {
    if (namecontroller.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter name");

      return;
    }
    if (emailcontroller.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter email");
      return;
    }
    if (passcontroller.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter password");
      return;
    }
    if (lang_selected == "Select langauge") {
      Fluttertoast.showToast(msg: "Select a language");
      return;
    }
    if (gender_selected == null) {
      Fluttertoast.showToast(msg: "Select a gender");
      return;
    }

    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString("Name", namecontroller.text.toString());
    await sp.setString("Email", emailcontroller.text.toString());
    await sp.setString("Pass", passcontroller.text.toString());
    isLogin = true;
    print("Local data saved");
    await sp.setString("isLogin", isLogin.toString());
    namecontroller.clear();
    emailcontroller.clear();
    passcontroller.clear();
    setState(() {
      lang_selected = "Select language";
      gender_selected = "";
    });
  }
}

class custom_text_field extends StatelessWidget {
  String HintText;
  Widget? suffixIcon;
  String label;
  TextEditingController controllerr;
  custom_text_field({
    required this.HintText,
    this.suffixIcon,
    required this.controllerr,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
          ),

          child: TextField(
            controller: controllerr,

            decoration: InputDecoration(
              hintText: HintText,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
      ],
    );
  }
}
