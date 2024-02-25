import XCTest
@testable import blocks

final class blocksTests: XCTestCase {
    func testOver() {
        let arch = Skill.skills.first { $0.name == "Arch" }
        let overarch = Skill.skills.first { $0.name == "Overarch" }

        XCTAssertNotNil(arch)
        XCTAssertNotNil(overarch)
        XCTAssertFalse(arch!.over)
        XCTAssertTrue(overarch!.over)
    }

    func testNoOneArmPlanche() {
        Skill.skills.forEach { s in
            XCTAssertFalse(s.category == .planche && s.support == .oneArm)
        }
    }

    func testMinSkills() {
        let routine = Routine(skills: [.named("2:1 Straddle")!, .named("Straddle")!, .named("Tuck")!], level: .bronze)
        let err = validate(routine).errors
        let e = err.first { $0.str == "Not enough skills: 3 / 5." }
        XCTAssertNotNil(e)
        if let e = e {
            XCTAssertNil(e.location)
            XCTAssertEqual(e.penalty, 20)
        }
    }

    func testUniqueHandstands() {
        let routine = Routine(skills: [.named("2:1 Handstand")!, .named("1-Arm Handstand")!, .named("2:1 Handstand")!], level: .diamond)
        let err = validate(routine).errors
        let e = err.first { $0.str == "Not enough handstands: 2 / 4." }
        XCTAssertNotNil(e)
        if let e = e {
            XCTAssertNil(e.location)
            XCTAssertEqual(e.penalty, 10)
        }
    }

    func testMaxDifficulty() {
        let routine = Routine(skills: ["Straddle", "Pike", "Tuck", "Pike", "Tuck"].map { Skill.named($0)! }, level: .bronze)
        let tariff = TariffSheet(routine)
        XCTAssertEqual(tariff.difficultyValue, 8)
        let warnings = validate(routine).warnings
        let w = warnings.first { $0.str.contains("maximum difficulty") }
        XCTAssertNotNil(w)
        if let w = w {
            XCTAssertEqual(w.str, "Below maximum difficulty: 8 / 10.")
        }
    }
}
