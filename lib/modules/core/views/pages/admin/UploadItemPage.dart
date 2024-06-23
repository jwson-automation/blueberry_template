import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../dto/ItemDto.dart';
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

class UploadItemPage extends ConsumerWidget {
  final FirestoreService firestoreService;
  final FirebaseStorageService firebaseStorageService;

  const UploadItemPage({
    super.key,
    required this.firestoreService,
    required this.firebaseStorageService,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();
    final _titleController = TextEditingController();
    final _originalPriceController = TextEditingController();
    final _discountedPriceController = TextEditingController();
    final _descriptionController = TextEditingController();
    final _categoryController = TextEditingController();
    bool _isMainListViewController = true;
    bool _isMainGridViewController = true;
    final _productTitleController = TextEditingController();
    final _productDescriptionController = TextEditingController();
    String _imageUrl = '';
    List<String> _categories = [];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final categories = ref.read(categoryProvider);
      _categories = categories;
      _categoryController.text = categories[0];
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Item'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
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
                                firebaseStorageService
                                    .uploadImageFromWeb(value, ImageType.item)
                                    .then((value) {
                                  _imageUrl = value;
                                  print(
                                      'Image uploaded successfully_Web : $_imageUrl');
                                });
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
                              firebaseStorageService
                                  .uploadImageFromApp(
                                  File(pickedFile.path), ImageType.item)
                                  .then((value) {
                                _imageUrl = value;
                                print(
                                    'Image uploaded successfully_App : $_imageUrl');
                              });
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
                  controller: _originalPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Original Price',
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
                  controller: _discountedPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Discounted Price',
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
                // Category dropdown
                DropdownButtonFormField<String>(
                  value: _categoryController.text,
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  items: _categories
                      .map<DropdownMenuItem<String>>((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    _categoryController.text = newValue!;
                  },
                  validator: (value) =>
                  value == null ? 'Category is required' : null,
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text("_isMainListViewController"),
                    Switch(
                        value: _isMainListViewController,
                        onChanged: (value) {
                          _isMainListViewController = value;
                        }),
                  ],
                ),
                Row(
                  children: [
                    Text("_isMainGridViewController"),
                    Switch(
                        value: _isMainGridViewController,
                        onChanged: (value) {
                          _isMainGridViewController = value;
                        }),
                  ],
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _productTitleController,
                  decoration: InputDecoration(
                    labelText: 'Product Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product Title is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _productDescriptionController,
                  decoration: InputDecoration(
                    labelText: 'Product Description',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product Description is required';
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
      floatingActionButton: FloatingActionButton(
        onPressed: _imageUrl == ''
            ? null
            : () {
          if (_formKey.currentState!.validate()) {
            // Create item and banner objects
            final itemDTO = ItemDTO(
              itemId: _titleController.text
                  .toLowerCase()
                  .replaceAll(' ', '_'),
              title: _titleController.text,
              originalPrice: double.parse(_originalPriceController.text),
              discountedPrice:
              double.parse(_discountedPriceController.text),
              description: _descriptionController.text,
              imageUrl: _imageUrl,
              category: _categoryController.text,
              isMainGridView: _isMainGridViewController,
              isMainListView: _isMainListViewController,
              productTitle: _productTitleController.text,
              productDescription:
              _productDescriptionController.text,
            );

            // Create item in Firestore
            firestoreService.createItem(itemDTO);

            // Close dialog and indicate success
            Navigator.of(context).pop(itemDTO);
          }
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
