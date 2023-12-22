import Foundation

final class PersistentStorage {
    var fileURL: URL
    
    init() {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        fileURL = documentsURL[0].appendingPathComponent("BucketList.json")
    }
}
