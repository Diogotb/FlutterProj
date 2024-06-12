
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/todolist.dart';


class TodolistController{
  //atributo list
  List<Todolist> _list = [];
  List<Todolist> get list => _list;

  //conectar ao firebase FireStore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //métodos
  //add
  Future<void> add(Todolist todolist) async{
    await _firestore.collection('todolist').add(todolist.toMap());
  }
  //deletar
  Future<void> delete(String id) async{
    await _firestore.collection('todolist').doc(id).delete();
  }
  //fetch list
  Future<void> fetchList(String userId) async{
    print(userId);
    QuerySnapshot result = await _firestore.collection('todolist').where('userid', isEqualTo: userId).get();
    print(result.size);
    List<dynamic> teste = result.docs as List;
    print(teste.length);
    for(int i = 0; i < teste.length; i++){
      print(teste[i].data());
    }
  }
}





// final moviesRef = FirebaseFirestore.instance.collection('movies').withConverter<Movie>(
//       fromFirestore: (snapshot, _) => Movie.fromJson(snapshot.data()!),
//       toFirestore: (movie, _) => movie.toJson(),
//     );