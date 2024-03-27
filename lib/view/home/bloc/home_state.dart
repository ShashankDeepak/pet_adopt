// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
sealed class HomeState {} // Will be handing when the UI will be build.

@immutable
sealed class HomeActionState
    extends HomeState {} // Will be handling when we want to take action in the page.

final class HomeInitial extends HomeState {}

class HomeClassLodaingAnimalDataState
    extends HomeState {} // In this UI is building thus it will be a HomeState

class HomeClassLoadingAnimalSuccessState extends HomeState {
  final List<AnimalModal> animalModal;
  final List<AnimalModal> allAnimals;
  HomeClassLoadingAnimalSuccessState({
    required this.animalModal,
    required this.allAnimals,
  });
}

class HomeClassLoadingAnimalFailedState extends HomeState {}

class HomeClassCategoryTapState extends HomeActionState {
  final String categoryName;
  final List<AnimalModal> animalModal;
  HomeClassCategoryTapState({
    required this.animalModal,
    required this.categoryName,
  });
}

class PageButtonTappedState extends HomeActionState {
  final List<AnimalModal> list;
  final int start;
  final List<AnimalModal> totalList;
  PageButtonTappedState(
      {required this.list, required this.start, required this.totalList});
}

class HomeClassAnimalSearchState extends HomeActionState {
  final List<AnimalModal> list;
  final List<AnimalModal> originalList;

  HomeClassAnimalSearchState({required this.originalList, required this.list});
}

class HomeClassHistoryButtonTapState extends HomeActionState {}

class HomeClassAnimalCardTapState extends HomeActionState {
  final AnimalModal animalModal;
  final List<AnimalModal> allAnimals;

  HomeClassAnimalCardTapState(
      {required this.animalModal, required this.allAnimals});
} // Since this is doing a naviagtion it will be a HomeActionState