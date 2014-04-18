<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iSelectSoldTo.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iChangeSoldTo_Lables.jsp"%>
<%
	if(session.getValue("SCList")!= null)
		session.removeValue("SCList");
	if(session.getValue("customers") != null)
		session.removeValue("customers");

	session.putValue("CRI_CUST_SAS",retcatarea);
	if((soldtoRows==1) && (catareaRows == 1))
	{
		String tempSoldTo = retsoldto.getFieldValueString(0,ERP_CUST_NUM);
		
		if(tempSoldTo.indexOf("&")>=0)
			tempSoldTo = tempSoldTo.replaceAll("&","@");	 
%>	       <html>
	       <body>
	       <script>
			 top.document.location.href="ezPreWelcome.jsp?SoldTo=<%=tempSoldTo%>&CatalogArea=<%=retcatarea.getFieldValue(0,SYSTEM_KEY)%>"
	       </script>
	       </body>
	       </html>
<%	}
	else
	{
%>  
<html>  
<head>

<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script language = "javascript">
	function myalert()
	{
		myurl = document.URL;
		index = myurl.indexOf(".jsp");
 		newurl = myurl.substring(0, index);
		mUrl1 =  newurl + ".jsp?";
		mUrl2 = "CatalogArea=" + document.Systems.CatalogArea.options[document.Systems.CatalogArea.selectedIndex].value;
		mUrl =  mUrl1 + mUrl2;
		location.href= mUrl;
	}
	function ezLogout()
	{
             	if(document.Systems.onceSubmit.value!=1)
             	{
   	     		document.Systems.onceSubmit.value=1
  	     		document.body.style.cursor="wait"
	     		document.Systems.action="ezLogout.jsp";
	     		document.Systems.target="_top"
	     		document.Systems.submit();
             	}
	}
	function formSubmit()
	{
		if(document.Systems.onceSubmit.value!=1)
		{
   			document.Systems.onceSubmit.value=1
  			document.body.style.cursor="wait"
			document.Systems.submit();
                }
	}
	function checkBrowser()
	{
		var browserName=navigator.appName;
		if(browserName!=null)
			document.Systems.chkBrowser.value=browserName
			
	
	}
	
</script>
</head>
<body  onLoad="checkBrowser()" topmargin=0 scroll="No" leftmargin=0 rightmargin=0 >
<form method="post" action="ezPreWelcome.jsp" name="Systems" target="_top">
<input type="hidden" name="onceSubmit" value=0>
<input type="hidden" name="TotalCount" value="<%=soldtoRows%>">
<input type="hidden" name="chkBrowser" value="">
<%
	String sysKeyDesc ="";
	String sysKeyVal ="";
	String noDataStatement = "";	
	if((soldtoRows==0)&& (catareaRows == 1))
	{
		sysKeyDesc = (String)(retcatarea.getFieldValue(0,SYSTEM_KEY_DESCRIPTION));
		noDataStatement = "No customers available in the Sales Area "+sysKeyDesc+"<BR><BR>Please contact the administrator.";
%>
		<%@ include file="ezDisplayNoData.jsp"%>
<%	
	}
	else if((soldtoRows==1)&& (catareaRows == 0))
	{
		noDataStatement = "No Sales Area assigned for your user id.<BR><BR>Please contact the administrator.";
%>
		<%@ include file="ezDisplayNoData.jsp"%>
<%	
	}
	else 
	{
		String display_header = null;
		if(catareaRows > 1){
		 	display_header ="PLEASE SELECT SALES ORGANIZATION AND CUSTOMER";
		}else{
			display_header ="PLEASE SELECT CUSTOMER";
		
		}
%>		
		
		
		<Table align=center width="100%" topMargin=0 marginheight="0">
			<Tr><Td align=center  height="35" bgcolor="#0865A5">
			<font size=2 face=verdana><b><%=display_header%></b></font></Td></Tr>
		</Table>
		
		<BR><BR>
		
		<Div id='InputDiv' style='position:absolute;align:center;top:20%;width:80%;left:10%; '>
		<Table width="70%" style="background-color:'#227A7A'" border="0" cellspacing="0" cellpadding="0" align=center valign=center style="background-color:'#227A7A'" >
		<Tr>
			<Td height="5" style="background-color:'#227A7A'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
			<Td height="5" style="background-color:'#227A7A'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
			<Td height="5" style="background-color:'#227A7A'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
		</Tr>
		<Tr height=50px  style="background-color:'#227A7A'"  >
			<Td width="5" style="background-color:'#227A7A'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
			<Td style="background-color:'#227A7A';font-size:12px" valign=middle align=center>

				<table width="80%" align=center border=0  borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
				<Tr>
					<Th width="15%" style="background-color:'#227A7A'" align=right>Sales Organization &nbsp;&nbsp;----&nbsp;&nbsp;</Th>
					<Th width="15%" align='left' style="background-color:'#227A7A'">
<%			
					if(catareaRows > 1)
					{
%>				
						<select name='CatalogArea' id=listBoxDiv style="border:1px solid"  onChange= 'myalert()' tabIndex=1>
<%				
						for (int i = 0 ; i < catareaRows; i++)
						{
							String cType = retcatarea.getFieldValueString(i,"ESKD_SUPP_CUST_FLAG");
							cType = cType.trim();
							if (cType.equals("V")) 
								continue;
							sysKeyVal  = (String)(retcatarea.getFieldValue(i,SYSTEM_KEY));
							sysKeyDesc = (String)(retcatarea.getFieldValue(i,SYSTEM_KEY_DESCRIPTION));
							if(catalog_area.equals(sysKeyVal))
							{
%>						
								<option selected value='<%=sysKeyVal%>'><%=sysKeyDesc%></option>
<%					
							}
							else
							{
%>						
								<option value='<%=sysKeyVal%>'><%=sysKeyDesc%></option>
<%					
							}
						}
%>				
						</select>
<%			
					}
					else
					{
						sysKeyVal  = (String)(retcatarea.getFieldValue(0,SYSTEM_KEY));
						sysKeyDesc = (String)(retcatarea.getFieldValue(0,SYSTEM_KEY_DESCRIPTION));
%>				
						<%=sysKeyDesc%>
						<input type='hidden' name='CatalogArea' value='<%=sysKeyVal%>'>
<%			
					}
%>			
					</Th>
				</Tr>
				<Tr style="background-color:'#227A7A'"><Td style="background-color:'#227A7A'">&nbsp;</Td></Tr>
				<Tr style="background-color:'#227A7A'"><Th width='15%' style="background-color:'#227A7A'" align=right>Company &nbsp;&nbsp;----&nbsp;&nbsp;</Th><Td width='15%' style="background-color:'#227A7A'">
<%			
				if(soldtoRows >1)
				{
%>						

					<select name='SoldTo' tabIndex=2 style="border:1px solid" >
<%				
					String str[]={ERP_CUST_NAME};
					for(int i = 0;i < soldtoRows;i++)
					{
%>						
						<option value="<%=retsoldto.getFieldValueString(i,ERP_CUST_NUM)%>"><%=retsoldto.getFieldValueString(i,ERP_CUST_NAME)%>[<%=retsoldto.getFieldValueString(i,ERP_CUST_NUM)%>]</option>
<%
					}
%>				
					</select>
<%			
				}
				else if(soldtoRows ==1)
				{
					String soldTo 	  = (String)(retsoldto.getFieldValue(0,ERP_CUST_NUM));
					String soldToName = (String)(retsoldto.getFieldValue(0,ERP_CUST_NAME));
					soldToName=(soldToName==null || "null".equals(soldToName) )?soldTo:soldToName;
%>				
					<%=soldToName%>
					<input type='hidden' name='SoldTo' value='<%=soldTo%>'>
<%			
				}
				else
				{
%>				
					<font color=red><b>No Customers Available.Please Contact System Administrator</b></font>
<%			
				}
%>			
				</Td></Tr></Table>				
				
				
			</Td>
			<Td width="5" style="background-color:'#227A7A'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
		</Tr>
		<Tr>
			<Td width="5" style="background-color:'#227A7A'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
			<Td height="5" style="background-color:'#227A7A'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
			<Td width="5" style="background-color:'#227A7A'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
		</Tr>
		</Table>
		</Div>

		<br>
		<div id="ButtonDiv"  style="position:absolute;left:0%;width:100%;top:40%">
		<center>
<%			
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();

		buttonName.add("Go");
		buttonMethod.add("formSubmit()");

		buttonName.add("Quit");
		buttonMethod.add("ezLogout()");
		out.println(getButtonStr(buttonName,buttonMethod));
%>     		
		</center>
		</div>
<%		
	}
%>
	</form>
	<Div id="MenuSol"></Div>
	</body>
	</html>
<%
	}
%>


