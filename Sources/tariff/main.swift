import Foundation
import blocks

let path = CommandLine.arguments[1]
guard let text = try? String(contentsOf: URL(fileURLWithPath: path)) else {
    print("Failed to read file \"\(path)\".")
    exit(1)
}
let lines = text.split(separator: "\n").map(String.init)

guard let level = Routine.Level.named(lines[0]) else {
    print("Could not read level: \"\(lines[0])\" (must be Bronze, Silver, Gold, Platinum, or Diamond).")
    exit(1)
}

// TODO: match skills against softer patterns
let skills = lines.dropFirst().compactMap(Skill.named)

let routine = Routine(introSkill: nil, skills: skills, level: level)

let errors = validate(routine)
// TODO: print errors

let tariff = TariffSheet(routine)
// TODO: print tariff sheet

print("Difficulty: \(tariff.difficultyValue)")


