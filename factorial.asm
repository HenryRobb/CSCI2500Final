/Step 0: Start With N, Load N-1 into Num
/Step 1: Run Mult two num with N and Num
/Step 2: Store That into Prod
/Step 3: Decrement Num
/Step 4: Move Prod into Neg
/Step 5: Halt if B = 0
/Step 6: Jump back to Step 1




    
    Load        N          / Load N into AC
    Add         Neg1
    Store       Num        / Store the number of loop iterations in loop control variable

Loop2,Load Num
    Store Ctr

Loop, Load    Prod       / Load the product into AC
    Add       N          / Add the multiplicand
    Store     Prod       / Store the new product
    Load      Ctr        / Load the loop control variable
    Add       Neg1       / Decrement the loop control variable by one
    Store     Ctr        / Store the new value of the loop control variable
    Skipcond  400        / If control variable = 0, skip next instruction to terminate the loop
    Jump      Loop       / Otherwise, go to Loop

    Load Num
    Add         Neg1    
    Store       Num
    Load        Prod
    Store       N
    Load        Zero
    Store       Prod
    Load        Num
    Skipcond    400
    Jump        Loop2
    Halt


N,    Dec     5          / N is N in N!
Num,    Dec     0        / Num is N-1 to 
Prod, Dec     0          / The product
Ctr,  Hex     0          / The loop control variable
Neg1, Dec     -1         / Used to increment and decrement by 1
Zero, Dec      0