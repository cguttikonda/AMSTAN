<jsp:useBean id="CnetManager" class="ezc.ezcnetconnector.client.EzCnetConnectorManager" scope="page"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ page import="ezc.ezcnetconnector.params.*,ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>


<%
    	
    	String catID     = request.getParameter("catID");
    	String atrID     = request.getParameter("atrID");
    	String atrDesc   = request.getParameter("atrDesc");
    	String id        = request.getParameter("id");
    	String autoSub   = request.getParameter("autoSub");
    	
	ReturnObjFromRetrieve retObj = null;
	int attrValCnt= 0;
	EzcParams ezcpparams = new EzcParams(true);
	EzCnetConnectorParams cnetParams=new EzCnetConnectorParams();
	cnetParams.setStatus("GET_ATTRVAL_CATNATTR");
	cnetParams.setCategoryID(catID);
	cnetParams.setAttrID(atrID);
	cnetParams.setQuery("");
	ezcpparams.setObject(cnetParams);
	ezcpparams.setLocalStore("Y");
	Session.prepareParams(ezcpparams);
	retObj = (ReturnObjFromRetrieve)CnetManager.ezGetCnetAttrValuesByStatus(ezcpparams);
	
	if(retObj!=null)
		attrValCnt = retObj.getRowCount();
        
		      
		 
	
%>

<html>
<head> <title>Product Details</title> 
<script>
		  var tabHeadWidth=95
 	   	  var tabHeight="70%"

	var id = "<%=id%>"
	var autoSub = '<%=autoSub%>'
	function selAtrVal(atrValID,atrValDesc)
	{
		window.returnValue = atrValID + "##" + atrValDesc
		window.close()
		
	}
	function funcLoad()
	{
	
		window.returnValue=""
	}
         
</script> 
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
</head>
<body onLoad="scrollInit();funcLoad()" onResize="scrollInit()" scroll=no>
<form name="myForm">

<%
	if(attrValCnt>0)
	{
%>
	<Div id='theads'>
      <Table  width="95%" id='tabHead' align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
          <Tr align="center" valign="middle">
            <Th width="100%">Select <%=atrDesc%></Th>
    	</Tr>
    </Table>
    </div>
    
    <DIV id='InnerBox1Div' style='overflow:auto;position:absolute;width:90%;height:70%'>
	<Table id='InnerBox1Tab' width='100%' align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<%
	for(int i=0;i<attrValCnt;i++)
	{
		String atrValID = retObj.getFieldValueString(i,"ValID");
		String atrValDesc = retObj.getFieldValueString(i,"ValText");
%>
	<tr>  
	     <td width="100%" align="left"><a href="#" onClick="selAtrVal('<%=atrValID%>','Description')"><%=atrValDesc%></td>
	</tr> 
<%
	}
%>
	</table>
	</div>
<%
	}
	else
	{
		String noDataStatement ="No values present for "+atrDesc;  
%>

	<%@ include file="../Misc/ezDisplayNoData.jsp"%> 

<%
	}
%>

<br>	
	
   <DIV style='overflow:auto;position:absolute;top:90%;left:42%'>
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