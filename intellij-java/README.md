# GoogleStyle (Custom)

This is my custom code style scheme used in IntelliJ IDEA.

- Base scheme: [Google Java Style](https://github.com/google/styleguide) (intellij-java-google-style.xml)
- Exported from: IntelliJ IDEA 2026.1.1

## Customizations

> [!NOTE]
>
> The following changes have been made to the base *Google Java Style*.

### Editor > Code Style

- Line separator: Unix and macOS (\n)
- [ ] Detect and use existing file indents for editing

### Editor > Code Style > Java

- Tabs and Indents
  - Tab size: 4
  - Indent: 4
  - Continuation indent: 8

- Wrapping and Braces
  - Keep when reformatting
    - [ ] Line breaks
  - Extends/implements/permits keyword: Wrap if long
  - Method declaration parameters: Chop down if long
    - [x] Align when multiline
  - Method call arguments: Chop down if long
  - Chained method calls: Chop down if long
  - 'try-with-resources': Wrap always
  - Assignment statement: Wrap if long
  - Enum constants: Wrap always
  - Record components: Chop down if long

- Blank Lines
  - Minimum blank lines
    - After class header: 0

- Imports
  - General
    - [ ] Insert imports for inner classes

- Arrangement
  - Grouping rules:
    - [x] Keep overridden methods together: keep order
  - Rules Alias Definitions
    - method_visibility
      1. `method` `public` `abstract`
      1. `method` `public` `final`
      1. `method` `public`
      1. `method` `protected` `abstract`
      1. `method` `protected` `final`
      1. `method` `protected`
      1. `method` `package private` `abstract`
      1. `method` `package private` `final`
      1. `method` `package private`
      1. `method` `private`
    - visibility
      1. `public`
      1. `protected`
      1. `package private`
      1. `private`
  - Matching rules:
    1. `field` `static`
    1. `initializer block` `static`
    1. `field`
    1. `initializer block`
    1. `constructor`
    1. `method` `static` `by visibility`
    1. `method` `by method_visibility`
    1. `overridden`
    1. `enum` `by visibility`
    1. `interface` `by visibility`
    1. `class` `by visibility`
    1. `class` `static` `by visibility`

- Code Generation
  - Comment Code
    - [ ] Line comment at first column
    - [x] Add a space at line comment start
      - [x] Enforce on reformat
    - [ ] Block comment at first column
    - [x] Add spaces around block comments

### Editor > Code Style > XML

- Other
  - Wrap attributes: Do not wrap
  - [ ] Wrap text
  - [x] Align attributes

- Arrangement
  - [DELETE] `name:.*` `namespace:.*`

- Code Generation
  - Comments
    - [ ] Line comment at first column
    - [ ] Block comment at first column
    - [x] Add spaces around block comments
