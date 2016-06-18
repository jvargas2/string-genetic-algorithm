//
//  Individual.swift
//  StringGeneticAlgorithm
//
//  Created by Jorge Vargas on 5/22/16.
//  Copyright © 2016 Jorge Vargas. All rights reserved.
//

import UIKit

class Individual {
    
    //MARK: Properties
    var value = ""
    var fitnessScore: Float!
    private var target: String!
    
    init(targetString: String) {
        self.target = targetString
        for _ in 0...(targetString.characters.count - 1) {
            let newGeneInt = Int(arc4random_uniform(95)) + 32
            let newGeneChar = Character(UnicodeScalar(newGeneInt))
            self.value.append(newGeneChar)
        }
        self.fitnessScore = self.calculateFitnessScore()
    }
    
    init(value: String, targetString: String) {
        self.value = value
        self.target = targetString
        self.fitnessScore = self.calculateFitnessScore()
    }
    
    func breedWith(otherInd: Individual) -> Individual {
        var newValue = ""
        let selfArray = Array(self.value.characters)
        let otherArray = Array(otherInd.value.characters)
        let targetArray = Array(self.target.characters)
        
        for (i, char) in selfArray.enumerate() {
            let s = Int(char.utf8Value())
            let o = Int(otherArray[i].utf8Value())
            let t = Int(targetArray[i].utf8Value())
            let betterInt = abs(s - t) < abs(o - t) ? s : o
            newValue.append(Character(UnicodeScalar(betterInt)))
        }
        return Individual(value: newValue, targetString: self.target)
    }
    
    func mutate() {
        self.value = ""
        
        for _ in 0...(self.target.characters.count - 1) {
            let newGeneInt = Int(arc4random_uniform(95)) + 32
            let newGeneChar = Character(UnicodeScalar(newGeneInt))
            self.value.append(newGeneChar)
        }
        
        //        let mIndex = Int(arc4random_uniform(UInt32(self.target.characters.count - 1)))
        //        var valueArray = Array(self.value.characters)
        //        let newGeneInt = Int(arc4random_uniform(95)) + 32
        //        let newGeneChar = Character(UnicodeScalar(newGeneInt))
        //        valueArray[mIndex] = newGeneChar
        //        self.value = String(valueArray)
        
        self.fitnessScore = self.calculateFitnessScore()
    }
    
    private func calculateFitnessScore() -> Float {
        let selfArray = Array(self.value.characters)
        let targetArray = Array(self.target.characters)
        var totalValue = 0
        for (i, char) in selfArray.enumerate() {
            let s = Int(char.utf8Value())
            let t = Int(targetArray[i].utf8Value())
            totalValue += abs(s - t)
        }
        return Float(totalValue) / Float(selfArray.count)
    }
}

// Adapted from http://stackoverflow.com/questions/24102044/how-can-i-get-the-unicode-code-points-of-a-character
extension String {
    func unicodeScalarCodePoint() -> UInt32 {
        let scalars = self.unicodeScalars
        return scalars[scalars.startIndex].value
    }
}

// Adapted from http://stackoverflow.com/questions/24463992/converting-character-in-an-array-to-an-integer
extension Character {
    func utf8Value() -> UInt8 {
        for s in String(self).utf8 {
            return s
        }
        return 0
    }
}

