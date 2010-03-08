To run this demo you need to have wsdl2perl.pl in your path.

Execute the generate.sh script to create the SOAP::WSDL structure needed for the server and then from this directory
run the test.pl script. 

You will be able to call the web service from

http://127.0.0.1:8089/WS/Test?wsdl

to get the wsdl file of the web service and then with SOAPUI or some other tool call the single test method of this 
wsdl.

Enjoy.
