<%@include file="../../Library/Globals/errorPagePath.jsp"%>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<%@page import="ezc.ezparam.*,ezc.ezpreprocurement.client.*,ezc.ezpreprocurement.params.*"%>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<%
	int retObjCount = 0;
	
	EzcParams ezcParams = null;
	ReturnObjFromRetrieve retObj = null;		
	EzPreProcurementManager procurementManager = new EzPreProcurementManager();
	EziReportParams reportParams = new EziReportParams();	

	reportParams.setCallPattern("LIST");
	reportParams.setReportType("MATERIALS");
	
	ezcParams = new EzcParams(false);
	ezcParams.setLocalStore("Y");

	ezcParams.setObject(reportParams);
	Session.prepareParams(ezcParams);		
	retObj = (ReturnObjFromRetrieve)procurementManager.getReportData(ezcParams);
	retObjCount = retObj.getRowCount();
	
%>



<head>
    <script>
    	 function validate()
         {         	
    		var flag = true
    		if (document.MyForm.mat.selectedIndex == 0)
		{
			alert('Please Select Material')         		
			flag = false
			document.MyForm.mat.focus()
             	}
    		if(flag)
           	{
           		matno = document.MyForm.mat[document.MyForm.mat.selectedIndex].value
           		obj = window.open('ezMPAChart.jsp?mat='+matno,'MPA','resizable=no,left=100,top=100,height=500,width=795,status=no,toolbar=no,menubar=no,location=no , scrollbars = yes');       			       			       			
           	}	
           			
           		
         }
         
         
    </script>
</head>

<html>

<html>

<body bgcolor='#FFFFFF'  onResize="scrollInit('SHOWTOT')"   scroll=no>
<form method="post" name="MyForm" >

	<input type=hidden name=status value='VQW'>
<%
	String display_header = "Material Price Analysis";
%>	

	<%@ include file="../Misc/ezDisplayHeader.jsp"%>	

	<Div id="ezdiv" style="position:absolute;width:100%">
		   <Table  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
		   <Tr>	
      			<Th>Select Material</Th>
      			<Td>
      			<div id="ListBoxDiv2">
				<select name='mat'>
					<option value=''>--Select Material--</option>
<%
					for(int i=0;i<retObjCount;++i)
					{
						String matNo=retObj.getFieldValueString(i,"ERD_MATERIAL");
						String matDesc = retObj.getFieldValueString(i,"ERD_MATERIAL_DESC");
						
						
%>
							<option value='<%=matNo%>'><%=matDesc%></option>
							
<%
					}
%>
					
				</select>
			</div>
     			 </Td>		
			<Td>
        			<img src="../../Images/Buttons/ENGLISH/GREEN/Go.gif" style="cursor:hand" onClick="validate()" border="none">
      			</Td>
		    </Tr>
		   </Table> 
	</Div>

</form>
<Div id="MenuSol"></Div>
</body> 
</html>