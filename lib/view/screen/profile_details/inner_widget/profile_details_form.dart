import 'package:flutter/material.dart';
import 'package:ezyrack/model/user_model.dart';
import 'package:ezyrack/view/widgets/textfields/custom_vertical_label_field.dart';

class ProfileDetailsForm extends StatelessWidget {

  final UserModel loggedInUser;

  const ProfileDetailsForm({required this.loggedInUser, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomVerticalLabelField(
          label: "Name",
          textController: TextEditingController(text: loggedInUser.userName ?? ""),
        ),
        const SizedBox(height: 16),
        CustomVerticalLabelField(
          label: "Email",
          textController: TextEditingController(text: loggedInUser.email ?? ""),
        ),
        const SizedBox(height: 16),
        CustomVerticalLabelField(
          label: "Phone number",
          textController: TextEditingController(text: loggedInUser.phoneNumber ?? ""),
        ),
        const SizedBox(height: 16),
        CustomVerticalLabelField(
          label: "Postcode",
          textController: TextEditingController(text: loggedInUser.postCode ?? ""),
        ),
      ],
    );
  }
}
