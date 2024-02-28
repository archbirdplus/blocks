
# Blocks

This Blocks repository was designed to make it simple and quick to find difficulty values for XCEL Blocks routines. The Swift package contains two primary products: a library and a front-end. The library implements the rules of blocks (aka pedestal) competitions relating to tariff sheets as defined in the [XCEL Blocks Code of Points](https://static.usagym.org/PDFs/Acro/blocks/cop_110623.pdf). The front-end exposes features of this library in a basic text-based interface.

## Blocks Library

Blocks is a Swift library for evaluating pedestal routines according to the Code of Points. The library has a straightforward API, as demo'd in the `tariff` front-end.

A basic example of using this library:

```swift
import blocks

print("Enter the name of a skill: ", terminator: "")
let name = readLine()!
let skill = Skill.named(name)!
print("\(name) is worth \(skillValue(skill)) difficulty.")
```

## Tariff Front-end

Tariff is a program using the Blocks library. Its primary use-case is to read a list of elements and print the difficulty of the routine, as well as any potential issues with it.

Usage:
```
swift run tariff my_blocks_routine
```

Tariff takes in routine descriptions consisting of a list of skills separated by lines. It will then print out the results of additional calculations that are necessary on an official tariff sheet, such as difficulty value.
```
Silver Routine
Tuck
Pike
Straddle
Croc
Straddle
Handstand
Handstand FT
```

## Build Process

```
swift build
```

