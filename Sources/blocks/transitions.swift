
// Recall the 7 categories:
// pike croc planche handstand arch yogi flag

fileprivate let X = 0;

// The value of a transition from one Category to another.
// transitions[support][start][end]
static let transitions: [[[Int]]] = [
    // Two Arms
    [
    [0, 0, 0, 3, 3, 3, 3], // from pike
    [0, 0, 5, 5, 5, 5, 5], // from croc
    [0, 3, 0, 3, 3, 3, 3], // from planche
    [2, 3, 2, 0, 0, 0, 0], // from handstand
    [2, 3, 2, 0, 0, 0, 0], // from arch
    [2, 3, 2, 0, 0, 0, 0], // from yogi
    [2, 3, 2, 0, 0, 0, 0], // from flag
    ],

    // 2:1 Arm
    [
    [0, 0, 0, 6, 6, 6, 6], // from pike
    [0, 0, 8, 8, 8, 8, 8], // from croc
    [0, 5, 0, 6, 6, 6, 6], // from planche
    [4, 5, 4, 0, 0, 0, 0], // from handstand
    [4, 5, 4, 0, 0, 0, 0], // from arch
    [4, 5, 4, 0, 0, 0, 0], // from yogi
    [4, 5, 4, 0, 0, 0, 0], // from flag
    ],

    // 1 Arm
    [
    [ 0,  3,  X, 20, 20, 20, 20], // from pike
    [ 2,  0,  X, 18, 18, 18, 18], // from croc
    [ X,  X,  X,  X,  X,  X,  X], // from planche
    [12, 12,  X,  3,  6,  6,  6], // from handstand
    [12, 12,  X,  6,  3,  6,  6], // from arch
    [12, 12,  X,  6,  6,  3,  6], // from yogi
    [12, 12,  X,  6,  6,  6,  3], // from flag
    ],
]

