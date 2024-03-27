// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'details_bloc.dart';

@immutable
sealed class DetailsEvent {}

class DetailsPetAdoptedEvent extends DetailsEvent {
  final AnimalModal animalModal;
  final List<AnimalModal> allAnimals;
  DetailsPetAdoptedEvent({
    required this.allAnimals,
    required this.animalModal,
  });
}

class AnimalImageClickEvent extends DetailsEvent {}
