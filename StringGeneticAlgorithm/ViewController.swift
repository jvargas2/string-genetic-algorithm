//
//  ViewController.swift
//  StringGeneticAlgorithm
//
//  Created by Jorge Vargas on 5/22/16.
//  Copyright © 2016 Jorge Vargas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    @IBOutlet weak var targetTextField: UITextField!
    @IBOutlet weak var runButton: UIButton!
    @IBOutlet weak var currentGenerationTextLabel: UILabel!
    @IBOutlet weak var bestIndividualTextLabel: UILabel!
    @IBOutlet weak var generationSlider: UISlider!
    
    private var currentGenerationIndex = 0
    private var generations = [Population]()
    private var solutionFound = false
    
    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.targetTextField.text = "Genetic algorithms in Swift"
        self.targetTextField.delegate = self
        
        runGeneticAlgorithm()
    }
    
    func updateView() {
        let bestIndividual = generations[currentGenerationIndex].bestIndividual
        self.currentGenerationTextLabel.text = "Generation " + String(self.currentGenerationIndex)
        self.bestIndividualTextLabel.text = bestIndividual.value
    }
    
    func runGeneticAlgorithm() {
        self.solutionFound = false
        self.generations = [Population]()
        self.currentGenerationIndex = 0
        self.generationSlider.value = Float(self.currentGenerationIndex)
        self.generations.append(Population(targetValue: self.targetTextField.text))
        
        while self.solutionFound == false {
            self.generations.append(self.generations.last!.breedNewGeneration())
            
            if self.generations.last!.bestIndividual.value == self.targetTextField.text {
                self.solutionFound = true
            } else if self.generations.count > 500 {
                self.solutionFound = true
            }
        }
        
        self.generationSlider.maximumValue = Float(generations.count - 1)
        self.updateView()
    }
    
    @IBAction func runButtonPressed(sender: UIButton) {
        runGeneticAlgorithm()
        view.endEditing(true)
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        self.currentGenerationIndex = Int(sender.value)
        self.updateView()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        runGeneticAlgorithm()
        self.view.endEditing(true)
        return false
    }
}


// MARK: Structs
struct Population {
    var individuals = [Individual]()
    var bestIndividual: Individual!
    
    init(targetValue: String!) {
        for i in 0...19 {
            let newIndividual = Individual(targetString: targetValue)
            self.individuals.append(newIndividual)
            if i == 0 {
                self.bestIndividual = newIndividual
            } else if newIndividual.fitnessScore < bestIndividual.fitnessScore {
                self.bestIndividual = newIndividual
            }
        }
    }
    
    init(individuals: Array<Individual>) {
        self.individuals = individuals
        self.bestIndividual = self.individuals[0]
        for ind in self.individuals {
            if ind.fitnessScore < self.bestIndividual.fitnessScore {
                self.bestIndividual = ind
            }
        }
    }
    
    func breedNewGeneration() -> Population {
        var newIndividuals = [Individual]()
        var remainingIndividuals = self.individuals
        
        for _ in 0...((self.individuals.count / 2) - 1) {
            let firstIndex = Int(arc4random_uniform(UInt32(remainingIndividuals.count - 1)))
            let firstIndividual = remainingIndividuals[firstIndex]
            remainingIndividuals.removeAtIndex(firstIndex)
            let secondIndex = Int(arc4random_uniform(UInt32(remainingIndividuals.count - 1)))
            let secondIndividual = remainingIndividuals[secondIndex]
            var fitterInd: Individual
            
            if firstIndividual.fitnessScore < secondIndividual.fitnessScore {
                fitterInd = firstIndividual
            } else if secondIndividual.fitnessScore < firstIndividual.fitnessScore {
                fitterInd = secondIndividual
            } else {
                let randomBool = arc4random_uniform(2) == 0 ? true : false
                if randomBool {
                    fitterInd = firstIndividual
                } else {
                    fitterInd = secondIndividual
                }
            }
            
            newIndividuals.append(fitterInd)
            let newInd = firstIndividual.breedWith(secondIndividual)
            if (Int(arc4random_uniform(10)) > 7) {
                newInd.mutate()
            }
            newIndividuals.append(newInd)
        }
        
        return Population(individuals: newIndividuals)
    }
}


