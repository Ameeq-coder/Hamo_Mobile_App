import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../Home/Screens/Home.dart';
import '../bloc/details/user_detail_bloc.dart';
import '../bloc/details/user_detail_event.dart';
import '../bloc/details/user_detail_state.dart';


class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  DateTime? selectedDate;
  File? _profileImage;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? image =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  InputDecoration _inputDecoration({required String hint, IconData? icon}) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: icon != null ? Icon(icon, size: 20) : null,
      filled: true,
      fillColor: Colors.grey[200],
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      validator: (value) => value == null || value.isEmpty ? 'Required' : null,
      decoration: _inputDecoration(hint: hint, icon: icon),
    );
  }

  void _submitDetails() {
    if (_formKey.currentState!.validate()) {
      if (_profileImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an image')),
        );
        return;
      }

      final box = Hive.box('userBox');
      final userId = box.get('userId'); // ✅ Get ID from Hive


      BlocProvider.of<UserDetailBloc>(context).add(
        SubmitUserDetailsEvent(
          userId: userId,
          name: _nameController.text.trim(),
          dob: _dobController.text.trim(),
          phone: _phoneController.text.trim(),
          address: _addressController.text.trim(),
          image: _profileImage!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Fill Your Profile',
            style: TextStyle(color: Colors.black)),
      ),
      body: BlocConsumer<UserDetailBloc, UserDetailState>(
        listener: (context, state) {
          if (state is UserDetailSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully!')),
            );
            Future.delayed(const Duration(milliseconds: 500), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const Home()),
              );
            });

          } else if (state is UserDetailFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          GestureDetector(
                            onTap: _pickImage,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: const Color(0xFFF2F2F2),
                              backgroundImage: _profileImage != null
                                  ? FileImage(_profileImage!)
                                  : null,
                              child: _profileImage == null
                                  ? const Icon(Icons.person,
                                  size: 50, color: Colors.grey)
                                  : null,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 4,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              child: GestureDetector(
                                onTap: _pickImage,
                                child: const Icon(Icons.edit,
                                    color: Colors.purple, size: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      _buildTextField(
                          controller: _nameController, hint: 'Full Name'),
                      const SizedBox(height: 15),
                      _buildTextField(
                          controller: _nicknameController, hint: 'Nickname'),
                      const SizedBox(height: 15),
                      _buildTextField(
                        controller: _dobController,
                        hint: 'Date of Birth',
                        icon: Icons.calendar_today,
                        readOnly: true,
                        onTap: () => _selectDate(context),
                      ),
                      const SizedBox(height: 15),
                      _buildTextField(
                        controller: _emailController,
                        hint: 'Email',
                        icon: Icons.email,
                      ),
                      const SizedBox(height: 15),
                      IntlPhoneField(
                        controller: _phoneController,
                        disableLengthCheck: true,
                        decoration: _inputDecoration(
                          hint: '726-0592',
                          icon: Icons.phone,
                        ),
                        initialCountryCode: 'PK',
                        onChanged: (phone) {},
                      ),
                      const SizedBox(height: 15),
                      _buildTextField(
                        controller: _addressController,
                        hint: 'Address',
                        icon: Icons.location_on,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: state is UserDetailLoading
                              ? null
                              : _submitDetails,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: state is UserDetailLoading
                              ? const CircularProgressIndicator(
                            valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                              : const Text(
                            'Continue',
                            style: TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
