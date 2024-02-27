
public func skillValue(_ skill: Skill) -> Int {
    return skill.difficulty
}

public func transitionValue(_ from: Skill?, to: Skill) -> Int {
    guard let from = from else { return 0 }
    guard from.support == to.support else { return 0 }
    let score: Int = transitions[from.support.index][from.category.index][to.category.index]
    return score
}

