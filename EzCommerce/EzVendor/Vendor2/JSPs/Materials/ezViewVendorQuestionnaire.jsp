<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ include file="../../../Includes/JSPs/Materials/iViewVendorQuestionnaire.jsp" %>
<%@ include file="../../../Includes/JSPs/Materials/iGetUploadTempDir.jsp"%>
<%

	String IsPrimeMfr = ret.getFieldValueString(0,"ISPRIMEMFR");
	IsPrimeMfr = IsPrimeMfr.equals("N")? "No":"Yes";

	String Gmp = ret.getFieldValueString(0,"GMP");

	String EmpTraining = ret.getFieldValueString(0,"EMPTRAINING");
	EmpTraining = EmpTraining.equals("N")? "No":"Yes";

	String HouseKeeping = ret.getFieldValueString(0,"HOUSEKEEPING");
	HouseKeeping = HouseKeeping.equals("N")? "No":"Yes";

	String EqDedicated = ret.getFieldValueString(0,"EQDEDICATED");
	EqDedicated = EqDedicated.equals("N")? "No":"Yes";

	String EqMultiPur = ret.getFieldValueString(0,"EQMULTIPUR");
	EqMultiPur = EqMultiPur.equals("N")? "No":"Yes";

	String EqWpMaint = ret.getFieldValueString(0,"EQWPMAINT");
	EqWpMaint = EqWpMaint.equals("N")? "No":"Yes";

	String EqWpClean = ret.getFieldValueString(0,"EQWPCLEAN");
	EqWpClean = EqWpClean.equals("N")? "No":"Yes";

	String EqWpCallib = ret.getFieldValueString(0,"EQWPCALLIB");
	EqWpCallib = EqWpCallib.equals("N")? "No":"Yes";

	String EqAbvDoc = ret.getFieldValueString(0,"EQABVDOC");
	EqAbvDoc = EqAbvDoc.equals("N")? "No":"Yes";

	String MfrTseCert = ret.getFieldValueString(0,"MFRTSECERT");
	MfrTseCert = MfrTseCert.equals("N")? "No":"Yes";

	String MfrIsPencillins = ret.getFieldValueString(0,"MFRISPENCILLINS");
	MfrIsPencillins = MfrIsPencillins.equals("N")? "No":"Yes";

	String MfrIsStOpProc = ret.getFieldValueString(0,"MFRISSTOPPROC");
	MfrIsStOpProc = MfrIsStOpProc.equals("N")? "No":"Yes";

	String MfrIsAbnormal = ret.getFieldValueString(0,"MFRISABNORMAL");
	MfrIsAbnormal = MfrIsAbnormal.equals("N")? "No":"Yes";

	String QcTestProc = ret.getFieldValueString(0,"QCTESTPROC");
	QcTestProc = QcTestProc.equals("N")? "No":"Yes";

	String QcSpecs = ret.getFieldValueString(0,"QCSPECS");
	QcSpecs = QcSpecs.equals("N")? "No":"Yes";

	String QcStatMethods = ret.getFieldValueString(0,"QCSTATMETHODS");
	QcStatMethods = QcStatMethods.equals("N")? "No":"Yes";

	String SheIsoAdapted = ret.getFieldValueString(0,"SHEISOADAPTED");
	SheIsoAdapted = SheIsoAdapted.equals("N")? "No":"Yes";

	String SheWaterAct = ret.getFieldValueString(0,"SHEWATERACT");
	SheWaterAct = SheWaterAct.equals("N")? "No":"Yes";

	String SheAirAct = ret.getFieldValueString(0,"SHEAIRACT");
	SheAirAct = SheAirAct.equals("N")? "No":"Yes";

	String SheWasteMgmt = ret.getFieldValueString(0,"SHEWASTEMGMT");
	SheWasteMgmt = SheWasteMgmt.equals("N")? "No":"Yes";

	String MiscTest = ret.getFieldValueString(0,"MISCTEST");
	MiscTest = MiscTest.equals("N")? "No":"Yes";

	String MiscCert = ret.getFieldValueString(0,"MISCCERT");
	MiscCert = MiscCert.equals("N")? "No":"Yes";

	String MiscSop = ret.getFieldValueString(0,"MISCSOP");
	MiscSop = MiscSop.equals("N")? "No":"Yes";
