import 'package:flutter/material.dart';
import 'package:golden_racks_admin/core/localization/demo_localization.dart';
import '../../feature/widgets/action_dialog.dart';
import '../router/router.dart';

class UnAuthoriazedUserDialog extends StatelessWidget {
  final bool isDissmisable;

  const UnAuthoriazedUserDialog({this.isDissmisable = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final demo = DemoLocalization.of(context);
    return ActionDialog(
      isDissmisable: isDissmisable,
      content: demo.getTranslatedValue('un_auth_dialog_content'),
      onApproveClick: () {
        MagicRouter.pop();
        // MagicRouter.navigateAndPopAll(AuthScreen());
      },
      approveAction: demo.getTranslatedValue('un_auth_dialog_button'),
    );
  }
}
