import Foundation
import blocks

let args = CommandLine.arguments
let path = args.count > 1 ? args[1] : nil

func getLines() -> [String] {
    if let path = path {
        guard let text = try? String(contentsOf: URL(fileURLWithPath: path))
            else {
            print("Failed to read file \"\(path)\".")
            exit(1)
        }
        return text.split(separator: "\n").map(String.init)
    } else {
        var lines: [String] = []
        fputs("level: ", stderr)
        while let line = readLine() {
            if line == "" && !lines.isEmpty { break }
            defer {
                fputs(lines.isEmpty ? "level: " : "skill: ", stderr)
            }
            if lines.isEmpty, let level = Routine.Level.named(line) {
                fputs("\(level.name)\n", stderr)
            }
            else if let skill = Skill.named(line) {
                fputs("\(skill.name)\n", stderr)
            } else {
                fputs("Couldn't parse \"\(line)\"\n", stderr)
                continue
            }
            lines.append(line)
        }
        return lines
    }
}

let lines = getLines()

if lines == [] {
    print("Usage:")
    print("    tariff routine_file -- generate tariff sheet for routine file")
    print("    tariff -- generate tariff sheet interactively")
    exit(0)
}

let rawLevel = Routine.Level.named(lines[0])
let assumingLevel = rawLevel == nil
let level = rawLevel ?? .gold
if assumingLevel {
    print("Assuming \(level.name) level")
}

// TODO: match skills against softer patterns
let allSkills = (assumingLevel ? lines[...] : lines.dropFirst())
    .compactMap(Skill.named)
let maxSkills = [5, 7, 10, 10, 10][level.index]

// If there are more skills than the max, let the first be a 1'' hold for
// transition value.
let introSkill = allSkills.count > maxSkills ? allSkills[0] : nil
let skills = allSkills.count > maxSkills ? Array(allSkills.dropFirst()) : allSkills

let routine = Routine(introSkill: introSkill, skills: skills, level: level)

let tariff = TariffSheet(routine)

print()
print("Tariff Sheet")

print("level: \(tariff.level.name)")

let boxes = tariff.declaration
let longest = boxes.reduce(0) { r, x in max(r, x.skill.name.count) }
let indent = String(repeating: " ", count: longest)

print("\(indent)\t| Link\t| Value")
if let intro = tariff.routine.introSkill {
    print("(1'' hold \(intro.name))")
}
for box in boxes {
    let dent = String(repeating: " ", count: longest - box.skill.name.count)
    print("\(box.skill.name)\(dent)\t| \(box.link)\t| \(box.value)")
}
print("Difficulty")
print("  Elements: \(tariff.elementsValue)")
print("   + Links: \(tariff.linksValue)")
print("  Difficulty Value: \(tariff.difficultyValue)")
print("  D-Score : \(tariff.dscore)")

let log = validate(routine)

func formatTenth(_ n: Int) -> String {
    return "\(n/10).\(n%10)"
}

func formatMessage(_ msg: Message) -> String {
    return "\(msg.str)\(msg.penalty == nil ? "" : " (-\(formatTenth(msg.penalty!)) penalty)")\(msg.location == nil ? "" : " (skill \(msg.location!))")"
}

func sortMessages(_ lhs: Message, _ rhs: Message) -> Bool {
    switch (lhs.location, rhs.location) {
    case (nil, nil):
        return true
    case (_, nil):
        return true
    case (nil, _):
        return false
    case let (a, b):
        return a! < b!
    }
}

for warning in log.warnings.sorted(by: sortMessages) {
    print("* \(formatMessage(warning))");
}

for error in log.errors.sorted(by: sortMessages) {
    print("! \(formatMessage(error))");
}

