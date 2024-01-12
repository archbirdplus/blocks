
// MARK:
// Represents the most granular type of skill that is still recognized
// as distinct- groups together variations that are considered interchangeable,
// but still separates skills with different difficulties.
struct Skill {
   // The point of support of the skill.
   enum Support {
      case twoArm
      case twoToOne
      case oneArm
   }

   // The category this skill falls under when calculating transition difficulty.
   enum Category {
      case pike
      case croc
      case planche // one arm planche is not a valid skill
      case handstand
      case arch
      case yogi
      case flag
   }

   let name: String
   let difficulty: Int
   let category: Category
   let support: Support

   init(_ name: String, _ diff: Int, _ category: Category, _ support: Support = .twoArm) {
      self.name = name
      self.difficulty = diff
      self.category = category
      self.support = support
   }
}

extension Skill {
   // A list of every valid skill in the Xcel Blocks Code of Points
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
      Skill("Ring", 5, .arch),
      Skill("Yogi", 5, .yogi),
      Skill("Arch FT", 6, .arch),
      Skill("Flag", 6, .flag),
      Skill("Overarch", 6, .arch),
      Skill("Yogi FT", 6, .yogi),
      Skill("High Russian Lever FT", 7, .pike),
      Skill("Side Flag", 7, .flag),
      Skill("Split Planche", 7, .planche),
      Skill("Overarch FT", 8, .arch),
      Skill("Planche", 10, .planche),
      Skill("Flag FT", 12, .flag),
      Skill("Overflag", 12, .flag),
      Skill("Planche FT", 17, .planche),

      // 2:1 Arm
      Skill("2:1 Straddle", 3, .pike, .twoToOne),
      Skill("2:1 Croc", 4, .croc, .twoToOne),
      Skill("2:1 Croc FT", 5, .croc, .twoToOne),
      Skill("2:1 Handstand", 10, .handstand, .twoToOne),
      Skill("2:1 Arch", 11, .arch, .twoToOne),
      Skill("2:1 Flag", 11, .flag, .twoToOne),
      Skill("2:1 Ring", 12, .arch, .twoToOne),
      Skill("2:1 Arch FT", 12, .arch, .twoToOne),
      Skill("2:1 Overarch", 12, .arch, .twoToOne),
      Skill("2:1 Yogi", 12, .yogi, .twoToOne),
      Skill("2:1 Split Planche", 13, .planche, .twoToOne),
      Skill("2:1 Overarch FT", 14, .arch, .twoToOne),
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
      Skill("1-Arm Ring", 15, .arch, .oneArm),
      Skill("1-Arm Arch FT", 16, .arch, .oneArm),
      Skill("1-Arm Split Arch", 16, .arch, .oneArm),
      Skill("1-Arm Side Flag", 16, .flag, .oneArm),
      Skill("1-Arm Split Flag Above", 17, .flag, .oneArm),
      Skill("1-Arm Split Flag Below", 17, .flag, .oneArm),
      Skill("1-Arm Flag FT", 18, .flag, .oneArm),
      Skill("1-Arm Overflag", 18, .flag, .oneArm),
      Skill("1-Arm Overarch", 19, .arch, .oneArm),
      Skill("1-Arm Overarch FT", 20, .arch, .oneArm),
   ]
}

