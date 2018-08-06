import 'package:flutter/material.dart';

class DataTableWidget extends StatelessWidget {

  // note that no of datacells need to be equivalent to the no of DataColumns

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        body: Center(
          child: DataTable(
          rows: <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(
                  Text('Hello')
                ),
                DataCell(
                  Text('Hello')
                ),
                
              ]
            )
          ],
          columns: <DataColumn>[
            DataColumn(
              label: Text('Hello')
            ),
            DataColumn(
              label: Text('Hello')
            ),
          ]
        )
      )
      );
    }
}