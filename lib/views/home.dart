import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:social_media_app/views/upload.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Social media"), actions: [
          IconButton(
            icon: Icon(Icons.upload),
            onPressed: () {
              print(urls);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => UploadPage()));
            },
          )
        ]),
        body: titles.isEmpty
            ? Center(
                child: Text('No Posts Added'),
              )
            : ListView(
                children: [
                  for (var i = 0; i < titles.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(titles[i].toString(),
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              Image.network(
                                urls[i],
                                errorBuilder: (context, error, stackTrace) =>
                                    Text('Post URL not valid'),
                              ),
                              SizedBox(height: 5),
                              Text(descriptions[i].toString())
                            ]),
                      ),
                    )
                ],
              ));
  }
}
