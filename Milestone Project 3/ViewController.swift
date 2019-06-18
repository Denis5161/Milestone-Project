//
//  ViewController.swift
//  Milestone Project 3
//
//  Created by Denis Goldberg on 18.06.19.
//  Copyright © 2019 Denis Goldberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var incorrectStringsView: UIView!
    var incorrectStringsViewHeightAnchorHidden: NSLayoutConstraint!
    var incorrectStringsViewHeightAnchorRevealed: NSLayoutConstraint!
    var guessLabel: UILabel!
    var incorrectGuessesLabel: UILabel!
    var scoreLabel: UILabel!
    var incorrectLettersLabel: UILabel!
    var incorrectWordsLabel: UILabel!
    
    var wordBank = [String]()
    var word = ""
    var promptWord = ""
    
    var incorrectLetters = [String]() {
        didSet {
            incorrectLettersLabel.text = "Incorrect letters:\n\(incorrectLetters.joined(separator: ", "))"
        }
    }
    var incorrectWords = [String]() {
        didSet {
            incorrectWordsLabel.text = "Incorrect words:\n\(incorrectWords.joined(separator: ", "))"
        }
    }
    var usedStr = [String]()
    var incorrectGuesses = 0 {
        didSet {
            incorrectGuessesLabel.text = "Incorrect Guesses: \(incorrectGuesses)"
            
        }
    }
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        incorrectGuessesLabel = UILabel()
        incorrectGuessesLabel.translatesAutoresizingMaskIntoConstraints = false
        incorrectGuessesLabel.textAlignment = .left
        incorrectGuessesLabel.text = "Incorrect Guesses: \(incorrectGuesses)"
        view.addSubview(incorrectGuessesLabel)
        
        guessLabel = UILabel()
        guessLabel.translatesAutoresizingMaskIntoConstraints = false
        guessLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        guessLabel.setContentCompressionResistancePriority(UILayoutPriority(1), for: .vertical)
        guessLabel.textAlignment = .center
        guessLabel.font = UIFont.systemFont(ofSize: 24)
        guessLabel.sizeToFit()
        guessLabel.numberOfLines = 0
        guessLabel.lineBreakMode = .byCharWrapping
        guessLabel.layer.borderWidth = 2
        guessLabel.layer.borderColor = UIColor.lightGray.cgColor
        guessLabel.layer.cornerRadius = 25
        view.addSubview(guessLabel)
        
        incorrectStringsView = UIView()
        incorrectStringsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(incorrectStringsView)
        incorrectStringsViewHeightAnchorHidden = incorrectStringsView.heightAnchor.constraint(equalToConstant: 0)
        incorrectStringsViewHeightAnchorHidden.isActive = true
        incorrectStringsViewHeightAnchorRevealed = incorrectStringsView.heightAnchor.constraint(equalToConstant: 150)
        
        incorrectLettersLabel = UILabel()
        incorrectLettersLabel.translatesAutoresizingMaskIntoConstraints = false
        incorrectLettersLabel.numberOfLines = 0
        incorrectLettersLabel.textAlignment = .left
        incorrectLettersLabel.font = UIFont.systemFont(ofSize: 24)
        incorrectLettersLabel.adjustsFontSizeToFitWidth = true
        incorrectStringsView.addSubview(incorrectLettersLabel)
        
        incorrectWordsLabel = UILabel()
        incorrectWordsLabel.translatesAutoresizingMaskIntoConstraints = false
        incorrectWordsLabel.numberOfLines = 0
        incorrectWordsLabel.textAlignment = .left
        incorrectWordsLabel.font = UIFont.systemFont(ofSize: 24)
        incorrectWordsLabel.adjustsFontSizeToFitWidth = true
        incorrectStringsView.addSubview(incorrectWordsLabel)
        
        let guessButton = UIButton(type: .system)
        guessButton.translatesAutoresizingMaskIntoConstraints = false
        guessButton.setTitle("Guess", for: .normal)
        guessButton.addTarget(self, action: #selector(guessTapped), for: .touchUpInside)
        guessButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        guessButton.layer.cornerRadius = 5
        view.addSubview(guessButton)
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            incorrectGuessesLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            incorrectGuessesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            
            guessLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 20),
            guessLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            guessLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            guessLabel.bottomAnchor.constraint(equalTo: incorrectStringsView.topAnchor),
            
            incorrectStringsView.topAnchor.constraint(equalTo: guessLabel.bottomAnchor),
            incorrectStringsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            incorrectStringsView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            incorrectStringsView.bottomAnchor.constraint(equalTo: guessButton.topAnchor),
            
            incorrectLettersLabel.topAnchor.constraint(equalTo: incorrectStringsView.topAnchor),
            incorrectLettersLabel.leadingAnchor.constraint(equalTo: incorrectStringsView.leadingAnchor),
            incorrectLettersLabel.trailingAnchor.constraint(equalTo: incorrectStringsView.trailingAnchor),
            incorrectLettersLabel.bottomAnchor.constraint(equalTo: incorrectStringsView.centerYAnchor),
            
            incorrectWordsLabel.heightAnchor.constraint(equalTo: incorrectLettersLabel.heightAnchor),
            incorrectWordsLabel.leadingAnchor.constraint(equalTo: incorrectStringsView.leadingAnchor),
            incorrectWordsLabel.trailingAnchor.constraint(equalTo: incorrectStringsView.trailingAnchor),
            incorrectWordsLabel.bottomAnchor.constraint(equalTo: incorrectStringsView.bottomAnchor),
            
            guessButton.bottomAnchor.constraint(greaterThanOrEqualTo: view.layoutMarginsGuide.bottomAnchor, constant: -50),
            guessButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            guessButton.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.5),
            guessButton.heightAnchor.constraint(equalToConstant: 50)
            
            ])
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadGame()
    }
    
    
    func loadGame(action: UIAlertAction? = nil) {
        var selectedLanguage = ""
        let ac = UIAlertController(title: "Choose Language", message: "Please choose a language from this list:", preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "German", style: .default, handler: { [weak self] _ in
            selectedLanguage = "german"
            self?.loadList(with: selectedLanguage)
        }))
        ac.addAction(UIAlertAction(title: "English", style: .default, handler: { [weak self] _ in
            selectedLanguage = "english"
            self?.loadList(with: selectedLanguage)
        }))
        ac.popoverPresentationController?.sourceView = view
        ac.popoverPresentationController?.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
        ac.popoverPresentationController?.permittedArrowDirections = [.up]
        
        present(ac, animated: true)
    }
    
    func loadList(with selectedLanguage: String) {
        print("Trying to load " + selectedLanguage)
        if let listOfWordsURL = Bundle.main.url(forResource: "\(selectedLanguage)Words", withExtension: "txt") {
            print("Found a url")
            if let listOfWordsContent = try? String(contentsOf: listOfWordsURL) {
                print("loaded the content")
                wordBank = listOfWordsContent.components(separatedBy: "\n")
                wordBank.removeLast()
                wordBank.shuffle()
                resetGame()
                
            }
        }
    }
    
    @objc func guessTapped(_ sender: UIButton) {
        let ac = UIAlertController(title: "Enter one letter", message: "Tip: You can also guess words", preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let characters = ac?.textFields?[0].text else { return }
            if characters == " " || characters.isEmpty { return }
            
            let range = NSRange(location: 0, length: characters.utf16.count)
            let regex = try? NSRegularExpression(pattern: "[A-Za-z]*[A-Za-z]")
            let characterCheck = regex?.firstMatch(in: characters, options: [], range: range)
            print(range)
            print(characterCheck?.range)
            
            //Check if the entered string contains a valid character AND that the range of valid characters is equal to the range of characters
            if characterCheck != nil && characterCheck?.range == range {
                self?.submit(characters)
            }
            else {
                self?.showErrorMessage(title: "Invalid Character", message: "The word only contains letters!")
            }
        }
        
        ac.addAction(submitAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
    
    func showErrorMessage(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    
    func submit(_ str: String) {
        let uppercasedStr = str.uppercased()
        
        if usedStr.contains(uppercasedStr) {
            let ac = UIAlertController(title: "Already used", message: "You have already entered this before!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
            return
        }
        
        usedStr.append(uppercasedStr)
        print("Used strings:  \(usedStr)")
        
        if uppercasedStr.count > 1 {
            if uppercasedStr == word {
                showSuccessMessage()
            } else {
                incorrectGuesses += 1
                incorrectWords.append(uppercasedStr)
            }
        } else {
            promptWord = ""
            for letter in word {
                if usedStr.contains(String(letter)) {
                    promptWord.append(letter)
                } else {
                    promptWord.append("_ ")
                }
            }
            switch promptWord {
            case word:
                showSuccessMessage()
            case guessLabel.text:
                incorrectGuesses += 1
                incorrectLetters.append(uppercasedStr)
            default:
                guessLabel.text = promptWord
            }
        }
        
        if incorrectGuesses > 7 {
            gameOver()
        } else if incorrectGuesses == 1 {
            animateIncorrectStringsView(hide: false)
        }
    }
    
    
    func presentWord(action: UIAlertAction? = nil) {
        wordBank.shuffle()
        let randomNumber = Int.random(in: 0..<wordBank.count)
        word = wordBank[randomNumber]
        print(randomNumber)
        print(word)
        usedStr.removeAll()
        incorrectWords.removeAll()
        incorrectLetters.removeAll()
        incorrectGuesses = 0
        animateIncorrectStringsView(hide: true)
        guessLabel.text = String(repeating: "_ ", count: word.count)
    }
    
    func resetGame() {
        score = 0
        presentWord()
        animateIncorrectStringsView(hide: true)
    }
    
    func gameOver() {
        let ac = UIAlertController(title: "Game Over", message: "You have guessed incorrectly too many times. You have failed. Word was: \(word)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: { [weak self]_ in self?.resetGame() }))
        present(ac, animated: true)
    }
    
    func showSuccessMessage() {
        score += 1
        let ac = UIAlertController(title: "Success!", message: "You have guessed the correct word: \(word)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Next Word", style: .default, handler: presentWord))
        present(ac, animated: true)
    }
    
    func animateIncorrectStringsView(hide: Bool) {
        print("Animating...")
        
        incorrectStringsViewHeightAnchorHidden.isActive = hide
        incorrectStringsViewHeightAnchorRevealed.isActive = !hide
        
        UIView.animate(withDuration: 0.2, animations: {
            self.incorrectStringsView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("Motion detected.")
            let ac = UIAlertController(title: "Change Language", message: "Resetting the language will delete all of your progress. Continue?", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: loadGame))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac, animated: true)
        }
    }
    
}

