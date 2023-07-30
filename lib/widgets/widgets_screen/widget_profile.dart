import 'package:flutter/material.dart';

class WidgetProfile extends StatefulWidget {
  final TextEditingController emailTextController;
  final TextEditingController displayNameTextController;
  final TextEditingController photoUrlTextController;
  final TextEditingController fullNameTextController;
  final bool isEditing;
  const WidgetProfile({
    Key? key,
    required this.emailTextController,
    required this.fullNameTextController,
    required this.displayNameTextController,
    required this.photoUrlTextController,
    required this.isEditing,
  }) : super(key: key);
  @override
  _WidgetProfile createState() => _WidgetProfile();
}

class _WidgetProfile extends State<WidgetProfile> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        reverse: true,
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height / 1.5,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: 150,
                    height: 150,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/Profile_Image.jpg',
                              fit: BoxFit.cover,
                              width: 150,
                              height: 150,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: widget.isEditing
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.image,
                                    size: 25,
                                  ),
                                  onPressed: () {},
                                )
                              : const SizedBox(),
                        ),
                      ],
                    ))
              ],
            )));
  }
}
