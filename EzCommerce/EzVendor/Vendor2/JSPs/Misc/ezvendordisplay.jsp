<%@page import="java.sql.*" %>
<%@ page import="java.util.*,ezc.ezbasicutil.*,ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iVendorProfile_Labels.jsp"%>
<%@ include file="../../../Includes/JSPs/Materials/iGetVendorProfile.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>   
<%

		
		String statusStr = "";
		
		Connection con = null;
		java.sql.Statement stmt = null;
		java.sql.PreparedStatement prepareStmt = null;
		ResultSet rs = null;
		int PRItemCnt  = 0;
		int id = 0;
		try
		{
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			con 	= DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ezlife;SelectMethod=cursor", "ezlife1", "ezlife1");
			stmt 	= con.createStatement();
			id 	= Integer.parseInt(request.getParameter("id"));
			
			rs = stmt.executeQuery("SELECT * FROM EZC_VENDOR_REG_DETAILS WHERE EVRD_ID="+id);
			while(rs.next()) 
			{
				
				

%>	
			
		
	
<%
	String appRej = rs.getString("EVRD_STATUS");

	if(count>0)
	{
%>
		<html>
		<head>
		<style>
		.menu{
			font-family: "Verdana";
			font-size: 11px;
			font-style: normal;
			color: #000000;
			}

			.labelcell{}
			td.labelcell{
				font-family: "Arial";
				font-size: 9pt;
				font-style: normal;
				color: WHITE;
				background-color:"#336699"
		}
		</style>
		<script src="../../Library/JavaScript/ezCountriesAndStates.js"></script>
		<%@ include file="../../../Includes/JSPs/Materials/iTopTabScript.jsp"%>
		<script>
		   function viewAttachments()
		   {
		   	var pathName=document.myForm.pathName.value;
		   	newWindow = window.open("ezViewAttachments.jsp?pathName="+pathName,"MyWindow","center=yes,height=450,left=100,top=50,width=550,titlebar=no,status=no,resizable,scrollbars")
		   }
		   function showDiv_new(currentTab,totalTabs)
		   {
		   	  for(var i=1;i<=totalTabs;i++)
		   	  {
		   		if(i==currentTab)
		   		{
		   			document.getElementById("tab"+i).style.visibility="visible"
		   			document.getElementById("tab"+i).style.width="100%"
		   			document.getElementById("tab"+i+"color").style.color="#00385D"
		   
		   			document.getElementById("tab"+i+"_3").src="../../../../EzCommon/Images/Tabs/ImgLftUp.gif"
		   			document.getElementById("tab"+i+"_2").src="../../../../EzCommon/Images/Tabs/ImgRgtUp.gif"
		   			document.getElementById("tab"+i+"_1").style.background="url('../../../../EzCommon/Images/Tabs/ImgCtrUp.gif')"
		   			
		   		}
		   		else
		   		{
		   			document.getElementById("tab"+i).style.visibility="hidden"
		   			document.getElementById("tab"+i+"color").style.color="#B7B7B7"
		   
		   			document.getElementById("tab"+i+"_3").src="../../../../EzCommon/Images/Tabs/ImgLftDn.gif"
		   			document.getElementById("tab"+i+"_2").src="../../../../EzCommon/Images/Tabs/ImgRgtDn.gif"
		   			document.getElementById("tab"+i+"_1").style.background="url('../../../../EzCommon/Images/Tabs/ImgCtrDn.gif')"
		   			document.getElementById("tab"+i).style.width="0%"
		   		}
		   	  }
		   
		   }
		   function funPrint()
		   {

			  newWindow = window.open("ezPrintVendorProfile.jsp","MyWindow","center=yes,height=450,left=100,top=50,width=550,titlebar=no,status=no,resizable,scrollbars")

		   }
		   function ApproveReject(status1)
		   {
		   	
		   	document.myForm.statushidden.value = status1;
		   	document.myForm.action = "ezApproveRejectVendor.jsp";
		   	document.myForm.submit();
		   	
		   }
		   
		   function goBack()
		   {
		   
		    document.location.href = "ezListOfVendors.jsp?statusFlag=SUBMITTED";

		   

		   }

			var newWindow4;

			function openFileWindow()
			{
				newWindow4 = window.open("ezViewProfileFiles.jsp?sysKey=<%=sysKey%>&soldTo=<%=soldTo%>","MyNewtest","center=yes,height=300,left=200,top=100,width=450,titlebar=no,status=no,resizable=no,scrollbars")

			}

			function funUnLoad()
			{
				if(newWindow4!=null && newWindow4.open)
				{
				   newWindow4.close();
				}
			}

			function showDiv(n)
			{
			  for(var i=1;i<=5;i++)
			  {
				if(i==n)
				{
					document.getElementById("tab"+i).style.visibility="visible"
					document.getElementById("tab"+i+"color").style.color="#000000"
				}
				else
				{
					document.getElementById("tab"+i).style.visibility="hidden"
					document.getElementById("tab"+i+"color").style.color="#ffffff"
				}


			  }
			  tabfun(n)
			}
		</script>
		</head>
		<body topmargin=0 rightmargin=0 leftmargin=0 onLoad="showDiv_new('1','5')" onUnLoad="funUnLoad()" scroll="No">
		<form name="myForm">
		<input type=hidden name="vendId" value='<%=id%>'>
		<input type = hidden name = "statushidden" >
			
		 <% String display_header=vendProf_L;%>
		 <%@ include file="../Misc/ezDisplayHeader.jsp" %>
		 
		 <Div >
		 <Table align=center border=0 cellPadding=0 cellSpacing=0  width=90%>
		 <TBODY>
		 <Tr>
		 <Td>
			<Table cellSpacing=0 cellPadding=0 width=100% border=0>
			<TBODY>
			<Tr>
			<Td vAlign=bottom height=45 width=100%  style="background:FFFBFB">
			<Table cellSpacing=0 cellPadding=0 border=0 >
			<TBODY>
			
				<Tr>
				<%
				java.util.Hashtable tabHash = new java.util.Hashtable();
				tabHash.put("TAB1","Address");
				tabHash.put("TAB2","Excise Details");
				tabHash.put("TAB3","Control Details");
				tabHash.put("TAB4","Bank Details");
				tabHash.put("TAB5","Personal Details");
				for(int i=1;i<=5;i++)
				{
					%>
					<Td width=5 class='blankcell'><IMG id="tab<%=i%>_3" height=27 src="../../../../EzCommon/Images/Tabs/ImgLftUp.gif" width=5 border=0></Td>
					<Td id="tab<%=i%>_1" style="cursor:hand" style="background-image:url('../../../../EzCommon/Images/Tabs/ImgCtrUp.gif')" onClick="showDiv_new('<%=i%>',5)"><font id='tab<%=i%>color'><b>&nbsp;&nbsp;&nbsp;&nbsp;<%=(String)tabHash.get("TAB"+i)%>&nbsp;&nbsp;&nbsp;</b></font></Td>
					<Td width=10 class='blankcell'><IMG id="tab<%=i%>_2" height=27 src="../../../../EzCommon/Images/Tabs/ImgRgtUp.gif" width=10  border=0></Td>
			
				<%}%>
				</Tr>
			</TBODY>
			</Table>
			</Td>
			<Td class=blankcell vAlign=center align=right height=45>&nbsp; </Td>
			</Tr>
			</TBODY>
			</Table>
		  </Td>
		  </Tr>
		</Table>

				
		<div id="tab1" style="overflow:auto;position:absolute;height:86%;width:100%;visibility:hidden">
		<div style="overflow:auto;position:absolute;height:70%;width:92%;left:5%;background-color:'#E6E6E6'">
		<br/><br/>
		<table align=center width=85% border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=0 cellSpacing=0>
		<tr><td class="blankcell">
			     <table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">
			  


			     <tr>
			     <th width="20%" align="left">Name</th>
			     <td width="30%"><%=rs.getString("EVRD_NAME")%>&nbsp;</td>
			     <input type="hidden" name="pathName" value="<%=rs.getInt("EVRD_ID")%>">
				<th width="20%" align="left">Street/House No:</th>
			     <td width="30%"><%=rs.getString("EVRD_HOUSE_NO")%>&nbsp;</td>
			     </tr>
			     <Tr>
			     <th width="20%" align="left">Postal Code:</th>
			     <td width="30%"><%=rs.getString("EVRD_POSTAL_CODE")%>&nbsp;</td>
			     <th width="20%" align="left">Country </th>
			     <td width="30%"><%=rs.getString("EVRD_ADDRESS_COUNTRY")%>&nbsp;</td>

			     </Tr>
			     <tr>
			     <th width="20%" align="left">Region </th>
			     <td width="30%"><%=rs.getString("EVRD_REGION")%>&nbsp;</td>
			      <th width="20%" align="left"> Telephone No </th>
			      <td width="30%"><%=rs.getString("EVRD_TEL_NO")%>&nbsp;</td>

			     </Tr>
			     <Tr>
			     <th width="20%" align="left">Mobile No:</th>
			     <td width="30%"><%=rs.getString("EVRD_MOBILE_NO")%>&nbsp;</td>
			      <th width="20%" align="left"> Fax</th>
			      <td width="30%"><%=rs.getString("EVRD_FAX")%>&nbsp;</td>

			     </tr>

			     <tr>
			     <th width="20%" align="left">E-mail </th>
			     <td width="30%"><%=rs.getString("EVRD_EMAIL")%> &nbsp;</td>
			     
			     </Tr>
			     
			      </table>
			      </td>
			    </tr>
			</table>
		 </div>

		      <div align=center style="position:absolute;top:75%;width:100%">
		      <center>
		      <%
		      	   buttonName = new java.util.ArrayList();
		      	   buttonMethod = new java.util.ArrayList();
		      	   if(filesCount>0)
		      	   {
		      	     %>
		      		
		      		<% buttonName.add("View Documents");
		      	           buttonMethod.add("openFileWindow()"); %>
		       <%  } %>
		      		      
		      		      
		         		<% 
		         		
		         		   buttonName.add("Back");
			   	  	   buttonMethod.add("goBack()");
		         		   if("SUBMITTED".equals(appRej))
		         		   {
						   buttonName.add("Approve");
						   buttonMethod.add("ApproveReject(\"Y\")"); 
						   buttonName.add("Reject");
						   buttonMethod.add("ApproveReject(\"N\")");
					   }
					   buttonName.add("View Attachments");
				   	   buttonMethod.add("viewAttachments()");
				   	   out.println(getButtonStr(buttonName,buttonMethod));%>
		      </center>
		      </div>
		</div>


		<div id="tab2" style="position:absolute;height:86%;width:100%;visibility:hidden">

		<div align=center style="overflow:auto;position:absolute;height:70%;width:92%;left:5%;background-color:'#E6E6E6'">
		<br/><br/>
		<table align=center width=85% border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=0 cellSpacing=0>
		<tr><td class="blankcell">

			    <table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">

			    <tr>
			    <th width="35%" align="left">Excise No</th>
			    <td width="65%"><%=rs.getString("EVRD_ECC_NO")%>&nbsp;</td>
			    </tr>

			    <tr>
			    <th width="35%" align="left">Excise Reg No</th>
			    <td width="65%"><%=rs.getString("EVRD_EXCISE_REG_NO")%>&nbsp;</td>
			    </tr>

			    <tr>
			    <th width="35%" align="left">Excise Range</th>
			    <td  width="65%"><%=rs.getString("EVRD_EXCISE_RANGE")%>&nbsp;</td>
			    </tr>

			    <tr>
			    <th width="35%" align="left">Excise Division</th>
			    <td width="65%"><%=rs.getString("EVRD_EXCISE_DIV")%>&nbsp;</td>
			    </tr>

			    <tr>
			    <th width="35%" align="left">PAN No</th>
			    <td width="65%"><%=rs.getString("EVRD_PAN_NO")%>&nbsp;</td>
			    </tr>

			   
			</table>

			      </td>
			    </tr>
			</table>
			</div>

		      <div align=center style="position:absolute;top:75%;width:100%">
		      <center>
		      <%
		      	   buttonName = new java.util.ArrayList();
		           buttonMethod = new java.util.ArrayList();
			   if(filesCount>0)
			   {
		      %>
				
				<% buttonName.add("View Documents");
				   buttonMethod.add("openFileWindow()"); %>
		      <%   } %>

		      
		      
		      		<% 
		      		   buttonName.add("Back");
			   	   buttonMethod.add("goBack()");
			   	if("SUBMITTED".equals(appRej))
		         	{
		      		   buttonName.add("Approve");
				   buttonMethod.add("ApproveReject(\"Y\")"); 
				   buttonName.add("Reject");
				   buttonMethod.add("ApproveReject(\"N\")");
				  }
				   buttonName.add("View Attachments");
				   buttonMethod.add("viewAttachments()");
				   out.println(getButtonStr(buttonName,buttonMethod));%>
		      </center>
		      </div>
		</div>


		<div id="tab3" style="position:absolute;height:86%;width:100%;visibility:hidden">

		<div align=center style="overflow:auto;position:absolute;height:70%;width:92%;left:5%;background-color:'#E6E6E6'">
		<br/><br/>
		<table width=85% align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=0 cellSpacing=0>
		<tr><td class="blankcell">

			   <table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">

			   <tr>
			   <th width=30% >VAT Reg No:&nbsp;</th>
			   <td><%=rs.getString("EVRD_VAT_REG_NO")%></td>
			</tr>
			</table>
			</td>
			</tr>
			</table>
			</div>

		      <div align=center style="position:absolute;top:75%;width:100%">
		      <center>
		      <%
		      	     	   buttonName = new java.util.ArrayList();
		      	           buttonMethod = new java.util.ArrayList();
		      		   if(filesCount>0)
		      		   {
		      	            %>
		      			
		      			<% buttonName.add("View Documents");
		      	 		   buttonMethod.add("openFileWindow()"); %>
		      	      <%   } %>
		      		      
		      		      
		      	      		<% 
		      	      		   buttonName.add("Back");
			   	  	   buttonMethod.add("goBack()");
			   	  	   if("SUBMITTED".equals(appRej))
		         		   {
		      	      		   buttonName.add("Approve");
					   buttonMethod.add("ApproveReject(\"Y\")"); 
					   buttonName.add("Reject");
					   buttonMethod.add("ApproveReject(\"N\")");
					   }
					   buttonName.add("View Attachments");
					   buttonMethod.add("viewAttachments()");
				   out.println(getButtonStr(buttonName,buttonMethod));%>
		      </center>
		      </div>
		</div>


		<div id="tab4" style="overflow:auto;position:absolute;height:86%;width:100%;visibility:hidden">

		<div align=center style="overflow:auto;position:absolute;height:70%;width:92%;left:5%;background-color:'#E6E6E6'">
		<br/><br/>
		<table width="85%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=0 cellSpacing=0>
		<tr><td class="blankcell">
		 <table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">
			<%  ezc.ezbasicutil.EzReplace rep = new ezc.ezbasicutil.EzReplace(); %>

			   <tr>
			    <th width="30%"align="left">Country</th>
			    <td width="70%" align=left><%=rs.getString("EVRD_BANK_COUNTRY")%>&nbsp;</td>
			    </tr>
				</tr>
			    <tr>
			    <th width="30%" align="left">Bank Key</th>
			    <td width="70%" align="left"><%=rs.getString("EVRD_BANK_KEY")%>&nbsp;</td>
			    </tr>

			    <tr>
			    <th width="30%" align="left">Bank Account</th>
			    <td  width="70%"><%=rs.getString("EVRD_BANK_ACCOUNT_NO")%>&nbsp;</td>
			    </tr>

			    <tr>
			    <th width="30%" align=left>A/C holder</th>
			    <td  width="70%"><%=rs.getString("EVRD_ACCOUNT_HOLDER")%>&nbsp;</td>
			    </tr>

			  
		     </table>
			      </td>
			    </tr>
			</table>
			</div>

		      <div align=center style="position:absolute;top:75%;width:100%">
		      <center>
		      <%
		       	   buttonName = new java.util.ArrayList();
		           buttonMethod = new java.util.ArrayList();
		    	   if(filesCount>0)
		    	   {
		    	      %>
		    		
		    		<% buttonName.add("View Documents");
		    		   buttonMethod.add("openFileWindow()"); %>
		      <%   } %>
		               
		               
		      		<%
		      		   buttonName.add("Back");
			   	   buttonMethod.add("goBack()");
			   	   if("SUBMITTED".equals(appRej))
		         		   {
		      		   buttonName.add("Approve");
				   buttonMethod.add("ApproveReject(\"Y\")"); 
				   buttonName.add("Reject");
				   buttonMethod.add("ApproveReject(\"N\")");
				   }
				   buttonName.add("View Attachments");
				   buttonMethod.add("viewAttachments()");
				   out.println(getButtonStr(buttonName,buttonMethod));%>
		      </center>
		      </div>
		</div>
<div id="tab5" style="overflow:auto;position:absolute;height:86%;width:100%;visibility:hidden">

		<div align=center style="overflow:auto;position:absolute;height:70%;width:92%;left:5%;background-color:'#E6E6E6'">
		<br/><br/>
		<table width="85%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=0 cellSpacing=0>
		<tr><td class="blankcell">
		 <table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">
			<%  rep = new ezc.ezbasicutil.EzReplace(); %>

			   <tr>
			    <th width="30%"align="left">First Name</th>
			    <td width="70%" align=left><%=rs.getString("EVRD_FIRST_NAME")%>&nbsp;</td>
			    </tr>
				</tr>
			    <tr>
			    <th width="30%" align="left">Last Name</th>
			    <td width="70%" align="left"><%=rs.getString("EVRD_SECOND_NAME")%>&nbsp;</td>
			    </tr>

			    <tr>
			    <th width="30%" align="left">Telephone No</th>
			    <td  width="70%"><%=rs.getString("EVRD_PERSONAL_TEL_NO")%>&nbsp;</td>
			    </tr>

			 
		     </table>
			      </td>
			    </tr>
			</table>
			</div>

		      <div align=center style="position:absolute;top:75%;width:100%">
		      <center>
		      <%
		       	   buttonName = new java.util.ArrayList();
		           buttonMethod = new java.util.ArrayList();
		    	   if(filesCount>0)
		    	   {
		    	      %>
		    		
		    		<% buttonName.add("View Documents");
		    		   buttonMethod.add("openFileWindow()"); %>
		      <%   } %>
		           <% 
		           buttonName.add("Back");
			   buttonMethod.add("goBack()");
			   if("SUBMITTED".equals(appRej))
		         	{
		           buttonName.add("Approve");
			   buttonMethod.add("ApproveReject(\"Y\")"); 
			   buttonName.add("Reject");
			   buttonMethod.add("ApproveReject(\"N\")");
			   }
			   buttonName.add("View Attachments");
			   buttonMethod.add("viewAttachments()");
			out.println(getButtonStr(buttonName,buttonMethod));%>    
		               
		      		
		      </center>
		      </div>
		</div>
		<input type="hidden" name="SysKey" value="<%=sysKey%>">
		<input type="hidden" name="SoldTo" value="<%=soldTo%>">
		<input type="hidden" name="editPage" value="<%=editPage%>">
		
<%  
	}
	else
	{  
		String noDataStatement = vendNotEnProf_L;
%>
		<%@ include file="../Misc/ezDisplayNoData.jsp" %>
<%
	}
	}
	}
	catch(Exception e)
			{
				System.out.println("Exception Occured While Inserting vendor details "+e);
			}
			finally
			{
			
				if(con!=null)	
				con.close();
				if(prepareStmt!=null)
				prepareStmt.close();
		}
	
%>

<Div id="MenuSol"></Div>
		</form>
		</body>
		</html>