//
//  Individual.swift
//  StringGeneticAlgorithm
//
//  Created by Jorge Vargas on 5/22/16.
//  Copyright © 2016 Jorge Vargas. All rights reserved.
//

import Foundation

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
    
    private func calculateFitnessScore() -> Float {
        let fitnessScore:Float = 0.0
        
        // TODO: calculate fitness score
        
        return fitnessScore
    }
    
    func breedWith(otherInd: Individual) -> Individual {
        let newValue = ""
        
        // TODO: breed new set of genes
        
        return Individual(value: newValue, targetString: self.target)
    }
    
    func mutate() {
        self.value = ""
        
        // TODO: mutate new set of genes
        
        self.fitnessScore = self.calculateFitnessScore()
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

