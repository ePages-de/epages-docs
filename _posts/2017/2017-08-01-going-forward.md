+layout: post
 +title: "Go'ing forward"
 +date: "2017-08-01 07:00:00"
 +image: blog-header/golang-library.jpg
 +categories: tech-stories
 +authors: ["Carsten", "Karsten"]

## i-doit backend library written in GOLANG

Long time no see guys. In my last blogpost i talked about [pipelines](https://developer.epages.com/blog/2015/08/03/creating-systems-with-pipelining.html) and today we take a deeper look into some of the special parts of these pipeline. 
So lets [GO(LANG)](https://golang.org/)

## {% image blog/blog-golang-library-idoit.png %}

Like already said in the previous blogpost we are using the i-doit CMDB extensivly. [I-doit](https://www.i-doit.com/) is a software especially desiged for documentation purposes of IT relevant stuff. 
You can find a short introduction to the tool [here](https://www.i-doit.com/en/products/cmdb/). 
We use the CMDB for the most part of our IT documentation and since we are lazy people we don't put information into it by hand. 
So we automated it partly, especially the network parts. 
When we are using our pipeline to integrate new parts (VM's, Server, even RPi's) into our network infrastructure, all the relevant data are put in to our CMDB. 
In this post we want to take a look what way the information are going and what we did to create these ways. 
The goal for us today is to see how the data goes into our CMDB and how we use the data to create network related configurations.

## Structure

Before we take a look on the way how data are going into our CMDB we need some structure. 
By default the CMDB has some preconfigured objects and one of these objects is called the Layer-3-Net. 
For those who forgot the [OSI model ](https://en.wikipedia.org/wiki/OSI_model) the Layer 3 abstraction is called the network Layer. 
So every node in this network needs an IP address and in most of our networks we have DHCP servers providing them. 
So if we talk about DHCP we also need a MAC address since IP addresses configured for specific MAC addresses. 
Often we dont want unfamiliar devices in our net and in these cases we don't have a dynamic address space configured. 

So whats the structure. 
We have a Layer-3-Net and some Objects lets call them Server, Virtual Machine, Router etc. and all of them are related to the Layer-3-Net because of the IP address in this net and everyone has a MAC address configured. 
With these small pieces of cake we can generate all configs we need for our DHCP server and since we know the domain of the network we can also generate all configs we need for our DNS servers as well. 

## of Magic ... and an API

Here i-doit comes with it's REST-API. 
When starting our pipeline project i started to use the [php client library](https://bitbucket.org/dstuecken/i-doit-api-clients/wiki/PHP) from Dennis Stücken. 
It was great and it did the job but finally it was to much code to maintain. 
So i thought it's time for some bad vodoo to create less code and make the generation process much faster.
In the beginning we started to select every Object related to a specific Layer-3-Net to get its IP and Mac. 
The generation of a /24 net lasts at about 5-6 Minutes and was about a third of the whole pipeline time to create a fully installed virtual machine. 
So the first trick we did is to use the i-doit integrated report manager. Here you can create reports from all data in your CMDB and correlate them together. 
So we created such reports for every Layer-3-Net only containing IP, MAC and the domain.
Another time consuming aspect was the need to Initialize Dennis library every time we use it because of our jenkins automation. 
We talked about [jenkins](https://jenkins.io/) in the last post also. 
It's a great tool for creating generic automation processes and workflows.
The library initialization is only necessary the first time you use it, but since our jenkins nodes sometimes restart (bad guys they need OS updates and such stuff or sometimes they decide to crash and run away in PANIC), we need to take care of this and so we initialize the library every time.
Using these two tricks we reduced the generation time from 5-6 min to something arrount 10-15 seconds.

## Lets' GOLANG {% image blog/blog-golang-library-gopher.png %}

So i wanted something small and simple. 
Writing 3 lines of code to get everything i want. 
The idea was born to write a library by myself and when i heard about the programming language called GO i wanted to lern it. 
From my point of view the best way to learn a new language is by using it. 
So we have a project and we have a language, lets start.

What are the primary requirements for our library:

- simple to use
- as small as possible ( i dont want to maintain so many code )
- fast and parallel working

At first i think the first two requirements are met and its fast because its go ;) but actually there is no parallel implementation present yet.

What are the features of go making things nice:

- binary generation ( we dont need to install java or php anymore we only deploy our ELF binary and start it)
- simple crosscompile ( actually we don't use it yet but its extreamly simpel to create crosscompiled binarys for other architectures like ARMv6 or v7 (think of the RPi's) )
- go run gives you the possibility to execute code without compiling it to a binary ( this makes development and code testing easy like writing a python script )

## a short intro

You can find the library on my [github accout](https://github.com/cseeger-epages/i-doit-go-api) and its under GPLv3 so if you want to use it ... GO.

Now we take a short look at the very basic function called Request. 
The function does what its name say's, it requests the REST-API of our CMDB. 
Every more complex Request is based on this generic Request function.

Before we can start requesting we need some basic information like the API URL and the API-Key. I-doit also supports login via X-RPC-Auth Headers (see NewApi and NewLogin function on github) 

Our C like Api struct holds this data for us.

```golang
// api struct used for implementing the apiMethods interface
type Api struct {
	Url, Apikey string
}
```
Since go does not have a strict object orientated model, it has a primitive called interface which specifys the behavior of our Api Object. Interfaces are implemented implicitly. If an object implements all interface functions it can use it without any direct relation to it.

Our ApiMethod interface defines the functions. At this point we are only interessted in the Request function.

For interfaces we have no ```func``` keyword, our function is defined by <name\> (input types) (return types). 
As you can see you can specify a list of input parameters and also a list of returns. Since the interface only defince the method there are no variables names only the types used for this function.

```golang
type ApiMethods interface {
	// i-doit api request structure
	// as defined in https://kb.i-doit.com/pages/viewpage.action?pageId=7831613
	// also there is a list of methods available
	Request(string, interface{}) (Response, error)
	...
}
```

We need to implement this method for our Api Object.

```golang
func (a Api) Request(method string, parameters interface{}) (Response, error) {
```

Now we have a full function definition using the ```func``` keyword followed by our object ```(a Api)``` of type API. As you can see we now have the variables method and parameters as input values and a Response and an error as return. 
A nice feature we use here it the so called empty interface ```interface{}``` for our parameters. 
Its like hey function you will get something and i don't know what it is but lets call it parameters. 
We can use the empty interface for encapsulating our request parameters without the need of directly defining the structure. 
Using interfaces as parameter input is a bit like generics ( which does not exists in GOLANG ! ).

Now lets take a look on our request data.

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

The ```GetParams``` function takes our Api object and our parameter struct and merges them together by adding the API-Key to the parameters. ```getID()``` returns a request iterated integer and our datastruct from type Request
```
type Request struct {
	Version string      `json:"version"`
	Method  string      `json:"method"`
	Params  interface{} `json:"params"`
	Id      int         `json:"id"`
}
```
has now all data we need. 
An you can find examples for the method string other functions like Search uses "idoit.search" as method string.
let's create some json data from our data and use the ```net/http``` and ```crypto/tls``` packet to send our request.

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
We create our new POST request using ```http.NewRequest``` add some content-type to our header and if we you use selfsigned certificates on your CMDB you need to import your CA or ignore the Verification :P. 
Now we are fireing our request using the ```client.Do``` with our client created using the http.Client reference. Thats it. We get some JSON data back and parse them using the ```ParseRespones()``` function:

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

As you see we use the empty interface here for the Result itself so we need to Type Assert our data in a way that corresponds to the data.
For this purpose the library has a GenericTypeAssert function which does the job for you. 
Type Asserting means you got an interface containing specific data and you assign them to a specific data type in go to make use of them.

At last lets take a look on a simple search Request:

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

We need to create an api object by providing a url and an api key and do a simple search by creating a struct containing the query parameter ```q ``` and request using the method ```idoit.search```.

Thats it, you can find more [examples](https://github.com/cseeger-epages/i-doit-go-api/tree/master/examples) on github showing usage examples and how to implement own functions. 
For a more detailed documentation see the [godoc.org](https://godoc.org/github.com/cseeger-epages/i-doit-go-api) platform generating documentations from code comments (great feature).
