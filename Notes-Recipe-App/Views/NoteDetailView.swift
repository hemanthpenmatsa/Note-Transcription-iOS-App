import SwiftUI

struct NoteDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel: NotesViewModel
    
    let note: Note
    @State private var title: String
    @State private var content: String
    
    init(note: Note, viewModel: NotesViewModel) {
        self.note = note
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._title = State(initialValue: note.title)
        self._content = State(initialValue: note.content)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                TextEditor(text: $content)
                    .frame(minHeight: 200)
                    .padding()
                
                Spacer()
            }
            .navigationTitle("Edit Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        viewModel.updateNote(note, title: title, content: content)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}

#Preview {
    let viewModel = NotesViewModel(persistenceController: PersistenceController.preview)
    let note = Note(title: "Sample Note", content: "This is a sample note content.")
    return NoteDetailView(note: note, viewModel: viewModel)
}
