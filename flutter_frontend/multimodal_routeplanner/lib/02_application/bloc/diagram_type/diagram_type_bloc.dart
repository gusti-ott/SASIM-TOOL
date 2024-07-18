import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multimodal_routeplanner/03_domain/enums/DiagramTypeEnum.dart';

part 'diagram_type_event.dart';
part 'diagram_type_state.dart';

class DiagramTypeBloc extends Bloc<DiagramTypeEvent, DiagramTypeState> {
  DiagramTypeBloc() : super(DiagramTypeInitial()) {
    on<DiagramTypeEvent>((event, emit) {
      if (event is DiagramTypeChangedEvent) {
        emit(DiagramTypeSelected(type: event.diagramType));
      }
    });
  }
}
