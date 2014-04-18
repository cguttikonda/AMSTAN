<%
java.util.TreeSet alphaTree = new java.util.TreeSet();
String alphaName = null;
String searchVen = "$";
String alphabet = "";
int retCount = sapvendRetCount;

	for(int i=0;i<retCount;i++)
	{
		alphaName = sapvendRet.getFieldValueString(i,"ECA_NAME");
		alphaTree.add((alphaName.substring(0,1)).toUpperCase());
	}
	
	if(request.getParameter("searchcriteria")!=null)
		searchVen=request.getParameter("searchcriteria");
		
	if(alphaTree.size()>0 && "$".equals(searchVen))
	{
		alphabet = (String)alphaTree.first();
		if(" ".equals(alphabet))
			alphabet = "A";
			
		searchVen=alphabet+"*";	
	}	
%>	


	<Table  border=0 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=5 cellSpacing=1   width="90%">
	<Tr>
	<th align = "center">
<%
	for(int i=65;i<91;i++)
	{
		char alpha = (char)i;
		if(alphaTree.contains(""+alpha))		
		{
			if((alpha+"*").trim().equals(request.getParameter("searchcriteria")) || (alpha+"").equals(alphabet))
			{
%>
				&nbsp;<font color = "white"><%=alpha%></font>&nbsp;
				
<%
			}
			else
			{
%>
				&nbsp;<a href = "JavaScript:ezAlphabet('<%=alpha%>')"><font color = "blue"><%=alpha%></font></a>&nbsp;
<%
			}
		}
		else
		{
%>		
			&nbsp;<%=alpha%>&nbsp;			
<%
		}
	}
	if(alphaTree.size()>0)
	{
		if("".equals(request.getParameter("searchcriteria")))
		{
%>
			&nbsp;<font color = "white">All</font>&nbsp;
						
<%
		}
		else
		{
%>
			&nbsp;<a href = "JavaScript:ezAlphabet('All')"><font color = "blue">All</font></a>&nbsp;
<%
		}
	}
	else
	{
%>
		&nbsp;All
<%
	}
%>
		</Th>
	</Tr>

</Table>
<%
ezc.ezbasicutil.EzSearchReturn mySearch = new ezc.ezbasicutil.EzSearchReturn();
if(searchVen !=null && (! "null".equals(searchVen)) && searchVen.length()!=3)
{
	mySearch.search(sapvendRet,"ECA_NAME",searchVen.toUpperCase());
}

	int rCount = sapvendRet.getRowCount();
	Vector Vendor=new Vector();
	Vector Neme=new Vector();
	sapvendRet.sort(new String[]{"ECA_NAME"},true);
	for(int i=0;i<rCount;i++)
	{
			if(!Vendor.contains((String) sapvendRet.getFieldValue(i,"EC_ERP_CUST_NO")))
			{
				String ven = ((String) sapvendRet.getFieldValue(i,"EC_ERP_CUST_NO")).trim();
				Vendor.addElement(ven);
				Neme.addElement((String) sapvendRet.getFieldValue(i,"ECA_NAME"));
			}
	}

%>
<%

	if(Vendor.size()==0)
	{
%>
	<br><br><br><br><br>
	<Table width=80% align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
		<Tr>
			<Th>No Vendors exist</th>
		</Tr>
	</table>
<%	}
	else
	{	
%>
<Div id="theads" >
<Table id="tabHead" width="90%" align=center  border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
        <tr>
        <th align="center" width="5%">&nbsp;</th>
        <th align="center" width="25%">Vendor</th>
        <th align="center" width="70%">Name</th>
        </tr>
</Table>
</Div>

<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:90%;height:60%;left:5%">
<Table  id="InnerBox1Tab" width="100%" align=center  border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
<%
	String vendor1="";
	
 	
 	for(int i=0;i<Vendor.size();i++)
	{	
		vendor1 = (String) Vendor.elementAt(i);//sapvendRet.getFieldValueString(i,"EC_ERP_CUST_NO");
		vendor1 = "-#"+vendor1+"#"+qty+"#"+"S";
%>
		<tr>
			<td align="center" width="5%"><input type="checkbox" name="chk1" value="<%=vendor1%>"><input type=hidden name='qtyTxt' class=InputBox value='<%=qty%>' style='width:100%' maxlength=6></td>
			<td align="left" width="25%"><a href = "javascript:funShowVndrDetails('<%=(String)session.getValue("SYSKEY")%>','<%=sapvendRet.getFieldValueString(i,"EC_ERP_CUST_NO")%>')"><%=sapvendRet.getFieldValueString(i,"EC_ERP_CUST_NO")%>&nbsp;</a></td>
        		<td align="left" width="70%"><%=(String) Neme.elementAt(i)%>&nbsp;</td>
		</tr>
<%
	}
%>
</table>
</div>
<% 	} 
%>
<Div id="MenuSol"></Div>
