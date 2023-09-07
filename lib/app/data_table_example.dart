import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ignore: use_key_in_widget_constructors
class DataTableExample extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _DataTableExampleState createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<DataTableExample> {
  List<Map<String, dynamic>> tableData = [
    {'name': 'Apples', 'NO.': 0, 'factor': 60.0},
    {'name': 'Bananas', 'NO.': 0, 'factor': 20.0},
    {'name': 'Oranges', 'NO.': 0, 'factor': 30.0},
    {'name': 'Grapes', 'NO.': 0, 'factor': 150.0},
    {'name': 'Strawberries', 'NO.': 0, 'factor': 150.0},
    {'name': 'Watermelon', 'NO.': 0, 'factor': 10.0},
    {'name': 'Pineapple', 'NO.': 0, 'factor': 50.0},
    {'name': 'Mangoes', 'NO.': 0, 'factor': 30.0},
    {'name': 'Peaches', 'NO.': 0, 'factor': 80.0},
    {'name': 'Blueberries', 'NO.': 0, 'factor': 150.0},
    // Add more data rows as needed
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate the total of products
    double totalProduct = tableData.fold(0.0, (sum, data) {
      double no = data['NO.'] is int ? data['NO.'].toDouble() : data['NO.'];
      double factor = data['factor'] is double ? data['factor'] : 0.0;
      return sum + (no * factor);
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('DataTable'),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(145, 0, 204, 82),
        ),
        body: SingleChildScrollView(
          // scrollDirection: Axis.horizontal,
          child: Container(
            width: MediaQuery.of(context)
                .size
                .width, // Set width to match screen width
            child: DataTable(
              // ignore: prefer_const_literals_to_create_immutables
              columns: [
                const DataColumn(label: Text('Name')),
                const DataColumn(label: Text('No.')),
                const DataColumn(label: Text('Product')),
                const DataColumn(label: Text('Price')),
              ],
              rows: [
                ...tableData.map((data) {
                  return DataRow(
                    cells: [
                      DataCell(Text(data['name'])),
                      DataCell( TextField(
                        textAlign: TextAlign.justify,
                        onChanged: (newValue) {
                          setState(() {
                            data['NO.'] = int.tryParse(newValue) ?? 0;
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0), // Add padding for better appearance
                        ),
                      )),
                      DataCell(Text(
                          (data['NO.'] * data['factor']).toStringAsFixed(2))),
                      DataCell(Text(data['factor'].toString())),
                    ],
                  );
                }).toList(),
                DataRow(cells: [
                  const DataCell(Text('Total',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0))),
                  const DataCell(Text('')),
                  DataCell(Text(totalProduct.toStringAsFixed(2),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.0))),
                  const DataCell(Text('')),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
