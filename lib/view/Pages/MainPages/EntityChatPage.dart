import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insergemobileapplication/controller/helper/management_helper.dart';
import 'package:insergemobileapplication/view/System/Widgets/Content/ImageBordersWidget.dart';

import '../../System/Settings/ProfileConstant.dart';
import '../../System/Widgets/Content/ContentBordersWidget.dart';
import '../../System/Widgets/Content/RowDescriptionWidget.dart';
import '../../System/Widgets/Buttons/ShortButtonRoundWidget.dart';

class EntityChatPage extends StatefulWidget {
  final User user;
  const EntityChatPage({super.key, required this.user});

  @override
  State<EntityChatPage> createState() => _EntityChatPageState(usuario: user);
}

class _EntityChatPageState extends State<EntityChatPage> {
  final User usuario;
  String nombreString = "";
  String descString = "";
  String urlImage = "";
  XFile? imageFile;

  final ImagePicker _imagePicker = ImagePicker();

  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();

  _EntityChatPageState({required this.usuario});

  @override
  void initState() {
    nombreString = UsuarioGlobal.nombre.toString() == 'null'
        ? ''
        : UsuarioGlobal.nombre.toString();
    descString = UsuarioGlobal.descripcion.toString() == 'null'
        ? ''
        : UsuarioGlobal.descripcion.toString();
    urlImage = UsuarioGlobal.urlImage.toString() == 'null'
        ? ''
        : UsuarioGlobal.urlImage.toString();
    nombreController.text = nombreString;
    descripcionController.text = descString;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Text(
            'Mi perfil',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 150,
          child: Row(
            verticalDirection: VerticalDirection.down,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: IconButton(
                  onPressed: () {
                    _metodoEditData();
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
              urlImage != ''
                  ? Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _viewImage();
                        },
                        child: ImageBorders(
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                            child: Image.network(
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return const CircularProgressIndicator(
                                  color: Colors.blue,
                                );
                              },
                              urlImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const Expanded(
                      child: Icon(
                        Icons.person_off,
                        size: 72,
                      ),
                    ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    _metodoEditPhoto();
                  },
                  icon: const Icon(Icons.camera_alt),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: defaultPadding),
        _descriptionProfile(descString),
        const SizedBox(height: defaultPadding),
        Expanded(
          child: ContentBorders(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RowDescription(title: 'Nombre:', desc: nombreString),
                RowDescription(title: 'Área:', desc: UsuarioGlobal.area),
                RowDescription(title: 'Cargo:', desc: UsuarioGlobal.cargo),
                RowDescription(title: 'Rol:', desc: UsuarioGlobal.role),
                RowDescription(
                    title: 'Teléfono:', desc: usuario.phoneNumber.toString()),
                RowDescription(title: 'Email:', desc: usuario.email.toString()),
                RowDescription(
                    title: 'Verificación:',
                    desc: usuario.emailVerified.toString()),
                RowDescription(
                    title: 'Anónimo:', desc: usuario.isAnonymous.toString()),
                RowDescription(
                    title: 'Número sesiones:',
                    desc: "${UsuarioGlobal.sesiones}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ShortButtonRound(
                      title: 'Cerrar sesión',
                      onTap: () {
                        UserManagement().signOut(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _metodoEditData() => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        bool isCharging = true;
        return StatefulBuilder(builder: (context, setState) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: const Text("Actualizar"),
              content: isCharging
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                            controller: nombreController,
                            decoration: const InputDecoration(
                              hintText: 'Nombre',
                            )),
                        TextField(
                            controller: descripcionController,
                            maxLines: 3,
                            maxLength: 80,
                            decoration: const InputDecoration(
                              hintText: 'Descripcion',
                            )),
                      ],
                    )
                  : SizedBox(
                      height: 100,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    ),
              actions: isCharging
                  ? <Widget>[
                      TextButton(
                        onPressed: () async {
                          isCharging = false;
                          setState(() {});
                          nombreString = nombreController.text;
                          descString = descripcionController.text;
                          try {
                            await UserManagement.updateUserData(
                              descripcionController.text,
                              nombreController.text,
                            );
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(this.context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Cambios guardados correctamente")));
                            this.setState(() {});
                          } catch (e) {
                            ScaffoldMessenger.of(this.context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Ocurrio un error al guardar")));
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text("Actualizar"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cerrar"),
                      )
                    ]
                  : [],
            ),
          );
        });
      });

  _descriptionProfile(String? content) {
    if (content != null && content != '' && content != 'null') {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 42),
        child: Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  _metodoEditPhoto() => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        bool isCharging = true;
        return StatefulBuilder(builder: (context, setState) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: const Text("Actualizar Foto"),
              content: isCharging
                  ? SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          Flexible(
                            child: ImageBorders(
                                child: usuario.photoURL.toString() != 'null'
                                    ? ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(100)),
                                        child: Image.network(
                                          urlImage,
                                        ),
                                      )
                                    : const Icon(
                                        Icons.person_off,
                                        size: 72,
                                      )),
                          ),
                          const Icon(Icons.arrow_forward_sharp),
                          Flexible(
                            child: GestureDetector(
                              onTap: () async {
                                XFile? picture = await _imagePicker.pickImage(
                                    source: ImageSource.gallery);
                                if (picture == null) return;
                                File? img = File(picture.path);
                                img = await _cropImage(imageFile: img);
                                if (img == null) return;
                                setState(() {
                                  imageFile = XFile(img!.path);
                                });
                              },
                              child: ImageBorders(
                                  child: imageFile != null
                                      ? ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(100)),
                                          child: Image.file(
                                            File(imageFile!.path),
                                          ),
                                        )
                                      : const Icon(
                                          Icons.camera,
                                          size: 72,
                                        )),
                            ),
                          )
                        ],
                      ),
                    )
                  : SizedBox(
                      height: 100,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    ),
              actions: isCharging
                  ? <Widget>[
                      TextButton(
                        onPressed: () async {
                          isCharging = false;
                          setState(() {});
                          if (imageFile != null) {
                            File image = File(imageFile!.path);
                            Reference imageref = FirebaseStorage.instance
                                .ref()
                                .child("usuarios")
                                .child(imageFile!.name);
                            await imageref.putFile(image);
                            urlImage = await imageref.getDownloadURL();
                            usuario.updatePhotoURL(urlImage);
                            await UserManagement.updateUserPhoto(urlImage);
                            imageFile = null;
                            Navigator.of(context).pop();
                            this.setState(() {});
                          } else {}
                        },
                        child: const Text("Actualizar"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancelar"),
                      )
                    ]
                  : [],
            ),
          );
        });
      });

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        compressQuality: 20,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  _viewImage() => showDialog(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Padding(
            padding: const EdgeInsets.all(defaultLargePadding),
            child: Image.network(
              urlImage,
            ),
          ),
        );
      });
}
