
public struct Variation: Equatable {
    public enum FullSupport {
        case twoArm
        case twoToOne
        case dominant
        case nonDominant
    }

    public enum Hands {
        case first
        case second

    }
    // style can be factored out, since it can always be switched.
    // public let style: Int
    // hands is used to allow a third one-arm handstand skill if the side is
    // switched at least once. Other skills should only select the first hand.
    public let hands: Hands
}

public struct Variant {
    public let skill: Skill
    public let variation: Variation

    init(_ skill: Skill, variation: Variation) {
        self.skill = skill
        self.variation = variation
    }

    public var fullSupport: Variation.FullSupport {
        switch skill.support {
        case .twoArm:
            return .twoArm
        case .twoToOne:
            return .twoToOne
        case .oneArm:
            return self.variation.hands == .first ? .dominant : .nonDominant
        }
    }

    public var isHandstand: Bool { skill.isHandstand }

    public var isOneArmHandstand: Bool { skill.isOneArmHandstand }
}

