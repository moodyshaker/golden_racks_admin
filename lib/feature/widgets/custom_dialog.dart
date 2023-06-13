import 'package:flutter/material.dart';

import '../../core/router/router.dart';


Future<void> CustomDialog({Widget? theDialog,bool? dismiss}){
  return showDialog(
       barrierDismissible: dismiss==true?true:false,
      context: MagicRouter.currentContext!,
      builder: (_) => theDialog!);
}