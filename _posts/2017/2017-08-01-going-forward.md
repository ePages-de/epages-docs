---
layout: post
title: "Go'ing forward"
date: "2017-08-01 08:00:00"
image: blog-header/golang-library.jpg
categories: tech-stories
authors: ["Carsten", "Karsten"]
---

Long time no see guys.
In my last blogpost I talked about [pipelines](https://developer.epages.com/blog/2015/08/03/creating-systems-with-pipelining.html).
Today we take a deeper look into some of the special parts of these pipelines.
This post deals with an i-doit backend library written in [GO(LANG)](https://golang.org/).

{% image blog/blog-golang-library-idoit.png %}

As already mentioned in the previous blogpost we are using the i-doit Configuration Management Database (CMDB) extensively.
[I-doit](https://www.i-doit.com/) is a software especially designed for documentation purposes of IT relevant stuff.
You can find a short introduction to the tool [here](https://www.i-doit.com/en/products/cmdb/).
We use the CMDB for most of our IT documentation, and because we are lazy people, we don't put information into it by hand.
So we automated it partly, especially the network parts.
When we use our pipeline to integrate new parts (VM's, Server, even RPi's) into our network infrastructure, all the relevant data are put in to our CMDB.
In this post we want to take a closer look towards the information flow and how we implemented it.
The goal for us today is to see how the data goes into our CMDB, and how we use the data to create network related configurations.

### Structure

Before we take a look at how to get data into our CMDB we need some structure.
By default, the CMDB has some preconfigured objects.
One of these objects is called the Layer-3-Net.
For those who forgot the [OSI model ](https://en.wikipedia.org/wiki/OSI_model), the Layer 3 abstraction is called the network Layer.
Every node in this network needs an IP address, and in most of our networks we have DHCP servers providing them.
So if we talk about DHCP, we also need a MAC address as IP addresses are configured for specific MAC addresses.
Often we don't want unfamiliar devices in our network, and in these cases we don't have a dynamic address space configured.

So what's the structure?
We have a Layer-3-Net.
Some objects, lets call them Server, Virtual Machine, Router etc., are related to the Layer-3-Net because of the IP address in this network, and everyone has a MAC address configured.
With these small pieces of cake we can generate all configs we need for our DHCP server.
Because we know the domain of the network we can also generate all configs we need for our DNS servers as well.

### About magic ... and an API

Here i-doit comes with it's REST-API.
When starting our pipeline project I started to use the [php client library](https://bitbucket.org/dstuecken/i-doit-api-clients/wiki/PHP) of [Dennis Stücken](https://twitter.com/dstuecken).
It's great, and did the job, but finally it was too much code to maintain.

So I thought it was time for some bad voodoo to create less code and make the generation process much faster.
In the beginning we started to select every object related to a specific Layer-3-Net to get its IP and Mac.
The generation of a /24 net lasts about 5-6 minutes, and was about a third of the whole pipeline time to create a fully installed virtual machine.
So the first trick we did is to use the i-doit integrated report manager.
Here you can create reports from all data in your CMDB and correlate them together.
We created such reports for every Layer-3-Net containing only IP, MAC and the domain.

Another time consuming aspect was the need to Initialize Dennis library every time we use it because of our [Jenkins](https://jenkins.io/) automation.
Jenkins is a great tool for creating generic automation processes and workflows.
The library initialization is only necessary the first time you use it.
But our Jenkins nodes sometimes restart (bad guys, they need OS updates and such stuff or sometimes they decide to crash and run away in PANIC {% emoji wink %} ), so we need to take care of this, and initialize the library every time.
Using these two tricks we reduced the generation time from 5-6 minutes to something around 10-15 seconds.

## Lets' GOLANG {% image blog/blog-golang-library-gopher.png %}

I wanted something small and simple.
3 lines of code to get everything necessary.
The idea was born to write a library by myself.
When I heard about the programming language GO, I wanted to learn it.
From my point of view, the best way to learn a new language is by using it.

Now that we have a project and a language, lets start!

Primary requirements for the library:

- easy to use
- as small as possible (I don't want to maintain so much code.)
- fast and working in parallel

The first two requirements are met, and it's fast, because it's GO {% emoji wink %}, but actually there is no parallel implementation present yet.

GO features making things nice:

- binary generation (we don't need to install Java or PHP anymore, but only deploy our ELF binary and start it)
- simple cross-compiling (actually we don't use it yet, but its extremely simple to create cross-compiled binarys for other architectures such as ARMv6 or v7 (think of the RPi's))
- go run gives you the possibility to execute code without compiling it to a binary (this makes development and code testing easy like writing a python script)

### Short intro

The library is available [here](https://github.com/cseeger-epages/i-doit-go-api).
You're free to use it ... just GO.

Let's take a short look at the very basic function called `request`.
The function does what the name says: it requests the REST API of our CMDB.
Every more complex request is based on this generic request function.

Before we can start requesting we need some basic information such as the API URL and the API key.
I-doit also supports login via X-RPC-Auth Headers (see NewApi and NewLogin function on Github).

Our C-like API struct holds this data for us:

```golang
// api struct used for implementing the apiMethods interface
type Api struct {
  Url, Apikey string
}
```
Since GO does not have a strict object-orientated model, it has a primitive called interface which specifies the behavior of our API object.
Interfaces are implemented implicitly.
If an object implements all interface functions it can use it without any direct relation to it.

Our ApiMethod interface defines the functions.
At this point we are only interessted in the `request` function.

For interfaces we have no ```func``` keyword.
The function is defined by <name\> (input types) (return types).
As you can see, you can specify a list of input parameters and also a list of returns.
The interface only defines the method, so there are no variables names, but only the types used for this function.

```golang
type ApiMethods interface {
  // i-doit api request structure
  // as defined in https://kb.i-doit.com/pages/viewpage.action?pageId=7831613
  // also there is a list of methods available
  Request(string, interface{}) (Response, error)
  ...
}
```

We need to implement this method for our API object.

```golang
func (a Api) Request(method string, parameters interface{}) (Response, error) {
```

Now we have a fully functioning definition using the ```func``` keyword followed by our object ```(a Api)``` of type API.
We now have the variables method and parameters as input values and a response and an error returned.
A nice feature we use here is the so called empty interface ```interface{}``` for our parameters.
Its like "hey function you will get something and I don't know what it is but lets call it parameters".
We can use the empty interface for encapsulating our request parameters without the need of directly defining the structure.
Using interfaces as parameter input is a bit like generics (which does not exists in GOLANG!).

Let's take a look on our request data.

```golang

  var params = GetParams(a, parameters)
  id = getID()

  data := Request{
    Version: "2.0",
    Method:  method,
    Params:  params,
    Id:      id,
  }
```

The ```GetParams``` function takes our API object as well as our parameter struct, and merges them together by adding the API key to the parameters.

`getID()` returns a request-iterated integer and our datastruct from type request
```
type Request struct {
  Version string      `json:"version"`
  Method  string      `json:"method"`
  Params  interface{} `json:"params"`
  Id      int         `json:"id"`
}
```
has now all data we need.
And you can find examples for the method string other functions like Search uses "idoit.search" as method string.
Let's create some json data from our data and use the ```net/http``` and ```crypto/tls``` packet to send our request.

```golang
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
```
As you can see its easy to create some json data from the data struct using the ```encoding/json``` package.
We create our new POST request using ```http.NewRequest``` add some content-type to our header and if we you use self-signed certificates on your CMDB you need to import your CA or ignore the verification {% emoji stuck_out_tongue %}.
Now we are fireing our request using the ```client.Do``` with our client created using the http.Client reference.
That's it.
We get some JSON data back and parse them using the ```ParseRespones()``` function:

```
func ParseResponse(resp *http.Response) Response {
  data, err := ioutil.ReadAll(resp.Body)
  if err != nil {
    log.Fatal("PARSING ERROR: ", err)
  }

  var ret Response
  _ = json.Unmarshal(data, &ret)

  return ret
}
```

Using the ```io/ioutil``` package to read the response and again our ```encoding/json``` to unmarshal our json back to our response struct.

```
type Response struct {
  Jsonrpc string      `json:"jsonrpc"`
  Result  interface{} `json:"result"`
  Error   IdoitError  `json:"error"`
}
```

As you see we use the empty interface here for the result itself so we need to Type Assert our data in a way that corresponds to the data.
For this purpose the library has a GenericTypeAssert function which does the job for you.
Type Asserting means you got an interface containing specific data and you assign them to a specific data type in go to make use of them.

Last but not least, let's take a look on a simple search request:

```
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
```

We need to create an API object by providing a URL and an API key and do a simple search by creating a struct containing the query parameter ```q ``` and request using the method ```idoit.search```.

## That's it, folks

You can find more [examples](https://github.com/cseeger-epages/i-doit-go-api/tree/master/examples) on github showing usage examples and how to implement own functions.
For a more detailed documentation see the [godoc.org](https://godoc.org/github.com/cseeger-epages/i-doit-go-api) platform generating documentation from code comments (great feature).
