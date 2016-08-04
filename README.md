# StockMonitor
OpenComputers script to monitor item and fluid levels and act accordingly.

Currently checks for Rotarycraft canola and lubricant and maintains adequate levels via redstone control but can easily be modified to check other fluids or items and act in different ways to maintain them.


## Instructions

1. Download or copy this program to your OpenComputer.
2. Modify the items/fluids you want to monitor in the main body and appropriate thresholds in the global variables.
3. Modify the colors and redstone bundled cable side.
4. Make sure your computer is connected to your ME Controller via an adapter.
5. Place your bundled cable on the appropriate side of the computer.
6. Run script.

## Known Issues

- If there multiple items of the same name but varying NBT data then it will check against the first one found only. Which one that is is up to AE.

  Example: 

  You have RotaryCraft Canola Seeds in your AE from harvesting but you also have extra 10/10/10 Agricraft Canola Seeds in your AE. The script may believe that you want to monitor the wrong one. Only solution I know of is to keep your agricraft seeds in separate storage. 
  
  Solution: I believe I should be able to fix this by checking for the Agricraft NBT data in my getItemAmount() function and skipping those items.
  
- The script has sometimes caused OC out of memory errors after running for a few days straight. I do not know whether this is caused by sloppy code on my behalf (very likely) or a memory leak elsewhere.

  Solution: Possibly implement an auto restart every 12/24 hours and set script to autorun at boot to get ahead of out of memory crashes.

  
## TODO:

- Fix issue with Agricraft improved seeds (see above known issue)
- Fix out of memory error (see above known issue)
- Reduce message spam a bit when nothing has changed
- Persistent GUI with bars and whatnot
