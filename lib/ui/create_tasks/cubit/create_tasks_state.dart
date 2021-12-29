part of 'crud_cubit.dart';

@immutable
abstract class CrudState {}

class CrudInitial extends CrudState {}

class CrudLoading extends CrudState {}

class CrudSuccess extends CrudState {}

class CrudArchived extends CrudState {}

class CrudDone extends CrudState {}

class CrudError extends CrudState {
  final String error;

  CrudError({required this.error});
}
