import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadbiro/data/repositories/event_repository.dart';
import '../../../data/models/event.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository _eventRepository;

  EventBloc({required EventRepository eventRepository})
      : _eventRepository = eventRepository,
        super(InitialEventState()) {
    on<GetEventsEvent>(_getEvents);
    on<AddEventEvent>(_addEvent);
    on<MakeLikedEvent>(_makeLiked);
    on<MakeParticipantEvent>(_makeParticipant);
  }

  void _getEvents(GetEventsEvent event, Emitter<EventState> emit) async {
    emit(LoadingEventState());

    try {
      await emit.forEach(_eventRepository.getEvents(), onData: (value) {
        return LoadedEventsState(value);
      });
    } catch (e) {
      emit(ErrorEventState(e.toString()));
    }
  }

  Future<void> _addEvent(AddEventEvent event, Emitter<EventState> emit) async {
    emit(LoadingEventState());

    try {
      await _eventRepository.addEvent(
        event.title,
        event.timestamp,
        event.description,
        event.imageFile,
        event.latitude,
        event.longitude,
        event.location,
      );
    } catch (e) {
      emit(ErrorEventState(e.toString()));
    }
  }

  Future<void> _makeLiked(
      MakeLikedEvent event, Emitter<EventState> emit) async {
    emit(LoadingEventState());

    try {
      await _eventRepository.makeLiked(event.id);
    } catch (e) {
      emit(ErrorEventState(e.toString()));
    }
  }

  Future<void> _makeParticipant(
      MakeParticipantEvent event, Emitter<EventState> emit) async {
    emit(LoadingEventState());

    try {
      await _eventRepository.makeParticipant(event.eventId, event.amount);
    } catch (e) {
      emit(ErrorEventState(e.toString()));
    }
  }
}
