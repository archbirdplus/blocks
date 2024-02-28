import blocks

let level: Routine.Level
if CommandLine.arguments.count < 2 {
    level = .diamond
} else {
    let arg = CommandLine.arguments[1]
    let l = Routine.Level.named(arg)
    guard let l = l else {
        print("Unrecognized blocks level: \"\(arg)\"")
        exit(1)
    }
    level = l
}
print("Maximizing difficulty for \(level.name).")
let searcher = Searcher(Skill.skills, level: level)
searcher.search()

