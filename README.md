# Elm Workshop

## Prelude

Some reading and exercises to follow before the workshop.

* Elm has a different language heritage and hence different syntax to Javascript. Look through the
[Syntax vs JS](http://elm-lang.org/docs/from-javascript) and [Syntax](http://elm-lang.org/docs/syntax) pages.
* Read the [guide](https://guide.elm-lang.org/) up to and including `Error Handling and Tasks` (forget about `Task` for now). Don't worry if there are bits you don't understand. You can also skip the `Web Sockets` section in `Effects`.

### Some questions to think about

* What are functions?
  - How are functions different in Elm than Javascript?
* What are types?
  - What types does Javascript have? When do you you get an error if types are inconsistent?
  - Does Elm support inheritance?
  - Are any types in an Elm program decided at runtime or is everything known at compile time?
  - Does Elm have `undefined` or `null` values?
  - How many possible return values can there be for a single implementation of a function with type `f : Bool -> Int` ?
  - What can you say about the implementation of the function `f : List a -> List a`? Can it change any of the values in the list? What about `f : List Int -> List Int`? (Remember that lower-case names are type parameters, so `List a` means a list containing any type, whereas `List Int` means a list containing `Int` values).
  - How many possible implementations are there for the function `f : a -> a`?


### Basic Exercises

To see how much you've picked up, try these exercises based on the code examples at [elm-lang.org](http://elm-lang.org/examples). You can also transfer the code to https://ellie-app.com which is a bit like codepen for Elm. You can then share your code solutions or ask for help if you have problems by providing the link.

#### [Strings](http://elm-lang.org/examples/strings)

Add some other strings created using functions like `slice` and `cons` from the [String module](http://package.elm-lang.org/packages/elm-lang/core/5.1.1/String).

#### [Define Functions](http://elm-lang.org/examples/define-functions)

Add a type signature for the `factorial` function. What is the type if we don't add a signature? Why don't we need to add explicit types everywhere?

Add a `double` functions which takes a single argument and multiplies it by 2. Add a type signature for this and for the existing `add` function.

Bonus (partial function application): What is the type of `add 5`? Use this with the [List.map function](http://package.elm-lang.org/packages/elm-lang/core/5.1.1/List#map) to add 5 to each element of the list `[1,2,3]`.


#### [If](http://elm-lang.org/examples/if)

Try the suggestion in the comment above the `assessPowerLevel` function.

#### [Case](http://elm-lang.org/examples/case)

Try removing the `_ -> "many"` form the case statement. Why doesn't the program compile? When might this compiler error be useful?

#### [Let](http://elm-lang.org/examples/let)

Read the two versions of the function and realize that they are the same thing.

Can we say anything about the order in which the expressions in a `let` block are evaluated? What about if we replaced the `in` with `String.toUpper otherLetters` (i.e. ignore `firstLetter`) ?

#### [Pipes](http://elm-lang.org/examples/pipes)

Again read the two versions and realize they are the same.

#### [Unordered list](http://elm-lang.org/examples/unordered-list)

On line 2, change the import of `class` to `style` and hit the compile button. You should get a compiler error at line 15, because the function `class` is no longer available:

```
Cannot find variable `class`

15|   ul [class "grocery-list"]
^^^^^
Maybe you want one of the following?
    clamp
    Html.Attributes.class
    Basics.clamp
    Debug.crash
```


Replace this line with:

```
  ul [style [("background-color", "pink"), ("width", "300px"), ("margin","auto")]]
```

Look at the type signature for the [`style` function](http://package.elm-lang.org/packages/elm-lang/html/2.0.0/Html-Attributes#style). What type is the first argument?

In future examples, you might need to change some of the imports from the [html](http://package.elm-lang.org/packages/elm-lang/html/latest) or [http](http://package.elm-lang.org/packages/elm-lang/http/latest) packages as we've done here, or add imports from other modules.

#### [Buttons](http://elm-lang.org/examples/buttons)

Add type signatures for `model`, `update` and `view` and make sure the program still compiles.


##### Union types

The `Msg` type has two constuctors, `Increment` and `Decrement`. Add a third called `Reset`. Does the program still compile?

Handle the `Reset` message in your `update` by returning the value `0` for the model.

Add an extra button at the bottom of the view which resets the counter.

Look at the `fields` example code and then see if you can add an input field to set the counter directly, defaulting to zero if a non-integer is entered (you can use [the `toInt` function](http://package.elm-lang.org/packages/elm-lang/core/5.1.1/String#toInt)) to convert the string value to an integer.

#### [Form](http://elm-lang.org/examples/form)

Add an extra validation check that the `password` field is greater than 8 characters, which is carried out before the check on whether the passwords match.

#### [Radio Buttons](http://elm-lang.org/examples/radio-buttons)

Add a `Huge` constructor to the `FontSize` type which sets the font size to `2.0em`.

#### [Http](http://elm-lang.org/examples/http)

Try disconnecting your machine  from the internet and hitting the "More please!" button. Nothing happens. Why? Where are errors handled in the code?

Improve the error handling by adding a `lastError : Maybe Http.Error` field to the model record and pattern matching on different cases of the [`Http.Error`](http://package.elm-lang.org/packages/elm-lang/http/1.0.0/Http#Error) type to set it. Report different error messages if the network is down or if the server returned an error code.

#### [Time](http://elm-lang.org/examples/time)

Change the `view` function to return `Html msg` rather than `Html Msg` and recompile. Why can we do this here, but not in the previous examples?
