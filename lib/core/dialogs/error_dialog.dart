import 'package:flutter/material.dart';

import '../../feature/widgets/action_dialog.dart';
import '../localization/demo_localization.dart';
import '../router/router.dart';

class ErrorDialog extends StatelessWidget {
  final String? text;

  const ErrorDialog({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final demo = DemoLocalization.of(context);
    return ActionDialog(
      content: text ?? demo.getTranslatedValue('error_content_dialog'),
      onApproveClick: () {
        MagicRouter.pop();
      },
      approveAction: demo.getTranslatedValue('dialog_agreed'),
    );
  }
}
