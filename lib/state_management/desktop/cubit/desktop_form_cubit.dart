import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'desktop_form_state.dart';

class DesktopFormCubit extends Cubit<DesktopFormState> {
  DesktopFormCubit() : super(DesktopFormInitial());
}
