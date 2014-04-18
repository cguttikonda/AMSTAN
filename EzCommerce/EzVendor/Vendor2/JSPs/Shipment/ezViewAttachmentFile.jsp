<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iViewAttachmentFile_Labels.jsp"%>
<%@ page import="java.util.*" %>
<%@ include file="../../../Includes/JSPs/Materials/iGetUploadTempDir.jsp" %>
<html>
<head>
	<title>Attachments</title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
	<script>
	var attach;
	function funAttach(i)
	{
		attach=window.open("../Shipment/ezAttachFile.jsp?index="+i,"UserWindow2","width=350,height=250,left=150,top=100,resizable=yes,scrollbars=yes,toolbar=no,menubar=no");
	}
	function funDone()
	{
		window.close();
	}
	</script>

<script>

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
  window.open("../Misc/ezViewFile.jsp?filename=<%=uploadFilePathDir%>"+sFile,"newWin","titlebar=yes")
  //document.location.href="/<%=uploadFilePathDir%>"+sFile
}

</script>

</head>
<body >
<%
	String bool="false";

	Vector vcfiles=new Vector();
	Vector vsfiles=new Vector();

	String cfiles=request.getParameter("filestring");
	String sfiles=request.getParameter("serverfiles");

	StringTokenizer cstk=new StringTokenizer(cfiles,"§");
	StringTokenizer sstk=new StringTokenizer(sfiles,"µ");

	while(cstk.hasMoreElements())
	{
		vcfiles.addElement(cstk.nextToken());
		vsfiles.addElement(sstk.nextToken());
	}

	String dcdoc=null;
	String lrdoc=null;
	String packagedoc=null;
	String invoicedoc=null;
	String sdcdoc=null;
	String slrdoc=null;
	String spackagedoc=null;
	String sinvoicedoc=null;

	if(vcfiles.size()>0)
	{
		dcdoc=(((String)vcfiles.elementAt(0)).equals("NA"))?"":(String)vcfiles.elementAt(0);
		lrdoc=(((String)vcfiles.elementAt(1)).equals("NA"))?"":(String)vcfiles.elementAt(1);
		packagedoc=(((String)vcfiles.elementAt(2)).equals("NA"))?"":(String)vcfiles.elementAt(2);
		invoicedoc=(((String)vcfiles.elementAt(3)).equals("NA"))?"":(String)vcfiles.elementAt(3);
		sdcdoc=(((String)vsfiles.elementAt(0)).equals("NA"))?"&nbsp;":(String)vsfiles.elementAt(0);
		slrdoc=(((String)vsfiles.elementAt(1)).equals("NA"))?"&nbsp;":(String)vsfiles.elementAt(1);
		spackagedoc=(((String)vsfiles.elementAt(2)).equals("NA"))?"&nbsp;":(String)vsfiles.elementAt(2);
		sinvoicedoc=(((String)vsfiles.elementAt(3)).equals("NA"))?"&nbsp;":(String)vsfiles.elementAt(3);
	}

%>
<form name="myForm">

	<table width="90%" align=center border=0>
	<tr><td><%=attFiles_L%></td></tr>
	<tr><td class="blankcell"><hr></td></tr>
	<tr><td class="blankcell"><%=clkViewSav_L%></td></tr>
	</table>

	<br>
	<table width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<%
	if(!(dcdoc==null || "null".equals(dcdoc)||"".equals(dcdoc)))
	{
		bool="true";

	%>
		<tr>
		<th colspan=3 align="left"><%=dc_Doc_L%></th>
		</tr>
		<tr>

		<td align="left">
		<!--<a href="../Materials/ezViewUploadedFile.jsp?fileName=<%//sdcdoc%>"><%//dcdoc%></a> -->
                <input type='hidden' name='upFile0' value='<%=sdcdoc%>'>
		<a href='javascript:funOpenFile(0)'><%=dcdoc%></a>
		<input type="hidden"   value="" name="serverfile">
		</tr>
<%
	}
	if(!(lrdoc==null || "null".equals(lrdoc) || "".equals(lrdoc)))
	{
		bool="true";
%>

		<tr>
		<th colspan=3 align="left"><%=lr_Doc_L%></th>
		</tr>
		<tr>

		<td align="left">
		<!--<a href="../Materials/ezViewUploadedFile.jsp?fileName=<%//slrdoc%>"><%//lrdoc%></a>-->
                <input type='hidden' name='upFile1' value='<%=slrdoc%>'>
		<a href='javascript:funOpenFile(1)'><%=lrdoc%></a>
		<input type="hidden"  value="" name="serverfile">
		</td>
		</tr>
<%
	}
	if(!(packagedoc==null || "null".equals(packagedoc) || "".equals(packagedoc)))
	{
		bool="true";
%>

		<tr>
		<th colspan=3 align="left"><%=pack_Doc_L%></th>
		</tr>
		<tr>

		<td align="left">
		<!--<a href="../Materials/ezViewUploadedFile.jsp?fileName=<%//spackagedoc%>"><%//packagedoc%></a>-->
                <input type='hidden' name='upFile2' value='<%=spackagedoc%>'>
		<a href='javascript:funOpenFile(2)'><%=packagedoc%></a>
		<input type="hidden" value="" name="serverfile">
		</td>
		</tr>
<%
	}
	if(!(invoicedoc==null || "null".equals(invoicedoc) || "".equals(invoicedoc)))
	{
		bool="true";
%>
		<tr>
		<th colspan=3 align="left"><%=inv_Doc_L%></th>
		</tr>
		<tr>

		<td align="left">
		<!--<a href="../Materials/ezViewUploadedFile.jsp?fileName=<%//sinvoicedoc%>"><%//invoicedoc%></a>-->
                <input type='hidden' name='upFile3' value='<%=sinvoicedoc%>'>
		<a href='javascript:funOpenFile(3)'><%=invoicedoc%></a>
		<input type="hidden"  value="" name="serverfile">
		</td>
		</tr>
<%
	}
%>
	</table><br>
<%
	if(bool.equals("false"))
	{
%>
		
		<!-- <br><br>
		<TABLE align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<tr>
			<Th><%=noFilesPres_L%></th>
		</tr>
		</table> -->
		<% String noDataStatement = noFilesPres_L;%>
		<%@ include file="../Misc/ezDisplayNoData.jsp" %>
		
<%
	}
%>


	
	

<div id="ButtonDiv" align="center" style="postion:absolute;top:90%">
<center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Done");
	buttonMethod.add("funDone()");

	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</div>


	<input type="hidden" name="shipupload" value="<%=request.getParameter("filestring")%>" >
	<input type="hidden" name="shipserver" value="<%=request.getParameter("serverfiles")%>" >
</form>
<Div id="MenuSol"></Div>
</body>
</html>
