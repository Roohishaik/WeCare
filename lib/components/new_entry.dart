import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewEntry extends StatefulWidget {
  final Function selectHandler;
  const NewEntry(this.selectHandler, {super.key});

  @override
  State<NewEntry> createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  DateTime? _selectedDate;
  String emotion = 'null';
  bool _isLoading = false;

  Future<void> _findEmotion(List<String> enBody) async {
    setState(() {
      _isLoading = true;
    });
    const apiUrl =
        'https://feec-2401-4900-36af-ecbb-e0aa-76b4-225d-a258.ngrok.io/api/predict'; // Replace with your Flask API endpoint URL

    final entryData = {
      'texts': enBody,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(entryData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Request successful, update the UI or perform any desired actions
        final responseData = json.decode(response.body);
        final predictions = responseData['predictions'] as List<dynamic>;
        if (predictions.isNotEmpty) {
          emotion = predictions[0]
              ['emotion']; // Extract the emotion from the response
          print('Emotion: $emotion'); // Display the emotion in the console

          // Rest of your code...
        }
      } else {
        emotion = 'null';
        // Request failed, handle the error
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
        });
      },
    );
  }

  void _submitData() async {
    print('working');
    final enteredTitle = _titleController.text;

    final enteredBody = _bodyController.text;
    List<String> entry = [enteredBody.toString()];
    if (enteredTitle.isEmpty || enteredBody.isEmpty || _selectedDate == null) {
      return;
    }
    await _findEmotion(entry);
    widget.selectHandler(enteredTitle, enteredBody, _selectedDate, emotion);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: (MediaQuery.of(context).viewInsets.bottom) + 10,
          ),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 55,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    labelText: 'Title',
                  ),
                  controller: _titleController,
                  onSubmitted: (_) => _submitData(),
                ),
              ),
              const SizedBox(
                width: double.infinity,
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                height: 100,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    labelText: 'Body',
                  ),
                  maxLines: null,
                  expands: true,
                  controller: _bodyController,
                  onSubmitted: (_) => _submitData(),
                ),
              ),
              const SizedBox(
                width: double.infinity,
                height: 10,
              ),
              SizedBox(
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 240,
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        _selectedDate == null
                            ? ''
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _presentDatePicker,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, elevation: 0),
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColorLight),
                onPressed: _isLoading ? null : _submitData,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        'Add Journal Entry',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
