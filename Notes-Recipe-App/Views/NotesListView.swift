import SwiftUI

struct NotesListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel: NotesViewModel
    
    init(viewModel: NotesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.allNotes) { note in
                    NavigationLink {
                        NoteDetailView(note: note)
                    } label: {
                        NoteRowView(note: note)
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            viewModel.deleteNote(note)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // TODO: Implement new note creation
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct NoteRowView: View {
    let note: Note
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(note.title)
                .font(.headline)
            Text(note.content)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
        }
    }
}

#Preview {
    NotesListView(viewModel: NotesViewModel(persistenceController: PersistenceController.preview))
}
