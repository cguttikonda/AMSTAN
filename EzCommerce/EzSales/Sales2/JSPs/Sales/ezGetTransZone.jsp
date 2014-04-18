<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/JSPs/Sales/iTranszoneTypes.jsp" %>

<%
	String searchKey =request.getParameter("searchKey");
	String label1="",label2="";
	
	java.util.Hashtable keyHT = null;
	if("TZ".equals(searchKey)){
		keyHT = tpZoneHT;
		label1 ="TranspZone";
		label2 ="Description";
	}else{
		keyHT = jurCodeHT;
		label1 ="Jurisdict. Code";
		label2 ="Name";
	}
	
	java.util.Enumeration enum1S =  keyHT.keys();
	String enum1Key=null;
	String enum1Desc=null;
%>
<html>
<head>
<title>Select Code-- Powered by EzCommerce Inc</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script src="../../Library/JavaScript/Misc/ezTrim.js"></script>
<Script>
		  var tabHeadWidth=90;
		  var tabHeight="60%";    
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<Script>
	function getCode(){
	 	
		var myObj= document.myForm.skey;
		var selValue="";
		
		
		for(i=0;i<myObj.length;i++){
			if(myObj[i].checked){
				selValue = myObj[i].value;
			}
		}
		
		if(selValue==""){
			alert('Please select code');
		}else{
			if('TZ'=='<%=searchKey%>'){
				opener.document.generalForm.tpZone.value = selValue;
				window.close();
			}else{
				opener.document.generalForm.jurisdiction.value = selValue;
				window.close();
			}
		}
		
		
	}
</Script>

</head>
<body  onLoad="scrollInit()" onresize="scrollInit()" scroll=no>
<form method="post"  name="myForm" >




<Div id="theads">
<Table  id="tabHead"  width="90%"  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1>
 <Tr>
   <Th width="5%">&nbsp;</Th>
   <Th width="30%"><%=label1%></Th>
   <Th width="65%"><%=label2%></Th>
 </Tr>
</Table>
</Div>
<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:60%;height:90%;">
<Table align=center id="InnerBox1Tab"  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 width="100%">
  
<%
	 while(enum1S.hasMoreElements())
	 {
		enum1Key = (String)enum1S.nextElement();
		enum1Desc = (String)keyHT.get(enum1Key);
%>
		<Tr>
		<Td width="5%"><input type="radio" name="skey" value="<%=enum1Key%>"></Td>
		<Td width="30%"><%=enum1Key%></Td>
 		<Td width="65%"><%=enum1Desc%></Td>
 		</Tr>
<%

	 }		
%>
		
  

</Table>
</Div>

<div align='center' style='Position:Absolute;width:100%;top:70%'>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Choose");
	buttonMethod.add("getCode()");
	buttonName.add("Close");
	buttonMethod.add("JavaScript:window.close()");
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>

</form>
<Div id="MenuSol"></Div>
</body>
</html>