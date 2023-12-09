/Step 0: Start With N, Load N-1 into Num
/Step 1: Run Mult two num with N and Num
/Step 2: Store That into Prod
/Step 3: Decrement Num
/Step 4: Move Prod into Neg
/Step 5: Halt if B = 0
/Step 6: Jump back to Step 1
    


FACT
Address     Value       Code    
00-01    Load        N          / Load N into AC
02-03    Sub         Pos1
04-05    Store       Num        / Store the number of loop iterations in loop control variable

06-07    Loop2,Load Num           /Setting the Ctr to be equal to Num
08-09    Store Ctr

0A-0B   Loop1, Load    Prod       / Load the product into AC
0C-0D    Add       N          / Add the multiplicand
0E-0F    Store     Prod       / Store the new product
10-11    Load      Ctr        / Load the loop control variable
12-13    Sub       Pos1       / Decrement the loop control variable by one
14-15    Store     Ctr        / Store the new value of the loop control variable
16-17    Skipcond  400        / If control variable = 0, skip next instruction to terminate the loop
18-19    Jump      Loop1       / Otherwise, go to Loop

1A-1B    Load Num             /Loads Num into AC to Decrment it one
1C-1D    Sub         Pos1     /Decrement one
1E-1F    Store       Num      /Stores back into num
20-21    Load        Prod     /This loads Product back into N so N can be a multiplicand
22-23    Store       N           
24-25    Load        Zero     /Resetting Product to be 0 for next loop or multiply
26-27    Store       Prod     
28-29    Load        Num      /Checking that num isnt 0
2A-2B    Skipcond    400
2C-2D    Jump        Loop2    /Jumping back start next multiply
2E-2F    Halt

30      N,    Dec     5          / N is N in N!
31      Num,    Dec   0        / Num is N-1 to 
32      Prod, Dec     0          / The product
33      Ctr,  Hex     0          / The loop control variable
34      Pos1, Dec     1         / Used to increment and decrement by 1
35      Zero, Dec     0