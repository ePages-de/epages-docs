---
layout: post
title: "Go'ing forward"
date: "2017-08-01 08:00:00"
image: blog-header/golang-library.jpg
categories: tech-stories
authors: ["Carsten", "Karsten"]
---

Long time no see guys.
In our last blogpost we talked about [pipelines](https://developer.epages.com/blog/2015/08/03/creating-systems-with-pipelining.html).
Today we take a deeper look into some of the special parts of these pipelines.
This post deals with an i-doit backend library written in [go(lang)](https://golang.org/).

{% image blog/blog-golang-library-idoit.png %}

As already mentioned in the previous blogpost, we are using the i-doit Configuration Management Database (CMDB) extensively.
[I-doit](https://www.i-doit.com/) is a software especially designed for documentation purposes of IT relevant stuff.
You can find a short introduction to the tool [here](https://www.i-doit.com/en/products/cmdb/).
We use the CMDB for most of our IT documentation, and because we are lazy people, we don't put information into it by hand.
So we automated it partly, especially the network parts.
When we use our pipeline to integrate new parts (VM's, Server, even RPi's) into our network infrastructure, all the relevant data are put into our CMDB.
In this post we want to take a closer look towards the information flow and how we implemented it.
The goal for us today is to see how the data goes into our CMDB, and how we use the data to create network related configurations.

### Structure

Before we take a look at how to get data into our CMDB we need some structure.
By default, the CMDB has some preconfigured objects.
One of these objects is called the Layer-3-Net.
For those who forgot the [OSI model ](https://en.wikipedia.org/wiki/OSI_model), the Layer 3 abstraction is called the network layer.
Every node in this network needs an IP/MAC address, and in most of our networks we have DHCP servers providing these IP's for specific MAC's.

Starting with some objects, lets call them server, virtual machine, router etc., are related to the Layer-3-Net because of the IP address in this network, and everyone has a MAC address configured.
With these small pieces of cake we can generate all configs we need for our DHCP server.
Because we know the domain of the network we can also generate all configs we need for our DNS servers as well.

### About magic ... and an API

Here i-doit comes with it's REST-API.
When starting our pipeline project we started to use the [php client library](https://bitbucket.org/dstuecken/i-doit-api-clients/wiki/PHP) of [Dennis Stücken](https://twitter.com/dstuecken).
It's great, and did the job, but finally it was too much code to maintain.

So we thought it was time for some bad voodoo to create less code and make the generation process much faster.
In the beginning we started to select every object related to a specific Layer-3-Net to get its IP and MAC.
The generation of a /24 net lasts about 5-6 minutes, and was about a third of the whole pipeline time to create a fully installed virtual machine.
So the first trick we did was to use the i-doit integrated report manager.
Here you can create reports from all data in your CMDB and correlate them together.
We created such reports for every Layer-3-Net containing only IP, MAC, and the domain.

Another time-consuming aspect was the need to initialize Dennis' library every time we use it because of our [Jenkins](https://jenkins.io/) automation.
Jenkins is a great tool for creating generic automation processes and workflows.
The library initialization is only necessary the first time you use it.
But our Jenkins nodes sometimes restart (bad guys, they need OS updates and such stuff, or sometimes they decide to crash and run away in PANIC {% emoji wink %} .
So we needed to take care of this, and initialize the library every time.
This was not necessary anymore, and with these two tricks we reduced the generation time from 5-6 minutes to something around 10-15 seconds.

## Let's Go(lang) {% image blog/blog-golang-library-gopher.png %}

We wanted something small and simple.
3 lines of code to get everything necessary.
The idea was born to write a library by ourselves.
When we heard about the programming language **Go**, we wanted to learn it.
And the best way to learn a new language is to use it.

Primary requirements for the library:

- easy to use
- as small as possible (don't want to maintain so much code)
- fast and working in parallel

The first two requirements are met, and it's fast, because it's Go {% emoji wink %}, but actually there is no parallel implementation present yet.

**Go** features that make things nice:

- binary generation (we don't need to install Java or PHP anymore, but only deploy our ELF binary and start it)
- simple cross-compiling (actually we don't use it yet, but its extremely simple to create cross-compiled binaries for other architectures, such as ARMv6 or v7 (think of the RPi's))
- the `go run` command gives you the possibility to execute code without compiling it to a binary (this makes development and code testing easy like writing a python script).

### Short intro

The library is available [here](https://github.com/cseeger-epages/i-doit-go-api).
You're free to use it ... just GO.

Let's take a short look at the very basic function called `Request`.
The function does what the name says: it requests the REST API of our CMDB.
Every more complex request is based on this generic request function.

Before we can start requesting, we need some basic information, such as the API URL and the API key.
I-doit also supports login via X-RPC-Auth Headers (see `NewApi` and `NewLogin` function on Github).

Our C-like API struct holds this data for us:

{% highlight golang %}

// api struct used for implementing the apiMethods interface
type Api struct {
  Url, Apikey string
}

{% endhighlight %}

Since **Go** does not have a strict object-orientated model, it has a primitive called [interface](https://gobyexample.com/interfaces) which specifies the behavior of our API object.

Our `ApiMethod` interface defines the functions.
As we can see, our interface holds our `Request` function signature.

{% highlight golang %}

type ApiMethods interface {
  // i-doit api request structure
  // as defined in https://kb.i-doit.com/pages/viewpage.action?pageId=7831613
  // also there is a list of methods available
  Request(string, interface{}) (Response, error)
  ...
}
```
{% endhighlight %}

Now we need implement this method for our API object.

{% highlight golang %}

func (a Api) Request(method string, parameters interface{}) (Response, error)

{% endhighlight %}

A nice feature we can see here is the so called [empty interface](https://tour.golang.org/methods/14) `interface{}` for our parameters.
We can use the empty interface for encapsulating our request parameters without the need to directly define the structure.

Let's take a look at our request data.

{% highlight golang %}

  var params = GetParams(a, parameters)
  id = getID()

  data := Request{
    Version: "2.0",
    Method:  method,
    Params:  params,
    Id:      id,
  }

{% endhighlight %}

The `GetParams` function takes our API object as well as our parameter struct, and merges them together by adding the API key to the parameters.

`getID()` returns a request-iterated integer, and our struct from the type `Request`

{% highlight golang %}

type Request struct {
  Version string      `json:"version"`
  Method  string      `json:"method"`
  Params  interface{} `json:"params"`
  Id      int         `json:"id"`
}

{% endhighlight %}

has now all data we need.
Let's create some json data and use the `net/http` and `crypto/tls` package to send our request.

{% highlight golang %}

  dataJson, err := json.Marshal(data)

  req, err := http.NewRequest("POST", a.Url, bytes.NewBuffer(dataJson))
  if err != nil {
    fmt.Println("REQUEST ERROR: ", err)
    return Response{}, err
  }
  req.Header.Add("content-type", "application/json")
  tr := &http.Transport{}
  if insecure {
    tr = &http.Transport{
      TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
    }
  } else {
    tr = &http.Transport{
      TLSClientConfig: &tls.Config{InsecureSkipVerify: false},
    }
  }
  client := &http.Client{Transport: tr}
  resp, err := client.Do(req)
  if err != nil {
    fmt.Println("REQUEST ERROR: ", err)
    return Response{}, err
  }
  var ret = ParseResponse(resp)
  return ret, nil
}

{% endhighlight %}

As you can see, it's easy to create some json data from the data struct using the `encoding/json` package.
We create our new `POST` request using `http.NewRequest`, add some Content-Type to our header and if you use self-signed certificates on your CMDB you need to import your CA or ignore the verification {% emoji stuck_out_tongue %}.
Now we are firing our request using the `client.Do` with our client created using the http.Client reference.
That's it.

We get some JSON data back and parse them using the `ParseRespones() function:

{% highlight golang %}

func ParseResponse(resp *http.Response) Response {
  data, err := ioutil.ReadAll(resp.Body)
  if err != nil {
    log.Fatal("PARSING ERROR: ", err)
  }

  var ret Response
  _ = json.Unmarshal(data, &ret)

  return ret
}

{% endhighlight %}

Using the `io/ioutil` package to read the response and again our encoding/json to unmarshall our json back to our response struct.

{% highlight golang %}

type Response struct {
  Jsonrpc string      `json:"jsonrpc"`
  Result  interface{} `json:"result"`
  Error   IdoitError  `json:"error"`
}

{% endhighlight %}

As you see, we use the empty interface here for the result itself so we need to type assert our data in a way that corresponds to the data.
For this purpose, the library has a `GenericTypeAssert` function which does the job for you.
Type asserting means you got an interface containing specific data and you assign them to a specific data type in **Go** to make use of them.

Last but not least, let's take a look at a simple search request:

{% highlight golang %}

package main

import (
  "fmt"
  "github.com/cseeger-epages/i-doit-go-api"
)

func main() {
  a, _ := goidoit.NewApi("https://example.com/src/jsonrpc.php", "yourapikey")

  // create your parameters as a struct, that gets marshalled to json
  p := struct {
    Query string `json:"q"`
  }{"test"}

  // define request method and request by referencing to your defined parameters
  data, _ := a.Request("idoit.search", &p)

  fmt.Println(data)
}

{% endhighlight %}

We create an API object by providing a URL and an API key, and do a simple search by creating a struct containing the query parameter `q`, and request using the method `idoit.search`.

## That's it, folks

You can find more [examples](https://github.com/cseeger-epages/i-doit-go-api/tree/master/examples) on github showing usage examples and how to implement own functions.
For a more detailed documentation see the [godoc.org](https://godoc.org/github.com/cseeger-epages/i-doit-go-api) platform generating documentation from code comments (great feature).
