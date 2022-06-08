import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/services/storage.dart';
import 'package:social_media_app/utils/colors.dart';
import 'package:social_media_app/views/home.dart';

var urls = [];
var titles = [];
var descriptions = [];

class UploadPage extends StatefulWidget {
  const UploadPage({
    Key? key,
  }) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController urlController = TextEditingController();
  File? file;
  StorageService storage = StorageService();
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        title: Text("Upload post"),
      ),
      body: SafeArea(
        child: Expanded(
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: Divider.createBorderSide(context),
                  ),
                  hintText: "Enter description of Post",
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // ElevatedButton(
            //   child: Text('Upload Post'),
            //   onPressed: () => {
            //     setState(() => {
            //           if (urlController.text.isNotEmpty)
            //             {
            //               urls.add(urlController.text),
            //             },
            //           if (titleController.text.isNotEmpty)
            //             {titles.add(titleController.text)},
            //           if (descriptionController.text.isNotEmpty)
            //             {descriptions.add(descriptionController.text)},
            //           print(urls)
            //         }),
            //     showDialog(
            //         context: context,
            //         builder: (context) => AlertDialog(
            //               title: const Text('Upload Complete'),
            //               content: const Text('Post Successfully uploaded'),
            //               actions: [
            //                 ElevatedButton(
            //                     onPressed: () => {Navigator.of(context).pop()},
            //                     child: Text('Close'))
            //               ],
            //             ))
            //   },
            // ),
            ElevatedButton(
                onPressed: () => {
                      showDialog(
                          context: context,
                          builder: (context) => SimpleDialog(
                                title: Text('Add a photo'),
                                children: [
                                  SimpleDialogOption(
                                    child: Text('Take a photo'),
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      final ImagePicker _imagePicker =
                                          ImagePicker();
                                      final XFile? xfile =
                                          await _imagePicker.pickImage(
                                              source: ImageSource.camera);
                                      file = File(xfile!.path);

                                      // Uint8List file = await xfile.readAsBytes();
                                    },
                                  ),
                                  SimpleDialogOption(
                                    child: const Text('Upload from gallery'),
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      final ImagePicker imagePicker =
                                          ImagePicker();
                                      final XFile? xfile =
                                          await imagePicker.pickImage(
                                              source: ImageSource.gallery);
                                    },
                                  ),
                                ],
                              ))
                    },
                child: Text('Add a photo')),
            SizedBox(
              height: 20,
            ),
            file != null
                ? Container(
                    width: size.width * 0.85,
                    height: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: MemoryImage(file!.readAsBytesSync()))))
                : Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                    ),
                    alignment: Alignment.center,
                    child: Text('Your picture'),
                    height: 200,
                    width: size.width * 0.85,
                  ),

            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (file != null) {
                    storage.uploadPost(titleController.text,
                        descriptionController.text, file!);
                  }
                },
                child: Text('Upload Post'))
          ]),
        ),
      ),
    );
  }
}
