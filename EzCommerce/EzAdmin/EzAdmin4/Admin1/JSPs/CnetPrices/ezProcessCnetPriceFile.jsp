<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/CnetPrices/iProcessCnetPriceFile.jsp" %>


<html>
<head>



	<Script>
			
		var tabHeadWidth="80";
		var tabHeight="55%";
	</script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
	
	<Script src="../../Library/JavaScript/Catalog/ezProcessCnetPriceFile.js"></Script>
	<Script>
	
	function funDownload()
	{
	   document.myForm.action="../Catalog/ezDownLoadExcel.jsp";
	   document.myForm.target="_self";
	   document.myForm.submit();   
	}
	
	</Script>
	
</head>

<Body scroll=no>
<Form name="myForm" method="post"> 
<Div id="MenuSol_R"></Div> 
<br>
<%
	session.setMaxInactiveInterval(-1);
	if(flag && dataObjCount>1)  
	{
	       
%>

		<Br>
		
		
		<Div id="theads" >
		<Table width="80%" id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>

			<Th width="5%" align="center"><input type="checkbox" name="chk" value='All' onClick="checkAll()"></th>
			<Th width="20%" align="left">CNET ID</Th>
			<Th width="45%" align="left">CNET MFR Name</th>
			<Th width="20%" align="left">CNET MFR PN</th>
			<Th width="10%" align="left">MSRP</th>
		</Tr>
		</Table>
		</Div>


		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:80%;height:55%;left:10%">
		<Table width="100%" id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<%
			String id="",mfrName="",mfrPn="",price="",tempStr="";
			for (int i=1;i<dataObjCount;i++)
			{
				id 	   =  dataObj.getFieldValueString(i,"CNET ID");
				mfrName    =  dataObj.getFieldValueString(i,"CNET MFR Name");
				mfrPn      =  dataObj.getFieldValueString(i,"CNET MFR PN");
				price  	   =  dataObj.getFieldValueString(i,"MSRP");
				price      =  price.replaceAll(",",""); 
				tempStr    =  id+"¥"+mfrName+"¥"+mfrPn+"¥"+price;
%>
				
				<Tr>
				<Td width="5%" align="center"><input type="checkbox" name="chk1" value='<%=tempStr%>'></Td>
				<Td width="20%" align="left"><%=id%></Td> 
				<Td width="45%" align="left"><%=mfrName%></Td>
				<Td width="20%" align="left"><%=mfrPn%></Td>
				<Td width="10%" align="right"><%=price%></Td>
				</tr>
<%
                       }
%>
				
		</Table>
		</Div>


		<Div id="image" style='Position:Absolute;visibility:visible;Left:10%;WIDTH:80%;height:70%;Top:88%'>

		<span id="EzButtonsSpan">
		<center>
			<img src="../../Images/Buttons/<%=ButtonDir%>/save.gif" border="none" valign=bottom style="cursor:hand" onclick="selectMat()"> 
			<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border="none" valign=bottom style="cursor:hand" onClick="javascript:history.go(-1)"> 
		</center>
		</span>
		<span id="EzButtonsMsgSpan" style="display:none">
			<Table align=center>
				<Tr>
					<Td class="labelcell">Your request is being processed... Please wait</Td>
				</Tr>
			</Table>
		</span>
		</Div>

		
<%
	}
	else 
	{
%>
		<Div align="center" style="overflow:auto;position:absolute;width:80%;left:8%;Top:40%">
			<Table  id="InnerBox1Tab" width="50%" align=center  border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
			<Tr>
<%
			if(!flag)          
			{
%>
				<Th>Please upload valid file(size should be less than 3MB)</Th>	
<%
			}
%>

<%
			if(dataObjCount<2 && flag)
			{
%>
				<Th>No Data Found In Excel</Th>	
<%
			}
%>

			</Tr>
			</Table>
		</Div>
		
		<Div id="image" style='Position:Absolute;visibility:visible;Left:10%;WIDTH:80%;height:70%;Top:80%'>
		<center>
			<img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" border="none" valign=bottom style="cursor:hand" onClick="javascript:history.go(-1)"> 
		</center>
		</Div>
<%
	}

         if(errObjCount>0 && flag)
         {
%>

		<div style="position:absolute;top:92%;left:5%;visibility:visible">
			<Table>
			<Tr>
				<Td><a href="JavaScript:funDownload()"><b>Down load error data</b></a></Td>
			</Tr>
			</Table>
		</div>
<%
        }
%>

<Div id="MenuSol"></Div> 
</form>
</body>
</html>

