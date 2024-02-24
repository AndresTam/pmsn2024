import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _validationForm = GlobalKey<FormState>();
  RegExp nameVal = RegExp('[0-9]');
  RegExp emailVal = RegExp('[a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*@[a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*[.][a-zA-Z]{2,5}');
  RegExp passwordVal = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,16}$');
  File? _image;

  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);

      setState(() {
        this._image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  TextEditingController conEmail = TextEditingController();
  TextEditingController conPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final txtName = TextFormField(
      decoration: InputDecoration(
        labelText: "Nombre",
        labelStyle: const TextStyle(color: Colors.black),
        errorStyle: const TextStyle(color: Colors.red),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      validator: (value) {
        if (value != null && value.isEmpty) {
          return "Ingresa un nombre";
        } else if(nameVal.hasMatch(value!)) {
          return "El nombre no puede tener numeros";
        }
        return null;
      },
    );

    final txtEmail = TextFormField(
      controller: conEmail,
      decoration: InputDecoration(
        labelText: "Correo Electronico",
        labelStyle: const TextStyle(color: Colors.black),
        errorStyle: const TextStyle(color: Colors.red),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if(value != null && value.isEmpty){
          return "Ingresa un correo";
        } else if(!emailVal.hasMatch(value!)){
          return "El correo no es valido";
        }
        return null;
      },
    );

    final txtPass = TextFormField(
      controller: conPass,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Contraseña",
        labelStyle: const TextStyle(color: Colors.black),
        errorStyle: const TextStyle(color: Colors.red),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      validator: (value) {
        if (value != null && value.isEmpty) {
          return 'Ingresa una contraseña';
        } else if(!passwordVal.hasMatch(value!)) {
          return "La contraseña debe tener:\n-8 a 16 caracteres\n-Iniciar con mayuscula\n-Contener numeros\n-Contener caracteres especiales";
        }
        return null;
      },
    );

    const middleSpace = SizedBox(
      height: 15,
    );

    final btnRregister = ElevatedButton(
      onPressed: (){
        if(!_validationForm.currentState!.validate()){
          Future(() => showDialog(
            context: context, 
            builder: (BuildContext context) => const AlertDialog(
              title: Text("No se pudo registrar"),
              content: Text("Algunos datos son incorrectos, por favor verificalos antes de continuar"),
          ))
          );
        } else{
          Future.delayed(
            new Duration(milliseconds: 2000),
            (){
              Navigator.pushNamed(context, "/dash").then((value){});
            }
          );
        }
      },
      style: ElevatedButton.styleFrom(
        elevation: 10.0,
        textStyle:
            const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
        fixedSize: const Size(800, 60),
      ),
      child: const Text('Registrarse'),
    );

    final btnGallery = ElevatedButton(
      onPressed: () {
        getImage(ImageSource.gallery);
      },
      style: ElevatedButton.styleFrom(fixedSize: const Size(400, 50)),
      child: const Row(
        children: [
          Icon(Icons.image_outlined),
          SizedBox(
            width: 20,
          ),
          Text('Elige una foto de la galería')
        ],
      ),
    );

    final btnCamera = ElevatedButton(
      onPressed: () {
        getImage(ImageSource.camera);
      },
      style: ElevatedButton.styleFrom(fixedSize: const Size(400, 50)),
      child: const Row(
        children: [
          Icon(Icons.camera),
          SizedBox(
            width: 20,
          ),
          Text('Realiza una foto con la camara')
        ],
      ),
    );

    final btnPhoto = ElevatedButton(
      onPressed: (){
        showModalBottomSheet(
          context: context,
          builder: (context){
            return ListView(
              padding: EdgeInsets.all(20),
              children: [
                middleSpace,
                btnGallery,
                middleSpace,
                btnCamera,
                middleSpace,
              ],
            );
          },
        );
      },
      child: const Row(
        children: [
          Icon(Icons.camera),
          SizedBox(
            width: 20,
          ),
          Text('Importar Fotografia')
        ],
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                children: [
                  middleSpace,
                  middleSpace,
                  ClipOval(
                    child: _image != null
                      ? Image.file(
                          _image!,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'images/avatar.png',
                          width: 150,
                        ),
                  ),
                  middleSpace,
                  btnPhoto,
                  Form(
                    key: _validationForm,
                    child: Column(
                      children: [
                        middleSpace,
                        txtName,
                        middleSpace,
                        txtEmail,
                        middleSpace,
                        txtPass,
                        middleSpace,
                        middleSpace,
                        btnRregister,
                      ]
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}