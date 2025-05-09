import Foundation

@Observable
final class NotesViewModel {
    private var notes: [Note] = []
    private let persistenceController: PersistenceController
    
    init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
        loadNotes()
    }
    
    var allNotes: [Note] {
        notes
    }
    
    func createNote(title: String, content: String, folderId: UUID? = nil) -> Note {
        let note = Note(title: title, content: content, folderId: folderId)
        notes.append(note)
        saveNote(note)
        return note
    }
    
    func updateNote(_ note: Note, title: String? = nil, content: String? = nil, folderId: UUID? = nil) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].update(title: title, content: content, folderId: folderId)
            saveNote(notes[index])
        }
    }
    
    func deleteNote(_ note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes.remove(at: index)
            deleteNoteFromStorage(note)
        }
    }
    
    private func loadNotes() {
        // TODO: Implement loading notes from persistence
    }
    
    private func saveNote(_ note: Note) {
        // TODO: Implement saving note to persistence
    }
    
    private func deleteNoteFromStorage(_ note: Note) {
        // TODO: Implement deleting note from persistence
    }
    
    func getNotes(inFolder folderId: UUID?) -> [Note] {
        notes.filter { $0.folderId == folderId }
    }
}