%>


<html>
<head>
<title>View Vendor Questionnaire</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script>

function fun3()
{
    var win = window.open("ezViewUndertaking.jsp","MyWin","center=yes,height=450,left=50,top=50,width=650,titlebar=no,status=no,resizable=no,scrollbars")
}


function funOpenFile(serverFileInd)
{

  serverFile = eval("document.myForm.upFile"+serverFileInd).value
  var fVal = serverFile.split('*')
  sFile="";
  for(var i=0;i<fVal.length;i++)
  {
      sFile = sFile+fVal[i]+"/"
  }
  sFile = sFile.substring(0,sFile.length-1)
  window.open("/<%=uploadFilePathDir%>"+sFile,"newWin","titlebar=yes")
  //document.location.href="/<%=uploadFilePathDir%>"+sFile
}



	var newWindow4;

	function funViewDocuments()
	{
		newWindow4 = window.open("ezViewQuestionnaireFiles.jsp","MyNewtest","center=yes,height=300,left=200,top=100,width=450,titlebar=no,status=no,resizable=no,scrollbars")

	}

	function funUnLoad()
	{
		if(newWindow4!=null && newWindow4.open)
		{
		   newWindow4.close();
		}
	}

</script>
<script src="../../Library/JavaScript/ezCountriesAndStates.js"></script>
</head>

<body onUnload="funUnLoad()">
<form name="myForm">
<table align="center" width="40%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<tr>
<td class="displayheader" align="center">View Vendor Questionnaire</td>
</tr>
</table>

