<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Freight/iProcessFreightFile.jsp" %>


<html>
<head>



	<Script>
			
		var tabHeadWidth="80";
		var tabHeight="55%";
	</script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
	
	
	<Script>
	function selectData()
	{

		var errCount ='<%=errObjCount%>'
		var y=false;

		var chkObj 	= document.myForm.chk1;
		var chkLen	= chkObj.length;
		var chkValue	= "";
		var count	= 0;

		if(!isNaN(chkLen))
		{
			for(i=0;i<chkLen;i++)
			{
				if(chkObj[i].checked)
				{
					count++;				
				}
			}
		}
		else
		{
			if(chkObj.checked)
			{
				count = 1;
			}
		}

		if(count == 0)
		{
			alert("Please select atleast one freight row to save");
			return;
		}


		buttonsSpan	  = document.getElementById("EzButtonsSpan")
		buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan")
		if(buttonsSpan!=null)
		{
		     buttonsSpan.style.display		= "none"
		     buttonsMsgSpan.style.display	= "block"
		}

		if(errCount>0)
		{

		   y=confirm("Some of the errors in the uploaded file.Do you want to continue with remaing data.")
		}
		else 
		   y=true;

		if(eval(y))
		{
			document.myForm.action = "ezSaveFreightData.jsp";
			document.myForm.submit();
		}
	}

	function checkAll()
	{
		var chkObj 	= document.myForm.chk;
		var chkObj1 	= document.myForm.chk1;
		var chkLen	= chkObj1.length;
		var chkValue	= "";
		var count	= 0;

		if(chkObj.checked)
		{
			if(!isNaN(chkLen))
			{
				for(i=0;i<chkLen;i++)
				{
					chkObj1[i].checked = true;
				}
			}
			else
			{
				chkObj1.checked = true;
			}
		}
		else
		{
			if(!isNaN(chkLen))
			{
				for(i=0;i<chkLen;i++)
				{
					chkObj1[i].checked = false;
				}
			}
			else
			{
				chkObj1.checked = false;
			}
		}
	}
	
	function funDownload()
	{
	   document.myForm.action="ezDownLoadExcel.jsp"; 
	   document.myForm.target="_self";
	   document.myForm.submit();   
	}
	
	</Script>
	
</head>

<Body onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
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
			<Th width="15%" align="left">Service Type</Th>
			<Th width="10%" align="left">Zone</th>
			<Th width="15%" align="left">Country Code</th>
			<Th width="10%" align="left">Pack Type</th>
			<Th width="15%" align="left">Weight</th>
			<Th width="20%" align="left">Price</th>
			<Th width="10%" align="left">Key</th>
		</Tr>
		</Table>
		</Div>


		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:80%;height:55%;left:10%">
		<Table width="100%" id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<%
			String sType="",zone="",cCode="",pType="",weight="",price="",tempStr="",key="";
			for (int i=1;i<dataObjCount;i++)
			{
				sType 	   =  dataObj.getFieldValueString(i,"Service Type");
				zone       =  dataObj.getFieldValueString(i,"Zone");
				cCode      =  dataObj.getFieldValueString(i,"Country Code");
				pType  	   =  dataObj.getFieldValueString(i,"Pack Type");
				weight     =  dataObj.getFieldValueString(i,"Weight");
				price  	   =  dataObj.getFieldValueString(i,"Price");
				key	   =  dataObj.getFieldValueString(i,"Key");
				
				price      =  price.replaceAll(",",""); 
				tempStr    =  sType+"¥"+zone+"¥"+cCode+"¥"+pType+"¥"+weight+"¥"+price+"¥"+key;
%>
				
				<Tr>
				<Td width="5%" align="center"><input type="checkbox" name="chk1" value='<%=tempStr%>'></Td>
				<Td width="15%" align="left"><%=sType%></Td> 
				<Td width="10%" align="left"><%=zone%></Td>
				<Td width="15%" align="left"><%=cCode%></Td>
				<Td width="10%" align="left"><%=pType%></Td>
				<Td width="15%" align="right"><%=weight%></Td>
				<Td width="20%" align="right"><%=price%></Td>
				<Td width="10%" align="left"><%=key%></Td>
				</tr>
<%
                       }
%>
				
		</Table>
		</Div>


		<Div id="image" style='Position:Absolute;visibility:visible;Left:10%;WIDTH:80%;height:70%;Top:88%'>

		<span id="EzButtonsSpan">
		<center>
			<img src="../../Images/Buttons/<%=ButtonDir%>/save.gif" border="none" valign=bottom style="cursor:hand" onclick="selectData()"> 
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

