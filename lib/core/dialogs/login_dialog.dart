import 'package:flutter/material.dart';
import '../../feature/widgets/action_dialog.dart';
import '../localization/demo_localization.dart';
import '../router/router.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final demo = DemoLocalization.of(context);
    return ActionDialog(
      content: demo.getTranslatedValue('auth_dialog_content'),
      onApproveClick: () {
        MagicRouter.pop();
        // MagicRouter.navigateAndPopAll(AuthScreen());
      },
      approveAction: demo.getTranslatedValue('auth_dialog_button'),
    );
  }
}
