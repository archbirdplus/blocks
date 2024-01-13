
class Routine {
    enum Level: Int {
        case bronze = 0
        case silver
        case gold
        case platinum
        case diamond

        var index: Int { self.rawValue }
    }

    // (H.g.)
    // An optional skill that counts only for its transition difficulty, and
    // can be held for just 1 second.
    var introSkill: Skill?
    var skills: [Skill]
    var level: Level

    init(introSkill: Skill? = nil, skills: [Skill], level: Level) {
        self.introSkill = introSkill
        self.skills = skills
        self.level = level
    }
}

