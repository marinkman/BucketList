import SwiftUI

struct BucketListView: View {
    
    var body: some View {
        VStack {
            Text(bucketListViewModel.listTitle)
                .font(.custom(String.AppFont.mainFont, size: 50))
                .bold()
            
            TextField(bucketListViewModel.textFieldPrompt, text: $bucketListItemName)
                .onSubmit {
                    bucketListViewModel.createItem(bucketListItemName)
                    bucketListItemName = bucketListViewModel.emptyTextField
                }
                .padding(.all)
                .border(Color.purple)
                .shadow(radius: 5)
                .font(.custom(String.AppFont.mainFont, size: 20))
            
            List {
                ForEach(bucketListViewModel.bucketListItems) { item in
                    HStack(spacing: 20) {
                        Button {
                            bucketListViewModel.toggleIsCompleted(item)
                        } label: {
                            Image(systemName: item.isCompleted ? String.IconName.doneItem : String.IconName.undoneItem)
                                .foregroundStyle(Color.purple)
                                .font(.system(size: 30))
                        }
                        Text(item.name)
                            .font(.custom(String.AppFont.mainFont, size: 30))
                    }
                }
                .onDelete(perform: bucketListViewModel.deleteItem)
                .frame(minWidth: 50)
                .listRowSeparator(.hidden, edges: .all)
            }
        }
        .padding()
        .listStyle(.plain)
        .onAppear {
            bucketListViewModel.loadFromStorage()
        }
    }
    
    @State private var bucketListItemName = String()
    private var bucketListViewModel = BucketListViewModel()
}

#Preview {
    BucketListView()
}
