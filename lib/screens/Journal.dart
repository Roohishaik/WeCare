import 'dart:convert';
import 'dart:io';

import 'package:wecare/components/new_entry.dart';
import 'package:wecare/components/entry.dart';
import 'package:wecare/components/entry_list.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class Journal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // errorColor: Colors.grey,
        primarySwatch: Colors.green,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
                titleMedium: const TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      title: 'Personal Expenses',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Entry> _userEntries = [];
  @override
  void initState() {
    super.initState();
    _loadEntries().then(
      (entriesString) {
        if (entriesString.isNotEmpty) {
          final entriesList = json.decode(entriesString) as List<dynamic>;
          setState(
            () {
              _userEntries =
                  entriesList.map<Entry>((en) => Entry.fromMap(en)).toList();
            },
          );
        }
      },
    );
  }

  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/entries.txt');
  }

  Future<void> _addNewEntry(String enTitle, String enBody, DateTime chosenDate,
      String emotionFound) async {
    final newEn = Entry(
        id: DateTime.now().toString(),
        body: enBody,
        date: chosenDate,
        title: enTitle,
        emotion: emotionFound);
    setState(() {
      _userEntries.add(newEn);
    });
    final file = await _getLocalFile();
    final entriesString =
        json.encode(_userEntries.map((en) => en.toMap()).toList());
    await file.writeAsString(entriesString);
  }

  Future<void> _deleteEntry(String id) async {
    setState(() {
      _userEntries.removeWhere((en) => en.id == id);
    });
    final file = await _getLocalFile();
    final entriesString =
        json.encode(_userEntries.map((en) => en.toMap()).toList());
    await file.writeAsString(entriesString);
  }

  Future<String> _loadEntries() async {
    try {
      final file = await _getLocalFile();
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return '';
    }
  }

  void _startNewEntry(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: false,
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewEntry(_addNewEntry),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      backgroundColor: Colors.greenAccent,
      title: const Text(
        'Journal Entries',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        IconButton(
          color: Colors.black,
          onPressed: () => _startNewEntry(context),
          icon: const Icon(Icons.add),
        ),
      ],
    );
    final enListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: EntryList(
        entries: _userEntries,
        deleteTx: _deleteEntry,
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: enListWidget),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () => _startNewEntry(context),
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
