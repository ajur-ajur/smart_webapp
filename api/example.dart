import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_webapp/main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Form Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: idController,
                decoration: const InputDecoration(labelText: 'ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: cityController,
                decoration: const InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: postalCodeController,
                decoration: const InputDecoration(labelText: 'Postal Code'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your postal code';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // String name = nameController.text;
                    // String id = idController.text;
                    // String city = cityController.text;
                    // String postalCode = postalCodeController.text;

                    // Map<String, dynamic> jsonData = {
                    //   'identity': {
                    //     'name': name,
                    //     'id': int.parse(id),
                    //     'address': {
                    //       'city': city,
                    //       'postal': int.parse(postalCode),
                    //     },
                    //   },
                    // };

                    // String jsonString = jsonEncode(jsonData);

                    var renameUrl = 'http://192.168.1.6:5000/rename';
                    var nameUrl = 'http://192.168.1.6:5000/name';
                    http.Response response = await http.get(Uri.parse(nameUrl));

                    if (response.statusCode == 200) {
                      logger.i('Success!: ${response.body}');
                    } else {
                      logger.e('Error: ${response.statusCode}');
                    }

                    // http.Response response = await http.post(renameUrl,
                    //     headers: {'Content-Type': 'application/json'},
                    //     body: jsonString);

                    // logger.i('${response.statusCode}:${response.body}');
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
