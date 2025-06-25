![](https://github.com/JoyHak/awesome-notepad-plus-plus/blob/main/images/banner.png)

[Awesome Notepad++](https://github.com/JoyHak/awesome-notepad-plus-plus/releases) is a modern portable version of the well-known text editor, which gives all users not only advanced features out of the box, but also allows you to customize the editor for yourself. Use beautiful syntax highlighting in existing user languages, learn from their example how to add your own language, write code with beautiful syntax highlighting and run it directly from Notepad++ (coming soon: for different languages). [You can download it here](https://github.com/JoyHak/awesome-notepad-plus-plus/releases ). Due to the large number of changes made, only the 64-bit version is supported. **For a better experience, it is recommended to install the [Maple Mono](https://github.com/subframe7536/maple-font) font.**

![](https://github.com/JoyHak/awesome-notepad-plus-plus/blob/main/images/toolbar.png)
![](https://github.com/JoyHak/awesome-notepad-plus-plus/blob/main/images/class.png)
[![]([https://youtu.be/Xaz8yMx-N9Y](https://www.youtube.com/watch?v=Xaz8yMx-N9Y))](https://www.youtube.com/watch?v=Xaz8yMx-N9Y)

You can always contribute to the project or add new features for yourself. Details on how to customize everything and where the settings are located are [described here](https://github.com/JoyHak/awesome-notepad-plus-plus/edit/main/README.md#customization).

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
- Buttons have been added to the toolbar settings menu for all plugins. You can always turn on the desired button in the special menu by clicking on the gear in the left corner of the toolbar.
 - Сreated a new fluent icon design on the toolbar
 - Added new buttons for pre-installed plugins and internal commands.
 - The font in the "Search/Replace" window has been enlarged and all labels have been simplified to a minimum.
 - Added a new application icon from the Lumicons set from niivu.

## Powerful AutoHotkey
- Syntax highlighting fully shows how the string and keys will be interpreted by commands like `Send`. For this purpose, I [invented my own Regex](https://github.com/JoyHak/RegEx-loop) to use the [EnahnceAnyLexer](https://github.com/Ekopalypse/EnhanceAnyLexer) plugin to its full potential!
- Added highlighting of negation of variables, functions, and integer expressions to quickly distinguish elements of logic algebra.
- Different colors have been added for different states and variable values.
- The individual colors have file paths, relative paths, extensions, module names, and included files.

## Customization
All settings are in individual files. Each plugin has an intuitive interface and is easy to set up. Below is a list of files and dirs that contain various customization elements. *Please read the comments in the files and the links to the plugins listed below. They will help you add something of your own or change the available parameters.*
- Syntax highlighting is configured by files in two directories
 - The internal syntax highlighting of basic keywords, operators, and functions is found in the files here: `C:\Users\ToYu\Notepad++\userDefineLangs`. *[Here](https://npp-user-manual.org/docs/user-defined-language-system/) you can find how to configure internal syntax highlighting using user-defines languages.* 
 - Syntax highlighting using the [Regex plugin](https://github.com/Ekopalypse/EnhanceAnyLexer) is configured in the file: `C:\Users\ToYu\Notepad++\plugins\Config\EnhanceAnyLexer\EnhanceAnyLexerConfig.ini`. *The directory contains finished languages. To add your own syntax highlghting, read the comments in the file and look at my regexes. You can find new languages [here](https://github.com/notepad-plus-plus/userDefinedLanguages).*
<details><summary>Details</summary>

```fsharp

// Each configured lexer must have a section with its name
//  followed by one or more lines with the syntax
//  color[optional whitelist] = regular expression.
//  A color is a number in the range 0 - 16777215.
//  Examples:

[Autohotkey]
; Functions and classes: whole word and ( or {
#6278df = \b\w+\b\.(call|bind|name)

; Logging
#abba41[4] = (?i)\b(Log\w*)\b
#ff3e33[4,8] = (?i)\b(\w*Error|(Log)?Exception|throw)\b
```
</details>

- The buttons on the toolbar were added using the [plugin](https://sourceforge.net/projects/npp-customize/) and are located in the file: `C:\Users\ToYu\Notepad++\plugins\Config\CustomizeToolbar.btn`
- All the button icons for plugins are here: `C:\Users\ToYu\Notepad++\plugins\Config\icons`
- Launch, compilation, and debugging buttons is configured using the [plugin](https://github.com/d0vgan/nppexec) and is located in the file: `C:\Users\ToYu\Notepad++\plugins\Config\npes_saved.txt`. *Please read the [documentation](https://github.com/d0vgan/nppexec/blob/master/docs/NppExec_HelpAll.txt) to add new buttons.*
- There are separate files for individual file extensions: `C:\Users\ToYu\Notepad++\plugins\Config\NppExecScripts`. *Files are started from npes_saved if the extension of the current file in Notepad++ matches the name of one of the files in this directory. If I am working with a `.ahk` file and want to run it, NppExec will search for a file named `.ahk.exec` in this directory.*
<details><summary>Details</summary>
Depending on the selected button, the file will start with arguments. For example, the `run` button will pass the `-run` argument to the file.

```javascript
// npes_saves.txt
::Run
    set local CONFIG = $(NPP_DIRECTORY)\plugins\Config\NppExecScripts\$(EXT_PART).exec
    set exists ~ fileexists $(CONFIG)
    if $(exists) == 1 then
        NPP_EXEC $(CONFIG) -run
```
Further, these arguments can be processed as desired in the file. I chose the option of [jumping](https://en.wikipedia.org/wiki/Goto) to the args:

```javascript
// .ahk.exec
// Jump to the label that matches the arg
goto $(ARGV)

:-run
    // Run using Windows file assoc.
    NPP_RUN "$(FULL_CURRENT_PATH)"
    exit

:-compile-run       
    :-compile
        // Kill running script & exe silently before compiling
        taskkill /f /t /im "$(NAME_PART)*"                      // .exe
        taskkill /fi "WINDOWTITLE eq $(FULL_CURRENT_PATH)*"     // .ahk

        $(COMPILER) /in "$(FILE_NAME)" /silent

        if $(ARGV) == -compile then
            exit            
        endif
     
    // Run only after success
    if $(EXITCODE) == 0 then
        set exists ~ fileexists $(OUTPUTL)
        if $(exists) == 1 then
            NPP_RUN $(OUTPUTL)
        ...
```
</details>


## Why Notepad++

I know that VScode is really popular, but for me, Notepad++ is just as good. You can do so much more with it, like customising the syntax highlighting, adding a programming language and a lot of hotkeys, writing a plugin,  and more. It's a super versatile text editor. But what I really want to do is make it an efficient editor that will be a handy tool for the different languages I use (xyplorer, autohotkey, Syncovery logs, php...).

I've tried other IDEs, but they're just not as flexible. Jetbrains (which I still work in) and VScode require me to write a plugin for powerful syntax highlighting in the new language, which is a bit of a pain. The existing plugins have very poor syntax highlighting. I've tried Notepad+, SciTE, AkelPad and other Notepad forks, but they don't have an ecosystem of useful plugins, and the ability to customise syntax highlighting without knowing the structure of their special files is a bit of a challenge.


