import 'dart:async';
import 'dart:convert';

import 'package:adopt_pet/view/home/modals/animal_modal.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial()) {
    on<DetailsPetAdoptedEvent>(detailsPetAdoptedEvent);
    on<AnimalImageClickEvent>(animalImageClickEvent);
  }

  FutureOr<void> detailsPetAdoptedEvent(
      DetailsPetAdoptedEvent event, Emitter<DetailsState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    event.animalModal.isAdopted = true;
    event.animalModal.date = DateTime.now();
    List<AnimalModal> allAnimalModal = [];
    for (AnimalModal a in event.allAnimals) {
      if (a.image == event.animalModal.image) {
        a.isAdopted = true;
        a.date = DateTime.now();
      }
      allAnimalModal.add(a);
    }
    print(allAnimalModal);
    var json = jsonEncode(allAnimalModal.map((e) => e.toJson()).toList());
    print("----------------------------------");

    // print(json)
    await prefs.setString("animals", json);
    print(prefs.get("animals"));
    emit(DetailsPetAdoptedState());
  }

  FutureOr<void> animalImageClickEvent(
      AnimalImageClickEvent event, Emitter<DetailsState> emit) {
    emit(AnimalImageClickState());
  }
}
