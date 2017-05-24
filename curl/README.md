# Sending SOS requests with CURL
CURL is a tool to transfer data from or to a server, using one of the supported protocols like HTTP or HTTPS. 
The command is designed to work without user interaction.
CURL offers a busload of useful tricks like proxy support, user authentication, FTP upload, HTTP post, SSL connections, cookies, file transfer resume and more. 
The number of features will make your head spin! For detailed information, please refer to the [man pages](https://linux.die.net/man/1/curl) or this [wiki page](https://wiki.ubuntuusers.de/cURL/).

Examples for the following content are provided in [curl-test.sh](curl-test.sh).
## JSON request
CURL supports sending HTTP POST requests with [JSON](https://en.wikipedia.org/wiki/JSON) content.
We are going to use it, to send all kind of requests to a 52°North SOS instance.
Let's start over with a basic example, the `getCapabilities` request. 
Below, the request is listed in JSON format.
```json
{ 
  "request": "GetCapabilities", 
  "service": "SOS" 
}
```
To send it to a SOS server using CURL we need to set JSON as POST
 request *content type*, specifiy the `getCapabilities` JSON request as *data element* and provide the 
 *SOS service endpoint URL* as argument. For testing it is recommended to use the `-v` switch of CURL 
 to receive verbose log messages.
 
 -----
:exclamation: **Note:**
> For improved readability the following commands have been split into multiple lines using the shell `\` command
> for [continuing lines](http://www.gnu.org/software/bash/manual/bashref.html#Escape-Character). **Avoid of whitespaces after the `\`, as they break the command.**

-----
  
```bash
curl  -v \
      -H "Content-Type: application/json" \
      -X POST \
      -d '{ "request": "GetCapabilities", "service": "SOS" }' \
    http://mysos.de:8080/52-sos-webapp/service
```

Specifiying the JSON data as string in the CURL call can be unpleasant and confusing.
Hence, it is recommended to use a JSON files instead and include it with `@{filename}` in the request.
If you have a `getCapabilities` request stored in a JSON file, your CURL call would look like this:

* getCapabilities.json
  ```json
  {
    "request": "GetCapabilities", 
    "service": "SOS" 
  }
  ```

* CURL request
  ```bash
  curl  -v \
        -H "Content-Type: application/json" \
        -X POST \
        -d @getCapabilities.json \
      http://mysos.de:8080/52-sos-webapp/service      
  ```

## SOAP request
Sending [SOAP requests](https://en.wikipedia.org/wiki/SOAP) to your SOS server using CURL works alomst the same as for JSON requests.
However, the *content type* needs to be changed to `application/soap+xml`.
The CURL call for sending the `InsertSensor` request from the [InsertSensor folder](../InsertSensor) is listed below.
The response of the request is written to `response.xml` in this example.
```bash
curl  -v \
      -H "Content-Type: application/soap+xml;charset=UTF-8" \
      -X POST \
      -d @../InsertSensor/insertSensor-SOAP.xml \
    http://mysos.de:8080/52n-sos-webapp/service > response.xml
```
  
## SOS Transactional security
The 52°North SOS can be configured to restrict access to *transactional operations* like `InsertSensor` or `InsertObservation`.
Besides host based authentification, a *transactional authorization token* can be used to identify users allowed for transactional operations.

If a transactional authorization token is set for the SOS server you are sending a request to, you need to specifiy a *HTTP authorization header* by adding following switch to your CURL call:
`-H "Authorization: {token}"`

Below you can see an example including a *transactional authorization token*. 
```bash
curl  -v \
      -H "Content-Type: application/json" \
      -H "Authorization: IamTheSecretToken-c1db8eb9f3f7" \
      -X POST \
      -d @insertObservation.json \
    http://mysos.de:8080/52-sos-webapp/service
```
