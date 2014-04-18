
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iChangeSoldTo.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iChangeSoldTo_Lables.jsp"%>


<html>
<head>

<script language = "javascript">
function reloadPage(){
	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "CatArea=" + document.Systems.CatalogArea.value;
	mUrl =  mUrl1 + mUrl2;
	location.href= mUrl;
}

function setAction(){
	document.forms[0].action = "../Misc/ezFinalSaveChangeSoldTo.jsp";
	document.returnValue = true;
}

function setFinalFlag(){
	document.forms[0].FinalFlag.value = 'Y';
	document.returnValue = true;
}

</script>

<title>Catalog Systems</title>

<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body>
<form method="post" action="ezCheckBforeChangeSoldTo.jsp" name="Systems">
  <table width="60%" border="0" align="center">
    <tr align="center"> 
      <td class="displayheader"><%=selSoldTo_L %></td>
    </tr>
  </table>
  <br>
  <table width="50%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
    <tr> 
      <td width="182" class="labelcell"><%=sArea_L%>:</td>
      <td width="141"> 
<%
int catareaRows = retcatarea.getRowCount();  
if ( catareaRows > 0 ) 
{
	out.println("<select name=\"CatalogArea\" onChange= \"reloadPage()\">"); 
	for ( int i = 0 ; i < catareaRows; i++ )
	{		
            	//Following Line commented by Venkat on 4/22/2001
		//String val = (String)(retcatarea.getFieldValue(i,CATALOG_SYSTEM_KEY));		
		String cType = retcatarea.getFieldValueString(i,"ESKD_SUPP_CUST_FLAG");
		cType = cType.trim();  
		if ( cType.equals("V") )continue;
		String val = (String)(retcatarea.getFieldValue(i,SYSTEM_KEY));		

		String sysKeyDesc = (String)(retcatarea.getFieldValue(i,SYSTEM_KEY_DESCRIPTION));

		if( catalog_area.equals( val.trim() ) )
		{
	        	out.println("<option selected value="+ val +">"); 
	        	out.println(sysKeyDesc);
	        	out.println("</option>"); 
		}
		else
		{
	        	out.println("<option value="+ val +">"); 
	        	out.println(sysKeyDesc);
	        	out.println("</option>"); 
		}
	}//End for
      	out.println("</select>"); 
}//End if
%> 
	</td>
	</tr>
      </table>
  <br>
  <table width="50%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
    <tr align="center" valign="middle"> 
      <th width="40%" ><%=soldParty_L%></th>
    </tr>
<%
int soldtoRows = retsoldto.getRowCount();
if ( soldtoRows > 0 ) 
{
	for ( int i = 0 ; i < soldtoRows; i++ )
	{		
		String custNum = (String)(retsoldto.getFieldValue(i,ERP_CUST_NUM1));
		//Modified on 04/27 for setting ERP Customer
		//String custNum = (String)(retsoldto.getFieldValue(i,ERP_CUST_NUM));
		String custName = (String)(retsoldto.getFieldValue(i,ERP_CUST_NAME));
 
		ezc.ezutil.EzSystem.out.println("Customer Name:" + custName);
		ezc.ezutil.EzSystem.out.println("Customer Number:" + custNum);
%> 
    <tr> 
      <td align="left">
<%
		if( (i == 0) || user_soldto.equals( custNum.trim() ) )
		{
			out.println("<input type=\"radio\" checked name=\"SoldTo\" value=\""+ custNum +"\" >");
			out.println(custName + "(" +custNum + ")");
		}
		else
		{
			out.println("<input type=\"radio\" name=\"SoldTo\" value=\""+ custNum +"\" >");
			out.println(custName + "(" +custNum + ")");
		}//End if
%>
	</td>
    </tr>
 <%
	}//End for
	out.println("<input type=\"hidden\" name=\"TotalCount\" value=\""+soldtoRows+"\" >");
      out.println("<input type=\"hidden\" name=\"FinalFlag\" value=\"N\">");
}//End If
%> 
  </table>
  <div align="center"> 
	<br>
 <%
if ( soldtoRows > 0 )  
{
      out.println("<input type=\"submit\" name=\"Submit\" value=\"Select Sold To Party\" onClick=\"setFinalFlag();return document.returnValue\">");
} 
else 
{
	out.println(noCustAsgSarea_L);
	out.println(noAuthSarea_L);
	out.println(selSarea_L);
}
%>
    <br>
    <br>
    <table width="75%" border="0">
      <tr> 
        <td class="blankcell">
          <div align="center">

<%
if ( soldtoRows > 0 )  
{
      out.println("<p>"+savCurrSession_L);
      out.println(savChanPerma_L+"</p>");
      out.println("<input type=\"submit\" name=\"Submit2\" value=\"Save Changes\" onClick=\"setFinalFlag();return document.returnValue\">");
}
%>
          </div>
</td>
      </tr>
    </table>
  </div>
</form>
<form name = ezHelpForm>
<input type=hidden name=ezHelpKeyword value="ezPageHelp">
</form>
<Div id="MenuSol"></Div>
</body>
</html>
