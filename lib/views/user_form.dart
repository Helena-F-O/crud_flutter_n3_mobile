import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    _formData['id'] = user.id!;
    _formData['nome'] = user.nome;
    _formData['email'] = user.email;
    _formData['avatarUrl'] = user.avatarUrl;
    _formData['peso'] = user.peso;
    _formData['altura'] = user.altura;
    _formData['imc'] = user.imc;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final user = ModalRoute.of(context)?.settings.arguments as User;
    _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados do Usuário'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState!.validate();

              if (isValid) {
                _form.currentState!.save();

                Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData['id'],
                    nome: _formData['nome']!,
                    email: _formData['email']!,
                    avatarUrl: _formData['avatarUrl']!,
                    peso: _formData['peso']!,
                    altura: _formData['altura']!,
                    imc: _formData['imc']!,
                  ),
                );

                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                initialValue: _formData['nome'],
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nome inválido';
                  }

                  if (value.trim().length < 3) {
                    return 'Nome muito pequeno. No mínimo 3 letras.';
                  }

                  return null;
                },
                onSaved: (value) => _formData['nome'] = value!,
              ),
              TextFormField(
                initialValue: _formData['email'],
                decoration: const InputDecoration(labelText: 'E-mail'),
                onSaved: (value) => _formData['email'] = value!,
              ),
              TextFormField(
                initialValue: _formData['avatarUrl'],
                decoration: const InputDecoration(labelText: 'URL do Avatar'),
                onSaved: (value) => _formData['avatarUrl'] = value!,
              ),
              TextFormField(
                initialValue: _formData['peso'],
                decoration: const InputDecoration(labelText: 'Peso'),
                onSaved: (value) => _formData['peso'] = value!,
              ),
              TextFormField(
                initialValue: _formData['altura'],
                decoration: const InputDecoration(labelText: 'Altura'),
                onSaved: (value) => _formData['altura'] = value!,
              ),
              TextFormField(
                initialValue: _formData['imc'],
                decoration: const InputDecoration(labelText: 'IMC'),
                onSaved: (value) => _formData['imc'] = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
