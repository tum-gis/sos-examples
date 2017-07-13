#!/bin/bash
# getCapabilites --------------------------------------------------------------
curl -v \
     -H "Content-Type: application/json" \
     -X POST \
     -d @getCapabilities.json \
    http://my.sos.server:8080/52n-sos-webapp/service
    
echo "Press ENTER key to continue..."
read
    
# getCapabilites - write answer to response.json ------------------------------
curl -v \
     -H "Content-Type: application/json" \
     -X POST \
     -d @getCapabilities.json \
    http://my.sos.server:8080/52n-sos-webapp/service > response.json
    
echo "Press ENTER key to continue..."
read

# JSON getObservation with token authorization --------------------------------
curl -v \
     -H "Content-Type: application/json" \
     -H "Authorization: IamTheSecretToken-c1db8eb9f3f7" \
     -X POST \
     -d @../insertObservation/insertObservation.json \
    http://my.sos.server:8080/52n-sos-webapp/service
    
echo "Press ENTER key to continue..."
read
 
# insertSensor SOAP with token authorization ----------------------------------
curl -v \
     -H "Content-Type: application/soap+xml;charset=UTF-8" \
     -H "Authorization: IamTheSecretToken-c1db8eb9f3f7" \
     -X POST \
     -d @../InsertSensor/insertSensor-SOAP.xml \
    http://my.sos.server:8080/52n-sos-webapp/service
    
echo "Press ENTER key to continue..."
read

# insertSensor SOAP with token authorization ----------------------------------
#   https protected server with self-signed certificate (add -k switch)
curl -v -k \
     -H "Content-Type: application/soap+xml;charset=UTF-8" \
     -H "Authorization: IamTheSecretToken-c1db8eb9f3f7" \
     -X POST \
     -d @../InsertSensor/insertSensor-SOAP.xml \
    https://my.sos.server:8080/52n-sos-webapp/service
    
echo "Press ENTER key to continue..."
read
 
# insertSensor SOAP with token authorization, write response to response.xml --
curl -v \
     -H "Content-Type: application/soap+xml;charset=UTF-8" \
     -H "Authorization: IamTheSecretToken-c1db8eb9f3f7" \
     -X POST \
     -d @../InsertSensor/insertSensor-SOAP.xml \
    http://my.sos.server:8080/52n-sos-webapp/service > response.xml

echo "Press ENTER key to quit..."
read

