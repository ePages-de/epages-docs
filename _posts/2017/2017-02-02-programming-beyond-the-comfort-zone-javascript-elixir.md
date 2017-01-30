---
layout: post
title: "Programming beyond the comfort zone: JavaScript |> Elixir"
date: "2017-02-02 07:00:00"
image: blog-header/drink.jpg
categories: tech-stories
authors: ["Erik"]
---

I'm a JavaScript Engineer.
I write JavaScript.
I really like writing JavaScript and I feel very comfortable doing so.
In the JavaScript world there are a gazillion web frameworks available and every week there are more coming.
Besides the usual suspects like `express` and `hapi` there are a lot of things that are fun to play with like zeit's `micro`.
Although having some different concepts they all have something in common: They're (of course) JavaScript frameworks.
Now if you want to learn more about the HTTP stack or the request and response cycle you should definitely check out a lot of different frameworks since different concepts give you different insights and perspectives of the inner workings.

So why should you start programming in some other language?

Let's take a step back from the frameworks and look at the language itself.
JavaScript claims to be both object-oriented (with prototypal inheritance) and functional.
And since it's both, it's neither nor to a satisfying extend.
Other languages like Elixir (which we're going to talk aboutin a bit) make it much easier to use functional language features and methods such as *destructuring*, *pattern matching* or *recursion*.
You might shift from doing everything with a `forEach` loop to solving pretty much every problem with `reduce`.
This paradigm shift not only broadens your programming knowledge but lets you view problems (and more importantly their solutions) from a different angle.
On top of that it impoves code readability most of the time ;)

Now what if I told you that you can learn all of this by using a web framework (and language) that is not only fun to work with but also faster and less error prone than all of the before mentioned?

### Enter: Elixir and Phoenix

This is rather a teaser that should make you curious about trying out something new and leaving your comfort zone than a full blown tutorial or language reference.
This first part will take a look at how **Elixir** might help you to rethink programming patterns leading to cleaner code and continue with what this **Phoenix** thing actually is.

### The Platform

Before we explore some Elixir code, let's start with a naive JS example of populating an array - mutation style.
Don't fraud, I've seen a lot of people (including myself) starting like this (which is totally fine).

```js
const myNumbers = [-2, 3, 5, -34, 0, 32]
@@ -38,7 +38,7 @@ const result = myNumbers
 .map(num => num * 2)
```

This time we see that `result` will contain the double of all positive numbers from the source array.
Way more explicit isn't it? For the record this is how the above would look in Elixir:

```elixir
my_numbers = [-2, 3, 5, -34, 0, 32]
@@ -48,16 +48,16 @@ result = my_numbers

```

This pretty much resembles the JavaScript solution right?
Almost.
Since Elixir is based on immutable data you could not have started like in the first JavaScript solution.
One does not simply mutate a data structure in Elixir! What you would have done is creating a new list with every value from the old one that you see fit.
Besides that there are some other oddities.
The `|>` is called a pipe operator and passes the value as the first argument to the next function.
While we're using the `fn` keyword to define an anonymous function as the `filter` expression and explicitely naming the variable `num` we're shortening this for the `map` function and just say "*This function uses the first argument (`&1`) it receives and doubles it*".

Let's take the example from above again.
In contrast to JavaScript we can use some sugar in Elixir called a `for` comprehension in conjunction with a filter to loop over the enumerable and create a new one (with all values > 0 doubled).

```elixir
my_numbers = [-2, 3, 5, -34, 0, 32]
result = for n <- my_numbers, n > 0, do: n * 2
```

Note that the last statement of every Elixir function is automatically returned creating a new list bound to `result`.
What actually looks like an assignment `=` is actually a `match`.
Trying to match `result = 4` afterwards will give you an error since the compiler tries to match `[6, 10, 64] = 4`.
This might look strange at first but makes more sense once you grasp concepts like pattern matching or destructuring.

Since we now have seen some language features I have to bore you with some facts.
Elixir runs on the Erlang VM (BEAM) and gives you the great ecosystem companies like *Heroku* and *WhatsApp* use to build their products.
It kind of relates to Erlang like Scala relates to Java (JVM).
Likewise you can import Erlang modules and use them right away.
Elixirs syntax is concise and reminds of the Ruby programming language due to the fact that creator José Valim is a very active member of the ruby community.
