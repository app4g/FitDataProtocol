//
//  RowExerciseName.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/16/19.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

/// Row Exercise Name
public struct RowExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = RowExerciseName

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension RowExerciseName: Hashable {

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    public var hashValue: Int {
        return name.hashValue ^ number.hashValue
    }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: RowExerciseName, rhs: RowExerciseName) -> Bool {
        return lhs.name == rhs.name &&
            lhs.number == rhs.number
    }
}

public extension RowExerciseName {

    /// List of Supported ExerciseNames
    public static var supportedExerciseNames: [RowExerciseName] {

        return [.barbellStraightLegDeadliftRow,
                .cableRowStanding,
                .dumbbellRow,
                .elevatedFeetInvertedRow,
                .weightedElevatedFeetInvertedRow,
                .facePull,
                .facePullExternalRotation,
                .intertedRowFeetSwissBall,
                .weightedIntertedRowFeetSwissBall,
                .kettlebellRow,
                .modifiedInvertedRow,
                .weightedModifiedInvertedRow,
                .neutralGripAlternatingDumbbellRow,
                .oneArmBentOverRow,
                .oneLeggedDumbbellRow,
                .renegadeRow,
                .reverseGripBarbellRow,
                .ropeHandleCableRow,
                .seatedCableRow,
                .seatedDumbbellRow,
                .singleArmCableRow,
                .singleArmCableRowRotation,
                .singleArmInvertedRow,
                .weightedSingleArmInvertedRow,
                .singleArmNeutralGripDumbbellRowRotation,
                .suspendedInvertedRow,
                .weightedSuspendedInvertedRow,
                .tBarRow,
                .towelGripInvertedRow,
                .weightedTowelGripInvertedRow,
                .underhandGripCableRow,
                .vGripCableRow,
                .wideGripSeatedCableRow
        ]
    }
}

public extension RowExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    public static func create(rawValue: UInt16) -> RowExerciseName? {

        for name in RowExerciseName.supportedExerciseNames {
            if name.number == rawValue {
                return name
            }
        }

        return nil
    }
}

// MARK: - Exercise Types
public extension RowExerciseName {

    /// Barbell Straight Leg Deadlift to Row
    public static var barbellStraightLegDeadliftRow: RowExerciseName {
        return RowExerciseName(name: "Barbell Straight Leg Deadlift to Row", number: 0)
    }

    /// Cable Row Standing
    public static var cableRowStanding: RowExerciseName {
        return RowExerciseName(name: "Cable Row Standing", number: 1)
    }

    /// Dumbbell Row
    public static var dumbbellRow: RowExerciseName {
        return RowExerciseName(name: "Dumbbell Row", number: 2)
    }

    /// Elevated Feet Inverted Row
    public static var elevatedFeetInvertedRow: RowExerciseName {
        return RowExerciseName(name: "Elevated Feet Inverted Row", number: 3)
    }

    /// Weighted Elevated Feet Inverted Row
    public static var weightedElevatedFeetInvertedRow: RowExerciseName {
        return RowExerciseName(name: "Weighted Elevated Feet Inverted Row", number: 4)
    }

    /// Face Pull
    public static var facePull: RowExerciseName {
        return RowExerciseName(name: "Face Pull", number: 5)
    }

    /// Face Pull with External Rotation
    public static var facePullExternalRotation: RowExerciseName {
        return RowExerciseName(name: "Face Pull with External Rotation", number: 6)
    }

    /// Inverted Row with Feet on Swiss Ball
    public static var intertedRowFeetSwissBall: RowExerciseName {
        return RowExerciseName(name: "Inverted Row with Feet on Swiss Ball", number: 7)
    }

    /// Weighted Inverted Row with Feet on Swiss Ball
    public static var weightedIntertedRowFeetSwissBall: RowExerciseName {
        return RowExerciseName(name: "Weighted Inverted Row with Feet on Swiss Ball", number: 8)
    }

    /// Kettlebell Row
    public static var kettlebellRow: RowExerciseName {
        return RowExerciseName(name: "Kettlebell Row", number: 9)
    }

    /// Modified Inverted Row
    public static var modifiedInvertedRow: RowExerciseName {
        return RowExerciseName(name: "Modified Inverted Row", number: 10)
    }

