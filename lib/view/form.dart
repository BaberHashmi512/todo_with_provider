import 'package:flutter/material.dart';
import 'package:todo_with_provider/resources/Components/round_button.dart';
import 'package:todo_with_provider/utils/utils.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  FocusNode titleFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleFocusNode.dispose();
    descriptionFocusNode.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ADD todo"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 231, 237, 222),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              focusNode: FocusNode(),
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: "Title",
              ),
              onFieldSubmitted: (value){
                Utils.fieldFocusChange(
                    context, titleFocusNode, descriptionFocusNode);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: "Description",
              ),
            ),
            const SizedBox(height: 30),
            Center(
                child: RoundButton(
                    title: "Add todo",
                    onPress: () {}
                )
            )
          ],
        ),
      ),
    );
  }
}
