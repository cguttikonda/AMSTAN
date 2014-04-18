<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@include file="../../../Includes/Lib/AddButtonDir.jsp" %> 

<html>
<script>
	var xmlDoc= "";
        if(window.ActiveXObject)
        {
	        xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
            xmlDoc.async=false;
        }
        else if(document.implementation && document.implementation.createDocument)
                xmlDoc= document.implementation.createDocument("","doc",null);
        if(typeof xmlDoc!="undefined")
	{       
                var url=location.protocol+"//<%=request.getServerName()%>/KissUSA/EzCommerce/EzCommon/XMLs/ezData.xml";
                xmlDoc.load(url); 
        }
        function doLoad()
        {
        	
        		
                var docElem = xmlDoc.documentElement;
                var currenArr;
                for(var k=0;k<docElem.childNodes.length;k++)
                {
	                    var tagVal = docElem.childNodes(k).tagName;
                        var optionName = new Option(tagVal,tagVal, false, false);
                        var length = document.myForm.Components.length;
                        document.myForm.Components.options[length] = optionName;
                }
                getAttributes();
        }
        function getAttributes()
        {
                document.myForm.subComponents.options.length = 0
                var selValue  = document.myForm.Components.options[document.myForm.Components.selectedIndex].value
                var currArray = xmlDoc.getElementsByTagName(selValue);
                for(var k=0;k<currArray.length; k++)
                {
	                	var tagVal = currArray.item(k);
                        for(var j=0;j<tagVal.childNodes.length;j++)
                        {
	                        var subTagVal = tagVal.childNodes(j).tagName
                                var optionName = new Option(subTagVal,subTagVal, false, false);
                                var length = document.myForm.subComponents.length;
                                document.myForm.subComponents.options[length] = optionName;
                        }
	            }
                getAttribVal();
       }
       function getAttribVal()
       {
                var selValue  = document.myForm.subComponents.options[document.myForm.subComponents.selectedIndex].value
                var currArray = xmlDoc.getElementsByTagName(selValue);
	        document.myForm.CompValue.value = currArray.item(0).text
	        	                 
       }
       function updateXML()
       {
       		document.myForm.action = "ezSaveXMLData.jsp";
		document.myForm.submit();
       }

</script>
<body onload=doLoad() >
<form name="myForm" method="POST">
<Div id="selectDiv" align=center style="position:absolute;top:10%;visibility:visible;left:15%">
	<Table  width="85%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	  	<Tr align="center">
			<Td class="displayheader" colspan=2>Change Info</Td>
	  	</Tr>
	  	<Tr>
			<Td width = "50%" align = "center" class="displayheader">Component</Td>
			<Td width = "50%" align = "center" class="displayheader">SubComponent</Td>
		</Tr>
	</Table>
	
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="85%">
	<Tr>
		<Td width = "50%" align = "center">
			<select name="Components" id="FullListBox" style="width:100%" onChange="getAttributes()">
				
			</select>
		</Td>
		<Td width = "50%" align = "center">
			<select name="subComponents" id="FullListBox" style="width:100%" onChange="getAttribVal()">
				
			</select>
		</Td>
	</Tr>
	</Table> 
	<br/>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="85%">
	<Tr>
		<Td width="100%" align = "center"><input type="text" name="CompValue" value="" style="width:90mm"></Td>	
	</Tr>
	</table>
	
	
	
</div>
<Div id="ButtonDiv" align=center style="position:absolute;top:70%;visibility:visible;left:47%">
	<center>
	<a href="javascript:updateXML()"><img src="../../Images/Buttons/<%= ButtonDir%>/update.gif" border=none></a>
	</center>
</div> 

<Div id="MenuSol"></Div>	
</form>
</body>
</html>
