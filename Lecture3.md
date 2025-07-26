# L3 - MVVM

## MVVM
- want to separate logic and data from UI (can have no/little separation, full separation, partial separation)
- model is UI independent
- view should be stateless + declared
- viewModel binds View to Model, publishes model's changes which View automatically observes, View rebuilds based on changes
    - also processes intents from user when interacting with View, modifies Model
- ViewModel:
    - `ObservableObject`
    - `@Published`
    - `objectWillChange.send()`

- View:
    - `@ObservedObject`
    - `@Binding`
    - `.onReceive`
    - `@EnvironmentObject`
    - `.environmentObject()`


## Varieties of Types
- structs + classes
    - both have: stored vars, computed vars, consts, functions, initializers
    - difference:
        - struct;
            - value type: struct stored in var
            - copied when passed/assigned
            - "free" init, inits all vars
        - class:
            - reference type: have pointer to class
            - "free" init, doesn't init vars
            - UIKit is class-based
            - used for ViewModel, cause it's used by lots of views, take advantage of that sharing property of classes

## Generics
- sometimes want type-agnostic data structures
- Swift is strongly-typed, so things can't just be untyped
    - use "don't care" types, known as type parameters
    - e.g. 
    ```swift
    struct Array<Element> {
        func append(_ element: Element) {}
    }

    // Element is just a placeholder for a type
    
    var a = Array<Int>()
    a.append(4)
    ```

## Protocols (part one)
- class/struct with no implementation, just describe behaviour
    e.g.
    ```swift
    protocol Moveable {
        func move(by: Int)
        var hasMoved: Bool { get }
        var distanceFromStart: Int {get set}
    }

    // implementing Moveable
    struct PortablThing: Moveable {
        // has to implement all the funcs and define vars
    }
    // PortableThing will now conform to/behave like a Moveable

    // can also have protocol inheritance - one protocol inherits from another
    protocol Vehicle: Moveable {
        var passengerCount: Int { get }
    }

    class Car: Vehicle {
        // implement everything from Moveable and Vehicle
    }

    // can also implement multiple protocols
    class Car: Vehicle, Leasable {
        // implement everything from Vehicle and Leasable
    }
    ```
    - a protocol is a type (more on this later)
    - protocols specify behaviour of a struct/class/enum
        - constrains + gains: can constrain another type (e.g. View is a protocol and needs to implement `var body`), gives lots of gains (e.g. View gets tons of free functions)

    - protocols turn "don't care" types into "somewhat cares"
    e.g. `struct Array<Element> where Element: Equatable`
        - only things that are equatable can be in the array

    - other protocols: Identifiable, Hashable, Equatable, CustomStringConvertible, Animatable

## Functions as Types
- can declare a varaible to be of type function
    e.g. `(Int, Int) -> Bool`, `() -> Void`

- closures: inline functions, recall that they can be args to functions

## Demo - implementing MVVM
- Model: 
    -  be sure to add file to folder rather than xproj
    - `import Foundation` contains all the basic Swift things like data structs
    - don't import SwiftUI for model
    - add `Card` struct within model struct for namespacing (aka modelStructName.Card)
- ViewModel - specific to memory game using emojis
    - import SwiftUI
    - if using superclass, list that first before protocols
    - connect to model: `var model: MemoryGame<String>`
