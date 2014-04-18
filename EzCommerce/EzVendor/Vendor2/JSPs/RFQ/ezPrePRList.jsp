<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%//@ include file="../../../Includes/JSPs/Misc/iSbuPlantAddress.jsp"%>

<%@include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@page import="ezc.ezutil.*,java.util.*"%>
<%//@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<%@ include file="../../../../EzCommon/Includes/iShowCal.jsp"%>
 
<Html>
<Head>
<Title>Selection Criteria for PR List -- Powered By Answerthink</Title>
<Script>
	var today ="<%= FormatDate.getStringFromDate(new Date(),".",FormatDate.DDMMYYYY) %>";	
</Script>
<Script src="../../Library/JavaScript/Rfq/ezPrePRList.js"></Script>
<Script src="../../Library/JavaScript/ezTrim.js"></Script>
<SCRIPT src="../../Library/JavaScript/ezCheckFormFields.js"></SCRIPT>
</Head>
<%
	 
	String Status = request.getParameter("Status");
	String display_header = "";
	
	if("R".equals(Status))
		display_header = "Selection Criteria for Released PRs";
	else
		display_header = "Selection Criteria for Unreleased PRs";
	
%>
<Body onLoad="document.myForm.matNo.focus()">
<Form name="myForm" method="POST">
<Input type="hidden" name="Status" value="<%=Status%>">
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<br><br>
<Table  id="tabHead" width="65%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
	<Tr>
		<Th width="20%" align="left">Material Number</Th>
		<Td width="40%">
			<input type="text"   class="InputBox" style="width:100%"  name="matNo" maxlength="20" size="20">
		</Td>
		<Td width="34%">
			<input type="text" class="InputBox"  style="width:100%" name="matDescScrh"  size="15" value="Enter Search String Here." onFocus="setEmpty()" onKeyPress="KeySubmit()">
		</Td>	
		<Td width="6%" valign=middle align=center rowspan=2>	
			<a href= "javascript:searchForMaterial()">Find</a>
		</Td>
	</Tr>  
	 <tr>
		    <th width="20%" align="left">Material Desc.</th>
		    <td width="40%">
			<input type="text" class="InputBox"  style="width:100%"  name="matDesc" maxlength="20" size="25" value="" readonly>
		    </Td>
		     <th width="34%"><input type="radio" name="SearchMat"  value="MatNo" checked>Material No.<input type="radio" name="SearchMat"  value="MatDesc">Material Desc.</th>
	   </tr> 	
	<Tr>
		<Th width="20%" align="left">Plant</Th>
		<Td width="80%" colspan=3>
			<select name="selplant" id="ListBoxDiv1" style="width:50%">
				<option value="">-- Select Plant --</option>
<%
				
%>  	   		
			</select>

		</Td>
	</Tr>  
	<Tr>
		<Th width="20%" align="left">From Date</Th>
		<Td width="80%" colspan=3><input type="text" style="width:50%" name="fromDate" class="InputBox" size=12  readonly><%=getDateImage("fromDate")%> </Td>
	</Tr>
	<Tr>
		<Th width="20%" align="left">To Date</Th>
		<Td width="80%" colspan=3><input type="text" style="width:50%" name="toDate" class="InputBox" size=12  readonly><%=getDateImage("toDate")%> </Td>
	</Tr>
</Table>
<br><br>    
<Div id='ButtonDiv' align="center" style="position:absolute;left:0%;width:100%;top:90%">
<Span id="EzButtonsSpan" >

<%
    	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
    
	buttonName.add("&nbsp;&nbsp;Get&nbsp;PRs&nbsp;&nbsp;");
	buttonName.add("&nbsp;&nbsp;&nbsp;&nbsp;Clear&nbsp;&nbsp;&nbsp;&nbsp;");

	buttonMethod.add("getPRs()");
	buttonMethod.add("reset()");
	
	out.println(getButtonStr(buttonName,buttonMethod));
%>
                        
</Span>

	<Span id="EzButtonsMsgSpan" style="display:none">
		<Table align=center>
			<Tr>
				<Td class="labelcell">Your request is being processed... Please wait</Td>
			</Tr>
		</Table>
	</Span>


</Div>
</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>