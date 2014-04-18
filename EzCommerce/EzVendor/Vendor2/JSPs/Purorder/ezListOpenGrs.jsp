<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iListOpenGrs_Labels.jsp"%>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ include file="../../../Includes/JSPs/Purorder/iListOpenGRS.jsp"%>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<Script>
var tabHeadWidth=96
var tabHeight="65%"
</Script>

<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<script src="../../Library/JavaScript/ezSortTableData.js"></script>

<script>
	function checkPark(Obj,aa){
		if (Obj.checked){
			if (aa=='X'){
				alert ('<%=grnQltyIns_L%>');
				Obj.checked=false;
			}
		}
	}
	function pageSubmit()
	{
		arr=new Array();
		j=0;
		if (isNaN(document.forms[0].Chk.length)){
			if (document.forms[0].Chk.checked)
				j++
		}
		else{
			for (i=0;i<document.forms[0].Chk.length;i++){
				if (document.forms[0].Chk[i].checked){
					a=document.forms[0].Chk[i].value
					b=a.split("||")
					arr[j]=b[1]
					j++;
				}
			}
			for (i=0;i<arr.length-1;i++){
				for (k=i+1;k<arr.length;k++){
					if (arr[i]!=arr[k]){
						alert('<%=plzSelPo_L%>')
						return false
					}
				}	
			}
		}
		if (j == 0){
			alert('<%=plzSelOneMorGR_L%>')
			return false
		}
		else{
			document.forms[0].action="ezCreateInvoiceForGR.jsp";
			document.forms[0].submit();
		}
	}
	function divAdjust(){
		divObj=document.getElementById("Div4");
		tabObj=document.getElementById("ezTab");	
		if ((divObj!=null)&&(tabObj!=null)){
			if(divObj.offsetHeight > tabObj.offsetHeight)
				divObj.style.width ="96%"
		}
	}

</script>
</head>
<body onLoad="ezInitSorting();scrollInit()" onresize="scrollInit()" scroll=no>

<form name="grForm"  method="post">
	<Table align="center" width="50%">
	<Tr>
	<Td align="center" class="displayheader" ><%=pendingGrs_L%></Td>
	</Tr>
	</Table>
