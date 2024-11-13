import Foundation

// Estrutura para representar uma tarefa
struct Task {
    let id: Int
    let description: String
    var isCompleted: Bool
}

// Classe para gerenciar a lista de tarefas
class TaskManager {
    private var tasks = [Task]()
    private var nextId = 1

    // Adiciona uma nova tarefa
    func addTask(description: String) {
        let task = Task(id: nextId, description: description, isCompleted: false)
        tasks.append(task)
        nextId += 1
        print("Tarefa adicionada: \(description)")
    }

    // Lista todas as tarefas
    func listTasks() {
        if tasks.isEmpty {
            print("Nenhuma tarefa encontrada.")
        } else {
            for task in tasks {
                let status = task.isCompleted ? "✔️" : "❌"
                print("\(task.id): \(task.description) [\(status)]")
            }
        }
    }

    // Marca uma tarefa como concluída
    func completeTask(id: Int) {
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            tasks[index].isCompleted = true
            print("Tarefa \(id) marcada como concluída.")
        } else {
            print("Tarefa com ID \(id) não encontrada.")
        }
    }
}

// Função principal para processar os argumentos
func main() {
    let manager = TaskManager()
    let arguments = CommandLine.arguments

    guard arguments.count > 1 else {
        print("Uso: add <descrição> | list | complete <id>")
        return
    }

    let command = arguments[1]

    switch command {
    case "add":
        let description = arguments.dropFirst(2).joined(separator: " ")
        manager.addTask(description: description)
    case "list":
        manager.listTasks()
    case "complete":
        if let id = Int(arguments[safe: 2]) {
            manager.completeTask(id: id)
        } else {
            print("ID inválido.")
        }
    default:
        print("Comando desconhecido: \(command)")
    }
}

// Função auxiliar para acessar elementos com segurança
extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

// Executa a função principal
main()
