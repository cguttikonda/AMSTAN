<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@page import="java.util.*"%>
<%@ include file="../../../Includes/JSPs/Misc/iblockcontrol.jsp" %>
<%@ include file="../../../Includes/JSPs/Rfq/ilistPRT.jsp" %>
<%
String divHgt = "70";
String PRno=request.getParameter("PRnum");
%>
<html>


<body  scroll=no>
<form name="myForm" method="post">
<input type=hidden name="purchaseHidden">
<input type ="hidden" name="reasons" value =""> 

<%  
	if(myRetCount==0)
	{
%>
	<br><br><br><br><br>
	<Table width=50% align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
		<Tr>
			<Th>No Purchase Requisitions exist to List</th>
		</Tr>
	</Table>
	
	<Div id="back" align=center style="position:absolute;top:91%;visibility:visible;width:100%">


</Div>
<%
	}
	else
	{
%>
<br>
<Div id="theads">
<Table id="tabHead" width="90%" align=center  border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
     
      
</Table>  
</Div>

<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:90%;left:2%">
<Table  id="InnerBox1Tab" width="100%" align=center  border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
<%
	boolean showStr = false;
	ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();
	String  reqno="",item="",material="",myMatDesc="";
	
	
	for(int i=0;i<myRetCount;i++)
	{
		
		try
		{
			reqno=""+Long.parseLong(myRet.getFieldValueString(i,"REQNO"));
		}
		catch(Exception e)
		{
			reqno=myRet.getFieldValueString(i,"REQNO");
		}
		try
		{
			item=""+Long.parseLong(myRet.getFieldValueString(i,"ITEM"));
		}
		catch(Exception e)
		{	
			item=myRet.getFieldValueString(i,"ITEM");
		}
		try
		{
			material=""+Long.parseLong(myRet.getFieldValueString(i,"MATERIAL"));
		}
		catch(Exception e)
		{
			material=myRet.getFieldValueString(i,"MATERIAL");
		}
		if(PRno.equals(reqno))
		{
		
		
%>
		<form name="myForm">
		      <div class="row">
		          <div class="span12"><h2>Answerthink</h2></div>
		      </div>
		<div class="container-fluid">
		<div class="row">
		    <div class="span12"><h4> Purchase Requisition Details:<%=PRno%></h4></div>
		</div>
		<form class="form-inline">
		    <div class="row-fluid">
		          <div class="span4 offset4 panel">
		                
		                        <table class="table table-striped table-bordered">
		                              <tbody>
		                               
		                                <tr>
		                                  <th>Material</th>
		                                  <td><input  name="Material" type="text" value="<%=material%>" ></td>
		                                </tr>
		                                <tr>
		                                  <th>Short Text</th>
		                                  <td><input type="text" id="shortText" name="shortText" value="<%=myRet.getFieldValueString(i,"DESCRIPTION")%>" ></td>
		                                </tr>
		                                    <tr>
		                                  <th>Delivery Date</th>
		                                  <td><input type="text" name="deliveryDate" value=<%=fd.getStringFromDate((Date)myRet.getFieldValue(i,"DELIV_DATE"),".",ezc.ezutil.FormatDate.DDMMYYYY)%> ></td>
		                                </tr>
		                                <tr>
		                                  <th>Quantity</th>
		                                  <td><input type="text" name="Quantity" value=<%=myRet.getFieldValueString(i,"QUANTITY")%> ></td>
		                                </tr>
		                                <tr>
		                                  <th>UOM</th>
		                                  <td><input type="text" name="UOM" value=<%=myRet.getFieldValueString(i,"UNIT")%> ></td>
		                                </tr>
		                                <tr>
		                                  <th>Val Price</th>
		                                  <td><input type="text" name="valPrice" placeholder="Val Price"></td>
		                                </tr>
		                              </tbody>
		                        </table>
		                        
		                </form>
		          </div>
		    </div>
		
		    
    </form>
<%
		}
	}
	
%>
</Table>
</Div>
<Div id="back" align=center style="position:absolute;top:91%;visibility:visible;width:100%">

		<span id="EzButtonsSpan" >
			


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
%>
	
<input type=hidden name="backChk" value="PRS">	


<input type="hidden" name="Status" value="<%=Status%>">
<input type="hidden" name="matNo" value="<%=matNo%>">
<input type="hidden" name="selplant" value="<%=plant%>">
<input type="hidden" name="fromDate" value="<%=fromDate%>">
<input type="hidden" name="toDate" value="<%=toDate%>">

</Form>
<Div id="MenuSol"></Div>
</body>
</html>
