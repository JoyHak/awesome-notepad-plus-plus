![](https://github.com/JoyHak/awesome-notepad-plus-plus/blob/main/images/banner.png)

[Awesome Notepad++](https://github.com/JoyHak/awesome-notepad-plus-plus/releases) is a modern portable version of the well-known text editor, which gives all users not only advanced features out of the box, but also allows you to customize the editor for yourself. Use beautiful syntax highlighting in existing user languages, learn from their example how to add your own language, write code with beautiful syntax highlighting and run it directly from Notepad++ (coming soon: for different languages). [You can download it here](https://github.com/JoyHak/awesome-notepad-plus-plus/releases ). Due to the large number of changes made, only the 64-bit version is supported. **For a better experience, it is recommended to install the [Maple Mono](https://github.com/subframe7536/maple-font) font.**

![](https://github.com/JoyHak/awesome-notepad-plus-plus/blob/main/images/toolbar.png)
![](https://github.com/JoyHak/awesome-notepad-plus-plus/blob/main/images/class.png)
[![]([https://youtu.be/Xaz8yMx-N9Y](https://www.youtube.com/watch?v=Xaz8yMx-N9Y))](https://www.youtube.com/watch?v=Xaz8yMx-N9Y)

## Improvements

- Added high-quality syntax highlighting for [Assembly](https://en.wikipedia.org/wiki/X86_assembly_language), [Xyplorer](https://www.xyplorer.com/tour.php?page=scripting), [Nilesoft Shell](https://nilesoft.org/docs), [Autohotkey](https://www.autohotkey.com/docs/v2/Program.htm), [Batch](https://en.wikipedia.org/wiki/Batch_file) (and DOS), [PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/overview?view=powershell-7.5) and [Regex](https://en.wikipedia.org/wiki/Regular_expression). 
- Added the buttons to run, compile, and debug this languages.
- Added buttons and a backend for working with DOSBox, launching and debugging the x86 Assembly.
- Each default script file can be run by default using the Windows shell (for example, [PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/overview?view=powershell-7.5) scripts).
- AutoHotkey files can be compiled with a single button if [Ahk2Exe directives](https://www.autohotkey.com/docs/v1/misc/Ahk2ExeDirectives.htm#Bin) are added to the file. [Here's an example.](https://github.com/JoyHak/QuickSwitch?tab=readme-ov-file#compiling)
- Autohotkey functions and labels have been updated in the functionList
- The initial version of auto-completion has been added
- Autohotkey has the most complete syntax highlighting: custom functions, private methods, interpolation.
- The application design and fonts have been improved.
- Modern versions of useful plugins are installed.

## New icons
 - created a new fluent icon design on the toolbar
 - added new buttons for pre-installed plugins
 - added launch, compile and debug buttons.
 - The font in the "Search/Replace" window has been enlarged and all labels have been simplified to a minimum.
 - Added a new application icon from the Lumicons set from niivu.

## Powerful AutoHotkey
- Syntax highlighting fully shows how the string and keys will be interpreted by commands like `Send`. For this purpose, I [invented my own Regex](https://github.com/JoyHak/RegEx-loop) to use the [EnahnceAnyLexer](https://github.com/Ekopalypse/EnhanceAnyLexer) plugin to its full potential!
- Added highlighting of negation of variables, functions, and integer expressions to quickly distinguish elements of logic algebra.
- Different colors have been added for different states and variable values.
- The individual colors have file paths, relative paths, extensions, module names, and included files.