    /// Weighted Modified Inverted Row
    public static var weightedModifiedInvertedRow: RowExerciseName {
        return RowExerciseName(name: "Weighted Modified Inverted Row", number: 11)
    }

    /// Neutral Grip Alternating Dumbbell Row
    public static var neutralGripAlternatingDumbbellRow: RowExerciseName {
        return RowExerciseName(name: "Neutral Grip Alternating Dumbbell Row", number: 12)
    }

    /// One Arm Bent Over Row
    public static var oneArmBentOverRow: RowExerciseName {
        return RowExerciseName(name: "One Arm Bent Over Row", number: 13)
    }

    /// One Legged Dumbbell Row
    public static var oneLeggedDumbbellRow: RowExerciseName {
        return RowExerciseName(name: "One Legged Dumbbell Row", number: 14)
    }

    /// Renegade Row
    public static var renegadeRow: RowExerciseName {
        return RowExerciseName(name: "Renegade Row", number: 15)
    }

    /// Reverse Grip Barbrell Row
    public static var reverseGripBarbellRow: RowExerciseName {
        return RowExerciseName(name: "Reverse Grip Barbrell Row", number: 16)
    }

    /// Rope Handle Cable Row
    public static var ropeHandleCableRow: RowExerciseName {
        return RowExerciseName(name: "Rope Handle Cable Row", number: 17)
    }

    /// Seated Cable Row
    public static var seatedCableRow: RowExerciseName {
        return RowExerciseName(name: "Seated Cable Row", number: 18)
    }

    /// Seated Dumbbell Row
    public static var seatedDumbbellRow: RowExerciseName {
        return RowExerciseName(name: "Seated Dumbbell Row", number: 19)
    }

    /// Single Arm Cable Row
    public static var singleArmCableRow: RowExerciseName {
        return RowExerciseName(name: "Single Arm Cable Row", number: 20)
    }

    /// Single Arm Cable Row and Rotation
    public static var singleArmCableRowRotation: RowExerciseName {
        return RowExerciseName(name: "Single Arm Cable Row and Rotation", number: 21)
    }

    /// Single Arm Inverted Row
    public static var singleArmInvertedRow: RowExerciseName {
        return RowExerciseName(name: "Single Arm Inverted Row", number: 22)
    }

    /// Weighted Single Arm Inverted Row
    public static var weightedSingleArmInvertedRow: RowExerciseName {
        return RowExerciseName(name: "Weighted Single Arm Inverted Row", number: 23)
    }

    /// Single Arm Neutral Grip Dumbbell Row and Rotation
    public static var singleArmNeutralGripDumbbellRowRotation: RowExerciseName {
        return RowExerciseName(name: "Single Arm Neutral Grip Dumbbell Row and Rotation", number: 25)
    }

    /// Suspended Inverted Row
    public static var suspendedInvertedRow: RowExerciseName {
        return RowExerciseName(name: "Suspended Inverted Row", number: 26)
    }

    /// Weighted Suspended Inverted Row
    public static var weightedSuspendedInvertedRow: RowExerciseName {
        return RowExerciseName(name: "Weighted Suspended Inverted Row", number: 27)
    }

    /// T Bar Row
    public static var tBarRow: RowExerciseName {
        return RowExerciseName(name: "T Bar Row", number: 28)
    }

    /// Towel Grip Inverted Row
    public static var towelGripInvertedRow: RowExerciseName {
        return RowExerciseName(name: "Towel Grip Inverted Row", number: 29)
    }

    /// Weighted Towel Grip Inverted Row
    public static var weightedTowelGripInvertedRow: RowExerciseName {
        return RowExerciseName(name: "Weighted Towel Grip Inverted Row", number: 30)
    }

    /// Underhand Grip Cable Row
    public static var underhandGripCableRow: RowExerciseName {
        return RowExerciseName(name: "Underhand Grip Cable Row", number: 31)
    }

    /// V Grip Cable Row
    public static var vGripCableRow: RowExerciseName {
        return RowExerciseName(name: "V Grip Cable Row", number: 32)
    }

    /// Wide Grip Seated Cable Row
    public static var wideGripSeatedCableRow: RowExerciseName {
        return RowExerciseName(name: "Wide Grip Seated Cable Row", number: 33)
    }

}
