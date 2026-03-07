import SwiftUI
import SwiftData
internal import Combine

// MARK: - Model
@available(iOS 17, *)
@Model
class Todo {
    // SwiftData needs properties to be accessible for schema generation
    var title: String
    var isCompleted: Bool
    var createdAt: Date
    
    init(title: String, isCompleted: Bool = false, createdAt: Date = .now) {
        self.title = title
        self.isCompleted = isCompleted
        self.createdAt = createdAt
    }
}

// MARK: - ViewModel
@available(iOS 17, *)
@MainActor
class TodoViewModel: ObservableObject {
    @Published var title: String = ""
    
    // Note: We move the data array out of the VM if using @Query in the View.
    // But if you want the VM to handle logic:

    func addTodo(context: ModelContext) {
        guard !title.isEmpty else { return }
        let todo = Todo(title: title)
        context.insert(todo)
        
        // SwiftData autosaves by default on the main context,
        // but explicit save is fine for critical operations.
        title = ""
    }

    func toggleComplete(todo: Todo) {
        todo.isCompleted.toggle()
        // No need to fetch again! SwiftData objects are observable.
    }

    func delete(todo: Todo, context: ModelContext) {
        context.delete(todo)
    }
}

// MARK: - View
@available(iOS 17.0, *)
struct TodoListView: View {
    @Environment(\.modelContext) private var context
    
    // Use @Query for automatic, high-performance data fetching
    @Query(sort: \Todo.createdAt, order: .reverse) private var todos: [Todo]
    @StateObject private var vm = TodoViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Enter todo...", text: $vm.title)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Add") {
                        vm.addTodo(context: context)
                    }
                }
                .padding()
                
                List {
                    ForEach(todos) { todo in
                        HStack {
                            Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(todo.isCompleted ? .green : .gray)
                                .onTapGesture {
                                    vm.toggleComplete(todo: todo)
                                }
                            
                            Text(todo.title)
                                .strikethrough(todo.isCompleted)
                            
                            Spacer()
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            vm.delete(todo: todos[index], context: context)
                        }
                    }
                }
            }
            .navigationTitle("SwiftData Todo")
        }
    }
}
