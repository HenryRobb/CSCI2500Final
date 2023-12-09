
/Step 0: Load a 'const' Zero into the AC
/Step 1: Add T1 & T2 into the AC and then store it in sum
/Step 2: Load T1 and store into T2
/Step 3: Load Sum and store into T1
/The stuff below that is just copy and pasted loop stuff from above


FIB
Address value               Code
00-01   Loop, Load  Zero    /Load zero into AC
02-03   Add T1              /Step 1a 
04-05   Add T2              /Step 1b
06-07   Store Sum           /End Step 1
08-09   Load T1             /Step 2a
0A-0B   Store T2            /Step 2b
0C-0D   Load Sum            /Step 3a
0E-0F   Store T1            /Step 3b
10-11   Load      Ctr       / Load the loop control variable
12-13   Sub       Pos1      / Decrement the loop control variable by one
14-15   Store     Ctr       / Store the new value of the loop control variable
16-17   Skipcond  400       / If control variable = 0, skip next instruction to terminate the loop
18-19   Jump      Loop 
1A-1B   Halt
1C      Zero                Dec 0
1D      T1                  Dec 1
1E      T2                  Dec 0
1F      Sum                 Dec 0
20      Ctr                 Hex b
21      Pos1                Dec 1