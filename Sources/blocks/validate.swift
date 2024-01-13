
struct Message {
    var location: Int?
    var str: String
    // Measured in tenths of a point.
    var penalty: Int?
}

class ErrorLog {
    var errors: [Message] = []
    var warnings: [Message] = []

    func err(loc: Int? = nil, _ str: String, penalty: Int? = nil) {
        errors.append(Message(location: loc, str: str, penalty: penalty))
    }

    func warn(loc: Int? = nil, _ str: String, penalty: Int? = nil) {
        warnings.append(Message(location: loc, str: str, penalty: penalty))
    }
}

func validate(_ routine: Routine) -> ErrorLog {
    let err = ErrorLog()
    validateSpecialRequirements(routine, err)
    return err
}

// Section G.
// Section I.
func validateSpecialRequirements(_ routine: Routine, _ err: ErrorLog) {
    validateMinSkills(routine, err)
    validateMinHandstands(routine, err)
    // validateMinSupports(routine, err)
    // validateMinOneArms(routine, err)
    // validateMinDifficulty(routine, err)
}

func validateMinSkills(_ routine: Routine, _ err: ErrorLog) {
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

func validateMinHandstands(_ routine: Routine, _ err: ErrorLog) {
    let required = [0, 1, 2, 3, 4][routine.level.index]
    let uniqueHandstands = Set(routine.skills.filter { $0.isHandstand }).count
    if uniqueHandstands < required {
        err.err(
            "Not enough handstands: \(uniqueHandstands) / \(required).",
            penalty: 10
        )
    }
}

