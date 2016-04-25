---
layout: post
title: "On the way to full stack ECMAScript 6"
date: "2015-11-16 12:00:00"
categories: tech-stories
authors: ["Paolo"]
---

**JavaScript is moving fast these days.** With all the languages out there compiling to it, JS itself is making a big leap forwards with the standardisation of its next version called _ECMAScript 6_ (or _ES6_, or _ECMAScript 2015_, or _ES2015_. [Naming is probably the hardest programming related task](https://twitter.com/a_ramella/status/656522461480099840), and if you think that _ECMAScript sounds like a skin disease_, you're [in good company with the inventor of JavaScript himself](https://mail.mozilla.org/pipermail/es-discuss/2006-October/000133.html)).

In this post, I want to share things we've learned during our ongoing adoption of the new language features.

## JS @epages
My team and I are working on an upcoming part of the ePages software that provides an easy to use drag-and-drop editor for the layout and appearance of an ePages shop. It also serves the actual shop website by displaying all product and editorial data in that layout.

Under the hood this means aggregating and manipulating JSON data from various REST resources, and providing a live preview of the result in the layout edit mode. Both are tasks JavaScript is really good at, so my team does **JS all the way** from the (Mongo) database through the (Node) server down to the browser.

## JavaScript modules revisited
One of our pains as JavaScript developers has always been **the lack of a module system**. Node.js introduced the _CommonJS_ approach consisting of `module.exports` and `require('module')`, which works well on the server but not on the client. That's because in the browser, we have network latency, and thus loading a module is an asynchronous operation. When we started our project, _RequireJS_ solved this for us as elegant as it can get without introducing a compile step, using its _AMD_ (asynchronous module definition) syntax, consisting of `define(['module'], function (module) {...});`.

But we're writing isomorphic JavaScript, which is a fancy way of saying: running (parts of) the exact same code on client and server alike. If you're doing this in combination with RequireJS, you can easily get a headache from looking at statements like `var require = require('requirejs');`.

**Enter _Webpack_.** Just like its cousin _Browserify_, it gets around the asynchronous loading issue by introducing a build step that compiles related modules into _bundles_. As a bonus, it offers a variety of pluggable _loaders_ that can transform things before putting them into the bundle. In our case this comes in handy for including _React JSX_, _Less_ CSS and _Dust_ template files.

## Suddenly, ES6
But the biggest benefit comes with the **_Babel_** Webpack loader. Using the widespread _Babel_ transpiler, formerly known as _6to5_ because it rewrites ES6 (and ES7) code to the ES5 language level every browser understands, we can now use most standardised ES6 features right away! Coming back to our module challenge, this adds to the list of module systems supported by Webpack (which comes with CommonJS and AMD support built in) **the canonical module system of ECMAScript 6**.

Let's have a look at some of our ES6 module code:
{% highlight javascript %}
import {DragSource} from '../../utils/DragAndDrop';
import Immutable from 'immutable';
import ImmutablePropTypes from 'react-immutable-proptypes';
import React from 'react';

export default class ImagePlugin extends React.Component {
  constructor() {
    super();
{% endhighlight %}

Much leaner than good ol' RequireJS syntax, isn't it?
The alert reader might notice some more ES6 novelties here: Yup, ES6 introduces the `class`, `extends`, and `super` keywords as syntactic sugar over JavaScript's prototypal inheritance system, something you might have already been using in other ECMAScript dialects like TypeScript (or, in my case, ActionScript 2).
When our Java colleagues saw this the other day, they went like: **"Oh, this looks almost like Java!"**. Dear Jens, to a JS developer this is _not a compliment_ ;)

## But wait there's more
Another much-awaited ES6 feature we have heavily adopted is **_arrow functions_ or _lambdas_**. One nice thing about them, especially for the Java developer new to JavaScript (hello Jens), is that unlike traditional JS functions they don't introduce their own `this`.

But in my team we love them for writing functional asynchronous code like this:
{% highlight javascript %}
return {
  ...
  cart: req.session.cartId
    ? model.cart.find(shop._id, req.session.cartId)
      .then(cart => Object.assign(cart, {
        totalNumberOfItems: cart.lineItems.reduce((total, item) => total + item.quantity.amount, 0)
      }))
      .catch(JsonHttpClientError, (err) => {...}
    : {}
};
{% endhighlight %}

Prior to ES6, the above code would have contained three times `function (...) {...}` and `return`, alongside some extra line breaks and curly braces. **CoffeeScript addicts will feel right at home!**
Once again, the alert reader might notice that we're making use of two other awesome ES6 features in the above code: _Promises_ for dealing with asynchronous execution, and `Object.assign` for library-free data structure augmentation.

But the list doesn't end here: [template strings](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/template_strings), `let` and `const`, and [Object literal extensions](https://github.com/lukehoban/es6features#enhanced-object-literals) are all things we're using in our client side code thanks to Babel and Webpack, and on the server thanks to V8/Node.js supporting them natively. That's right: **We're not yet using Babel on the server**, but once we've found the time to do that as well we'll address it in a follow-up post.

## So what's the bad news?
As always, **there are a few gotchas** that we've stumbled upon during our transition to ECMAScript 6:

First of all, you'll need to update your tool set to support ES6. In our case, this meant switching to [an ES6 supporting fork](https://github.com/deedubs/es6-plato) of the _Plato_ complexity analysis tool, and turning on ES6 support in the _ESlint_ linter.
Since code coverage measures shouldn't be affected by transpiler output, we had to include the [_Isparta_](https://github.com/douglasduteil/isparta) library, which, again via a fork, enables the _karma-coverage_ task to provide _Istanbul_ code coverage for ES6.

Another issue is **debugging ES6 code**. The browsers' developer tools do a great job when it comes to displaying the original ES6 code in the source code view,  thanks to _source maps_. But they stop there. Scope variables currently don't use source mapping, which is why you'll still have to deal with transpiler output like `_react2.default` while inspecting code from within a breakpoint.

Speaking of breakpoints: With the beauty of one-liner arrow functions, I sometimes find myself adding line breaks and curly braces just to be able to set a breakpoint inside a `filter` predicate function.

## TL;DR
Wrapping up, we're really excited about using ES6 features today, and have found our code to be more concise and readable at the same time.
On the other hand, ES6 is still quite new, and we're all just getting familiar with the big list of new features (or did you know that in an ES6 _Set_, ["NaN is considered the same as NaN (even though NaN !== NaN)"](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Set)?).

So stay tuned for even more ES6 goodness, and in the meantime [learn ES6 by TDD](http://es6katas.org/) and share your experience with us!
