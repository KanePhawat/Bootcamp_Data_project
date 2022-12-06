chatbot <- function(){
  action <- 0
  pizza_order <- as.character()
  size <- as.character()
  price <- as.numeric()
  while (action < 3){
    print("[1]menu [2]order now [3]Bill:")
    action <- as.numeric(readLines("stdin",n=1))
    # show menu
    if (action==1){
      print("------------Pizza menu-------------")
      print("  1.Ham & Mushroom 2.Four Cheese   ")
      print("  3.Pepperoni      4.Chicken BBQ   ")
      print(" [size S = 389฿ M = 439฿ L = 519฿] ")
      print("-----------------------------------")
    }# order pizza
    else if (action==2){
      print("What would you like to order some pizza?(type the menu number):")
      step1 <- as.numeric(readLines("stdin",n=1))
      if (step1 == 1){
        pizza_topping <- "Ham & Mushroom"
      }else if (step1 == 2){
        pizza_topping <- "Four Cheese"
      }else if (step1 == 3){
        pizza_topping <- "Pepperoni"
      }else if (step1 == 4){
        pizza_topping <- "Chicken BBQ"
      }
      
      # choose size 
      print("What size?[S/M/L]:")
      step2 <- toupper(readLines("stdin",n=1))
      if (step2 =="S"){   
        pizza_size <- "S"
        pizza_price <- 389
      }else if (step2 == "M"){
        pizza_size <- "M"
        pizza_price <- 439
      }else if (step2 == "L"){
        pizza_size <- "L"
        pizza_price <- 519
      }

      #Confirm/Cancle
      print("Confirm order[Y/N]:")
      step3 <- toupper(readLines("stdin",n=1))
      if (step3 =="Y"){
        print("confirmed this order")
        pizza_order <- append(pizza_order,as.character(pizza_topping))
        size <- append(size,pizza_size)
        price <- append(price,pizza_price)
        print("Do you want to order more?")
      }else if (step3 =="N"){
        print("cancled this order")
        print("Do you want to order more?")
      }
    }

    # bill
    else if (action==3){
      pizza_data <- data.frame(pizza_order,size,price)
      print("[1]Cash [2]Credit card:")
      payment <- as.numeric(readLines("stdin",n=1))
      if (payment == 2){
        change <- "Credit Card"
        print("         =Kane's Pizza=          ")
        print("---------------------------------")
        print("             RECEIPT             ")
        print("---------------------------------")      
        print(paste("Customer name: Khun.",customer))
        print(pizza_data)
        print("---------------------------------")
        print(paste("Total:",sum(price)," ฿"))
        print(paste("Payment:",change))
        print("         Enjoy your meal         ")
        print("------------THANK YOU------------")

      }else {
        print("Amount:")
        cash <- as.numeric(readLines("stdin",n=1))
        change <- cash - sum(price)
        print("         =Kane's Pizza=          ")
        print("---------------------------------")
        print("          CASH RECEIPT           ")
        print("---------------------------------")      
        print(paste("Customer name: Khun.",customer))
        print(pizza_data)
        print("---------------------------------")
        print(paste("Total :",sum(price)," ฿"))
        print(paste("Cash  :",cash," ฿"))
        print(paste("Change:",change," ฿"))
        print("         Enjoy your meal         ")
        print("------------THANK YOU------------")
      }
    }
  }
}
chatbot()
