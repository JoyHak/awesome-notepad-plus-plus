![](images/banner.png)

Awesome Notepad++ is a customized version of the famous text editor with various features out of the box. Write code with beautiful syntax highlighting, launch scripts and translate comments directly from Notepad++. [You can download it here](https://github.com/JoyHak/awesome-notepad-plus-plus/releases ). **For a better experience, please download the [Maple Mono NF CN](https://github.com/subframe7536/maple-font) font or [install it from the repo](MapleMono-NF-CN-Regular.ttf).**

<img src="images/ahk/syntax.png" title="" alt="" width="629">

You can always contribute to the project or add new features for yourself. [Read how customize everything and where to find configs here](#customization).

## Features

Click on any hyperlink to quickly open related paragraph about this feature. See demo in [/Images](/images).

- High-quality [syntax highlighting](#syntax) for [Autohotkey](https://www.autohotkey.com/docs/v2/Program.htm), [PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/overview?view=powershell-7.5), [Xyplorer](https://www.xyplorer.com/tour.php?page=scripting), [Nilesoft Shell](https://nilesoft.org/docs), [Assembly](https://en.wikipedia.org/wiki/X86_assembly_language), [Batch](https://en.wikipedia.org/wiki/Batch_file) (and DOS). Consistent theme for other languages.

- [Auto-completion](#completion) and [code snippets](#snippets) for Autohotkey, PowerShell and Xyplorer.

  <img src="images/ahk/snippets1.gif" title="" alt="" width="412" />
  <img src="images/ahk/snippets2.gif" title="" alt="" width="507" />

  Press `Tab` to insert code snippet; press `Ctrl+L` to move caret to the next placholder (e.g. inside `try { }` block).

- [Documentation popup](#calltips) and function parameters popup.

  <img src="images/ahk/docs4.gif" title="" alt="" width="697">
  <img src="images/ahk/hint.gif" title="" alt="" width="697">
  <img src="images/xy/Array.gif" title="" alt="" width="697">
  <img src="images/xy/foreach.gif" title="" alt="" width="697">

  Type `(` after function name or press `Ctrl+Shift+O` to see calltip (function parameters hint); `Ctrl+J` - next page, `Ctrl+U` - previous page. 
  Hover your mouse on function/keyword to see documentation popup; click on it to open next page.

  **Supports all languages.**

  <img src="images/ahk/docs2.gif" title="" alt="" width="697">

- [Offline documentation](Notepad++\helpDocumentation) search from context menu: AutoHotkey, Xyplorer, MSDN (WinApi, useful for DllCalls).

- [Buttons](#buttons) to build and run any scripts.

  - AutoHotkey scripts can be compiled via "compile" button if [Ahk2Exe directives](https://www.autohotkey.com/docs/v1/misc/Ahk2ExeDirectives.htm#Bin) are presented in the file. [Here's an example](https://github.com/JoyHak/QuickSwitch?tab=readme-ov-file#compiling).
    ![](images/output.png)
  - Assembly x86 can be compiled automatically using bundled toolchain. 
    ![](images/output2.png)
  - Quick shortcuts:
    `Ctrl+Shift+A` - compile
    `Ctrl+Shift+S` - run
    `Ctrl+Shift+D` - compile and run

- [Customizable toolbar](#toolbar) with new icons.

  <img src="images/icons.png" title="" alt="" width="643">

  [All icons can be found here](Notepad++\plugins\Config\icons). You can [override or change them](#toolbar).

- Useful [context menu actions](#menu):

  - [Translate selected text](#scripts), get alternative translation variants.

    <img src="images/translate.gif" title="" alt="" width="708">

  - Search for [magic number](#scripts) (CLSID, WinApi macro/constant, DllCall values).

    <img title="" src="images/find_magic.gif" alt="" width="458">

  - Add [separators](#scripts) with text.

    <img src="images/separator.png" title="" alt="" width="708">

  - Change text case.

- New search/replace dialog design with bigger font

  <img title="" src="images/find1.png" alt="" width="626">

  Press `Ctrl+E` to search for all calls of the function under caret.
  ![](images/ahk/find_usages.gif)

## Syntax highltighting

Syntax highltighting can be configured via [basic language file](Notepad++\userDefineLangs) and powerful [EnhanceAnyLexer config](Notepad++\plugins\Config\EnhanceAnyLexer\EnhanceAnyLexerConfig.ini). See demo in [/Images](/images). [Read how to configure it](#syntax).

Syntax highlighting is designed so that the most important things are slightly contrasting; negation/error throwing are bright red; operators and comments do not distract from reading; everything else is soft colors that are slightly different from each other.

#### AutoHotkey

- Negation of variables, functions, and integer expressions to quickly distinguish elements of logic algebra.

  <img src="images/negation.png" title="" alt="class" width="573">

- Each identifier has its own unique color.

  <img src="images/identifier.png" title="" alt="locals" width="573">

- Each logging level has its own color. The colors for `return` and `throw` allow you to quickly see what the function returns: an error or a value.

  <img src="images/ahk/logging.png" title="" alt="" width="573">
  <img src="images/ahk/logging2.png" title="" alt="" width="573">

- You can quickly distinguish between the DllCall function and its argument types.
  ![](images/ahk/dllcall.png)

#### Xyplorer

- Labels, sub-routines (sub-scripts), user functions and built-in functions has it's own distinct smooth colors.

  <img src="images/xy/syntax.png" title="" alt="" width="751">

- Arguments, switches, strings and paths has it's own colors.

  <img src="images/xy/args.png" title="" alt="" width="751">
  <img src="images/xy/args2.png" title="" alt="" width="751">

- You can quickly distinguish between strings, paths, booleans, and lists.

  <img src="images/xy/vars.png" title="" alt="" width="604">

#### Powershell

- You can quickly distinguish between splatting, switches and named parameters.

  <img src="images/ps/syntax.png" title="" alt="" width="839">

- Special operators and named parameters has it's own distinct smooth colors.

  <img src="images/ps/operators.png" title="" alt="" width="237">

## Customization

Everything can be configured through the intuitive interface of the installed plugins (the `Plugins` menu at the top) or through various configs, links to which are provided below. Please read the comments at the beginning of each config to understand how it works.

<a name="syntax"></a>

- [Internal syntax highlighting](Notepad++\userDefineLangs) of basic keywords, operators, and functions is found in the files here. *[Here](https://npp-user-manual.org/docs/user-defined-language-system/) you can read how to configure internal syntax highlighting using user-defines languages.* 
- [RegEx syntax highlighting](Notepad++\plugins\Config\EnhanceAnyLexer\EnhanceAnyLexerConfig.ini) for any expression/complex keyword. *Read comments about syntax at the beginning or [see the docs](https://github.com/Ekopalypse/EnhanceAnyLexer).*
- [Theme and syntax highlighting for other languages](Notepad++\themes\Colorful dark.xml).

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

<a name="toolbar"></a>

- Toolbar buttons can be [changed and re-ordered here](Notepad++\plugins\Config\CustomizeToolbar.btn). *Read comments about syntax at the beginning.*
- All the icons [can be found here](Notepad++\plugins\Config\icons). You can [download more icons here](https://drive.google.com/drive/folders/12Zp8vIvtqpUsaJbYuWgyfNvbjYEuOzjt).

<details><summary>Details</summary>

```ini
; Each custom button definiton comprises 7 comma separated fields:
; Menu1, Submenu1, Submenu2, Submenu3, name.bmp, light.ico, dark.ico
;  
; Some fields are optional:
;   .bmp and .ico
;   after the last visible SubmenuN, the SubmenuN+1 fields become optional 
;  
; If .bmp or .ico file names are present, the files must be located 
; in the Notepad++ configuration sub-folder: ..\plugins\config
;  
;  
; Quick codes can be used instead of file names: *color:label 
; A quick code comprises:
; an * followed by either a color code letter/hex color value
; label
;  
;  
; EXAMPLES
; Define custom button using file names:
Edit,Select_All,,,standard-1.bmp,fluentlight-1.ico,fluentdark-1.ico
; Redefine existing button using file names:
Plugins,Compare,Navigation_Bar,,standard-3.bmp,fluentlight-3.ico,fluentdark-3.ico
; Run and compile
Plugins,NppExec,Debug,,,icons\debug.ico
Plugins,NppExec,Compile,,,icons\compile.ico
Plugins,NppExec,Run,,,icons\run.ico
 
```

</details>

<a name="menu"></a>

- [Context menu](Notepad++\contextMenu.xml) actions are [NppExec scripts](https://github.com/d0vgan/nppexec).

<details><summary>Add new action</summary>

1. [Write a new scipt here](Notepad++\plugins\Config\npes_saved.txt). See the docs about [NppExec language syntax](Notepad++\plugins\NppExec\doc\NppExec\NppExec_HelpAll.txt) *(open via Notepad++, select `Language - NppExec` at the top for better readability.*.
2. Open `Plugins - NppExec - Advanced Options` at the top.
3. Select your new scripts and press `Add`. 
4. Restart Notepad++.
5. Open [context menu config](Notepad++\contextMenu.xml) and add new script. *See other menu actions syntax*.
6. Restart Notepad++.

</details>

<a name="buttons"></a>

- Run and compile buttons is configured using the [NppExec](https://github.com/d0vgan/nppexec) in [this txt config](Notepad++\plugins\Config\npes_saved.txt). *Please [read the documentation](Notepad++\plugins\NppExec\doc\NppExec\NppExec_HelpAll.txt) to add new buttons.*
- There are [separate NppExec scripts](Notepad++\plugins\Config\NppExecScripts) to run individual file extensions. "Run" is defined in [npes_saved](Notepad++\plugins\Config\npes_saved.txt). If the extension of the current opened file matches the name of one of the `.exec` scripts in [this directory](Notepad++\plugins\Config\NppExecScripts), this script will be launched to proceed opened file. *If I am working with a `.ahk` file and want to run it, "Run" will search for a file named `.ahk.exec` in [this directory](Notepad++\plugins\Config\NppExecScripts).*

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

<a name="scripts"></a>

- Some of the [features](#features) are [NppExec scripts](Notepad++\plugins\Config\npes_saved.txt) with [additional `.ahk` helpers](Notepad++\AutoHotkey):

  - [Add separators with text](Notepad++\plugins\Config\npes_saved.txt)
  - [Find usages](Notepad++\plugins\Config\npes_saved.txt)
  - [Translate selected text](Notepad++\AutoHotkey\GetTranslation.ahk)
  - [Magic numbers](Notepad++\AutoHotkey\MagicNumbers\IniReadFuzzy.ahk)

<a name="completion"></a>

- [Auto-completetion dir](Notepad++\autoCompletion) contains files with docs/syntax/parameters for each function, command or keyword. Each `.xml` file will be used to display auto-completion menu, calltip (function hint) and docs popup. [Read about schema and syntax here](https://npp-user-manual.org/docs/auto-completion).

<details><summary>Schema</summary>

Each `<KeyWord>` can contain different structure.

### 1. Function

`<KeyWord>` tag with `func="yes"` atrribute. Can contain 1+ `<Overload>` tags with 1+ `<Param>` tags:

```html
        <KeyWord name="ControlClick" func="yes">
            <Overload retVal="" descr="Sends a mouse button or mouse wheel event to a control.">
               <Param name="[ControlOrPos]"/>
               <Param name="[WinTitle]"/>
               <Param name="[WinText]"/>
               <Param name="[Button]"/>
               <Param name="[ClickCount]"/>
               <Param name="[Options]"/>
               <Param name="[NotInTitle]"/>
               <Param name="[NotInText]"/>
            </Overload>
            <Overload retVal="" descr="Control-or-pos:
    ControlClick 'x100 y200', ...
    ControlClick Var, ... (where Var is ClassNN, text, HWND, or an obj with 'hwnd' property)
Button: 
  Left (L), Right (R), Middle (M), X1, X2, WheelUp (WU), WheelDown (WD)

ClickCount: 
  Default = 1

Options:
 NA = possible reliability improvement
  D = press and hold mouse button
  U = release specified mouse button
Pos = use only 'x y' for Control-or-pos param
 Xn = where to click, relative to control top left (default is center)
 Yn = where to click, relative to control top left (default is center)">
               <Param name="[ControlOrPos]"/>
               <Param name="[WinTitle]"/>
               <Param name="[WinText]"/>
               <Param name="[Button]"/>
               <Param name="[ClickCount]"/>
               <Param name="[Options]"/>
               <Param name="[NotInTitle]"/>
               <Param name="[NotInText]"/>
            </Overload>
        </KeyWord>
```

Each `<Overload>` tag is basically the page. User can list pages by `Ctrl+J/U` or by click on docs popup. If you have one large `<Overload>`, it may not fit inot user's screen, so it's better to split long overloads into multiple tags. Rule of thumb: 1st page for parameters only (function signature) and brief description; 2nd page for detailed information; other pages for different kind of information about function.

If function accepts inly one group of params like `ControlClick` above, **you must duplicate `<param>` tag in all `<Overload>` tags! Otherwise each page will contain different parameters set, i.e. different function signature that may distract the reader.

It's better to specify return value (if any) in `retVal` attribute:

```html
        <KeyWord name="DateAdd" func="yes">
            <Overload retVal="{Date}" descr="Adds or subtracts time from a date-time value.">
               <Param name="DateTime"/>
               <Param name="Time"/>
               <Param name="TimeUnits"/>
            </Overload>
            <Overload retVal="{Date}" descr=" DateTime = YYYYMMDDHH24MISS format
     Time = Integer or float.
TimeUnits = Seconds (S), Minutes (M), Hours (H), Days (D)
Year (if used) must be on or after 1601.">
               <Param name="DateTime"/>
               <Param name="Time"/>
               <Param name="TimeUnits"/>
            </Overload>
        </KeyWord>
```

Each <Overload retVal="{Date}"...` should display consistent function signature: `{Date} DateAdd(DateTime, Time, TimeUnits)` on each page.

### Keyword with Description

You can specify keyword the will be visible in auto-completion list after typing its name; in docs popup after mouse hover. Just specify

```
        <KeyWord name="for" func="no">
            <Overload retVal="" descr="Repeats one or more statements once for each key-value pair in an object.
for value in &lt;expression&gt; {
    ...
}

-- OR --

for index , value in &lt;expression&gt; {
    ...
}

Supports more than 2 variables for classes with __Enum(n) method."/>
        </KeyWord> 

Description will be displayed in docs popup only!

### Keyword Only

This type of keywords will be displayed in auto-completion list only.

```html
        <KeyWord name="local"/>
        <KeyWord name="global"/>
        <KeyWord name="static"/>
```

</details>

<img src="images/ahk/hint.gif" title="" alt="" width="697">

  <a name="calltips"></a>
  Documentation popup is done via [Python script](Notepad++\plugins\Config\PythonScript\scripts\calltips.py).
  <a name="snippets"></a>
  Auto-completion menu also includes [code snippets](Notepad++\plugins\Config\QuickText.ini). Open `Plugins - QuickText - Settings` to add new snippet.

<details><summary>Details</summary>
Dollar sign `$` is placeholder for caret after applying code snippet. Press `Ctrl+L` to jump caret to the next placeholder. *For user languages (udf) like AutoHotkey or PowerShell you must use `[15]` section only! You cannot define separate snippets for user languages.

```ini
[15]
#LANGUAGE_NAME=udf
addresource-ahk2exe=;@Ahk2Exe-AddResource $\n
astr-dllcall='AStr', $
base-ahk2exe=;@Ahk2Exe-Base $\n
base-exe-ahk2exe=;@Ahk2Exe-Base $, $\n
blind-send='{Blind}$'
case=case $:\n	$
catch=catch {\n	$\n}
catch-as=catch $ as $ {\n	$\n}
```

</details>

## Why Notepad++

VSCode is quite popular, but it uses the Electron framework, which is written in high-level JavaScript. In fact, it is a small browser that weights hundred megabytes. It feels slow and heavy.

Notepad++ is written entirely in C++. It is low-level (compiled) the language that makes Notepad++ fast and compact. It is very useful on weak machines and laptops.

The main drawback of Notepad++ is its out-of-the-box appearance: it doesn't look as attractive as VSCode, it doesn't have the necessary plugins and powerful syntax highlighting. I tried to solve these problems and give every programmer the tools that Notepad++ lacks so much.
