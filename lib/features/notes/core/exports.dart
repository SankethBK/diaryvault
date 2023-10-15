/// Core
/// -- Failures
export 'package:dairy_app/features/notes/core/failures/failure.dart';

/// -- Validators

/// Data
/// -- Data Sources
export 'package:dairy_app/features/notes/data/datasources/local%20data%20sources/local_data_source_template.dart';

/// -- Models
export 'package:dairy_app/features/notes/data/models/notes_model.dart';

/// -- Repositories
/// Domain
/// -- Entities
export 'package:dairy_app/features/notes/domain/entities/notes.dart';

/// -- Repositories
export 'package:dairy_app/features/notes/domain/repositories/notes_repository.dart';

/// -- Use Cases

/// Presentation
/// -- Bloc
export 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
export 'package:dairy_app/features/notes/presentation/bloc/notes_fetch/notes_fetch_cubit.dart';
export 'package:dairy_app/features/notes/presentation/bloc/selectable_list/selectable_list_cubit.dart';

/// -- Pages
export 'package:dairy_app/features/notes/presentation/pages/note_create_page.dart';
export 'package:dairy_app/features/notes/presentation/pages/note_read_only_page.dart';

/// -- Widgets
export 'package:dairy_app/features/notes/presentation/widgets/note_save_button.dart';
export 'package:dairy_app/features/notes/presentation/widgets/note_title_input_field.dart';
export 'package:dairy_app/features/notes/presentation/widgets/notes_close_button.dart';
export 'package:dairy_app/features/notes/presentation/widgets/rich_text_editor.dart';
export 'package:dairy_app/features/notes/presentation/widgets/show_notes_close_dialog.dart';
export 'package:dairy_app/features/notes/presentation/widgets/toggle_read_write_button.dart';
export 'package:dairy_app/features/notes/presentation/widgets/note_preview_card.dart';
