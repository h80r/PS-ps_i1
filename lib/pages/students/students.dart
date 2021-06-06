import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:ps_i1/components/students_item.dart';

import 'package:ps_i1/pages/students/students_view_model.dart';
import 'package:ps_i1/services/services.dart';
import 'package:ps_i1/store/app_state.dart';
import 'package:ps_i1/store/students/students_actions.dart';

class Students extends StatelessWidget {
  const Students({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, StudentsViewModel>(
      onInit: (store) => store.dispatch(loadThunk(Services.students)),
      converter: (store) => StudentsViewModel.fromStore(store),
      builder: (context, viewModel) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Controle de alunos'),
            centerTitle: true,
          ),
          body: ListView.separated(
            itemBuilder: (context, index) => ListTile(
              onTap: () => viewModel.onTapItem(index),
              title: StudentItem(
                size: MediaQuery.of(context).size,
                fullName: viewModel.students[index].name,
                status: viewModel.students[index].state,
              ),
            ),
            itemCount: viewModel.students.length,
            separatorBuilder: (context, index) => Divider(
              color: Theme.of(context).primaryColor,
              indent: 25,
              endIndent: 25,
            ),
          ),
          bottomSheet: viewModel.isEditing
              ? Container(
                  margin: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        viewModel.editedStudent!.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      TextFormField(
                        key: Key(
                          viewModel.editedStudent!.uid +
                              viewModel.editedStudent!.firstGrade.toString() +
                              'fg',
                        ),
                        initialValue:
                            viewModel.editedStudent!.firstGrade.toString(),
                        decoration: const InputDecoration(
                          labelText: 'Nota I',
                        ),
                        onChanged: viewModel.onFirstGradeChange,
                      ),
                      TextFormField(
                        key: Key(
                          viewModel.editedStudent!.uid +
                              viewModel.editedStudent!.firstGrade.toString() +
                              'sg',
                        ),
                        initialValue:
                            viewModel.editedStudent!.secondGrade.toString(),
                        decoration: const InputDecoration(
                          labelText: 'Nota II',
                        ),
                        onChanged: viewModel.onSecondGradeChange,
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: viewModel.onSave,
                          child: const Text('Salvar'),
                        ),
                      ),
                    ],
                  ),
                )
              : null,
        );
      },
    );
  }
}
