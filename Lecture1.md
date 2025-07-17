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