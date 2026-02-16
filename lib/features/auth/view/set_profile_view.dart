import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:codefest_travel_app/core/utils/app_exports.dart';
import 'package:codefest_travel_app/features/auth/bloc/auth_bloc.dart';

class SetProfileView extends StatefulWidget {
  final bool isEditing;
  const SetProfileView({super.key, this.isEditing = false});

  @override
  State<SetProfileView> createState() => _SetProfileViewState();
}

class _SetProfileViewState extends State<SetProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _professionController = TextEditingController();
  String? _networkImageUrl;
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthBloc>().state.user;
    if (user != null) {
      _nameController.text = user.name ?? '';
      _mobileController.text = user.mobileNumber ?? '';
      _professionController.text = user.profession ?? '';
      _networkImageUrl = user.fullProfileImageUrl;
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          if (widget.isEditing) {
            Navigator.pop(context);
          } else {
            NavigatorService.pushNamedAndRemoveUntil(AppRoutes.bottomNavigationView);
          }
        } else if (state.status == AuthStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage ?? 'Update failed')));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            title: Text(
              widget.isEditing ? 'EDIT PROFILE' : 'SET UP PROFILE',
              style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: const Color(0xFFF5F5F5),
                          backgroundImage: _pickedImage != null
                              ? FileImage(_pickedImage!)
                              : (_networkImageUrl != null
                                  ? NetworkImage(_networkImageUrl!)
                                  : const NetworkImage(
                                      'https://t3.ftcdn.net/jpg/08/05/28/22/360_F_805282248_LHUxw7t2pnQ7x8lFEsS2IZgK8IGFXePS.jpg',
                                    )) as ImageProvider,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 18,
                            child: Image.asset(Assets.images.pngGallary, color: Colors.white, width: 18, height: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  TextFormField(
                    controller: _nameController,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      labelText: 'FULL NAME',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(Assets.images.pngProfile, color: Colors.black, width: 22, height: 22),
                      ),
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'Please enter your name' : null,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      labelText: 'MOBILE NUMBER',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(Assets.images.pngContact, color: Colors.black, width: 22, height: 22),
                      ),
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'Please enter your mobile number' : null,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _professionController,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      labelText: 'PROFESSION',
                      prefixIcon: Icon(Icons.work_outline, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 48),
                  ElevatedButton(
                    onPressed: state.status == AuthStatus.loading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    UpdateProfileRequested(
                                      name: _nameController.text,
                                      mobileNumber: _mobileController.text,
                                      profession: _professionController.text,
                                      profileImage: _pickedImage?.path,
                                    ),
                                  );
                            }
                          },
                    child: state.status == AuthStatus.loading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : const Text(
                            'SAVE & CONTINUE',
                            style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w900),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
