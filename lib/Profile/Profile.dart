import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


import '../Common/BottomSheet.dart';
import 'bloc/profile_bloc.dart';
import 'bloc/profile_event.dart';
import 'bloc/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  String countryCode = '+92'; // Changed to Pakistan as your local is PK

  @override
  void initState() {
    super.initState();
    // Trigger BLoC event here
    context.read<ProfileBloc>().add(FetchProfile("usr_p-Uv00B42r")); // Replace with dynamic ID if needed
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(1995, 12, 27),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        dobController.text = DateFormat('MM/dd/yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ProfileLoaded) {
          // Fill controllers with API data
          nameController.text = state.profile.name;
          dobController.text = DateFormat('MM/dd/yyyy')
              .format(DateTime.parse(state.profile.dob));
          emailController.text = state.profile.email;
          phoneController.text = state.profile.phone;
          addressController.text = state.profile.address;
        } else if (state is ProfileError) {
          return Center(child: Text("Error: ${state.message}"));
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Center(
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: Color(0xFFECECEC),
                          backgroundImage: state is ProfileLoaded
                              ? NetworkImage(state.profile.imageUrl)
                              : null,
                          child: state is! ProfileLoaded
                              ? Icon(Icons.person, size: 50, color: Colors.grey)
                              : null,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(nameController, 'Full Name'),
                      _buildDateField(context),
                      _buildTextField(emailController, 'Email', icon: Icons.email_outlined),
                      _buildPhoneField(),
                      _buildTextField(addressController, 'Address'),
                      const SizedBox(height: 30),
                      _buildLogoutButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigation(currentIndex: 4),

        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: icon != null ? Icon(icon) : null,
          hintText: hint,
          filled: true,
          fillColor: Color(0xFFF7F7F7),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: dobController,
        readOnly: true,
        onTap: () => _selectDate(context),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.calendar_today_outlined),
          hintText: 'Date of Birth',
          filled: true,
          fillColor: Color(0xFFF7F7F7),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          prefixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 12),
              const Text("🇵🇰", style: TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(countryCode, style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(width: 10),
              const VerticalDivider(width: 1, color: Colors.grey),
            ],
          ),
          hintText: 'Phone Number',
          filled: true,
          fillColor: Color(0xFFF7F7F7),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Log out logic
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Color(0xFF6C00FF),
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        child: Text("Log Out", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
