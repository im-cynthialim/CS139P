# L5 - Protocols, Enums, and Constraints

- `@ObservedObject` vs `@StateObject`
    - `@ObservedObject`: just used to observe an object
        - scoping: can be passed to sibling view as well
    - `@StateObject`: var comes into existence when view (where this is used) comes onto screen - tied to lifetime of view (if used in app, then exists during throughout entire lifetime of app)
        - scoping: can only be used in its view or any subviews

- small animation
    - add `.animation` view modifier to a view
    - only animates when `value:` changes
    ```swift
        cards
            .animation(.default, value: viewModel.cards)
    ```
    - requires that cards be equatable (so that differences to `viewModel.cards` are actually possible through comparing the before + after array)
        - set `struct Card: Equatable`, need to also implement `static func ==` function
            - for card: check that `lhs.isFaceUp == rhs.isFaceUp` && both match && contents match (<- but this requires CardContent to be Equatable, so add constraint to MemoryGame: `struct MemoryGame<CardContent> where CardContent: Equatable`)
            - can now remove `==` func if implementation just involves `==` for each var
    - running animation now is iffy, they just fade in/out
        - ForEach of cards is wrong cause we're iterating through indices of the array + making a view for each one - indices get shuffled around but `ForEach` still sees the same card at index 0
        - instead want to loop through the actual cards - when card moves, view moves
            - fix: `ForEach(viewModel.cards, id: \.self) { card in CardView(card)}` instead of `ForEach(viewModel.cards.indices...)`
            - small failure: `id: .\self` doesn't work anymore
                - need to conform to Hashable but hashing wouldn't work since card's "state" changes
                - removing `id` arg requires you to conform to Identifiable


- conforming to Identifiable
    - `struct Card: Equatable, Identifiable`
        - to conform, need `var id`
        - for the card, make the id a String
            - in init, can create an id using `\(pairIndex+1)` + a or b

- `CustomDebugStringConvertible` protocol
    - add `var debugDescription: String {}`
    - use to change String name in debugger console


- ViewModel Intents - user's intentions/actions trigger UI
    - functions like shuffle + choose in EmojiMemoryGame (viewModel)
        - calls model's (aka MemoryGame) shuffle/choose function which has implementation
    - used as `viewModel.choose(card)` when tapping on card to flip over 
    - can't use `.toggle()` because of value vs. reference types - you've passed in a value type (a copy of the card)
    - to find right card for `choose` function, rather than iterating through, re-write cleanly:
        ```swift
        mutating func choose(_ card: Card) {

            // firstIndex returns Optional Int
            if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
                cards[chosenIndex].isFaceUp.toggle()
            }
        }
        ```

- enum
    - holds different states, value is discrete
    - is a value type like struct - value is copied when passed around
    - no stored properties but methods + computed props. allowed
    - has associated data for cases (`case hamburger(numPatties: Int)`)
        - for switch statement: can use `let` to use args in case `...(let numPatties: Int) { ...\(numPatties)}`
    - switch statement: use `fallthrough` as last line of a case to fall through
    - to iterate through enum, make it conform to `caseIterable`: `enum TeslaModel: CaseIterable`
        - can now iterate with: `for case in myEnum.allCases {}`

- Optionals
    - an enum
    ```swift
        enum Optional<T> {
            case none
            case some(<T>)

            // var hello: String? = nil --> var hello: Optional<String> = nil
            //  " = "hi" --> " = .some("hi")
        }
    ```

- get + set for computed property
    - to get one and only facing up card, create an empty array that will hold all faced up cards, iterate through all cards, append to array if face up + if array count == 1, return first card else return nil
    - to set, find card at `newValue` index make it face up, all other cards face down
    - improve with functional programming
        - for get: `cards.indices.filter { index in cards[index].isFaceUp}` and return this array if count == 1
        - for set: `return cards.indices.forEach { cards[$0].isFaceUp = ( newValue == $0)}`
            - `cards[$0]` = the element at index $0 of the array, which is the current index since we're looping through cards


- extensions
    - add computed property `only` to Array which returns 1 or nil depending on count of array: 
    ```swift
        extension Array {
            var only: Element? {
                count == 1 ? first : nil
            }
        }
    ```