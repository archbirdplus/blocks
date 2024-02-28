import blocks

class Searcher {
    let skillSet: [Skill]
    let level: Routine.Level
    let maxSkills: Int
    
    let skillDifficultyUpperBound: Int

    var orders: [[(Skill, Int)]]
    var maxDifficulty = 0
    var best: [Routine] = []

    init(_ skillSet: [Skill], level: Routine.Level) {
        self.skillSet = skillSet
        self.level = level
        self.maxSkills = [5, 7, 10, 10, 10][level.index]
        self.skillDifficultyUpperBound = skillSet.lazy
            .flatMap { a in skillSet.lazy.map { b in (a: a, b: b) } }
            .reduce(0) { r, x in
                max(r, skillValue(x.a) + skillValue(x.b) + transitionValue(x.a, to: x.b))
            }
        self.orders = (0..<maxSkills).map { _ in skillSet.map { ($0, 0) } }
    }

    func shortPrintRoutine(_ r: Routine) {
        print("\(r.introSkill?.name ?? "") : \(r.skills.map { $0.name }.joined(separator: ", "))")
    }

    func search() {
        let intros = [Skill.Category.pike, .croc, .planche, .handstand, .arch, .yogi, .flag]
            .lazy
            .flatMap { c in
                [Skill.Support.twoArm, .twoToOne, .oneArm].compactMap { s in
                    return self.skillSet
                        .first { $0.category == c && $0.support == s }
                }
            }
            .sorted { a, b in
                skillValue(a) > skillValue(b)
            }
        print("Selected \(intros.count) intros out of \(skillSet.count) skills.")
        for skill in intros {
            print("trying intro \(skill.name)")
            search(intro: skill, [], depth: 0)
        }
        search(intro: nil, [], depth: 0)
        print("final difficulty: \(maxDifficulty)")
        print("best routines:")
        best.forEach(shortPrintRoutine)
    }

    func score(intro: Skill?, _ skills: [Skill]) -> Int {
        let routine = Routine(introSkill: intro, skills: skills, level: level)
        let score = TariffSheet(routine).difficultyValue
        return score
    }

    func potentialScore(intro: Skill?, _ skills: [Skill]) -> Int {
        let remaining = maxSkills - skills.count
        let potential = remaining * skillDifficultyUpperBound
        let score = score(intro: intro, skills)
        return score + potential
    }

    func search(intro: Skill?, _ skills: [Skill], depth: Int) {
        assert(depth == skills.count)
        if skills.count == maxSkills {
            let routine = Routine(introSkill: intro, skills: skills, level: level)
            let score = TariffSheet(routine).difficultyValue
            if score == maxDifficulty {
                best.append(routine)
                print("tie x\(best.count)")
            } else if score > maxDifficulty {
                maxDifficulty = score
                best = [routine]
                print("new best! difficulty: \(score)")
                shortPrintRoutine(routine)
            }
        } else {
            var tmp = skills
            for i in 0..<orders[depth].count {
                let p = orders[depth][i]
                tmp.append(p.0)
                orders[depth][i].1 = potentialScore(intro: intro, tmp)
                tmp.removeLast()
            }
            orders[depth].sort { a, b in
                a.1 > b.1
            }
            for p in orders[depth] {
                // Prune
                if p.1 < maxDifficulty { return }
                tmp.append(p.0)
                search(intro: intro, tmp, depth: depth+1)
                tmp.removeLast()
            }
        }
    }
}

