
class TariffSheet {
    struct Box {
        let skill: Skill
        let link: Int
        let value: Int
    }
    let level: Routine.Level
    let declaration: [Box]
    let elementsValue: Int
    let linksValue: Int
    var difficultyValue: Int { elementsValue + linksValue }
    var dscore: Double {
        let maxD = [10, 25, 45, 65, nil][level.index]
        let capped = maxD == nil ? difficultyValue : min(difficultyValue, maxD!)
        return Double(capped) / 10.0
    }
    init(_ routine: Routine) {
        var declaration: [Box] = []
        // (H.d.)
        // An identical skill is defined in the Xcel Blocks Tables of
        // Difficulty according to the name of each skill.
        var repeats: [String: Int] = [:]
        _ = routine.skills.reduce(routine.introSkill) { prev, next in
            repeats[next.name, default: 0] += 1
            declaration.append(
                Box(
                    skill: next,
                    link: transitionValue(prev, to: next),
                    value: repeats[next.name]! > 2 ? 0 : skillValue(next)
                )
            )
            return next
        }
        self.level = routine.level
        self.declaration = declaration
        self.linksValue = declaration.reduce(0) { r, x in r + x.link }
        self.elementsValue = declaration.reduce(0) { r, x in r + x.value }
    }
}

