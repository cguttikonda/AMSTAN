<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/SalesDocMails/iGetSalesDocMailDetails.jsp" %>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<html>
<head>
<script  src="../../Library/JavaScript/SalesDocMails/ezUpdateSalesDocMails.js"></script>
<script  src="../../Library/JavaScript/CheckFormFields.js"></script>
<script language="JavaScript">
function funUpdate()
{
	if(chkMail())
	{
   		document.myForm.action="ezEditSalesDocMails.jsp"
   		document.myForm.submit()
   	}
}
function checkFields()
{
   	var j=document.myForm.elements.length
   	return true
}
function funFocus()
{
	if(document.myForm.To!=null)
		document.myForm.To.focus();
}
</script>
</head>
<body onLoad = "funFocus()">
<form name=myForm method=post>
<%

      	if(DetObj.getRowCount()!=0)
      	{
	     	if(cenplan.equals("noexist"))
     	     	{
	         	cenplan=DetObj.getFieldValueString(0,"ESM_PRODUCT_CODE");
     	     	}
	     	else if(cenplan.equals("mktservices"))
             	{
         		cenplan="Marketing Services";
     	     	}
     	     	else
             	{
        	 	cenplan="Central Planner";
             	}
%>

<br>
	<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
	   	<tr>
	 		<th align="center">Update Mails for <%=cenplan %> </th>
	   	</tr>
	</table>
	<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
<%
	String plant = DetObj.getFieldValueString(0,"ESM_PLANT");
	if((plant==null) || ("null".equals(plant)))
        {
           	plant="";
        }
     	String Pcode="";
     	int len=0;String temp1="";
     	String to=DetObj.getFieldValueString(0,"ESM_TO");
	if((to==null) || ("null".equals(to)))
        {
           	to="";
        }
        if(to.endsWith(","))
        {
           	to=to.substring(0,to.length()-1);
        }
        String cc=DetObj.getFieldValueString(0,"ESM_CC");
	if((cc==null) || ("null".equals(cc)))
        {
	        cc="";
        }
	if(cc.endsWith(","))
        {
         	cc=cc.substring(0,cc.length()-1);
        }
     	String edd=DetObj.getFieldValueString(0,"ESM_EDD");
     	if((edd==null) || ("null".equals(edd)))
     	{
        	edd="";
     	}
     	if(edd.endsWith(","))
     	{
         	edd=edd.substring(0,edd.length()-1);
     	}
        String plan=DetObj.getFieldValueString(0,"ESM_PLANT");
        if((plan==null) || ("null".equals(plan)) || (plan=="") || (plan.equals("")) || (plan.equals(" "))  )
        {
            	plan="";
        }
     	Pcode=DetObj.getFieldValueString(0,"ESM_PRODUCT_CODE");
%>
   		<input type="hidden" name="Plant" value = "<%=plant%>">
	<tr>
		<td class="labelcell" align = "right">Plant</td>
		<td><%=plant%></td>
	</tr>
	<tr>
		<Th align = "right" valign = "top" width = "15%">To</th>
        	<td><textarea rows=3 name="To" style="overflow:auto;border:0;width:100%"><%=to%></textarea></td>
	</tr>
	<tr>
		<th align = "right" valign = "top" width = "15%">CC</th>
       		<td><textarea rows=3 name="Cc" style="overflow:auto;border:0;width:100%"><%=cc %></textarea></td>
	</tr>
	<tr>
		<th align = "right" valign = "top" width = "15%">BCC/ERP ID</th>
        	<td><textarea rows=3 name="Edd" style="overflow:auto;border:0;width:100%"><%=edd%></textarea></td>
	</tr>
</table>
<center><font size = -1 face = "arial">* If you want to enter more than one mailid separate with ","<font></center>
<br>
<center>
	<a href="javascript:funUpdate()"><img src="../../Images/Buttons/<%=ButtonDir%>/save.gif" style="cursor:hand" border=no ></a>
	<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
	<img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none onClick="javascript:history.go(-1)" style = "cursor:hand">
</center>

<input type="hidden" name="PCode" value="<%=Pcode%>">
<%

}
else
{
	String str="";
	if("centralplanner".equals(cenplan))
		str="Central Planner";
	else if("mktservices".equals(cenplan))
		str="Marketing Service";
%>
	<br><br><br><br>
	<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
		<tr>
		 	<th align="center">No <%=str%> Mails to List, Please Click on Add to Add <%=str%> Mail.</th>
		</tr>
       </table>
       <br>
       <center>

       		<a href="ezAddSalesDocMails.jsp?From=<%=cenplan%>"><img src="../../Images/Buttons/<%= ButtonDir%>/add.gif" border=none></a>
       		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
       </center>
<%
}

%>
</form>
</body>
</html>
