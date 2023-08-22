import 'package:flutter/material.dart';
import 'package:todo_with_provider/network/Helper/apis.dart';
import 'package:todo_with_provider/resources/Components/round_button.dart';
import 'package:todo_with_provider/utils/snakbar_service.dart';
import 'package:todo_with_provider/utils/utils.dart';

class FormPage extends StatefulWidget {
  const FormPage({
    super.key,
    required this.title,
    required this.buttonTitle,
    this.todo,
    this.initialTitle,
    this.initialDescription,
    this.itemId,
  });

  final String title;
  final String buttonTitle;
  final Map? todo;
  final String? initialTitle;
  final String? initialDescription;
  final String? itemId;

  @override
  // ignore: no_logic_in_create_state
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  ApiService apiService = ApiService();

  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      _titleController.text = todo['title'];
      _descriptionController.text = todo['description'];
    } else {
      _titleController.text = widget.initialTitle ?? '';
      _descriptionController.text = widget.initialDescription ?? '';
    }
  }

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
                if (widget.buttonTitle == 'Add Todo') {
                  final isSuccess = await apiService.submitData(
                    _titleController.text,
                    _descriptionController.text,
                  );
                  if (isSuccess) {
                    // ignore: use_build_context_synchronously
                    SnackBarService.showSuccessMessage(
                        context, 'Creation Success');
                  } else {
                    // ignore: use_build_context_synchronously
                    SnackBarService.showErrorMessage(
                        context, 'Creation failed');
                  }
                } else if (widget.buttonTitle == 'Edit Todo') {
                  print("Office");
                  final isSuccess = await apiService.updateData(
                    _titleController.text,
                    _descriptionController.text,
                    widget.itemId!,
                  );
                  if (isSuccess) {
                    // ignore: use_build_context_synchronously
                    SnackBarService.showSuccessMessage(context, 'Edit Success');
                  } else {
                    // ignore: use_build_context_synchronously
                    SnackBarService.showErrorMessage(context, 'Edit failed');
                  }
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
