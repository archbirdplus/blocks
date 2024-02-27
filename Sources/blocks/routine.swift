
public class Routine {
    public enum Level: Int {
        case bronze = 0
        case silver
        case gold
        case platinum
        case diamond

        var index: Int { self.rawValue }
        public static func named<Str: StringProtocol>(_ str: Str) -> Level? {
            switch str.lowercased() {
            case "bronze":
                return .bronze
            case "silver":
                return .silver
            case "gold":
                return .gold
            case "platinum":
                return .platinum
            case "diamond":
                return .diamond
            default:
                return nil
            }
        }
    }

    // (H.g.)
    // An optional skill that counts only for its transition difficulty, and
    // can be held for just 1 second.
    var introSkill: Skill?
    var skills: [Skill]
    var level: Level

    public init(introSkill: Skill? = nil, skills: [Skill], level: Level) {
        self.introSkill = introSkill
        self.skills = skills
        self.level = level
    }
}

