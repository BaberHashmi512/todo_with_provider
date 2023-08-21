import 'package:flutter/material.dart';
import 'package:todo_with_provider/network/Helper/Apis.dart';
import 'package:todo_with_provider/resources/Components/round_button.dart';
import 'package:todo_with_provider/utils/snakbar_service.dart';
import 'package:todo_with_provider/utils/utils.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key, required this.title, required this.buttonTitle});

  final String title;
  final String buttonTitle;

  @override
  State<FormPage> createState() => _FormPageState(title);
}

class _FormPageState extends State<FormPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();

  _FormPageState(String title);

  @override
  void dispose() {
    super.dispose();
    titleFocusNode.dispose();
    descriptionFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
              controller: _titleController,
              focusNode: FocusNode(),
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: "Title",
              ),
              onFieldSubmitted: (value) {
                Utils.fieldFocusChange(
                    context, titleFocusNode, descriptionFocusNode);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _descriptionController,
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
              title: widget.buttonTitle,
              onPress: () async {
                final isSuccess = await ApiService.submitData(
                    _titleController.text, _descriptionController.text);
                if (isSuccess) {
                  // ignore: use_build_context_synchronously
                  SnackBarService.showSuccessMessage(
                      context, 'Creation Success');
                } else {
                  // ignore: use_build_context_synchronously
                  SnackBarService.showErrorMessage(context, 'Creation failed');
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
