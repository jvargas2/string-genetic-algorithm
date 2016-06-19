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
        
//        while self.solutionFound == false {
//            self.generations.append(self.generations.last!.breedNewGeneration())
//            
//            if self.generations.last!.bestIndividual.value == self.targetTextField.text {
//                self.solutionFound = true
//            } else if self.generations.count > 2 {
//                self.solutionFound = true
//            }
//        }
        
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
        self.individuals.append(Individual(targetString: targetValue))
        self.individuals.append(Individual(targetString: targetValue))
        self.individuals.append(self.individuals[0].breedWith(self.individuals[1]))
        self.bestIndividual = self.individuals[0]
        for ind in self.individuals {
            print("\(ind.value): \(ind.fitnessScore)")
            if ind.fitnessScore < self.bestIndividual.fitnessScore {
                self.bestIndividual = ind
            }
        }
    }
    
    init(individuals: Array<Individual>) {
        // TODO: initialize from an array of individuals
    }
    
    func breedNewGeneration() -> Population {
        let newIndividuals = [Individual]()
        
        // TODO: breed new set of individuals
        
        return Population(individuals: newIndividuals)
    }
}


