# Pao Ying Shub
print("--------------------Pao Ying Shub game--------------------")
 
# Greeting 
print("What is your name?")
player_name <- readLines("stdin",n=1)
print(paste("Halo! Khun.",player_name,"Glad to meet you"))

# Defining
win_p <- 0
winAI <- 0
draw <- 0
times <- 0

#Start the game
print("Would you like to start game now?[Y/N]")
action1 <-readLines("stdin",n=1)
while (tolower(action1) == 'y'){
  print("Before going to start the game, please read the basic rules.")
  print("enter 'r' for Rock")
  print("enter 's' for Scissors")  
  print("enter 'p' for Paper")
  print("enter 'q' to end the game")
  print("-------------------------------------------------------")
  print("Let's start!!")
  while (TRUE){
    cards <- c("r","s","p")
    names(cards) <- c("Rock","Scissors","Paper")
    print(paste("What do your choose"))
    player <-readLines("stdin",n=1)
    AI <- sample(cards,1)
    # Draw
    if (tolower(player) == AI) {
      print(paste("AI:",names(AI)))
      print("Draw!!")
      print("--------------------")
      draw <- draw+1
      times <- times+1
    } #Player win
    else if ((tolower(player) == "r" & AI == "s") ||
            (tolower(player) == "s" & AI == "p") ||
            (tolower(player) == "p" & AI == "r"))
    { print(paste("AI:",names(AI)))
      print("You wins!")
      print("--------------------")
      win_p <- win_p+1 
      times <- times+1    
    } #AI win
    else if ((tolower(player) == "r" & AI == "p") ||
            (tolower(player) == "s" & AI == "r") ||
            (tolower(player) == "p" & AI == "s"))
    { print(paste("AI:",names(AI)))
      print("You lose!")
      print("--------------------")
      winAI <- winAI+1 
      times <- times+1   
    } else if (toupper(player) =="Q") {
      break
    } else {
      print("!!INCORRECT WORD!! Please try again")
    }
  }
  # summarize
  print("---------------------TOTAL SCORES---------------------")
  print(paste("Playing times:  ",times,"times"))
  print(paste("Player Wins:    ",win_p,"times"))
  print(paste("AI Wins:        ",winAI,"times"))
  print(paste("Draws:          ",draw,"times"))
  print("======================================================")
  if (win_p > winAI){
    print(paste("**",player_name,"Wins!! **"))
  } else if(win_p<winAI){
    print(paste("** AI Wins!! **"))
  } else{
    print(paste("** Draw!! **"))
  }
  print("======================================================")
  print("Thank you playing, see ya!")
  break
}
print("Quit the game")
