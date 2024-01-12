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
}
