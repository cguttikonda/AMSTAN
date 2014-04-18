<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ page import = "ezc.ezparam.*,ezc.ezpreprocurement.params.*,ezc.ezbasicutil.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="PreProManager" class="ezc.ezpreprocurement.client.EzPreProcurementManager" scope="session" />
<%
      int lastPODtlCount=0;
      String myMatNo=request.getParameter("matNumber");
      myMatNo="000000000000000000"+myMatNo;
      EzcParams ezContainer	= new EzcParams(false);
      EziPOItemTable rfqItemTab = new EziPOItemTable();
      EziPOItemTableRow rfqItemTabRow = new EziPOItemTableRow();
      rfqItemTabRow.setMaterial(myMatNo.substring(myMatNo.length()-18,myMatNo.length()));
      rfqItemTab.appendRow(rfqItemTabRow);
      ezContainer.setObject(rfqItemTab);
      Session.prepareParams(ezContainer);
      ReturnObjFromRetrieve lastPODtl = (ReturnObjFromRetrieve)PreProManager.ezGetLastPODetails(ezContainer);
      if(lastPODtl!=null){
          lastPODtlCount=lastPODtl.getRowCount();
      }   
      
      if(lastPODtlCount>0){
        //lastPODtl.sort(new String[]{"NET_PRICE"},true);
      }
      
      String display_header = "Pricing Analysis for Last PO";
%>
<Html>
<Head>
<Title>Last PO Details</Title>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<Script>
	var tabHeadWidth=98
	var tabHeight="60%"

</Script>	

<Script src="../../Library/JavaScript/ezTabScroll.js"></Script></Head>
<Body onLoad="scrollInit(10)" onResize="scrollInit(10)">
<Form name=myForm>
<%
    if(lastPODtlCount>0){
%>
       <br>
        <Table id="header" align=center width="80%" border=0 borderColorDark=#ffffff borderColorLight=#000000  cellspacing="0" cellpadding="2">
        <Tr>
        <Th><%=display_header%></Th>
        </Tr>
        </Table>
        <br>
        <Div id="theads">
        <Table  id="tabHead" width="98%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
        <Tr align="center" valign="middle">
        <Th width="10%">Doc No</Th>
        <Th width="10%">Doc Date</Th>
        <Th width="20%">Vendor</Th>
        <Th width="6%">Item</Th>
        <Th width="10%">Material</Th>
        <Th width="8%">Qty</Th>
        <Th width="6%">OUnit</Th>
        <Th width="8%">Price</Th>
        <Th width="6%">Curr</Th>
        <Th width="4%">Per</Th>
        <Th width="6%">PUnit</Th> 
        <Th width="6%">Plant</Th>
       
        
        </Tr>
        </Table>
        </Div>
        <Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:80%;left:2%">
        <Table id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
<%
          String matNoStr="";
          String lineNo="";
          ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();
          for(int i=0;i<lastPODtlCount;i++){
              try{
                  matNoStr=String.valueOf(Long.parseLong(myMatNo));
                  
              }catch(Exception err){matNoStr=myMatNo;}
              try{
                  lineNo=String.valueOf(Long.parseLong(lastPODtl.getFieldValueString(i,"DOC_LINE")));
              }catch(Exception err){lineNo=lastPODtl.getFieldValueString(i,"DOC_LINE");}
              
%>
              <Tr align="center">
              <Td width="10%" align="center"><%=lastPODtl.getFieldValueString(i,"DOC_NO")%></Td>
              <Td width="10%" align="center"><%=formatDate.getStringFromDate((java.util.Date)lastPODtl.getFieldValue(i,"DOC_DATE"),"/",ezc.ezutil.FormatDate.MMDDYYYY)%></Td>
              <Td width="20%" align="left"><%=lastPODtl.getFieldValueString(i,"VENDOR_NAME")%></Td>
              <Td width="6%" align="center"><%=lineNo%></Td>
              <Td width="10%" align="center"><%=matNoStr%>&nbsp;</Td>
              <Td width="8%" align="center"><%=lastPODtl.getFieldValueString(i,"ORD_QTY")%></Td>
              <Td width="6%" align="center"><%=lastPODtl.getFieldValueString(i,"ORD_UNIT")%></Td>
              <Td width="8%" align="right"><%=lastPODtl.getFieldValueString(i,"NET_PRICE")%></Td>
              <Td width="6%" align="center"><%=lastPODtl.getFieldValueString(i,"CURRENCY")%></Td>
              <Td width="4%" align="center"><%=lastPODtl.getFieldValueString(i,"ORD_PER")%></Td>
              <Td width="6%" align="center"><%=lastPODtl.getFieldValueString(i,"ORD_PRICE_UNIT")%></Td>
              <Td width="6%" align="center"><%=lastPODtl.getFieldValueString(i,"PLANT")%></Td>
              
              </Tr>
<%
          }
%>
        </Table>
        </Div>
<Div align=center style="position:absolute;top:90%;visibility:visible;width:100%">

<%
    	butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Close&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
      butActions.add("window.close()");
    	out.println(getButtons(butNames,butActions));
%>
          <!--<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="10%">
          <Tr>
            <Td class='blankcell'><img src="../../Images/Buttons/<%=ButtonDir%>/close.gif"  onClick="JavaScript:window.close()" border="none" valign=bottom style="cursor:hand"></Td>
          </Tr>
          </Table>
          -->
        </Div>
        
<%
    }else{
%>
            <Div align=center style="position:absolute;top:30%;visibility:visible;width:100%">
              <Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="50%">
              <Tr>
                <Th>No Documents Exist</Th>
              </Tr>
              </Table>
            </Div>
            <Div align=center style="position:absolute;top:90%;visibility:visible;width:100%">
<%
    	butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Close&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
      butActions.add("window.close()");
    	out.println(getButtons(butNames,butActions));
%>
               
              <!--<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="10%">
              <Tr>
                <Td class='blankcell'><img src="../../Images/Buttons/<%=ButtonDir%>/close.gif"  onClick="JavaScript:window.close()" border="none" valign=bottom style="cursor:hand"></Td>
              </Tr>
              </Table>
              -->
            </Div>
<%
    }
%>
</Form>
</Body>
</Html>
