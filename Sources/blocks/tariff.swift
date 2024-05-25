
public class TariffSheet {
    public struct Box {
        public let skill: Variant
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
        // (H.e.)
        // A one arm element can be done an additional time on the
        // non-dominant arm for credit once only
        var repeats: [String: (first: Int, second: Int)] = [:]
        let maxSkills = [5, 7, 10, 10, 10][routine.level.index]
        _ = routine.skills.prefix(maxSkills).reduce(routine.introSkill)
            { prev, next in
            let r = repeats[next.skill.name, default: (first: 0, second: 0)]
            let nonDominant = next.skill.support == Skill.Support.oneArm && next.variation.hands == Variation.Hands.second
            let rp = nonDominant ?
                (first: r.first, second: r.second + 1) :
                (first: r.first + 1, second: r.second)
            repeats[next.skill.name] = rp
            let overRepeated = rp.first > 2 || rp.second > 2 || rp.first + rp.second > 3
            declaration.append(
                Box(
                    skill: next,
                    link: transitionValue(prev, to: next),
                    value: overRepeated ? 0 : skillValue(next.skill)
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

