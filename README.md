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
- Move configs to external file and generate new file if not found
- Reduce message spam a bit when nothing has changed
- Persistent GUI with bars and whatnot


## Contributing

This section was taking in its entirety (with heavy edits) from the [OpenComputers](https://github.com/MightyPirates/OpenComputers) repository as they have excellent repository documentation and I could never do better.

###Assets and Localizations
1. **Translations**  
   Translations to other languages are very much appreciated. I have not implemented a localization system yet but feel free to create one and submit the pull request. Keep it sorted alphabetically, use the name and region Minecraft itself uses. If you don't know how to do that, that's OK, I'll do it later.
2. **Documentation**  
   Help with the [wiki][] or other documentation would be *really* appreciated. If you notice anything amiss and know better, fix it. If you don't ask someone who does, then fix it. If you had a question answered, consider adding that information somewhere in the wiki where you would have expected to find that information.  

###Bug fixes, features and scripts
1. **Bugs**  
   If you've found a bug, please report it in the [issue tracker][issues], after checking it has not been reported before - and possibly even fixed by now. If you think you can and have fixed it, feel free to do a pull request, I'll happily pull it if it looks all right to me - otherwise I'll gladly tell you what to change to get it merged.
2. **Features**  
   If you'd like to propose a new feature, take it to the [issue tracker][issues]. If you'd like to contribute code that adds new features, please make sure to discuss the feature with me, first - again, the issue tracker is an OK place for this, there are a couple of feature requests there, already. Blind / unexpected feature pull requests might very well not make it, so save yourself some time by talking about it, first! Thanks.

####Pull requests
The following are a few quick guidelines on pull requests. That is to say they are not necessarily *rules*, so there may be exceptions and all that. Just try to stick to those points as a baseline.
- Make sure your code is formatted properly.
- Make sure the script runs for a long enough test period without issue.
- Try to keep your changes as minimal as possible. In particular, no whitespace changes in existing files, please.
- [Squash](http://gitready.com/advanced/2009/02/10/squashing-commits-with-rebase.html) your commits!

Also, and this should go without saying, your contributed code will also fall under the existing license, unless otherwise specified (in the super rare case of adding third-party stuff, add the according license information as a `LICENSE-???` file, please).
