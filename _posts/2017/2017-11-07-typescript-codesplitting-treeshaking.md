---
layout: post
title: "Code splitting and tree shaking with Typescript and Webpack"
date: "2017-11-07 13:41:02"
image: blog-header/sunny-road.jpg
categories: tech-stories
authors: ["Christian H."]
---

These days, single page applications are all around and bring application-like user experience to the browser.
If done naively, the JavaScript for the application can get very big.
You will experience difficulties in terms of network transfer, but also the client browser has to parse a lot of JavaScript upfront before being able to make the application interactive.
This is especially a challenge for mobile devices.
To reduce initial loading and parsing of unneeded JavaScript there is [code splitting][code-splitting].
To drop unused code all together there is [tree shaking][tree-shaking].
This blog post will show you how to get these two working with your [TypeScript][typescript]+[Webpack][webpack] project in a step-by-step guide.

## TypeScript configuration

Most users will configure the TypeScript compiler to use `"es5"` as `target`, and hence do a complete compiling from TypeScript down to browser compatible ES5 JavaScript.
But Webpack will not be able to do tree shaking anymore as it will only see `require` instead of ES6 `import`.
Code splitting would still be possible, if you use Webpack's proprietary `require.ensure`, but this is not a nice solution: Your IDE won't be able to give type information anymore.
To solve this, you should choose `"esnext"` as a target and as a `module`.
Basically what you need is, that the TypeScript compiler does not change anything, but also strips TypeScript typing information from the code.
To achieve that, the important configuration in your `tsconfig.json` should look like this:

{% highlight javascript %}
{
  "compilerOptions": {
    // leave JSX as it is
    "jsx": "preserve",
    // resolve modules as you would expect
    "moduleResolution": "node",
    // leave imports as they are
    "module": "esnext",
    // do not transpile stuff like classes, async/await, ...
    "target": "esnext",
    // produce a source map
    "sourceMap": true
  }
}
{% endhighlight %}

## Babel configuration

Now you will get JavaScript that uses a bunch of features, that are not widely supported by now.
With the preset `babel-preset-env` you just define what browser you want to support. The preset `babel-preset-env` will configure [Babel][babel] to precisely transpile only what needs to be transpiled to run in the browsers you chose. Your `.babelrc` should look somewhat like this:

{% highlight javascript %}
{
  "presets": [
    "react",
    [
      "env",
      {
        // leave imports as they are
        "modules": false,
        "targets": {
          "browsers": [
            // choose browsers you want to support
            "last 2 chrome versions"
          ]
        }
      }
    ]
  ],
  "plugins": [
    // support dynamic import syntax, but leave it unchanged
    "babel-plugin-syntax-dynamic-import"
  ]
}
{% endhighlight %}

Two important things to notice here: You must tell `babel-preset-env` to not touch the modules, meaning it will just keep import statements like `import a from './b'` as they are.
In addition you have to add `babel-plugin-syntax-dynamic-import` as plugin to keep dynamic import statements like `const a = await import('./b')` untouched.
You now have compiled your TypeScript down to JavaScript that is compatible with the browsers of your choice, but with the original (dynamic) imports.

## Webpack configuration

As final step, we have to configure Webpack accordingly.
You would use your `awesome-typescript-loader` as usual, but add the `useBabel: true` option (which is the same as prepending the `babel-loader` in the rules chain).
The important parts of your `webpack.config.js` would look like this:

{% highlight javascript %}
module.exports = {
  target: 'web',
  entry: {
    app: ['./index.ts'],
  },
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: [
          {
            loader: require.resolve('awesome-typescript-loader'),
            options: {
              // compile with TypeScript, then transpile with Babel
              useBabel: true,
            },
          },
        ],
      },
    ],
  },
  // produce sourcemap
  devtool: '#sourcemap',
}
{% endhighlight %}

That's it.
Now you not only enabled Webpack to do code splitting and tree shaking, but you also reduced your JavaScript asset size even more, because the use of `babel-preset-env` instead of letting TypeScript do the whole compilation.
For example, `async`/`await` will most likely just be in your resulting JavaScript instead of being transpiled to generators, which is just way shorter.

## TL;DR

Let's wrap up with a brief overview of what had to be done:

1. Configure TypeScript compiler to leave code more or less untouched by using `"esnext"` as target.
2. Add Babel configuration to transpile with `babel-preset-env` preset while not touching imports or dynamic imports.
3. Tell Webpack to use TypeScript + Babel, either by configuring `awesome-typescript-loader` or by manually adding `babel-loader`.

To see everything in action, I prepared a [demo repository](https://github.com/ePages-de/typescript-babel-webpack-treeshaking-codesplitting-demo).

[code-splitting]: https://webpack.js.org/guides/code-splitting/
[tree-shaking]: https://webpack.js.org/guides/tree-shaking/
[webpack]: https://webpack.js.org/
[typescript]: https://www.typescriptlang.org/
[babel]: https://babeljs.io/
