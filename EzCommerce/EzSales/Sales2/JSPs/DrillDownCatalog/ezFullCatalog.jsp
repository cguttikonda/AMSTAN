
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/DrillDownCatalog/iFullCatalog.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iFullCatalogFinal_Lables.jsp"%>
<html>
<head>
<title>ezCatalog</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<Script>
		  var tabHeadWidth=85
 	   	  var tabHeight="60%"
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<script>
	function funShow(aURL,aCatDesc,aGroup,aLevel,aDesc)
	{
		document.myForm.action=aURL;
		document.myForm.ProductGroup.value=aGroup
		document.myForm.GroupDesc.value=aDesc
		document.myForm.GroupLevel.value=aLevel
            	document.body.style.cursor="wait"
		document.myForm.CatalogDescription.value=aCatDesc
		document.myForm.onceSubmit.value=1
		document.myForm.submit();
	}
	function selSoldTo()
	{
		document.location.replace("../Misc/ezWelcome.jsp");
	}
</script>
</head>
<body  onLoad="scrollInit(10)" onresize="scrollInit(10)" scroll=no>
<Div id="theads">
<table align=center id="tabHead" border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
    <td align=center height="35" class="displayheader"  width="100%"><%= CatalogDescription %></td>
</tr>
</table>
</Div>
    	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:88%;height:60%;left:6%">
	<Table align=center id="InnerBox1Tab"  width="100%">
<%
	
	String groupDesc 	= null;
	String groupNum 	= null;
	String groupLevel 	= null;
	String termFlag 	= null;
	String grpforgif 	= null;
	
	if (retCount > 0){
		// Loop thru All the Product Group retCount
		for ( int i = 0 ; i <  retCount; i++ ) {
		  if("Y".equals(ret.getFieldValueString(i,"ISCHECKED")))
		  {
			if (i%3==0){
				out.println("<tr>");
			}
			groupDesc = (String)ret.getFieldValue(i, PROD_GROUP_WEB_DESC);
			java.util.StringTokenizer strtok = new java.util.StringTokenizer(groupDesc," ");
			groupNum = (String)ret.getFieldValue(i, PROD_GROUP_NUMBER);
			grpforgif = groupNum;

			grpforgif = groupNum.replace('*','0');
			grpforgif = grpforgif.trim();

			if(ret.getFieldValue(i,PROD_GROUP_LEVEL) != null){
					groupLevel = (ret.getFieldValue(i, PROD_GROUP_LEVEL)).toString();
			}

			termFlag = (String)ret.getFieldValue(i, PROD_GROUP_TERMINAL_FLAG);
			%>
		        <TD align="center"  width="33%" class="blankcell"><br>
		        <%
		      
				//Check for the last level
				if(termFlag.equals("Y")){
			%>
					<A HREF ="JavaScript:funShow('ezCatalogFinalLevel.jsp','<%=CatalogDescription%>','<%=groupNum.trim()%>','<%=groupLevel%>','<%=groupDesc%>')" <%=statusbar%>><%=groupDesc%></A>
			<%
				}else{
			%>
					<A HREF ="JavaScript:funShow('ezCatalogNextLevel.jsp','<%=CatalogDescription%>','<%=groupNum.trim()%>','<%=groupLevel%>','<%=groupDesc%>')"    <%=statusbar%>><%=groupDesc%></A>
			<%
				}//End check for terminal flag
			
			%> </TD>

			<%--   <TD align="center" class="blankcell">
			// Product Group Image
			out.println("<img src=\"../../Images/Catalog/Groups/" +grpforgif+ ".gif\" vspace=\"10\" hspace=\"10\" border=\"2\">");
			</TD> 

		      <TD align="left" class="blankcell" width="15%">
			<a href="JavaScript:funShow('ezAddCustomCatalog.jsp','<%=CatalogDescription%>','<%=groupNum%>','<%=groupLevel%>','<%=groupDesc%>')"   <%=statusbar%>>
			<img src="../../Images/Icons/addtofav.gif" border="0"  title=" "></a>
        		</TD>--%>
			<%
       			if ((i!=0)&&(i/3.0==0)){
					out.println("</tr>");
			}
		   }//end of if
		}// End for
	}else {
	%>
		<TR>
	        <TD colspan="3"> <font size="4"><%=error_L%></font></TD>
	    </TR>
	<%
	}//End if retCount>0
	%>
</Table>
</Div>
<div id="buttonDiv" style="position:absolute;top:90%;left:45%">
<%
		
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		
		buttonName.add("Back");
		buttonMethod.add("selSoldTo()");
		out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>

<form name=myForm>
<input type="hidden" name="onceSubmit" value=0>
<input type=hidden name="ProductGroup" value="">
<input type=hidden name=CatalogDescription  value="">
<input type=hidden name=GroupLevel value="">
<input type=hidden name="GroupDesc" value="">
<input type=hidden name="from" value="1">
</form>
<Div id="MenuSol"></Div>
</body>
</html>
