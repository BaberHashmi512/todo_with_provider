// ROund Button
// RoundButton(
//   title: widget.buttonTitle,
//   onPress: () async {
//     if (widget.buttonTitle == 'Add Todo') {
//       final isSuccess = await apiService.submitData(
//         _titleController.text,
//         _descriptionController.text,
//       );
//       if (isSuccess) {
//         // ignore: use_build_context_synchronously
//         SnackBarService.showSuccessMessage(
//             context, 'Creation Success');
//         // ignore: use_build_context_synchronously
//         Navigator.pushNamedAndRemoveUntil(
//           context,
//           RoutesName.home,
//           (route) => false,
//         );
//       } else {
//         // ignore: use_build_context_synchronously
//         SnackBarService.showErrorMessage(
//             context, 'Creation failed');
//       }
//     } else if (widget.buttonTitle == 'Edit Todo') {
//       final isSuccess = await apiService.updateData(
//         itemId,
//         _titleController.text,
//         _descriptionController.text,
//       );
//       if (isSuccess) {
//         // ignore: use_build_context_synchronously
//         SnackBarService.showSuccessMessage(
//             context, 'Edit Success');
//         // ignore: use_build_context_synchronously
//         Navigator.pushNamedAndRemoveUntil(
//             context,
//             RoutesName.home,
//             (route)=> false,
//         );
//       } else {
//         // ignore: use_build_context_synchronously
//         SnackBarService.showErrorMessage(context, 'Edit failed');
//       }
//     }
//   },
// ),