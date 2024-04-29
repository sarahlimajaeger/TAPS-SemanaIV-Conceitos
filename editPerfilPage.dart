import 'dart:html';
import 'dart:io';

import 'package:carteira_saude/model/usuario/usuario.dart';
import 'package:carteira_saude/pages/perfil/editPerfilPage.dart';
import 'package:carteira_saude/pages/components/appBarComponent.dart';
import 'package:carteira_saude/services/perfilServices/firebase_perfil_services.dart';
import 'package:carteira_saude/storage/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditPerfilPage extends StatefulWidget {
  const EditPerfilPage({super.key});

  @override
  State<EditPerfilPage> createState() => _EditPerfilPageState();
}

class _EditPerfilPageState extends State<EditPerfilPage> {
  final FirebasePerfilService perfilService = FirebasePerfilService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Color botaoColor = Color.fromARGB(255, 40, 78, 121);
  Color tituloColor = Color.fromARGB(255, 40, 78, 121);
  Color textColor = Colors.black;
  Color fundoColor = Color.fromARGB(255, 239, 239, 239);
  Color fundoInfosColor = Color.fromARGB(255, 217, 217, 217);
  Color textoBotao = Colors.white;

  final Map<String, TextEditingController> _controllers = {
    'sexo': TextEditingController(),
    'estadoCivil': TextEditingController(),
    'genero': TextEditingController(),
    'endereco': TextEditingController(),
    'cidade': TextEditingController(),
    'uf': TextEditingController(),
    'rg': TextEditingController(),
    'cns': TextEditingController(),
    'tipoSang': TextEditingController(),
    'ativFisica': TextEditingController(),
    'dieta': TextEditingController(),
    'fumo': TextEditingController(),
    'cirurgias': TextEditingController(),
    'remedio': TextEditingController(),
    'doenca': TextEditingController(),
    'alergia': TextEditingController(),
    'medico': TextEditingController(),
  };

  void _limpar() {
    _controllers.values.forEach((controller) => controller.clear());
  }

  Future<void> _editarPerfil({
    required String sexo,
    required String estadoCivil,
    required String genero,
    required String endereco,
    required String cidade,
    required String uf,
    required String rg,
    required String cns,
    required String tipoSang,
    required String ativFisica,
    required String dieta,
    required String fumo,
    required String cirurgia,
    required String remedio,
    required String doenca,
    required String alergia,
    required String medico,
  }) async {
    User? user = _auth.currentUser;
    try {
      if (user != null) {
        String userId = user!.uid;
        perfilService.updateUserData(
            userId,
            sexo,
            estadoCivil,
            genero,
            endereco,
            cidade,
            uf,
            rg,
            cns,
            tipoSang,
            ativFisica,
            dieta,
            fumo,
            cirurgia,
            remedio,
            doenca,
            alergia,
            medico);
      }
    } catch (e) {
      print("Erro ao atualizar dados do usuário: $e");
    }
  }

  bool _todosCamposPreenchidos() {
    return _controllers.values
        .every((controller) => controller.text.isNotEmpty);
  }

  //Método para construir os campos do perfil
  Widget _textCamposPerfil({
    required TextEditingController controller,
    required String labelText,
  }) {
    return TextFormField(
      controller: controller,
      autofocus: true,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: tituloColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: textColor,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: textColor,
          ),
        ),
      ),
    );
  }

  //Método para construir os botões do perfil
  Widget _botoes({
    required VoidCallback onPressed,
    required String label,
    required IconData icon,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: botaoColor,
        onPrimary: textoBotao,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          SizedBox(width: 8.0),
          Text(
            label,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 25),
            ),
            Text(
              "Editar perfil",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: tituloColor,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: fundoColor,
                      borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    children: [
                      Padding(padding: const EdgeInsets.all(8.0)),
                      Text(
                        "Informações básicas",
                        style: TextStyle(
                          color: tituloColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _textCamposPerfil(
                        controller: _controllers['sexo']!,
                        labelText: "Sexo:",
                      ),
                      _textCamposPerfil(
                        controller: _controllers['estadoCivil']!,
                        labelText: "Estado Civil:",
                      ),
                      _textCamposPerfil(
                        controller: _controllers['genero']!,
                        labelText: "Gênero:",
                      ),
                      _textCamposPerfil(
                        controller: _controllers['endereco']!,
                        labelText: "Endereço:",
                      ),
                      _textCamposPerfil(
                        controller: _controllers['cidade']!,
                        labelText: "Cidade:",
                      ),
                      _textCamposPerfil(
                        controller: _controllers['uf']!,
                        labelText: "UF:",
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 25),
                      ),
                      Text(
                        "Documentos",
                        style: TextStyle(
                          color: tituloColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _textCamposPerfil(
                        controller: _controllers['rg']!,
                        labelText: "RG:",
                      ),
                      _textCamposPerfil(
                        controller: _controllers['cns']!,
                        labelText: "CNS:",
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 25),
                      ),
                      Text(
                        "Saúde",
                        style: TextStyle(
                          color: tituloColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _textCamposPerfil(
                        controller: _controllers['tipoSang']!,
                        labelText: "Tipo Sanguíneo:",
                      ),
                      _textCamposPerfil(
                        controller: _controllers['ativFisica']!,
                        labelText: "Atividade física:",
                      ),
                      _textCamposPerfil(
                        controller: _controllers['dieta']!,
                        labelText: "Tipo de dieta:",
                      ),
                      _textCamposPerfil(
                        controller: _controllers['fumo']!,
                        labelText: "Fumo:",
                      ),
                      _textCamposPerfil(
                        controller: _controllers['cirurgias']!,
                        labelText: "Cirurgias:",
                      ),
                      _textCamposPerfil(
                        controller: _controllers['remedio']!,
                        labelText: "Remédios:",
                      ),
                      _textCamposPerfil(
                        controller: _controllers['doenca']!,
                        labelText: "Doenças:",
                      ),
                      _textCamposPerfil(
                        controller: _controllers['alergia']!,
                        labelText: "Alergias:",
                      ),
                      _textCamposPerfil(
                        controller: _controllers['medico']!,
                        labelText: "Médicos responsáveis:",
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _botoes(
                              onPressed: () {
                                Navigator.pop(context);
                                _limpar();
                              },
                              label: "Cancelar",
                              icon: Icons.keyboard_return),
                          Padding(
                            padding: EdgeInsets.only(left: 40),
                          ),
                          _botoes(
                              onPressed: () {
                                if (_todosCamposPreenchidos()) {
                                  _editarPerfil(
                                    sexo: _sexoController.text,
                                    estadoCivil: _estadoCivilController.text,
                                    genero: _generoController.text,
                                    endereco: _enderecoController.text,
                                    cidade: _cidadeController.text,
                                    uf: _ufController.text,
                                    rg: _rgController.text,
                                    cns: _cnsController.text,
                                    tipoSang: _tipoSangController.text,
                                    ativFisica: _ativFisicaController.text,
                                    dieta: _dietaController.text,
                                    fumo: _fumoController.text,
                                    cirurgia: _cirurgiasController.text,
                                    remedio: _remedioController.text,
                                    doenca: _doencaController.text,
                                    alergia: _alergiaController.text,
                                    medico: _medicoController.text,
                                  );
                                  _limpar();
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => PerfilPage(),
                                    ),
                                  );
                                } else {
                                  showSnackBar(
                                      context: context,
                                      mensagem:
                                          "Todos os campos devem estar preenchidos!");
                                }
                              },
                              label: "Salvar",
                              icon: Icons.save),
                          Padding(
                            padding: EdgeInsets.only(top: 50),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
