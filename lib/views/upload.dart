import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/services/storage.dart';
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
    return Scaffold(
      appBar: AppBar(
          title: Text("Upload post"),
          leading: IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage()));
            },
          )),
      body: SafeArea(
        child: Column(children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: Divider.createBorderSide(context),
              ),
              hintText: "Enter Title of Post",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: Divider.createBorderSide(context),
              ),
              hintText: "Enter description of Post",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: urlController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: Divider.createBorderSide(context),
              ),
              hintText: "Enter url of Post",
            ),
          ),
          ElevatedButton(
            child: Text('Upload Post'),
            onPressed: () => {
              setState(() => {
                    if (urlController.text.isNotEmpty)
                      {
                        urls.add(urlController.text),
                      },
                    if (titleController.text.isNotEmpty)
                      {titles.add(titleController.text)},
                    if (descriptionController.text.isNotEmpty)
                      {descriptions.add(descriptionController.text)},
                    print(urls)
                  }),
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('Upload Complete'),
                        content: const Text('Post Successfully uploaded'),
                        actions: [
                          ElevatedButton(
                              onPressed: () => {Navigator.of(context).pop()},
                              child: Text('Close'))
                        ],
                      ))
            },
          ),
          /*ElevatedButton(
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
                                    final XFile? xfile = await _imagePicker
                                        .pickImage(source: ImageSource.camera);
                                    File file = File(xfile!.path);
                                    storage.uploadPost(titleController.text,
                                        descriptionController.text, file);
                                    // Uint8List file = await xfile.readAsBytes();
                                  },
                                ),
                                SimpleDialogOption(
                                  child: const Text('Upload from gallery'),
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    final ImagePicker imagePicker =
                                        ImagePicker();
                                    final XFile? xfile = await imagePicker
                                        .pickImage(source: ImageSource.gallery);
                                  },
                                ),
                              ],
                            ))
                  },
              child: Text('Add a photo'))*/
        ]),
      ),
    );
  }
}
