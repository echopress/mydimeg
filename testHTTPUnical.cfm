<!---<cfset xml_data ="pippo">
<cffile action="append" output = "#xml_data#" file="D:\WWW\mydimeg\rrrr.txt">--->

<cfset fileName = url.val1 />

<!---<cfset codiceFiscale = url.Q_CODICEFISCALE />
<cfset firmaDigitale = url.Q_FIRMADIGITALE />--->



<cfoutput>




<cfset xml_data = ToString(GetHttpRequestData().content) >


<!---<cfdump var="#xml_data#" output="D:\WWW\mydimeg\portale_admin\rrrr.txt" >--->

<cfset returnValue = '#xml_data#' >

<!---<cfset returnValue= '<?xml version="1.0" encoding="UTF-8" standalone="no"?><PatientRecord>        <Name>John Doe</Name>        <Account id="acct">123456</Account>        <Visit date="10pm March 10, 2002">    	 <Diagnosis>Broken second metacarpal</Diagnosis>        </Visit><Signature xmlns="http://www.w3.org/2000/09/xmldsig##"><SignedInfo><CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315##WithComments"/><SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig##rsa-sha1"/><Reference URI=""><Transforms><Transform Algorithm="http://www.w3.org/2000/09/xmldsig##enveloped-signature"/></Transforms><DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig##sha1"/><DigestValue>UT5I1iu5jQesOHAAQn2ewQ3Nl/g=</DigestValue></Reference></SignedInfo><SignatureValue>PFwA9TYeoPWs9UOUpOhHuiG2h3cuCwOzL193xWm5241eXfK+8x65eylVLQAsin+ty3ZHlYPvD8hm
kj1Au2kyitRfw2egB40JW0kVeWm+ExmSfnf135KbU6HBKvnG+wINC/u18Cvy6EOtOWr7kGXNNeAb
Pi4aiXrXWyij6/kGxf4=</SignatureValue><KeyInfo><KeyValue><RSAKeyValue><Modulus>lsHpNYgkjW+Iwl/hfPkRGeTFfyMwI+yft6nkHG6/RSyUS/SktFfdVlh6woLhpSQKxDhhrlD90/rS
xVJaEuH3UUMlnaEY/knTj6Cue8qSZsz+/uMnR4n3L6R613UbQ13agewS+zSzWGlZdEmOn5A1LrU9
zrvtbFRQ5QZS7tEQ+FM=</Modulus><Exponent>AQAB</Exponent></RSAKeyValue></KeyValue></KeyInfo></Signature></PatientRecord>' >--->


#returnValue#

<cfset myXMLDocument = XmlParse(returnValue)>

<cfset XMLText=ToString(myXMLDocument)>

</cfoutput>

<cfset fileUrl = "D:\WWW\mydimeg\portale_admin\" & url.val1 & ".xml">
<cffile action="write" file = "#fileUrl#" output="#XMLText#">