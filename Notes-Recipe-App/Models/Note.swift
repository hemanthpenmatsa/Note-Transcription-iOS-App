import Foundation

@Observable
final class Note {
    let id: UUID
    var title: String
    var content: String
    var createdAt: Date
    var updatedAt: Date
    var folderId: UUID?
    
    init(
        id: UUID = UUID(),
        title: String,
        content: String,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        folderId: UUID? = nil
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.folderId = folderId
    }
    
    func update(
        title: String? = nil,
        content: String? = nil,
        folderId: UUID? = nil
    ) {
        if let title = title { self.title = title }
        if let content = content { self.content = content }
        if let folderId = folderId { self.folderId = folderId }
        self.updatedAt = Date()
    }
}
