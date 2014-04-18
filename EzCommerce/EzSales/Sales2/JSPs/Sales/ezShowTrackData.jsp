<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ page import="ezc.ezcnetconnector.params.*,ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>


<%
    	String id        = request.getParameter("id");
%>

<html>
<head> <title>Tracking Info</title> 
<script>

	var parentObj="";
	var docObj="";
	var id = "<%=id%>"
	if(!document.all)
	{
		parentObj 	= opener.document.generalForm	
		docObj 		= opener.document
	}
	else
	{
		parentObj 	= parent.opener.generalForm	
		docObj	 	= parent.opener.document
	}

	function setData()
	{
		document.myForm.track.value = docObj.getElementById("ZZTEXT_"+id).value 
		document.myForm.matcode.value = docObj.getElementById("Product_"+id).value
		//window.close();
	}
         
</script> 
</head>
<body onLoad="setData();"scroll=no>
<form name="myForm">
	<Div id='theads'>
      <Table  width="95%" id='tabHead' align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
          <Tr align="center" valign="middle">
            <Td width="100%">Tracking Info for <input type="text" class="tx" readonly value="" name="matcode" size="15">  </Td>
    	  </Tr>
    	  <Tr align="center" valign="middle">
    	    <Td width="100%">
		<textarea rows="5" cols="20" name="track" readonly>
		
		</textarea> 
    	    </Td>
    	  </Tr>
    	  
    </Table>
    </div>
    


<br>	
	
   <DIV style='overflow:auto;position:absolute;top:85%;left:42%'>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Close");
	buttonMethod.add("window.close()");
		
	out.println(getButtonStr(buttonName,buttonMethod));	
%>

  </div>   

</form>
</body>
</html>