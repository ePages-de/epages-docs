---
layout: page
key: apps-tutorial-php
title: App Tutorial (PHP)
---

The general page about [creating an app](page:apps-create) explains some of the concepts and the basic workflow, which is required to develop an app.
This includes the most crucial part, the Auth2 token exchange.

On this page we are going into more detail and explain exactly how you can implement this.
We are using PHP, but the functionality is very simple and can easily be implemented in any other language.

You will see how the OAuth2 exchange is done to get your access token and how you can use it to make API calls.

# Prerequisites

In order to get this code working, you need to setup your development environment:

- PHP 5.2+
- publicly reachable server

### Sign up for an ePages Test Shop

Simply go on [our website](epages-demo-signup) and sign up for a free account.

### Create a Developer App

In order to create an app, test it and submit it to the App Store, you have to create a developer app.

Go to the **Developer App** section in our **Apps & Themes** Store and [create a new developer app](page:apps-create) by clicking on **Add**.

After choosing a name to your liking, you need to set the callback URL to your publicly available PHP script (e.g. `https://myapp.com/callback.php`), which we will implement later.

{% callout info Note: %}
We allow HTTP callback URLs for developer apps, but you need to provide an HTTPS URL once you want to submit the app to the App Store.
{% endcallout %}

Once you are done with that, the detail page will show your **client credentials**.

{% image developer-app-details.png %}{% endimage %}

As you can see, there is no access token right away.
You have to go through the installation process first to acquire one.

The **Test Authorisation**-Button basically simulates an installation by a user - in this case yourself.
After the token exchange is done, you will receive an access token, which will also be displayed on this page.

{% callout info Note: %}
Any subsequent calls will uninstall the app and reinitiate the installation process, which will result in a new access token (and invalidation of the old access token).
{% endcallout %}

# Getting an Access Token

For a more general overview of the installation process and the OAuth2 token exchange, we recommend you to read the [installation page](page:apps-install) first.

Now that everything is in place, we can actually start coding.
We will create the mentioned `callback.php` file, which will be called when a user installs an app.

### Setting credentials

The first thing we will do is set the client credentials you got from the developer app detail page.

    <?php
    
    $client_id     = '0BE38CFF-F3B6-4D68-8F16-1CE270C028BC';
    $client_secret = 'DkRUi6uo6KzglHmwOhFkVYNhcumCTOlP';


### Listen for Callback

Next, you need to listen for a request to get the **authorization code**, which you can exchange for an access token.
The call, which you can trigger with the **Test Authorization** button, will look like this:

https://myapp.com/callback.php?code=*{authorization_code}*&access_token_url=*{access_token_url}*&api_url=*{api_url}*

You need to extract the code, *access_token_url* and *api_url* to use later on.
We also send the *return_url* to redirect the user back to, as soon as he is done with the registration and installation.

    $code             = $_GET["code"];
    $access_token_url = $_GET["access_token_url"];
    $api_url          = $_GET["api_url"];

{% callout warning Note: %}
In a production environment, you would use the *api_url* as the unique identifier for the merchant.
You will also use it as the base URL for REST calls.
{% endcallout %}

### Exchange Authorization Code for Access Token

Now we need to exchange the **authorization code** for the **access token**.
We will create a function called `get_token()`, which will need the *client credentials*, the *access_token_url* and the *code* and will just print the access token as a response.

    $access_token = get_token($access_token_url, $client_id, $client_secret, $code);
    echo $access_token;

{% callout info Note: %}
In a production environment, you would not disclose that token to anyone, not even the merchant.
This token (depending on the scopes) has access to the merchants shop and is directly associated to your app.
{% endcallout %}

Next, we need to actually implement the `get_token()` function.
In this function we need to:

- encode the *client credentials* and *code* as `x-www-form-urlencoded`,
- pass them as a POST request to the *access_token_url* and
- parse the JSON response containing a single *access_token* value.

The encoded *client_id*, *client_secret* and *code* are assigned to `$post_content`.

After that, we set the necessary request options for `curl`:

- the URL,
- the HTTP method,
- the *Content-Type*-Header and the
- request body.

After a successful request, we receive a JSON-encoded response and return the extracted access token.

    function get_token($url, $client_id, $client_secret, $code)
    {
        // request body
        $post_content = http_build_query(array(
            'code' => $code,
            'client_id' => $client_id,
            'client_secret' => $client_secret
        ));
        
        // curl options
        $curl_options = array(
            CURLOPT_URL => $url,
            CURLOPT_POST => 1,
            CURLOPT_HEADER => "Content-Type: application/x-www-form-urlencoded",
            CURLOPT_POSTFIELDS => $post_content,
            CURLOPT_RETURNTRANSFER => TRUE
        );
        
        // curl request
        $curl = curl_init();
        curl_setopt_array($curl, $curl_options);
        $result = curl_exec($curl);
        curl_close($curl);
        return json_decode(utf8_encode($result))->{access_token};
    }
    ?>


# Use the API

After you have successfully received the access token, you can use it to make requests to the API.
You construct the available resource URL by taking the *api_url* and appending the resource you want to call.

If you want to list the products, you can make a simple GET request to the *products* endpoint.
We are using the command line tool `curl` in this example:

    curl -XGET {api_url}/products
         -H 'Accept: application/vnd.epages.v1+json'
         -H 'Authorization: Bearer {access_token}'

The response will look something like this:

    {
      "results": 1,
      "page": 1,
      "resultsPerPage": 10,
      "items": [
        {
          "productId": "55BB92D1-DE61-A290-24CD-7F000101F96C",
          "name": "Berghaus Paclite Jacket - Men",
          "shortDescription": "Weatherproof. Small pack size. Ultra light.",
          "description": "Weatherproof and compact. Ultra light.",
          "images": [
            {
              "url": "http://gecko/WebRoot/Store/Shops/DemoShop/Products/be_40401/be_40401_blue.jpg",
              "classifier": "Large"
            },
            ...
          ],
          "priceInfo": {
            ...
          },
          "forSale": false,
          "specialOffer": false,
            ...
          ]
        },
      ]
    }


An overview of our available resources are listed in the [API reference](page:api-resources-all).


You can find the code in our [GitHub repository][github-demo-app-php].

[github-demo-app-php]: https://github.com/pshingala/epphp
[epages-demo-signup]: http://www.epages.com/de/produkte/demo-shop/