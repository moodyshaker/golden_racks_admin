import 'package:flutter/material.dart';
import '../../feature/widgets/action_dialog.dart';
import '../localization/demo_localization.dart';
import '../router/router.dart';

class CredentialDialog extends StatelessWidget {
  const CredentialDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final demo = DemoLocalization.of(context);
    return ActionDialog(
      content: demo.getTranslatedValue('credential_dialog_content'),
      onApproveClick: () {
        MagicRouter.pop();
      },
      approveAction: demo.getTranslatedValue('auth_dialog_button'),
    );
  }
}
