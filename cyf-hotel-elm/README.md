Hotel booking app in Elm, similar to [cyf-hotel-react](https://github.com/CodeYourFuture/cyf-hotel-react). 

# Build

You need to have Elm 0.19.1 installed locally (`npm install -g elm` should work).

Then run:

```
elm make --output=app.js src/Main.elm

```

to compile the code to Javascript. Load the app via the `index.html` file. You can also use the `elm reactor` command to run a web server locally.
