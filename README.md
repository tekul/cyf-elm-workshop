# Elm Workshop

## Prelude

Some reading and exercises to follow before the workshop.

* Elm has a different language heritage and hence different syntax to Javascript. Look through the
[Syntax vs JS](https://elm-lang.org/docs/from-javascript) and [Syntax](https://elm-lang.org/docs/syntax) pages.
* Read the [guide](https://guide.elm-lang.org/) up to and including `Web Apps`. Don't worry if there are bits you don't understand. You can skip the `Javascript Interop` section .

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

To see how much you've picked up, try these exercises based on the code examples at [elm-lang.org](https://elm-lang.org/examples). You can also transfer the code to https://ellie-app.com which is a bit like codepen for Elm. You can then share your code solutions or ask for help if you have problems by providing the link. You can also install the elm compiler locally using npm (`npm install -g elm`). This also provides a repl (`elm repl`).

#### [Hello World](https://elm-lang.org/examples/hello)

Extract a function `sayHello` and call that from `main` instead of using `text "Hello"` directly.
Add a type signature for the function. What is the type if we don't add a signature? Why don't we need to add explicit types everywhere?


#### Basic numbers

Paste the following code into the online editor at https://elm-lang.org/try.

```
import Html exposing (text)

main =
   text (String.fromInt (add 2 3))

add x y = x + y
```

Note that all functions from the ["core" module](https://package.elm-lang.org/packages/elm/core/latest/), such as `String.fromInt` are always available, but for others, such as `Html.text` we have to add `import` statements.

Add a `double` functions which takes a single argument and multiplies it by 2. Add a type signature for this and for the existing `add` function (assume all the numbers are of type `Int`).

What happens if you remove the `String.fromInt` call? Why?

Remember to hit the "compile" button when you've made a change.

Change the `add` function to

```
add (x, y) = x + y
```

What's the difference? Fix the signature and function call so that the program compiles again.

Bonus (partial function application): What is the type of `add 5`? Use this with the [List.map function](https://package.elm-lang.org/packages/elm-lang/core/latest/List#map) to add 5 to each element of the list `[1,2,3]`.


#### [Rendering HTML](https://elm-lang.org/examples/groceries)

The `Html` module exposes functions (such as `div`) for rendering the DOM. These usually take two arguments. The first is a list of attributes and the second is a list of child elements. Try expanding the HTML in the example with some more HTML elements you know of.

Add an import for the [HTML attributes](https://package.elm-lang.org/packages/elm/html/latest/Html-Attributes) module:

```
import Html.Attributes exposing (..)
```

Then use the `style` function to change the background colour for the main div. Check your code still compiles. Check the module documentation link above if it doesn't and look at the type signature for `style`. The compiler should also give you a hint about what is wrong.

#### [Buttons](https://elm-lang.org/examples/buttons)

##### Algebraic data types

The `Msg` type has two values, `Increment` and `Decrement`. Add a third option called `Reset`. Does the program still compile? Why doesn't the program compile? When might this compiler error be useful?

Handle the `Reset` message in your `update` function by returning the value `0` for the model.

Add an extra button at the bottom of the view which resets the counter.

At first, this might seem similar to enums which you have seen in other languages, but it is actually more powerful.

Change `Reset` to be `Reset Int`. This makes `Reset` a constructor for the type `Msg` which takes an integer argument (the value you want to set it to). If we create this type in the repl, we can see that `Reset` is actually a function of type `Int -> Msg`:

```
> type Msg = Increment | Decrement | Reset Int
> Decrement
Decrement : Msg
> Reset
<function> : Int -> Msg
> Reset 1
Reset 1 : Msg
```

#### [Input Fields](https://elm-lang.org/examples/text-fields)

In this example, the model uses a record format with a `content` field. Try changing it to be a plain String:

```
type alias Model = String
```

and get the program to compile and work as before.

Bonus: For the buttons example, add an input field to set the counter directly, defaulting to zero if a non-integer is entered (you can use [the `toInt` function](https://package.elm-lang.org/packages/elm/core/latest/String#toInt) to convert the string value to an integer. Read the example code for the `toInt` function to see how to deal with invalid input (i.e. where the function returns `Nothing`).


#### [Let blocks](https://elm-lang.org/examples/time)

The `view` function at the bottom of this example uses a `let` block. What is this for? Can you rewrite the function without the `let` block so that it still does exactly the same thing?

Can we say anything about the order in which the expressions in a `let` block are evaluated? Does it matter? Does reordering them have any effect?

Change the `view` function to return `Html msg` rather than `Html Msg` and recompile. Why can we do this here, but not in the previous examples?

#### [Form](https://elm-lang.org/examples/forms)

Add an extra validation check that the `password` field is greater than 8 characters, which is carried out before the check on whether the passwords match.

#### [Http (Book)](https://elm-lang.org/examples/book)

Change the URL used in `Http.get` to an invalid one and recompile the program. You should see an error message. Where is the error case handled? Try removing the code which handles the `Failure` case and recompile.

#### [Http (Cats)](https://elm-lang.org/examples/cat-gifs)

Try disconnecting your machine from the network and click the "More please!" button. You should see a generic error message as in the books example. We want to improve the error message so that the user gets more information on what went wrong, such as whether the connection failed or there was a server error.

Look at the `Msg` type and the `getRandomCatGif` function which is called when the button is pressed. You will see that the `GetGif` message is used to pass the result of the request to our program. `GetGif` has a parameter of type `Result Http.Error String`. [`Result`](https://package.elm-lang.org/packages/elm-lang/core/latest/Result#Result) is a type which captures the posibility of an operation failing. In our case we get a `String` if the request succeeds and an `Http.Error` otherwise.

Find the place where the `GetGif` message is handled and the code pattern-matches on the `Result` cases, `Ok` and `Err`. You will see that it ignores the details of the `Err` case, just matching on `Err _` which ignores the details of _why_ the error occurred. Change the `Failure` constructor in our `Model` so that it stores the `Http.Error` value in the same way the `Success` value stores the `String`.

Have a look at the [`Http.Error`](https://package.elm-lang.org/packages/elm-lang/http/latest/Http#Error) type. Write a function which converts this type into a more useful error message which explains whether the network is down or the server returned an error code.

Replace the generic error message in the view with a call to your new function. Test it by disconnecting or requesting the URL to another API (e.g. https://api.github.com) which provides incompatible data.

