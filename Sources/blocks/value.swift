
public func skillValue(_ skill: Skill) -> Int {
    return skill.difficulty
}

public func haveSameSupport(_ from: Variant?, _ to: Variant) -> Bool {
    guard let from = from else { return false }
    return from.variation.hands == to.variation.hands && from.skill.support == to.skill.support
}

public func areMutualVariants(_ from: Variant?, _ to: Variant) -> Bool {
    guard let from = from else { return false }
    return from.skill.ToD_id == to.skill.ToD_id && from.variation.hands == to.variation.hands && from.skill.styles
}

public func isIdentical(_ from: Variant?, _ to: Variant) -> Bool {
    guard let from = from else { return false }
    return from.skill.ToD_id == to.skill.ToD_id && from.variation == to.variation && !from.skill.styles
}

public func transitionValue(_ from: Variant?, to: Variant) -> Int {
    guard let from = from else { return 0 }
    guard haveSameSupport(from, to) else { return 0 }
    // Don't give credit for repeating a skill without stylistic options. It's
    // a serious error anyways.
    if isIdentical(from, to) { return 0 }
    let a = from.skill
    let b = to.skill
    let value: Int = transitions[a.support.index][a.category.index][b.category.index]
    var overBonus = 0
    // This rule is a little confusing.
    // TODO: Does this apply for the first element of a routine?
    // > Additional transition value is given ONLY ENTERING these positions from any position as long as the point of support is not changed.
    // TODO: If a skill is repeated (but with necessary stylistic changes), does it count as a transition?
    // For now, we will count it.
    if a.over && !areMutualVariants(from, to) {
        // Support enums are ordered twoArm, twoToOne, oneArm; 0, 1, 2 raw
        overBonus = b.support.index + 1
    }
    return value + overBonus
}

