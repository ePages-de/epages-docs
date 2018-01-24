---
layout: docs
key: soap-access
title: Access to the web services
---

Basic authentication is used in order to access the web services.
The following credentials are required to use the web services and will be provided by ePages:

* user name and password for the web service
* user name and password for the web service activation (client application)

The client application credentials have to be added to the web service credentials.
Both user names and passwords have to be concatenated with the special character `char(1)`, as shown in the Java example code below:

{% highlight java %}
{
  public class WebServiceApplicationConfiguration {
    private static final char SEPARATOR = (char) 1
    private URL webserviceURL;
    private String username;
    private String password;

    public URL getWebserviceURL() {
      return webserviceURL;
    }

    public void setWebserviceURL(URL webserviceURL) {
      this.webserviceURL = webserviceURL;
    }

    public String getUsername() {
      return username;
    }

    public void setUsernames(String username, String applicationName) {
      this.username = username;
      if (applicationName !=null) {
        this.username+=SEPARATOR + applicationName;
      }
    }

    public String getPassword() {
      return password;
    }

    public void setPasswords(String password, String applicationPassword) {
      this.password = password;
      if (applicationPassword != null) {
        this.password += SEPARATOR + applicationPassword;
      }
    }
  }
}
{% endhighlight %}

To being able to interact with the ePages shops, the respective web services will be enabled and WSDL file and version will be provided by ePages.

{% callout info Web services are subject to change. %}
It is recommended to use the latest web service version available on the repository. Older versions may not be displayed, but will be supported further.
{% endcallout %}
