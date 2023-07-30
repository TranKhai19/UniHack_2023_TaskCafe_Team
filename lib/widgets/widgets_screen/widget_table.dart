import 'package:flutter/material.dart';

class CustomTable extends StatelessWidget {
  final List<List<String>> data;
  final bool hasHeader;

  const CustomTable({Key? key, required this.data, this.hasHeader = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TableRow> rows = data
        .asMap()
        .map((index, row) {
      return MapEntry(
          index,
          TableRow(
            decoration: BoxDecoration(
              color: (index == 0 )
                  ? const Color(0xFF50C1AC)
                  : null,
            ),
            children: [
              for (final cell in row)
                TableCell(
                  child: Container(
                    decoration: BoxDecoration(
                      color: (index == 0 || row.indexOf(cell) == 0)
                          ? const Color.fromARGB(0, 0, 0, 0)
                          : null,
                    ),
                    child: Center(
                      child: Text(cell),
                    ),
                  ),
                ),
            ],
          ));
    })
        .values
        .toList();
    return Table(
      border: TableBorder.all(
        borderRadius: BorderRadius.circular(10.0),
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      defaultColumnWidth: const IntrinsicColumnWidth(),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
        3: FlexColumnWidth(),
        4: FlexColumnWidth(),
      },
      children: [
        if (hasHeader)
          const TableRow(
            decoration: BoxDecoration(
              color: Color(0xFF50C1AC),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            children: [
              TableCell(
                child: Center(
                  child: Text(
                    'Header 1',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text(
                    'Header 2',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text(
                    'Header 3',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text(
                    'Header 4',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text(
                    'Header 5',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ...rows,
      ],
    );
  }
}
