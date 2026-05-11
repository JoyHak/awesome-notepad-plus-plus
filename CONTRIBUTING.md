# Contributing

***Ask not what Notepad++ can do for you - ask what you can do for Notepad++***

## Reporting Issues

Bug reports are appreciated. Following a few guidelines listed below will help speed up the process of getting them fixed.

1. Search the issue tracker to see if it has already been reported.
2. Disable your plugins to see if one of them is the problem. You can do this by renaming your `plugins` folder to something else.
3. Fill the complete information: a template will be shown when you create an issue. Please fill the complete information in the template, it can help to solve the issue.

Before reporting a security issue, please read [Security Policy](SECURITY.md) first!

## Pull Requests
If you have something to offer, and your pull requests are welcome.<br/>

You can improve this modification by expanding syntax highlighting for existing languages, adding new words to AutoComplete, adding new tags for quick navigation, expanding code snippets, or improving existing plugin configurations.

You can also suggest new toolbar icon designs to complement the current Fluent pack or to replace the old icons.

### Guidelines for pull requests

1. Keep your code readable and well-structured. All configuration files are written with care and attention to detail so that anyone can read them. 

>    If yoг're writing a new RegEx, try to make it readable by using comments `(?#)`, named groups `(?<name>)`, and spaces with `(?x)` flag.

1. Create a new branch for each PR. **Make sure your branch name wasn't used before** - you can add date (for example `patch3_20200528`) to ensure its uniqueness.
2. Single feature or bug-fix per PR. If you've modified the configuration files - one PR per plugin. If you've added a new languages - one PR with all required files.
3. Don't make single big commit with all files to make the review process easier.
4. When creating new PR, try to base it on latest master. Some configs may be already changed.
5. Finally, please test your pull requests, at least once. Open multiple files, e.g. `.ahk` and check that they are displayed correctly.
