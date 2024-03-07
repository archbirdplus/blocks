
public class TariffSheet {
    public struct Box {
        public let skill: Skill
        public let link: Int
        public let value: Int
    }
    public let level: Routine.Level
    public let routine: Routine
    public let declaration: [Box]
    public let elementsValue: Int
    public let linksValue: Int
    public var difficultyValue: Int { elementsValue + linksValue }
    public var dscore: Double {
        let maxD = [10, 25, 45, 65, nil][level.index]
        let capped = maxD == nil ? difficultyValue : min(difficultyValue, maxD!)
        return Double(capped) / 10.0
    }
    public init(_ routine: Routine) {
        var declaration: [Box] = []
        // (H.d.)
        // An identical skill is defined in the Xcel Blocks Tables of
        // Difficulty according to the name of each skill.
        var repeats: [String: Int] = [:]
        let maxSkills = [5, 7, 10, 10, 10][routine.level.index]
        _ = routine.skills.prefix(maxSkills).reduce(routine.introSkill)
            { prev, next in
            repeats[next.name, default: 0] += 1
            // TODO: Confirm that switching hands in one arm gives transition value.
            let maxRepeats = next.isOneArmHandstand ? 3 : 2
            declaration.append(
                Box(
                    skill: next,
                    link: transitionValue(prev, to: next),
                    value: repeats[next.name]! > maxRepeats ? 0 : skillValue(next)
                )
            )
            return next
        }
        self.level = routine.level
        self.routine = routine
        self.declaration = declaration
        self.linksValue = declaration.reduce(0) { r, x in r + x.link }
        self.elementsValue = declaration.reduce(0) { r, x in r + x.value }
    }
}

