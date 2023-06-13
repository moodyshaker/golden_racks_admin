import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';

class ImagePickerDialog extends StatelessWidget {
  final ValueChanged<XFile?> onImageReceived;

  ImagePickerDialog({required this.onImageReceived});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: imagePickerList(context)
                .map((e) => TextButton(
                    onPressed: () => imagePickerList(context).indexOf(e) == 0
                        ? getImagePath(ImageSource.camera)
                        : getImagePath(ImageSource.gallery),
                    style: ButtonStyle(alignment: Alignment.centerRight),
                    child: Text(
                      e,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    )))
                .toList()),
      ),
    );
  }

  void getImagePath(ImageSource source) async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: source);
    onImageReceived(file);
  }
}
