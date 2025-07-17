# L1 - Getting Started with Swift

## Video Lecture 

https://www.youtube.com/watch?v=n1qabtjZ_jg

### XCode environment
Covers:
- Creating an XCode project
- Building onto simulator
- Using preview pane (canvas)
    - run mode vs select mode
- Navigation: files, tabs, path bar
- Right pane: inspector
    - shows all the properties you can change + change updates code
- Bottom panes: debugger (left) + console (right)


### Code
- structs aren't classes, no inheritance happening
- functional programming/protocol-oriented programming
    -  data encapsulation, behaviour
    - `... : View` => "behaves like a View"
        - to behave like a View, have `var body: some View` within struct
    - computed property (e.g. `var body: some View {whatever's in here}`)
        - computed = value of `body` is computed every time, not stored
        - `var i: Int` is a stored property
    - `some View`: `some` = can be any struct as long as it behaves like a View, determined when computed
- creating instances of structs
    - e.g. `Text("")`
- named parameters
    - e.g. `Image(systemName: "globe")`
- parameter defaults
    - e.g. `VStack` - by default, centers content
        - is a function
        - contains a TupleView, which it takes in as an arg
        - within, can list views, use conditionals, declare local vars
        - alternatively written as:
        ```swift
        VStack(content : {
            Image(...)
            Text(...)
        })
        ```
    
- `@ViewBuilder` - turns list of views into TupleView
- **View Modifiers**
    - functions applied to a view that returns a view
    - e.g. `.imageScale` and `.foregroundColor`
    - scope matters
    
- Shapes
    - `RoundedRectangle(cornerRadius: )`
    - `Rectangle()`
    - `Circle()`

- Variants
    - bottom bar of canvas
    - Color Scheme Variants: dark/light mode
    - Orientation Variants: portrait/landscape
    - Dynamic Type Variants
    - can also set this as main canvas view using switch button (canvas device settings)


- MemorizeGameApp
    - building card
        - use 2 rounded rectangles: 1 for stroke, other for white background
        - add bool `isFaceUp`

## Reading Assignment

### Simple Values
- `var`, `let`
- string 

### Control Flow
- `for`
    - `for i in 0..<4` to add a range that goes from 0 to 3
    - `...` to include upper value
- `while`
- unwrap with `if let`

### Functions and Closures

```swift
func greet(_ person: String, on day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet("John", on: "Wednesday")
```
- use `_` to use no argument label
- can also customize arg labels, place before parameter name
- possible to return tuples
    - e.g. `... -> (min: Int, max: Int, sum: Int) {}`
- nested functions can use variables declared in outer function
- functions can return functions
    ```swift
    func makeIncrementer() -> ((Int) -> Int) {
        func addOne(number: Int) -> Int {
            return 1 + number
        }
        return addOne // returning the function, not calling it
    }
    var increment = makeIncrementer()
    increment(7)
    ```
- functions can also take a function as an arg
- closures: blocks of code that can be call later
    - can access vars/funcs available in scope where it was created, even if caled elsewhere
    - closure without name: surround code with `({})`:
        ```swift
            // map takes each element of numbers and applies the closure to it
            // e.g. numbers = [1, 2, 3], returns numers = [2, 4, 6]
            numbers.map({ (number: Int) -> Int in
                let result = 2 * number
                return result
            })
        ```
        - <mark>aside:</mark> map is a higher-order function
        - can omit params type and/or return type
            - single statement closures return the value implicitly
        - can refer to params using numbers (`$0`: first param, `$1`: second param)
        
### Objects and Classes

### Enumerations and Structures

### Generics

###