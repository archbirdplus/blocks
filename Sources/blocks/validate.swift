
public struct Message {
    public var location: Int?
    public var str: String
    // Measured in tenths of a point.
    public var penalty: Int?
}

public class ErrorLog {
    public var errors: [Message] = []
    public var warnings: [Message] = []

    public func err(loc: Int? = nil, _ str: String, penalty: Int? = nil) {
        errors.append(Message(location: loc, str: str, penalty: penalty))
    }

    public func warn(loc: Int? = nil, _ str: String, penalty: Int? = nil) {
        warnings.append(Message(location: loc, str: str, penalty: penalty))
    }
}

public func validate(_ routine: Routine) -> ErrorLog {
    let err = ErrorLog()
    validateSpecialRequirements(routine, err)
    return err
}

// Section G.
// Section I.
public func validateSpecialRequirements(_ routine: Routine, _ err: ErrorLog) {
    validateMinSkills(routine, err)
    validateMinHandstands(routine, err)
    validateSupports(routine, err)
    validateDifficulty(routine, err)
    // TODO: warn about consecutive repeats- they must have variations
}

public func validateMinSkills(_ routine: Routine, _ err: ErrorLog) {
    let required = [5, 7, 10, 10, 10][routine.level.index]
    let skillCount = routine.skills.count
    if skillCount < required {
        err.err(
            "Not enough skills: \(skillCount) / \(required).",
            penalty: 10 * (required - skillCount)
        )
    } else if skillCount > required {
        err.warn(
            "Too many skills, skills past the limit are ignored: \(skillCount) / \(required)."
        )
    }
}

public func validateMinHandstands(_ routine: Routine, _ err: ErrorLog) {
    let required = [0, 1, 2, 3, 4][routine.level.index]
    let uniqueHandstands = Set(routine.skills.filter { $0.isHandstand }).count
    if uniqueHandstands < required {
        err.err(
            "Not enough handstands: \(uniqueHandstands) / \(required).",
            penalty: 10
        )
    }
}

public func validateSupports(_ routine: Routine, _ err: ErrorLog) {
    switch routine.level {
    case .bronze, .silver, .gold:
        return
    case .platinum:
        let supports = Set(routine.skills.map { $0.support }).count
        if supports >= 2 { return }
        err.err(
            "Not enough points of support: \(supports) / 2.",
            penalty: 10
        )
        return
    case .diamond:
        let hasOneArmHandstand = routine.skills.contains
            { $0.isHandstand && $0.support == .oneArm }
        if hasOneArmHandstand { return }
        err.err(
            "Missing one arm handstand.",
            penalty: 10
        )
    }
}

public func validateDifficulty(_ routine: Routine, _ err: ErrorLog) {
    // Min difficulty only applies to platinum, but it is recommended to
    // achieve max difficulty otherwise.
    // Going over max difficulty is perfectly fine.
    let minDifficulty = [nil, nil, nil, nil, 75][routine.level.index]
    let maxDifficulty = [10, 25, 45, 65, nil][routine.level.index]
    let tariff = TariffSheet(routine)
    let difficulty = tariff.difficultyValue
    if let minDifficulty = minDifficulty, difficulty < minDifficulty {
        err.err(
            "Missing minimum difficulty: \(difficulty) / \(minDifficulty).",
            penalty: 10
        )
    }
    if let maxDifficulty = maxDifficulty, difficulty < maxDifficulty {
        err.warn(
            "Below maximum difficulty: \(difficulty) / \(maxDifficulty)."
        )
    }
}