<%
if (retGrs.getRowCount()>0)
{%>	<br>
	<div id="theads">
	<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="96%">
	<Tr>
	<Th width="5%">M</Th>
	<Th width="12%" style="cursor:hand" onClick="ezSortElements(1,'_ALPHANUM')"><%=dcNo_L%></Th>
	<Th width="10%" style="cursor:hand" onClick="ezSortElements(2,'_DATE')"><%=dcDate_L%></Th>
	<Th width="10%" style="cursor:hand"  onClick="ezSortElements(3)"><%=poNo_L%></Th>
	<Th width="12%" style="cursor:hand"  onClick="ezSortElements(4)"><%=grNo_L%></Th>
	<Th width="10%" style="cursor:hand" onClick="ezSortElements(5,'_DATE')"><%=grDate_L%></Th>
	<Th width="28%" style="cursor:hand"  onClick="ezSortElements(6)"><%=matDesc_L%></Th>
	<Th width="13%" style="cursor:hand"  onClick="ezSortElements(7)"><%=qty_L%></Th>
	</Tr>
	</Table>
	</Div>
	<DIV id="InnerBox1Div"  style="overflow:auto;position:absolute;width:96%;height:65%;left:2%">
	<Table align=center id="InnerBox1Tab" border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
	<%
	FormatDate fD=new FormatDate();	
	
	for(int i=0;i<retGrs.getRowCount();i++)
	{
		String DCNo=retGrs.getFieldValueString(i,"REFDOCNO");
		DCNo=((DCNo.trim()).length()==0)?"NA":DCNo;
		String UOM=retGrs.getFieldValueString(i,"UOM");
		UOM=((UOM.trim()).length()==0)?" ":UOM;
		String ITEMNO=retGrs.getFieldValueString(i,"ITEMNO");	
		ITEMNO=((ITEMNO.trim()).length()==0)?" ":ITEMNO;
		String FISCALYEAR=retGrs.getFieldValueString(i,"FISCALYEAR");	
		FISCALYEAR=((FISCALYEAR.trim()).length()==0)?" ":FISCALYEAR;
		String PLANT=retGrs.getFieldValueString(i,"PLANT");	
		PLANT=((PLANT.trim()).length()==0)?" ":PLANT;
		String QUANTITY=retGrs.getFieldValueString(i,"QUANTITY");	
		QUANTITY=((QUANTITY.trim()).length()==0)?" ":QUANTITY;
		String LCAMOUNT=retGrs.getFieldValueString(i,"LCAMOUNT");	
		LCAMOUNT=((LCAMOUNT.trim()).length()==0)?" ":LCAMOUNT;
		String MATDESC=retGrs.getFieldValueString(i,"MATDESC");	
		MATDESC=((MATDESC.trim()).length()==0)?" ":MATDESC;
		String GRITEMNO=retGrs.getFieldValueString(i,"GRITEMNO");	
		GRITEMNO=((GRITEMNO.trim()).length()==0)?" ":GRITEMNO;
		String dcNo = retGrs.getFieldValueString(i,"REFDOCNO");
		String DcDate = fD.getStringFromDate((java.util.Date)retGrs.getFieldValue(i,"DOCDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
		String GrDate = fD.getStringFromDate((java.util.Date)retGrs.getFieldValue(i,"GRDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
	%>
		<Tr>	
		<Td width="5%" align=center><input type="checkbox" name="Chk" onClick="JavaScript:checkPark(this,'<%=retGrs.getFieldValueString(i,"NAME1")%>')" value="<%=retGrs.getFieldValueString(i,"GRNO")%>||<%=Long.parseLong(retGrs.getFieldValueString(i,"PONO"))%>||<%=ITEMNO%>||<%=UOM%>||<%=FISCALYEAR%>||<%=PLANT%>||<%=QUANTITY%>||<%=LCAMOUNT%>||<%=DCNo%>||<%=GRITEMNO%>||<%=MATDESC%>"></Td>
		<Td width="12%" title="<%=dcNo%>"><input type=text class="tx" size=10 readonly value="<%=dcNo%>"></Td>
		<Td width="10%"><%=DcDate%></Td>
		<Td width="10%"><%=Long.parseLong(retGrs.getFieldValueString(i,"PONO"))%></Td>	
		<Td width="12%"><%=retGrs.getFieldValueString(i,"GRNO")%>&nbsp;</Td>
		<Td width="10%"><%=GrDate%></Td>
		<Td width="28%"><%=MATDESC%></Td>
		<Td width="13%" align=right><%=QUANTITY%></Td>	
		</Tr>
		<script>
	  	rowArray=new Array()
		rowArray[0]=""
		rowArray[1]="<%=dcNo%>"
		rowArray[2]="<%=DcDate%>"
		rowArray[3]="<%=Long.parseLong(retGrs.getFieldValueString(i,"PONO"))%>"
		rowArray[4]="<%=retGrs.getFieldValueString(i,"GRNO")%>"
		rowArray[5]="<%=GrDate%>"
		rowArray[6]='<%=MATDESC.replace('\'','`')%>'
		rowArray[7]="<%=QUANTITY%>"
		dataArray[<%=i%>]=rowArray
		</script>
		<%}%>
	</Table>
	</div>


	<div id="head1" style="position:absolute;top:85%;left:10%">
	<Table align="center">
	<Tr><Td class="blankcell">
	<font face="verdana" color=blue><%=plzGrInvPro_L%></font>
	</Td></Tr></Table>
	</div>

	<div id="back" style="position:absolute;top:90%;visibility:visible" align="center">
	<Table align="center" width="100%">
	<Tr align="center">
	<Td class="blankcell">
		<!-- <img src="../../Images/Buttons/<%=ButtonDir%>/process.gif" onMouseover="window.status=' '; return true" alt="Process"  style="cursor:hand" tabIndex="20" border="none" onClick="JavaScript:pageSubmit()"></a> -->
		<center>
		<%
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();
		
				buttonName.add("Process");
				buttonMethod.add("pageSubmit()");
				out.println(getButtonStr(buttonName,buttonMethod));
		%>
		</center>
	</Td>
	</Tr>
	</Table>
	</div>
	<%
	}
else{
%>
	<br><br>
	<Table width=50% align="center" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
	<Tr align="center">
	<Th><%=noPendingGrs_L%></Th>
	</Tr>
	</Table>
<%}
%>	
</form>
<Div id="MenuSol"></Div>
</body>
</html>



