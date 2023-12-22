import Foundation

@Observable class BucketListViewModel {
    var bucketListItems = [BucketListItemModel]()
    private var storage = PersistentStorage()
    
    // MARK: CRUD functions
    func createItem(_ name: String) {
        let newItem = BucketListItemModel(name: name)
        bucketListItems.append(newItem)
        saveToStorage()
    }
    
    func toggleIsCompleted(_ item: BucketListItemModel) {
        guard let index = bucketListItems.firstIndex(of: item) else { return }
        bucketListItems[index].isCompleted.toggle()
        saveToStorage()
    }
    
    func deleteItem(_ index: IndexSet) {
        bucketListItems.remove(atOffsets: index)
        saveToStorage()
    }
    
    // MARK: Persistent Storage
    func saveToStorage() {
        do {
            let data = try JSONEncoder().encode(bucketListItems)
            try data.write(to: storage.fileURL)
        } catch {
            print("Error while saving.")
        }
    }
    
    func loadFromStorage() {
        do {
            let data = try Data(contentsOf: storage.fileURL)
            bucketListItems = try JSONDecoder().decode([BucketListItemModel].self, from: data)
        } catch {
            print("Error while loading.")
        }
    }
    
    // MARK: Text for the view
    let textFieldPrompt = "Enter an item."
    let emptyTextField = ""
    let listTitle = "Bucket List"
}
