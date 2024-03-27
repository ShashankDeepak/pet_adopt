import 'dart:async';
import 'dart:convert';
import 'package:adopt_pet/view/home/home_elements.dart';
import 'package:adopt_pet/view/home/modals/animal_modal.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeIntialAnimalFetchEvent>(homeIntialAnimalFetchEvent);
    on<CategoryButtonClickedEvent>(categoryButtonClickedEvent);
    on<HomeClassHistoryButtonTapEvent>(homeClassHistoryButtonTapEvent);
    on<AnimaleCardClickedEvent>(animaleCardClickedEvent);
    on<SearchTextFieldClickedEvent>(searchTextFieldClickedEvent);
    on<PageButtonTappedEvent>(pageButtonTappedEvent);
  }
  FutureOr<void> homeIntialAnimalFetchEvent(
      HomeIntialAnimalFetchEvent event, Emitter<HomeState> emit) async {
    emit(HomeClassLodaingAnimalDataState()); //First we will load the data
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    var jsonString;
    if (prefs.containsKey("animals")) {
      print("hello78786y87");
      jsonString = prefs.getString("animals");
      print("2324" + jsonString);
    } else {
      jsonString ??= await rootBundle.loadString('assets/animals.json');
      prefs.setString("animals", jsonString);
    }
    final List<dynamic> jsonData = jsonDecode(jsonString!);
    print(jsonString);
    print("--------------------------");
    print(jsonData.runtimeType);

    List<AnimalModal> animalModal = jsonData.map((j) {
      AnimalModal modal =
          AnimalModal.fromMap(jsonDecode(j) as Map<String, dynamic>);
      return modal;
    }).toList();
    print(animalModal);
    allAnimalModalsList = List.of(animalModal);
    List<AnimalModal> modals = [];
    for (int i = 0; i <= 3; i++) {
      modals.add(animalModal[i]);
    }
    print(animalModal.length);
    emit(HomeClassLoadingAnimalSuccessState(
        animalModal: modals, allAnimals: animalModal));
  }

  FutureOr<void> categoryButtonClickedEvent(
      CategoryButtonClickedEvent event, Emitter<HomeState> emit) {
    print("${event.categoryName} clicked");
    List<AnimalModal> animalModal = [];
    // print(event.animalModal.length);
    for (var modal in event.animalModal) {
      if (modal.species == event.categoryName) {
        animalModal.add(modal);
      }
    }

    emit(HomeClassCategoryTapState(
        categoryName: event.categoryName, animalModal: animalModal));
  }

  FutureOr<void> animaleCardClickedEvent(
      AnimaleCardClickedEvent event, Emitter<HomeState> emit) {
    print("Animal card clicked");
    emit(HomeClassAnimalCardTapState(
        animalModal: event.animalModal, allAnimals: event.allAnimals));
  }

  FutureOr<void> searchTextFieldClickedEvent(
      SearchTextFieldClickedEvent event, Emitter<HomeState> emit) {
    List<AnimalModal> ans = [];
    String text = event.searchText.trim();
    List<AnimalModal> originalList = [];
    if (event.categoryName.isNotEmpty) {
      for (AnimalModal a in event.animalModal) {
        if (a.species == event.categoryName) {
          originalList.add(a);
        }
      }
    } else {
      originalList = List.of(event.animalModal);
    }
    if (text.isEmpty) {
      emit(HomeClassAnimalSearchState(list: ans, originalList: originalList));
    } else {
      print(text);
      for (AnimalModal animal in originalList) {
        if (animal.name.toLowerCase().contains(text.toLowerCase())) {
          ans.add(animal);
        } else if (event.categoryName != "" &&
            animal.species == event.categoryName &&
            animal.name.toLowerCase().contains(text.toLowerCase())) {
          print("---------sda---------------");
          ans.add(animal);
        }
      }

      emit(HomeClassAnimalSearchState(list: ans, originalList: originalList));
    }
  }

  FutureOr<void> homeClassHistoryButtonTapEvent(
      HomeClassHistoryButtonTapEvent event, Emitter<HomeState> emit) {
    emit(HomeClassHistoryButtonTapState());
  }

  FutureOr<void> pageButtonTappedEvent(
      PageButtonTappedEvent event, Emitter<HomeState> emit) {
    List<AnimalModal> animals = [];
    for (int i = event.start; i <= event.end; i++) {
      animals.add(event.animalModal[i]);
    }
    emit(PageButtonTappedState(
        list: animals, start: event.start, totalList: event.animalModal));
  }
}
