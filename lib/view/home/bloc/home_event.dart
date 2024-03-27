// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeIntialAnimalFetchEvent extends HomeEvent {}

class AnimaleCardClickedEvent extends HomeEvent {
  final AnimalModal animalModal;
  final List<AnimalModal> allAnimals;
  AnimaleCardClickedEvent({
    required this.animalModal,
    required this.allAnimals,
  });
}

class CategoryButtonClickedEvent extends HomeEvent {
  final String categoryName;
  final List<AnimalModal> animalModal;
  CategoryButtonClickedEvent({
    required this.animalModal,
    required this.categoryName,
  });
}

class HomeClassHistoryButtonTapEvent extends HomeEvent {}

class SearchTextFieldClickedEvent extends HomeEvent {
  final String searchText;
  final List<AnimalModal> animalModal;
  final String categoryName;

  SearchTextFieldClickedEvent(
      {required this.searchText,
      required this.animalModal,
      required this.categoryName});
}

class PageButtonTappedEvent extends HomeEvent {
  final int start;
  final int end;
  final List<AnimalModal> animalModal;
  PageButtonTappedEvent(
      {required this.start, required this.end, required this.animalModal});
}
