
public func skillValue(_ skill: Skill) -> Int {
    return skill.difficulty
}

public func transitionValue(_ from: Skill?, to: Skill) -> Int {
    guard let from = from else { return 0 }
    guard from.support == to.support else { return 0 }
    let value: Int = transitions[from.support.index][from.category.index][to.category.index]
    var overBonus = 0
    // This rule is a little confusing.
    // Additional transition value is given ONLY ENTERING these positions from any position as long as the point of support is not changed.
    if to.over && to != from {
        // Support enums are ordered twoArm, twoToOne, oneArm; 0, 1, 2 raw
        overBonus = to.support.index + 1
    }
    return value + overBonus
}

