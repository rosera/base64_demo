import 'dart:convert'; // To decode Base64 and JSON
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Base64 Decoder',
      home: Base64DecoderScreen(),
    );
  }
}

class Base64DecoderScreen extends StatefulWidget {
  @override
  _Base64DecoderScreenState createState() => _Base64DecoderScreenState();
}

class _Base64DecoderScreenState extends State<Base64DecoderScreen> {
  final TextEditingController _controller = TextEditingController();
  String _region = "";
  String _projectId = "";
  String _error = "";

  // Function to decode Base64 string and parse it as JSON
  void _decodeBase64() {
    setState(() {
      _region = "";
      _projectId = "";
      _error = "";
    });

    try {
      // Step 1: Decode Base64
      String decodedString = utf8.decode(base64Decode(_controller.text));

      // Step 2: Parse the decoded string as JSON
      Map<String, dynamic> jsonData = jsonDecode(decodedString);

      // Step 3: Extract "region" and "project_id"
      setState(() {
        _region = jsonData['region'] ?? 'Unknown';
        _projectId = jsonData['project_id'] ?? 'Unknown';
      });
    } catch (e) {
      setState(() {
        _error = "Invalid Base64 or JSON format";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Base64 to JSON Decoder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),

            Text(
              "Data Result",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            Divider(),
            SizedBox(height: 10),
            // Display the extracted "region" and "project_id"
            if (_error.isEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (_region.isNotEmpty)
                    Text(
                      'Region: $_region',
                      style: TextStyle(
                        fontSize: 16,
                        // fontWeight: FontWeight.bold
                      ),
                    ),
                  if (_projectId.isNotEmpty)
                    Text(
                      'Project ID: $_projectId',
                      style: TextStyle(
                        fontSize: 16,
                        // fontWeight: FontWeight.bold
                      ),
                    ),
                ],
              ),

            // Display an error message if there's an issue with decoding
            if (_error.isNotEmpty)
              Text(
                _error,
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),

            SizedBox(height: 20),

            // Center(
            //   child: Text(
            //     "BASE64",
            //     style: TextStyle(fontSize: 38, color: Colors.blueGrey),
            //   ),
            // ),

            // SizedBox(height: 20),

            Text(
              "Data Entry",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            Divider(),
            SizedBox(height: 10),
            // Input field for Base64 encoded string
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter Base64 Encoded String',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Button to decode Base64
            ElevatedButton(
              onPressed: _decodeBase64,
              child: Text('Decode'),
            ),

          ],
        ),
      ),
    );
  }
}
