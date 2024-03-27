part of 'history_bloc.dart';

@immutable
sealed class HistoryEvent {}

class HistoryItemsFetchedEvent extends HistoryEvent {}
