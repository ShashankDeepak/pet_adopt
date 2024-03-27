// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'details_bloc.dart';

@immutable
sealed class DetailsState {}

@immutable
sealed class DetailsActionState extends DetailsState {}

final class DetailsInitial extends DetailsState {}

class DetailsPetAdoptedState extends DetailsActionState {}

class AnimalImageClickState extends DetailsActionState {}
