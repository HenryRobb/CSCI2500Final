
/Step 0: Load a 'const' Zero into the AC
/Step 1: Add T1 & T2 into the AC and then store it in sum
/Step 2: Load T1 and store into T2
/Step 3: Load Sum and store into T1
/The stuff below that is just copy and pasted loop stuff from above


FIB

Loop, Load  Zero     /Load zero into AC
    Add T1          /Step 1a 
    Add T2          /Step 1b
    Store Sum       /End Step 1
    Load T1         /Step 2a
    Store T2        /Step 2b
    Load Sum        /Step 3a
    Store T1        /Step 3b


    Load      Ctr        / Load the loop control variable
    Add       Neg1       / Decrement the loop control variable by one
    Store     Ctr        / Store the new value of the loop control variable
    Skipcond  400        / If control variable = 0, skip next instruction to terminate the loop
    Jump      Loop 
    Halt

Zero    Dec     0
T1,     Dec     1
T2,     Dec     0
Sum,    Dec     0
Ctr,    Hex     b
Neg1,   Dec     -1
