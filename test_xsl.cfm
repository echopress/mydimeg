<cffile action="read" file="D:\www\xslt\custorder.xsl" variable="xmltrans"> 
<cfset xmldoc = XmlParse("D:\www\xslt\custorder.xml")> 
<cfoutput>#XmlTransform(xmldoc, xmltrans)#</cfoutput>