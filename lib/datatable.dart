import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'database_handler.dart';

class DataTableExample extends StatefulWidget {
  const DataTableExample({super.key});

  @override
  State<DataTableExample> createState() => _DataTablePageState();
}

class _DataTablePageState extends State<DataTableExample> {
  final _formKey = GlobalKey<FormState>();

  late DatabaseHandler handler;

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {
      setState(() {});
    });
  }

  Future<List<DataRow>> getRows() async {
    List<DataRow> dataRows = [];

    var listUsers = await handler.retrieveUsers();
    for (var user in listUsers) {
      dataRows.add(DataRow(
        cells: <DataCell>[
          DataCell(Text(user.name)),
          DataCell(Text(user.time.toString())),
          DataCell(Text(user.attempts.toString())),
        ],
      ));
    }
    dataRows.add(DataRow(
      cells: <DataCell>[
        DataCell(Text('')),
        DataCell(TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(16.0),
          ),
          onPressed: () {},
          child: const Text('Refresh'),
        )),
        DataCell(Text(''))
      ],
    ));
    return dataRows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: FutureBuilder(
            future: getRows(),
            builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
              if (asyncSnapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Name',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Username',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Action',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ],
                  rows: asyncSnapshot.data,
                );
              }
            }));
  }
}
