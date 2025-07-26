# L2 - More SwiftUI

https://www.youtube.com/watch?v=sXiD-2XrkKQ

Recall: `struct ContentView: View` is not referring to a superclass like in OOP - in functional programming, this is, "behaves like a"

- source control
    - in tab bar, Source Control > Commit...
    - Source Control > Push
        - only works immediately because Git repo was set up when project created

- trailing closure syntax
    e.g. `ZStack (alignment: .top, content: {})` can be rewritten as `ZStack (alignment: .top) { // content body}`

- `RoundedRectangle` by default has a `.fill()`

- local vars in `@ViewBuilder`: can only have consts/vars, lists, and conditionals, no logic

- let vs. var: if property has default value and won't be changing, make it const., else needs to be var.

- type inference
    - option + click on var to see inferred type
    - Swift is strongly typed, knows all types at compile time
        - let it infer to reduce number of changes needed when type is changed

- `.onTapGesture`
    - view modifier
    - `.onTapGesture(perform: {})` but with trailing closure syntax: `.onTapGesture {}`
    - also has count argument for number of taps required before performing fn

- can print to console within preview (starting from XCode 14.3)
    - see "Previews" tab in console

- views are immutable
    - use `@State` to change vars in views
        - creates pointer to this, never changes but what it points to can change
- can use `.toggle()` on Bool to toggle value

- arrays can be written as `Array<String>` or `[String]`

```swift
    // index is an argument of the closure
    ForEach (0..<4, id: \.self) {index in ...}
    
    // can also use .indices which gives range of array
    ForEach (arrayName.indices ...) {}
```

- buttons
    - `Button("Text Label") {// action}`
    - `Button (action: {}, label: { Image (systemName: "globe") // allows you to use other views as label, like an image})`


- views
    - can be both `vars` (can also lie within same struct as `var body: some View`) or `structs`

- implicit return
    - HStack contains a View/ViewBuilder, HStack itself is still a function
    - if computed property/func only has one line (recall that HStack is technically one line + its body is its args), then that code is returned implicitly

- `LazyVGrid`
    - specify number of columns with `GridItem()` in an array
    - uses as little space as it can vs. HStack/VStack which use as much space as possible
    ```swift
    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()])

    // adaptive: fit as many items as possible in row
    // minimum: min. width of item
    GridItem(.adaptive(minimum: 65))
    ```

- use opacity instead of toggling fill of card, which changes its size
    - `base.fill().opacity(isFaceUp ? 0 : 1)`

- `Group`
    - like a `ForEach` of 1
    - helpful if you want to apply a view modifier to multiple views

- CardView sizing
    - use aspect ratio modifier: `.aspectRatio(2/3, contentMode: .fit)`
    - cards will overflow and push buttons off page, so place them in `ScrollView`