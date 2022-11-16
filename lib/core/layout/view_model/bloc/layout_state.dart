part of 'layout_bloc.dart';

abstract class LayoutState extends Equatable {
  const LayoutState();
  
  @override
  List<Object> get props => [];
}

class LayoutInitial extends LayoutState {}
