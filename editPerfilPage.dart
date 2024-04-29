import 'dart:io';

import 'package:carteira_saude/model/usuario/usuario.dart';
import 'package:carteira_saude/pages/perfil/editPerfilPage.dart';
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
  
  inal FirebasePerfilService perfilService = FirebasePerfilService();
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
    // Verifique se todos os campos estão preenchidos com strings
    return _sexoController.text.isNotEmpty &&
        _estadoCivilController.text.isNotEmpty &&
        _generoController.text.isNotEmpty &&
        _enderecoController.text.isNotEmpty &&
        _cidadeController.text.isNotEmpty &&
        _ufController.text.isNotEmpty &&
        _rgController.text.isNotEmpty &&
        _cnsController.text.isNotEmpty &&
        _tipoSangController.text.isNotEmpty &&
        _ativFisicaController.text.isNotEmpty &&
        _dietaController.text.isNotEmpty &&
        _fumoController.text.isNotEmpty &&
        _cirurgiasController.text.isNotEmpty &&
        _remedioController.text.isNotEmpty &&
        _doencaController.text.isNotEmpty &&
        _alergiaController.text.isNotEmpty &&
        _medicoController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fundoColor,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/logoCabecalho.png',
              width: 100, // Ajuste o tamanho conforme necessário
              height: 30,
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: tituloColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
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
                    color: fundoColor, borderRadius: BorderRadius.circular(25)),
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
                    TextFormField(
                      controller: _sexoController,
                      autofocus: true,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        labelText: "Sexo:",
                        labelStyle: TextStyle(
                            color: tituloColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
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
                    ),
                    TextFormField(
                      controller: _estadoCivilController,
                      autofocus: true,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        labelText: "Estado Civil:",
                        labelStyle: TextStyle(
                            color: tituloColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
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
                    ),
                    TextFormField(
                      controller: _generoController,
                      autofocus: true,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        labelText: "Gênero:",
                        labelStyle: TextStyle(
                            color: tituloColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
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
                    ),
                    TextFormField(
                      controller: _enderecoController,
                      autofocus: true,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        labelText: "Endereço:",
                        labelStyle: TextStyle(
                            color: tituloColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
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
                    ),
                    TextFormField(
                      controller: _cidadeController,
                      autofocus: true,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        labelText: "Cidade:",
                        labelStyle: TextStyle(
                            color: tituloColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
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
                    ),
                    TextFormField(
                      controller: _ufController,
                      autofocus: true,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        labelText: "UF:",
                        labelStyle: TextStyle(
                            color: tituloColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
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
                    TextFormField(
                      controller: _rgController,
                      autofocus: true,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        labelText: "RG:",
                        labelStyle: TextStyle(
                            color: tituloColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
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
                    ),
                    TextFormField(
                      controller: _cnsController,
                      autofocus: true,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        labelText: "CNS:",
                        labelStyle: TextStyle(
                            color: tituloColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
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
                    TextFormField(
                      controller: _tipoSangController,
                      autofocus: true,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        labelText: "Tipo Sanguíneo:",
                        labelStyle: TextStyle(
                            color: tituloColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
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
                    ),
                    TextFormField(
                      controller: _ativFisicaController,
                      autofocus: true,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        labelText: "Atividade física:",
                        labelStyle: TextStyle(
                            color: tituloColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
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
                    ),
                    TextFormField(
                      controller: _dietaController,
                      autofocus: true,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        labelText: "Tipo de dieta:",
                        labelStyle: TextStyle(
                            color: tituloColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
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
                    ),
                    TextFormField(
                      controller: _fumoController,
                      autofocus: true,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        labelText: "Fumo:",
                        labelStyle: TextStyle(
                            color: tituloColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
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
                    ),
                    TextFormField(
                      controller: _cirurgiasController,
                      autofocus: true,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        labelText: "Cirurgias:",
                        labelStyle: TextStyle(
                            color: tituloColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
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
                    ),
                    TextFormField(
                      controller: _remedioController,
                      autofocus: true,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        labelText: "Remédios:",
                        labelStyle: TextStyle(
                            color: tituloColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
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
                    ),
                    TextFormField(
                      controller: _doencaController,
                      autofocus: true,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        labelText: "Doenças:",
                        labelStyle: TextStyle(
                            color: tituloColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
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
                    ),
                    TextFormField(
                      controller: _alergiaController,
                      autofocus: true,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        labelText: "Alergias:",
                        labelStyle: TextStyle(
                            color: tituloColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
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
                    ),
                    TextFormField(
                      controller: _medicoController,
                      autofocus: true,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        labelText: "Médicos responsáveis:",
                        labelStyle: TextStyle(
                            color: tituloColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
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
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _limpar();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: botaoColor, // Cor de fundo do botão
                            onPrimary: textoBotao, // Cor do texto do botão
                            padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 16), // Ajuste o tamanho do botão aqui
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  25.0), // Borda arredondada
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.keyboard_return),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                "Cancelar",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 40),
                        ),
                        ElevatedButton(
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
                          style: ElevatedButton.styleFrom(
                            primary: botaoColor,
                            onPrimary: textoBotao,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.save),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                "Salvar",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
