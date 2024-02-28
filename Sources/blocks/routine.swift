
public class Routine {
    public enum Level: Int {
        case bronze = 0
        case silver
        case gold
        case platinum
        case diamond

        public var index: Int { self.rawValue }
        public var name: String {
            switch self {
            case .bronze:
                return "Bronze"
            case .silver:
                return "Silver"
            case .gold:
                return "Gold"
            case .platinum:
                return "Platinum"
            case .diamond:
                return "Diamond"
            }
        }
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
    public var introSkill: Skill?
    public var skills: [Skill]
    public var level: Level

    public init(introSkill: Skill? = nil, skills: [Skill], level: Level) {
        self.introSkill = introSkill
        self.skills = skills
        self.level = level
    }
}

