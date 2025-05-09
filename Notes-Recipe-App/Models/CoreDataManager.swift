import CoreData

class CoreDataManager {
    
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "NotesContainer")
        
        if inMemory {
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [description]
        }
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load store: \(error)")
            }
        }
    }
    
var context: NSManagedObjectContext {
    container.viewContext
}

func loadCoreData(completion: @escaping (Bool) -> Void) {
    // Simulate async loading for preview
    DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
        completion(true)
    }
}
}
