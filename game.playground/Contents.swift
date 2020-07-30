import UIKit

//We are building a dice game called Knock Out!. It is played using the following rules:
//1 Each player chooses a "knock out number" - either 6,7,8,9. More than one player can choose the same number.
//2 Players take turns throwing both dice, once each turn. Add the number of both dice to the player's running score.
//3. If a player rolls their own knock out number, they are knocked out of the game.#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//4 Play ends when either all players have been knocked out, or if a singler player scores 100 points or higher.

protocol GeneratesRandomNumber {
    func random() -> Int
}

class OneThroughTen: GeneratesRandomNumber {
    func random() -> Int {
        return Int.random(in: 1...10)
    }
}

class OneThroughOneHundred: GeneratesRandomNumber {
    func random() -> Int {
        return Int.random(in: 1...100)
    }
}

class Dice {
    let sides: Int
    let generator: GeneratesRandomNumber  // ANYTHING that conforms to this protocol can be the value for generator
    
    init(sides: Int, generator: GeneratesRandomNumber){
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        let rolledNumber = generator.random() % sides + 1
        return rolledNumber
    }
}

// These are the requirements for any dice game that we could play.
protocol DiceGame {
    var dice: Dice { get }
    func play()
}

// create a custoemr class for trackinga player in our dice game.

class Player {
    let id: Int
    let KnockOutNumber: Int
    var score = 0
    var isKnockedOut = false
    
    init(id: Int){
        self.id = id
        self.KnockOutNumber = Int.random(in: 6...9)
        
    }
}

class KnockOut: DiceGame {
    var dice: Dice = Dice(sides: 6, generator: OneThroughTen())
    var players: [Player] = []
    
    init(_ numberOfPlayers: Int){
        for playerId in 1...numberOfPlayers {
            let player = Player(id: playerId)
            players.append(player)
        }
    }
    
    func play() {
        var gameHasEnd = false
        
        while gameHasEnd == false {
            
            for player in players {
                
                guard player.isKnockedOut == false else { continue }
                
                let diceRoll = dice.roll() + dice.roll()
                
                if diceRoll == player.KnockOutNumber {
                    print("Player \(player.id) is knocked out by rolling a \(diceRoll)")
                    player.isKnockedOut == true
                    
                    // check if everyone else is also knocked out.
                    let activePlayers = players.filter({ $0.isKnockedOut == false}) //$0 is every player
                    
                    //same thing as above
//                    var activePlayers: [Player] = []
//
//                    for player in players {
//                        if player.isKnockedOut == false {
//                            activePlayers.append(player)
//                        }
//                    }
                    
                    if activePlayers.count == 0 {
                        gameHasEnd = true
                        print("The game has ended. All players have been knocked out")
                    }
                    
                    
                } else {
                    player.score += diceRoll
                    if player.score >= 100 {
                        gameHasEnd = true
                        print("Player \(player.id) has won with a final score of \(player.score)")
                        break
                    }
                }
            }
        }
    }
}

let game = KnockOut(20)
game.play()
