import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../dto/EventDto.dart';
import '../../../providers/CategoryProvider.dart';
import '../../../providers/firebase/FirebaseStoreServiceProvider.dart';
import '../../../providers/firebase/fireStorageServiceProvider.dart';

/**
 * AdminPage.dart
 *
 * Admin Page
 * - 관리자 페이지
 * - 임시 데이터 생성 및 업로드를 위한 화면
 *
 * @jwson-automation
 */

class UploadEventDialog extends StatefulWidget {
  final FirestoreService firestoreService;
  final FirebaseStorageService firebaseStorageService;

  const UploadEventDialog({
    Key? key,
    required this.firestoreService,
    required this.firebaseStorageService,
  }) : super(key: key);

  @override
  _UploadEventDialogState createState() => _UploadEventDialogState();
}

class _UploadEventDialogState extends State<UploadEventDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _eventMaintitleController = TextEditingController();
  final _eventSubTitleController = TextEditingController();
  final _eventItemTitleController = TextEditingController();
  final _eventItemSubTitleController = TextEditingController();
  String _imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
      final _category = ref.watch(categoryProvider);
      return AlertDialog(
        title: const Text('Create Item'),
        content: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image selection section
                  Row(
                    children: [
                      TextButton(
                          onPressed: () async {
                            // 웹인 경우
                            if (kIsWeb) {
                              final ImagePicker _picker = ImagePicker();
                              final XFile? image = await _picker.pickImage(
                                  source: ImageSource.gallery);

                              if (image != null) {
                                image.readAsBytes().then((value) async {
                                  widget.firebaseStorageService
                                      .uploadImageFromWeb(value, ImageType.item)
                                      .then((value) => setState(() {
                                            _imageUrl = value;
                                            print(
                                                'Event uploaded successfully_Web : $_imageUrl');
                                          }));
                                });
                              } else {
                                print('No image selected');
                              }
                            }
                            // 앱인 경우
                            if (!kIsWeb) {
                              final pickedFile = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);

                              if (pickedFile != null) {
                                // Upload image to Firebase Storage
                                widget.firebaseStorageService
                                    .uploadImageFromApp(
                                        File(pickedFile.path), ImageType.item)
                                    .then((value) => setState(() {
                                          _imageUrl = value;
                                          print(
                                              'Event uploaded successfully_App : $_imageUrl');
                                        }));
                              } else {
                                print('No image selected');
                              }
                            }
                          },
                          child: (_imageUrl != '')
                              ? Text('Uploaded Image :)')
                              : Text('Select Image')),
                      SizedBox(width: 16),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Item information input fields
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Title is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Price is required';
                      }

                      try {
                        double.parse(value);
                      } catch (e) {
                        return 'Invalid price format';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Description is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _eventMaintitleController,
                    decoration: InputDecoration(
                      labelText: 'Event Main Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Event Main Title is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _eventSubTitleController,
                    decoration: InputDecoration(
                      labelText: 'Event Sub Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Event Sub Title is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _eventItemTitleController,
                    decoration: InputDecoration(
                      labelText: 'Event Item Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Event Item Title is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _eventItemSubTitleController,
                    decoration: InputDecoration(
                      labelText: 'Event Item Sub Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Event Item Sub Title is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _imageUrl == ''
                ? null
                : () {
                    if (_formKey.currentState!.validate()) {
                      // Create item and banner objects
                      final eventDTO = EventDTO(
                        itemId: _titleController.text
                            .toLowerCase()
                            .replaceAll(' ', '_'),
                        title: _titleController.text,
                        price: double.parse(_priceController.text),
                        description: _descriptionController.text,
                        imageUrl: _imageUrl,
                        eventMainTitle: _eventMaintitleController.text,
                        eventSubTitle: _eventSubTitleController.text,
                        eventItemList: [],
                        eventItemTitle: _eventItemTitleController.text,
                        eventItemSubTitle: _eventItemSubTitleController.text,
                      );

                      // Create item in Firestore
                      widget.firestoreService.createEvent(eventDTO);

                      // Close dialog and indicate success
                      Navigator.of(context).pop(eventDTO);
                    }
                  },
            child: Text('Create'),
          ),
        ],
      );
    });
  }
}
