//BlackForce exercise

public class GuessGame {
    
    Integer computerGuess = Integer.valueof(Math.floor((Math.random() * 10) + 1));
    Integer totalGuessAvailable = 5;
    Integer usedGuess = 0;
    
    public String play(Integer userGuess){
        usedGuess++;
        if(usedGuess > totalGuessAvailable){
           // System.debug('Game over you have exhuasted your guesses the computer guess was ' + computerGuess);
            return'Game over you have exhuasted your guesses the computer guess was ' + computerGuess;
            
        }
        
        Integer totalGuessLeft = totalGuessAvailable - usedGuess;
        if(userGuess > computerGuess){
            return 'Your guess is high, you have made ' + usedGuess + ' guesses  you have' + totalGuessLeft +' more guesses left to make';
            
            
        }else if(userGuess < computerGuess){
           return 'your guess is low, you have made  ' + usedGuess + ' you have ' + totalGuessLeft +' more guesses left to make';
            
        }else{
            return 'You guessed the correct number, your guess is ' + userGuess + ', and the computer guess is ' + computerGuess;
            
        }
        
        
    }
    
    
}