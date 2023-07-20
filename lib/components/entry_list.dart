import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wecare/components/new_entry.dart';
import 'package:wecare/components/entry.dart';
import 'package:intl/intl.dart';

class EntryList extends StatelessWidget {
  final List<Entry> entries;
  final Function deleteTx;
  const EntryList({required this.entries, required this.deleteTx});
  @override
  Widget build(BuildContext context) {
    return entries.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  Container(
                      padding: const EdgeInsets.all(25),
                      height: constraints.maxHeight * 0.6,
                      child: _buildLottieAnimation()),
                  Text(
                    'No journal entries added yet!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: entries.length,
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: 7,
                  horizontal: 5,
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(entries[index].title,
                          style: Theme.of(context).textTheme.titleMedium),
                      subtitle: Text(
                        DateFormat.yMMMd().format(entries[index].date),
                      ),
                      trailing: MediaQuery.of(context).size.width > 460
                          ? ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.black,
                                elevation: 0,
                              ),
                              label: Text(
                                'Delete',
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.error),
                              ),
                              onPressed: () => deleteTx(entries[index].id),
                              icon: Icon(Icons.delete,
                                  color: Theme.of(context).colorScheme.error),
                            )
                          : IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => deleteTx(entries[index].id),
                              color: Theme.of(context).colorScheme.error,
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          entries[index].body,
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          entries[index].emotion,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }

  Widget _buildLottieAnimation() {
    return Lottie.asset(
      'assets/writing.json',
      width: 300,
      height: 300,
      repeat: true,
      reverse: true,
    );
  }
}
