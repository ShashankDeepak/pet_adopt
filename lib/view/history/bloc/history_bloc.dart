import 'dart:async';
import 'dart:convert';

import 'package:adopt_pet/view/home/modals/animal_modal.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial()) {
    on<HistoryItemsFetchedEvent>(historyItemsFetchedEvent);
  }

  FutureOr<void> historyItemsFetchedEvent(
      HistoryItemsFetchedEvent event, Emitter<HistoryState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey("animals")) {
      emit(HistoryItemsFetchedState(listOfAdoptedPet: const []));
    } else {
      String? jsonString = prefs.getString("animals");
      List<dynamic> jsonData = jsonDecode(jsonString!);
      List<AnimalModal> listOfAdoptedPet = [];
      jsonData.forEach((e) {
        AnimalModal modal = AnimalModal.fromJson(e);
        if (modal.isAdopted == true) {
          print("hello");
          print(modal);
          listOfAdoptedPet.add(modal);
        }
      });
      listOfAdoptedPet.sort((a, b) => a.date!.compareTo(b.date!));
      emit(HistoryItemsFetchedState(listOfAdoptedPet: listOfAdoptedPet));
    }
  }
}
