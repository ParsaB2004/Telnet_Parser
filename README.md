# Telnet Parser

A Telnet protocol command parser built with **Flex** (lexical analyzer) and **Bison** (parser generator). It reads lines of text, identifies Telnet IAC (Interpret As Command) sequences, and classifies each line as either an IAC command or regular body text.

## Overview

Telnet uses a command/response protocol where special sequences are prefixed with `IAC` (Interpret As Command, byte `0xFF`). This parser reads **textual representations** of Telnet commands (e.g., `IAC DO ECHO`) and parses them into structured output.

## Example

**Input:**
```
IAC DO ECHO
Hello from Telnet client!
IAC WILL TERMINAL-TYPE
```

**Output:**
```
[IAC] DO ECHO
[Body] Hello from Telnet client!
[IAC] WILL TERMINAL-TYPE
```

## Grammar

The parser recognizes two types of lines:

- **IAC lines**: `IAC <COMMAND> <OPTION>`
  - Commands: `DO`, `DONT`, `WILL`, `WONT`
  - Options: `ECHO`, `SUPPRESS-GO-AHEAD`, `TERMINAL-TYPE`, `NAWS`, `LINEMODE`, `NEW-ENVIRON`, `STATUS`, `BINARY`, `SGA`, or any `WORD`
- **Body lines**: Free-form text (one or more words)

## Building

### Prerequisites

- GCC (or any C99-compatible compiler)
- Flex (lexical analyzer)
- Bison (parser generator)

### Build

```bash
make
```

### Run

```bash
make run
# or
./telnet_parser < input.text
```

### Clean

```bash
make clean       # remove binary
make distclean   # remove binary AND generated C files
```

## Files

| File              | Description                                    |
|-------------------|------------------------------------------------|
| `telnet.y`        | Bison grammar definition (`.y` file)            |
| `telnet.l`        | Flex lexer definition (`.l` file)               |
| `telnet.tab.c`    | Generated C parser (from Bison)                 |
| `telnet.tab.h`    | Generated parser header (from Bison)            |
| `lex.yy.c`        | Generated C lexer (from Flex)                   |
| `input.text`      | Sample input file                               |
| `Makefile`        | Build automation                                |

## Customization

### Adding Telnet Options

Edit `telnet.l` and add new option tokens following the existing pattern:

```lex
"MY-NEW-OPTION"  { yylval.str = strdup("MY-NEW-OPTION"); return OPTION; }
```

### Case Sensitivity

The lexer uses `%option case-insensitive`, so `iac do echo`, `IAC DO ECHO`, and `Iac Do Echo` are all treated identically.

## License

MIT
