
// MARK:
// Represents the most granular type of skill that is still recognized
// as distinct- groups together variations that are considered interchangeable,
// but still separates skills with different difficulties.
class Skill {
    // The point of support of the skill.
    enum Support: Int {
        case twoArm = 0
        case twoToOne = 1
        case oneArm = 2

        var index: Int { self.rawValue }
    }

    // The category this skill falls under when looking up the difficulty
    // of a transition in or out of it.
    enum Category: Int {
        case pike = 0
        case croc
        case planche // one arm planche is not a valid skill
        case handstand
        case arch
        case yogi
        case flag

        var index: Int { self.rawValue }
    }

    let name: String
    let difficulty: Int
    let category: Category
    let support: Support
    // Determines whether to add +1/2/3 on entering the position.
    let over: Bool

    var isHandstand: Bool {
        switch category {
        case .pike, .croc, .planche:
            return false
        case .handstand, .arch, .yogi, .flag:
            return true
        }
    }

    // TODO: (H.f.) Some skills have multiple variations, which allows it to
    // be repeated consecutively.
    init(_ name: String, _ diff: Int, _ category: Category, _ support: Support = .twoArm, over: Bool = false) {
        self.name = name
        self.difficulty = diff
        self.category = category
        self.support = support
        self.over = over
    }
}

extension Skill: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
    }

    static func == (lhs: Skill, rhs: Skill) -> Bool {
        // TODO: names might be the same, hashing to the same value, yet
        // might not be actually equatable
        return lhs === rhs
    }
}

extension Skill {
    // A list of every valid skill in the Xcel Blocks Code of Points, along with
    // some properties of them.
    static let skills: [Skill] = [
        // Two Arms
        Skill("Tuck", 1, .pike),
        Skill("Straddle", 2, .pike),
        Skill("Pike", 2, .pike),
        Skill("Croc", 3, .croc),
        Skill("Handstand", 4, .handstand),
        Skill("Russian Lever FT", 4, .pike),
        Skill("Croc FT", 4, .croc),
        Skill("Handstand FT", 5, .handstand),
        Skill("Arch", 5, .arch),
        Skill("Ring", 5, .arch, over: true),
        Skill("Yogi", 5, .yogi),
        Skill("Arch FT", 6, .arch),
        Skill("Flag", 6, .flag),
        Skill("Overarch", 6, .arch, over: true),
        Skill("Yogi FT", 6, .yogi),
        Skill("High Russian Lever FT", 7, .pike),
        Skill("Side Flag", 7, .flag),
        Skill("Split Planche", 7, .planche),
        Skill("Overarch FT", 8, .arch, over: true),
        Skill("Planche", 10, .planche),
        Skill("Flag FT", 12, .flag),
        Skill("Overflag", 12, .flag, over: true),
        Skill("Planche FT", 17, .planche),

        // 2:1 Arm
        Skill("2:1 Straddle", 3, .pike, .twoToOne),
        Skill("2:1 Croc", 4, .croc, .twoToOne),
        Skill("2:1 Croc FT", 5, .croc, .twoToOne),
        Skill("2:1 Handstand", 10, .handstand, .twoToOne),
        Skill("2:1 Arch", 11, .arch, .twoToOne),
        Skill("2:1 Flag", 11, .flag, .twoToOne),
        Skill("2:1 Ring", 12, .arch, .twoToOne, over: true),
        Skill("2:1 Arch FT", 12, .arch, .twoToOne),
        Skill("2:1 Overarch", 12, .arch, .twoToOne, over: true),
        Skill("2:1 Yogi", 12, .yogi, .twoToOne),
        Skill("2:1 Split Planche", 13, .planche, .twoToOne),
        Skill("2:1 Overarch FT", 14, .arch, .twoToOne, over: true),
        Skill("2:1 Planche", 16, .planche, .twoToOne),
        Skill("2:1 Planche FT", 23, .planche, .twoToOne),

        // One Arm
        Skill("1-Arm Croc", 5, .croc, .oneArm),
        Skill("1-Arm Split Croc", 5, .croc, .oneArm),
        Skill("1-Arm Croc FT", 6, .croc, .oneArm),
        Skill("1-Arm Straddle", 7, .pike, .oneArm),
        Skill("1-Arm Pike", 10, .pike, .oneArm),
        Skill("1-Arm Handstand", 12, .handstand, .oneArm),
        Skill("1-Arm Yogi", 13, .yogi, .oneArm),
        Skill("1-Arm Handstand FT", 14, .handstand, .oneArm),
        Skill("1-Arm Flag", 14, .flag, .oneArm),
        Skill("1-Arm Yogi FT", 14, .yogi, .oneArm),
        Skill("1-Arm Arch", 15, .arch, .oneArm),
        Skill("1-Arm Ring", 15, .arch, .oneArm, over: true),
        Skill("1-Arm Arch FT", 16, .arch, .oneArm),
        Skill("1-Arm Split Arch", 16, .arch, .oneArm),
        Skill("1-Arm Side Flag", 16, .flag, .oneArm),
        // There are two pictures of 1-Arm Split Flag, however due to (H.d.)
        // they are identical.
        Skill("1-Arm Split Flag", 17, .flag, .oneArm),
        Skill("1-Arm Split Flag", 17, .flag, .oneArm),
        Skill("1-Arm Flag FT", 18, .flag, .oneArm),
        Skill("1-Arm Overflag", 18, .flag, .oneArm, over: true),
        Skill("1-Arm Overarch", 19, .arch, .oneArm, over: true),
        Skill("1-Arm Overarch FT", 20, .arch, .oneArm, over: true),
    ]

    static func named(_ name: String) -> Skill? {
        Self.skills.first { $0.name == name }
    }
}