<div id="totDiv" style="overflow:auto;position:absolute;top:9%;left:5%;width:92%;height:75%">
	<table align=center width=100% border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
	<tr>
	<th align="left" width=25%>Name of the Material</th>
	<td colspan=3 width=25%><%=MaterialDesc%></td>
	</tr>

	<tr>
	<th align="left" colspan=4 width=25%>Contact Person(s)</th>
	</tr>

	<tr>
	<th align="left" colspan=4>1 . Marketing Department</th>
	</tr>

	<tr>
	<th align="left" width=25%>Name</th>
	<td width=25%><%=MktContactName%>&nbsp;</td>
	<th align="left" width=25%>Designation</th>
	<td width=25%><%=MktContactDesignation%>&nbsp;</td>
	</tr>

	<tr>
	<th align="left" width=25%>Phone1</th>
	<td width=25%><%=MktContactPhone1%>&nbsp;</td>
	<th align="left" width=25%>Phone2</th>
	<td width=25%><%=MktContactPhone2%>&nbsp;</td>
	</tr>

	<tr>
	<th align="left" width=25%>Fax</th>
	<td width=25%><%=MktContactFax%>&nbsp;</td>
	<th align="left" width=25%>E-mail</th>
	<td width=25%><%=MktContactEmail%>&nbsp;</td>
	</tr>

	<tr>
	<th align="left" colspan=4 width=25%>2 . Quality Assurance</th>
	</tr>

	<tr>
	<th align="left" width=25%>Name</th>
	<td width=25%><%=QaContactName%>&nbsp;</td>
	<th align="left" width=25%>Designation</th>
	<td width=25%><%=QaContactDesig%>&nbsp;</td>
	</tr>

	<tr>
	<th align="left" width=25%>Phone1</th>
	<td width=25%><%=QaContactPhone1%>&nbsp;</td>
	<th align="left" width=25%>Phone2</th>
	<td width=25%><%=QaContactPhone2%>&nbsp;</td>
	</tr>

	<tr>
	<th align="left" width=25%>Fax</th>
	<td width=25%><%=QaContactFax%>&nbsp;</td>
	<th align="left" width=25%>E-mail</th>
	<td width=25%><%=QaContactEmail%>&nbsp;</td>
	</tr>

	<tr>
	<th align="left" width=65% colspan=2>Manufacturing Capacity</th>
	<td width=35% colspan=2><%=MfgCapacity%>&nbsp;</td>
	</tr>

	<tr>
	<th align="left" width=65% colspan=2>Total Capacity per Month</th>
	<td width=35% colspan=2><%=TotalCapacity%>&nbsp;</td>
	</tr>

	<tr>
	<th align="left" width=65% colspan=2>% of supply to NCP</th>
	<td width=35% colspan=2><%=PctgSupply%>&nbsp;</td>
	</tr>

	<tr>
	<th align="left" width=65% colspan=2>Is the company a prime manufacturer ?</th>
	<td width=35% colspan=2><%=IsPrimeMfr%>&nbsp;</td>
	</tr>

	<%  ezc.drl.util.Replace rep = new ezc.drl.util.Replace(); %>

	<tr>
	<th align="left" width=65% colspan=2>Name of other products manufactured</th>
	<td width=35% colspan=2><%=rep.setNewLine(prodsOffered)%>&nbsp;</td>
	</tr>


	<tr>
	<th align="left" width=65% colspan=2>Name of other major customers</th>
	<td width=35% colspan=2><%=rep.setNewLine(customers)%>&nbsp;</td>
	</tr>

	<tr>
	<th align="left" width=65% colspan=2>Is the facility certified?<br>If Yes, Please attach a copy of Certificate. </th>
	<td width=35% colspan=2>

	    <% if(Gmp.equals("Y"))
	       {
	   %><br>GMP :&nbsp;&nbsp;&nbsp;
		 <!--<a href="ezViewUploadedFile.jsp?fileName=<%//gmpServerFile%>"><%//gmpFile%></a> -->
                <input type='hidden' name='upFile1' value='<%=gmpServerFile%>'>
                <a href='javascript:funOpenFile(1)'><%=gmpFile%></a>
	    <% } %>

	    <% if(!Other.equals(""))
	       {
	    %>
	    	<br>Other : &nbsp;&nbsp;&nbsp;<%=Other%>&nbsp;</td>
            <%}%>
	</tr>
	</table>

	<table align=center width=100% border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>

	<tr>
	<th align="left" colspan=2 width=80%>Personnel</th>
	</tr>

	<tr>
	<td align="left" width=80%>Is training program conducted for personnel ?</td>
	<td width=20%><%=EmpTraining%>&nbsp;</td>
	</tr>

	<tr>
	<th align="left" colspan=2 width=80%>Premises</th>
	</tr>

	<tr>
	<td align="left" width=80%>Does the company have written procedures for house keeping ?</td>
	<td width=20%><%=HouseKeeping%>&nbsp;</td>
	</tr>

	<tr>
	<th align="left" colspan=2 width=80%>Equipment</th>
	</tr>

	<tr>
	<td align="left" colspan=2 width=80%>Is the manufacturing equipment </td>
	</tr>

	<tr>
	<td align="left" width=80%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Dedicated</td>
	<td width=20%><%=EqDedicated%>&nbsp;</td>
	</tr>

	<tr>
	<td align="left" width=80%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Multi purpose type</td>
	<td width=20%><%=EqMultiPur%>&nbsp;</td>
	</tr>

	<tr>
	<td align="left" colspan=2 width=80%>Are written procedures available for </td>
	</tr>

	<tr>
	<td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Maintenance of equipment</td>
	<td><%=EqWpMaint%>&nbsp;</td>
	</tr>

	<tr>
	<td align="left" width=80%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cleaning of equipment</td>
	<td width=20%><%=EqWpClean%>&nbsp;</td>
	</tr>

	<tr>
	<td align="left" width=80%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Calibration of equipment and instruments</td>
	<td width=20%><%=EqWpCallib%>&nbsp;</td>
	</tr>

	<tr>
	<td align="left" width=80%>Are all the above mentioned activities being documented</td>
	<td width=20%><%=EqAbvDoc%>&nbsp;</td>
	</tr>

	<tr>
	      <th align="left" colspan=2>Manufacture</th>
	</tr>

	<tr>
	      <td align="left" width="80%">Are the materials supplied by the company, of
	        animal origin ?<br>
	(Furnish the TSE / BSE declaration certificate)</td>
	      <td width="20%"><%=MfrTseCert%>&nbsp;</td>
	</tr>

	<tr>
	      <td align="left" width="80%">Are the materials being manufatured along with
	        Cephalosporins/Pencillins ?</td>
	      <td width="20%"><%=MfrIsPencillins%>&nbsp;</td>
	</tr>

	<tr>
	      <td align="left" width="80%">Are there Standard Operating procedures for carrying
	        out Various activities related to the Production ?</td>
	      <td width="20%"><%=MfrIsStOpProc%>&nbsp;</td>
	</tr>

	<tr>
	      <td align="left" width="80%">Is follow up action taken in case any abnormalities
	        are observed during the course of manufacture of any batch ?</td>
	      <td width="20%"><%=MfrIsAbnormal%>&nbsp;</td>
	</tr>

	<tr>
	      <th align="left" colspan=2>Quality Control</th>
	</tr>

	<tr>
	      <td align="left" width="80%">Are there test procedures for the analysis of
	        the products of the company ?</td>
	      <td width="20%"><%=QcTestProc%>&nbsp;</td>
	</tr>

	<tr>
	      <td align="left" width="80%">Are all the specifications and test procedures
	        documented ?</td>
	      <td width="20%"><%=QcSpecs%>&nbsp;</td>
	</tr>

	<tr>
	      <td align="left" width="80%">Are there any statistical methods being employed
	        in the Sampling of the materials for the purpose of analysis ?</td>
	      <td width="20%"><%=QcStatMethods%>&nbsp;</td>
	</tr>

	<tr>
	    <th align="left" colspan=2>SHE Questionnaire</th>
	</tr>

	<tr>
	    <td align="left" width="80%">Has the company adopted ISO 14000/Responsible Care/Any
	      other voluntary environmental code ?</td>
	    <td width="20%"><%=SheIsoAdapted%>&nbsp;</td>
	</tr>

	<tr>
	    <td align="left" colspan=2>Does the company have Environmental consents as per</td>
	</tr>

	<tr>
	    <td align="left" width="80%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Water Act</td>
	    <td width="20%"><%=SheWaterAct%>&nbsp;</td>
	</tr>

	<tr>
	    <td align="left" width="80%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Air Act</td>
	    <td width="20%"><%=SheAirAct%>&nbsp;</td>
	</tr>

	<tr>
	    <td align="left" width="80%">Authorization as per the hazardous waste management ?</td>
	    <td width="20%"><%=SheWasteMgmt%>&nbsp;</td>
	</tr>

	<tr>
	    <th align="left" colspan=2>Miscellaneous</th>
	</tr>

	<tr>
	    <td align="left" width="80%">Is the company prepared to provide the Test Methods
	      for the products supplied ?</td>
	    <td width="20%"><%=MiscTest%>&nbsp;</td>
	</tr>

	<tr>
	    <td align="left" width="80%">Is the company prepared to provide the Certificate
	      of Analysis for the dispatched batches ?</td>
	    <td width="20%"><%=MiscCert%>&nbsp;</td>
	</tr>

	<tr>
	    <td align="left" width="80%">Does the company have a SOP on complaints and does
	      it address the Corrective and Preventive actions ?</td>
	    <td width="20%"><%=MiscSop%>&nbsp;</td>
	</tr>
	</table>
	</div>

	<%
	   if(!fileName.equals(""))
	   {
	%>
		<div style="position:absolute;top:87%;width:100%" align="center">
		<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border=none onClick="history.go(-1)" >
		<img src="../../Images/Buttons/<%=ButtonDir%>/viewdocuments.gif" style="cursor:hand" border=none onClick="funViewDocuments()">
		</div>
	<% }
		else
		{
	%>


		<div style="position:absolute;top:87%;width:100%" align="center">
		<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border=none onClick="history.go(-1)">
		</div>
	<%
		}
	%>

<input type=hidden name="fileName" value="<%=fileName%>">
<input type=hidden name="serverLou" value="<%=serverLou%>">
</form>
<Div id="MenuSol"></Div>
</body>
</html>
