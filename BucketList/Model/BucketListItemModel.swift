import Foundation

struct BucketListItemModel: Identifiable, Equatable, Codable {
    var name: String
    var id = UUID()
    var isCompleted: Bool = false
}
