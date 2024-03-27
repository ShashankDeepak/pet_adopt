// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'history_bloc.dart';

@immutable
sealed class HistoryState {}

final class HistoryInitial extends HistoryState {}

class HistoryItemsFetchedState extends HistoryState {
  final List<AnimalModal> listOfAdoptedPet;
  HistoryItemsFetchedState({
    required this.listOfAdoptedPet,
  });
}
