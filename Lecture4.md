# L4 - Applying MVVM

- cont. creating ViewModel
- in View, connect it to the ViewModel: `var viewModel = EmojiMemoryGame`
    - this is partial separation since the view can access the viewmodel which has access to the model
    - to have full separation:
        - make model private in ViewModel: `private var model: MemoryGame<String>`
        - for view to access cards, need to return them: `var cards: Array<MemoryGame<String>.Card> { return model.cards }`
        - for functions, would need to call the model's functions: `func choose(card: MemoryGame<String>.Card) { model.choose(card: card)}`

- `private (set)`: only setting the variable is private, looking at it is public

- initializer for model
    - take in arg: numberOfPairsOfCards
    - init vars: `cards = Array<Card>()` or `cards = [Card]()` or `cards = []`
    - need to add cardcontent, but model doesn't have this info, viewmodel does
        - pass in function as type

- can also use `_` in for-in if element not used in loop body
- to convert global func to closure: replace `{` with `in`, move `{` to front, remove any arg labels, remove types + extra parentheses
    - if this is for the last arg of a computed prop/func, can make it the var's body (trailing closure syntax)

    ```swift
    private var model = MemoryGame(
        numberOfPairsOfCard: 4,
        cardContentFactory: {(index: Int) -> String in
        return ["", "", ""][index]
    })

    // can rewrite as
    private var model = MemoryGame(numberOfPairsOfCard: 4) {index in
        return ["", "", ""][index]
    }
    ```

- can't use properties when initializing another one, soln:
    - make the property a global var (not the best)
    - add `static`: makes the var global but namespaced within class
        - even better: `private static`
        - also works for funcs:
            ```swift
            private var model = createMemoryGame()

            private static func createMemoryGame() -> MemoryGame<String> {
                ...
            }
            ```

- cmd + click to rename struct (semantic rename)
    - doesn't pick up on previews

- to have emojis fit within card:
    - set GridItem's hspacing and vspacing to 0
    - add padding to card view
    - give card text a large system font size
    - use `.minimumScaleFactor(0.01)`: when the content doesn't fit, you can scale it down by this much
    - use `.aspectRatio(1, contentMode: .fit)`: set 1:1 aspect ratio

- for any function in model that mutates its properties, add `mutating` keyword

- add `ObservableObject` protocol to Model to make it reactive 
    - this protocol includes a var: `objectWillChange`
        - use in function that will cause change, like shuffle:
        ```swift
        func shuffle() {
           model.shuffle()
           objectWillChange.send() 
        }
        ```
    - won't need to use this ^
    - instead, mark any var that can cause change with `@Published`, use on model var
        - in View, mark ViewModel var as `@ObservedObject`
            - never have `@ObservedObject` assigned to something, should be passed in
            - use `@StateObject` if you really need to:
                - still set to `@ObservedObject`, but when instance created, pass in `@StateObject`