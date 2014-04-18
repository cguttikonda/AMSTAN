<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Materials/iGetVendorProfile.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%
	ButtonDir = "ENGLISH/MAROON";
%>
<%
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

		   function funPrint()
		   {

			  newWindow = window.open("ezPrintVendorProfile.jsp","MyWindow","center=yes,height=450,left=100,top=50,width=550,titlebar=no,status=no,resizable,scrollbars")

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
			  for(var i=1;i<=4;i++)
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
		<body topmargin=0 rightmargin=0 leftmargin=0 onLoad="showDiv('1')" onUnLoad="funUnLoad()" scroll="No">
		<form name="myForm">
		<!--
		<table align="center" width="40%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>

			<tr>
			<td class="displayheader" align="center">Vendor Profile</td>
			</tr>
			</table>
		-->	

		 <Div >
		 <Table align=center border=0 cellPadding=0 cellSpacing=0  width=90%>
		 <TBODY>
		 <Tr>
		 <Td>
			<Table cellSpacing=0 cellPadding=0 width=100% border=0>
			<TBODY>
			<Tr>
			<Td vAlign=bottom height=45 width=100%  class=blankcell>
			<Table cellSpacing=0 cellPadding=0 border=0 >
			<TBODY>
			<Tr>
				<Td class=blankcell width=10 ><IMG name=startBack height=27 src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_front_left.gif" width=15 border=0></Td>

				<Td class=blankcell id="tab1_1" style="cursor:hand" background="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_fill_front.gif" onClick="showDiv('1')"><font id='tab1color'>Corporate Details</font></Td>
				<Td class=blankcell width=10><IMG name="tab1_2" height=27 src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_front_right.gif" width=15  border=0></Td>
				<Td class=blankcell width=10><IMG name="tab1_3" height=27 src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_back1_left.gif" width=15 border=0></Td>

				<Td class=blankcell id="tab2_1" style="cursor:hand" background="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_fill_back.gif" onClick="showDiv('2')"><font id='tab2color'>Trade Details</font></Td>
				<Td class=blankcell width=10><IMG name="tab2_2" height=27 src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_back_right.gif" width=15 border=0></Td>
				<Td class=blankcell width=10 ><IMG name="tab2_3" height=27  src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_back2_left.gif" width=15 border=0></Td>
				<Td class=blankcell id="tab3_1" style="cursor:hand" background="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_fill_back.gif" onClick="showDiv('3')"><font  id='tab3color'>Manufacturing Sites</font></Td>
				<Td class=blankcell width=10><IMG name="tab3_2" height=27 src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_back_right.gif" width=15 border=0></Td>
				<Td class=blankcell width=10 ><IMG name="tab3_3" height=27  src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_back2_left.gif" width=15 border=0></Td>

				<Td class=blankcell id="tab4_1" style="cursor:hand" background="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_fill_back.gif" onClick="showDiv('4')"><font id='tab4color'>Company Details</font></td>
				<Td class=blankcell width=10><IMG name="tab4_2" height=27 src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_back_right.gif" width=15 border=0></Td>
				<Td class=blankcell width=12><IMG name="tab4_3" height=27 src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_back_end.gif" width=12 border=0></Td>
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

		<div style="overflow:auto;position:absolute;height:70%;width:92%;left:5%">
		<table align=center width=100% border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
		<tr><td class="blankcell">
			     <table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">
			     <tr>
			     <th width="20%" align="left">Company Name</th>
			     <td width="80%" colspan=3><%=companyName%>&nbsp;</td>
		 </tr>


			     <tr>
			     <th width="20%" align="left">Address1 </th>
			     <td width="30%"><%=address1%>&nbsp;</td>
				<th width="20%" align="left">Contact Person </th>
			     <td width="30%"><%=contactPerson%>&nbsp;</td>
			     </tr>
			     <Tr>
			     <th width="20%" align="left">Address2</th>
			     <td width="30%"><%=address2%>&nbsp;</td>
			     <th width="20%" align="left">Designation </th>
			     <td width="30%"><%=designation%>&nbsp;</td>

			     </Tr>
			     <tr>
			     <th width="20%" align="left">City </th>
			     <td width="30%"><%=city%>&nbsp;</td>
			      <th width="20%" align="left"> Phone1 </th>
			      <td width="30%"><%=phone1%>&nbsp;</td>

			     </Tr>
			     <Tr>
			     <th width="20%" align="left">State</th>
			     <td width="30%"><%=state%>&nbsp;</td>
			      <th width="20%" align="left"> Phone2 </th>
			      <td width="30%"><%=phone2%>&nbsp;</td>

			     </tr>

			     <tr>
			     <th width="20%" align="left">Country </th>
			     <td width="30%"><%=country%> &nbsp;</td>
			     <th width="20%" align="left"> Fax </th>
			      <td width="30%"><%=fax%>&nbsp;</td>
			     </Tr>
			     <Tr>
			     <th width="20%" align="left">Zip </th>
			     <td width="30%"><%=zipcode%>&nbsp;</td>
			     <th width="20%" align="left">Email </th>
			     <td width="30%"><%=email%>&nbsp;</td>
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
		      		<!-- <img src="../../Images/Buttons/<%=ButtonDir%>/viewdocuments.gif"  border="none" valign=bottom style="cursor:hand" onClick="openFileWindow()"> -->
		      		<% buttonName.add("View Documents");
		      	           buttonMethod.add("openFileWindow()"); %>
		       <%  } %>
		      		      <!--<img src="../../Images/Buttons/<%=ButtonDir%>/printversion.gif"  border="none" valign=bottom style="cursor:hand" onClick="funPrint()"> -->
		      		      <!--<a href="../Misc/ezSBUWelcome.jsp" target="display"><img src="../../Images/Buttons/<%=ButtonDir%>/cancel.gif" style="cursor:hand" border="none"></a>-->
		         		<% buttonName.add("Print Version");
		     			   buttonMethod.add("funPrint()"); 
			   		   out.println(getButtonStr(buttonName,buttonMethod));%>
		      </center>
		      </div>
		</div>


		<div id="tab2" style="position:absolute;height:86%;width:100%;visibility:hidden">

		<div align=center style="overflow:auto;position:absolute;height:70%;width:92%;left:5%">
		<table align=center width=100% border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
		<tr><td class="blankcell">

			    <table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">

			    <tr>
			    <th width="35%" align="left">Salestax Regn No</th>
			    <td width="65%"><%=salestax%>&nbsp;</td>
			    </tr>

			    <tr>
			    <th width="35%" align="left">Central Excise Regn No</th>
			    <td width="65%"><%=cexcise%>&nbsp;</td>
			    </tr>

			    <tr>
			    <th width="35%" align="left">Drug License No</th>
			    <td  width="65%"><%=druglic%>&nbsp;</td>
			    </tr>

			    <tr>
			    <th width="35%" align="left">DMF No</th>
			    <td width="65%"><%=dmfno%>&nbsp;</td>
			    </tr>

			    <tr>
			    <th width="35%" align="left">Total Production Capacity </th>
			    <td width="65%"><%=prodCapacity%>&nbsp;</td>
			    </tr>

			    <tr>
			    <th width="35%" align="left">TurnOver - Domestic/Exports</th>
			    <td  width="65%" class=""><%=turnOver%>&nbsp;</td>
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
				<!-- <img src="../../Images/Buttons/<%=ButtonDir%>/viewdocuments.gif"  border="none" valign=bottom style="cursor:hand" onClick="openFileWindow()"> -->
				<% buttonName.add("View Documents");
				   buttonMethod.add("openFileWindow()"); %>
		      <%   } %>

		      <!--<img src="../../Images/Buttons/<%=ButtonDir%>/printversion.gif"  border="none" valign=bottom style="cursor:hand" onClick="funPrint()"> -->
		      <!--<a href="../Misc/ezSBUWelcome.jsp" target="display"><img src="../../Images/Buttons/<%=ButtonDir%>/cancel.gif" style="cursor:hand" border="none"></a>-->
		      		<% buttonName.add("Print Version");
				   buttonMethod.add("funPrint()"); 
				   out.println(getButtonStr(buttonName,buttonMethod));%>
		      </center>
		      </div>
		</div>


		<div id="tab3" style="position:absolute;height:86%;width:100%;visibility:hidden">

		<div align=center style="overflow:auto;position:absolute;height:70%;width:92%;left:5%">
		<table width=100% align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
		<tr><td class="blankcell">

			   <table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">

			   <tr>
			   <th>&nbsp;</th>
			   <th>Manufacturing Site - I</th>
			   <th>Manufacturing Site - 2</th>
			   <th>Manufacturing Site - 3</th>
			   </tr>
			   <tr>
			   <th align="left" width="19%">Address1 </th>
			   <td width="27%"><%=man1address1%>&nbsp;</td>
			   <td width="27%"><%=man2address1%>&nbsp;</td>
			   <td width="27%"><%=man3address1%>&nbsp;</td>
			   </Tr>
			   <Tr>
			   <th align="left" width="19%">Address2 </th>
			   <td width="27%"><%=man1address2%>&nbsp;</td>
			   <td width="27%"><%=man2address2%>&nbsp;</td>
			   <td width="27%"><%=man3address2%>&nbsp;</td>
			   </tr>
			   <tr>
			   <th align="left" width="19%">City </th>
			   <td width="27%"><%=man1city%>&nbsp;</td>
			   <td width="27%"><%=man2city%>&nbsp;</td>
			   <td width="27%"><%=man3city%>&nbsp;</td>
			   </Tr>
			   <Tr>
			   <th width="19%" align="left">State </th>
			   <td width="27%"><%=man1state%>&nbsp;</td>
			   <td width="27%"><%=man2state%>&nbsp;</td>
			   <td width="27%"><%=man3state%>&nbsp;</td>
			   </tr>
			   <tr>
			   <th width="19%" align="left">Country </th>
			   <td width="27%">
				<script>
				   for(var i=0;i<CountryArr.length;i++)
				   {
						if(CountryArr[i].key=='<%=man1country%>')
						{
							document.write(CountryArr[i].value);
						}
				   }
				</script>

				&nbsp;</td>
			   <td width="27%">
			  <script>
				   for(var i=0;i<CountryArr.length;i++)
				   {
						if(CountryArr[i].key=='<%=man2country%>')
						{
							document.write(CountryArr[i].value);
						}
				   }
				</script>


			   &nbsp;</td>
			   <td width="27%">
			  <script>
				   for(var i=0;i<CountryArr.length;i++)
				   {
						if(CountryArr[i].key=='<%=man3country%>')
						{
							document.write(CountryArr[i].value);
						}
				   }
				</script>
			&nbsp;</td>
			   </Tr>
			   <Tr>
			   <th width="19%" align="left">Zip </th>
			   <td width="27%"><%=man1zipcode%>&nbsp;</td>
			   <td width="27%"><%=man2zipcode%>&nbsp;</td>
			   <td width="27%"><%=man3zipcode%>&nbsp;</td>
			   </tr>

			   <tr>
			   <th width="19%" align="left"> Phone1 </th>
			   <td width="27%"><%=man1phone1%>&nbsp;</td>
			   <td width="27%"><%=man2phone1%>&nbsp;</td>
			   <td width="27%"><%=man3phone1%>&nbsp;</td>
			   </Tr>
			   <Tr>
			   <th width="19%" align="left">Phone2 </th>
			   <td width="27%"><%=man1phone2%>&nbsp;</td>
			   <td width="27%"><%=man2phone2%>&nbsp;</td>
			   <td width="27%"><%=man3phone2%>&nbsp;</td>
			   </tr>
			   <tr>
			   <th width="19%" align="left">Fax </th>
			   <td width="27%"><%=man1fax%>&nbsp;</td>
			   <td width="27%"><%=man2fax%>&nbsp;</td>
			   <td width="27%"><%=man3fax%>&nbsp;</td>
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
		      			<!-- <img src="../../Images/Buttons/<%=ButtonDir%>/viewdocuments.gif"  border="none" valign=bottom style="cursor:hand" onClick="openFileWindow()"> -->
		      			<% buttonName.add("View Documents");
		      	 		   buttonMethod.add("openFileWindow()"); %>
		      	      <%   } %>
		      		      <!--<img src="../../Images/Buttons/<%=ButtonDir%>/printversion.gif"  border="none" valign=bottom style="cursor:hand" onClick="funPrint()"> -->
		      		      <!--<a href="../Misc/ezSBUWelcome.jsp" target="display"><img src="../../Images/Buttons/<%=ButtonDir%>/cancel.gif" style="cursor:hand" border="none"></a>-->
		      	      		<% buttonName.add("Print Version");
		      			   buttonMethod.add("funPrint()"); 
			 		   out.println(getButtonStr(buttonName,buttonMethod));%>
		      </center>
		      </div>
		</div>


		<div id="tab4" style="overflow:auto;position:absolute;height:86%;width:100%;visibility:hidden">

		<div align=center style="overflow:auto;position:absolute;height:70%;width:92%;left:5%">
		<table width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
		<tr><td class="blankcell">
		 <table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">
			<%  ezc.ezbasicutil.EzReplace rep = new ezc.ezbasicutil.EzReplace(); %>

			   <tr>
			    <th width="30%"align="left">Organogram </th>
			    <td width="70%" align=left><%=rep.setNewLine(organogram)%>&nbsp;</td>
			    </tr>
				</tr>
			    <tr>
			    <th width="30%" align="left">Details of the Company </th>
			    <td width="70%" align="left"><%=rep.setNewLine(companyDetails)%>&nbsp;</td>
			    </tr>

			    <tr>
			    <th width="30%" align="left">Banker Details </th>
			    <td  width="70%"><%=rep.setNewLine(bankerDetails)%>&nbsp;</td>
			    </tr>

			    <tr>
			    <th width="30%" align=left>Products Offered </th>
			    <td  width="70%"><%=rep.setNewLine(prodsOffered)%>&nbsp;</td>
			    </tr>

			    <tr>
			    <th width="30%" align=left>New Developments </th>
			    <td  width="70%"><%=rep.setNewLine(newDevelopments)%>&nbsp;</td>
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
		    		<!-- <img src="../../Images/Buttons/<%=ButtonDir%>/viewdocuments.gif"  border="none" valign=bottom style="cursor:hand" onClick="openFileWindow()"> -->
		    		<% buttonName.add("View Documents");
		    		   buttonMethod.add("openFileWindow()"); %>
		      <%   } %>
		               <!--<img src="../../Images/Buttons/<%=ButtonDir%>/printversion.gif"  border="none" valign=bottom style="cursor:hand" onClick="funPrint()"> -->
		               <!--<a href="../Misc/ezSBUWelcome.jsp" target="display"><img src="../../Images/Buttons/<%=ButtonDir%>/cancel.gif" style="cursor:hand" border="none"></a>-->
		      		<% buttonName.add("Print Version");
		      		   buttonMethod.add("funPrint()"); 
				   out.println(getButtonStr(buttonName,buttonMethod));%>
		      </center>
		      </div>
		</div>

		<input type="hidden" name="SysKey" value="<%=sysKey%>">
		<input type="hidden" name="SoldTo" value="<%=soldTo%>">
		<input type="hidden" name="editPage" value="<%=editPage%>">
		<Div id="MenuSol"></Div>
		</form>
		</body>
		</html>
<%  
	}
	else
	{  
		String noDataStatement = "Vendor has not yet entered his Profile";
%>
		<%@ include file="../Misc/ezDisplayNoData.jsp" %>
<%
	}
%>

