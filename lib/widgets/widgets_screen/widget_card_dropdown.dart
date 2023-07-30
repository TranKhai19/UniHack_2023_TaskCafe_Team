import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomCard extends StatefulWidget {
  final String titleText;
  final String subtitleText;
  final String weightText;
  final String dropdownValue;
  final List<String> dropdownItems;
  final void Function(String?) onDropdownChanged;

  const CustomCard({
    Key? key,
    required this.titleText,
    required this.subtitleText,
    required this.weightText,
    required this.dropdownValue,
    required this.dropdownItems,
    required this.onDropdownChanged,
  }) : super(key: key);

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 80,
      ),
      child: Card(
        elevation: 5,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.titleText,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width:100,
                        child: Text(
                          widget.subtitleText,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFB2EBF2),
                    ),
                    child: SizedBox(
                        width: 100,
                        height: 40,
                        child: Center(
                          child: Text(
                            widget.weightText,
                          ),
                        )),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF00BCD4),
                    ),
                    child: SizedBox(
                      width: 130,
                      height: 40,
                      child: Row(
                        //mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          const Text('Ratting:'),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              value: widget.dropdownValue,
                              items: widget.dropdownItems
                                  .map((String value) =>
                                      DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      ))
                                  .toList(),
                              onChanged: widget.onDropdownChanged,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
