//BlackForce exercise

public class GuessGame {
    // random method
    // range
    // unknown
    // getRandomInteger = 200;
    Integer computerGuess = Integer.valueof(Math.floor((Math.random() * 10) + 1));
    
    
    public String play(Integer userGuess){
        // compare userguess and computer guess if(ahkla === kj) else if c > u
        if(userGuess > computerGuess){
            System.debug('Your guess is high, try again');
            return 'Your guess is high, try again';
        }else if(userGuess < computerGuess){
            System.debug('your guess is low, try again.');
            return 'your guess is low, try again.';
        }else if(userGuess == computerGuess){
            System.debug('You guess the number correctly!');
            return 'You guess the number correctly!';
        }else{
            return 'come back later';
        }
        // if there's a match return 'You guess the number correctly!'
        // if not return either 'Your guess is high, try again'
        // your guess is low, try again.
    }
    
    
}