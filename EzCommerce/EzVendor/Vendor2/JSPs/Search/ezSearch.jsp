<%--
***************************************************************
       /* =====================================
        * Copyright Notice 
	* This file contains proprietary information of Answerthink India Ltd.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2005-2006 
	=====================================*/

       /* =====================================
        * Author : Girish Pavan Cherukuri
	* Team : EzcSuite
	* Date : 20-09-2005
	* Copyright (c) 2005-2006 
	=====================================*/
***************************************************************
--%>


<%@ include file="../../Library/Globals/errorPagePath.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iSearch_Labels.jsp"%>

<HTML>
<HEAD>
	<TITLE>Welcome to Search</TITLE>
	<META http-equiv=Content-Type content="text/html; charset=windows-1252">
	<%@include file="../../../Includes/Lib/AddButtonDir.jsp" %>
	<Script>
	
		var plzPoNum_L = '<%=plzPoNum_L%>';
		var plzMatNum_L = '<%=plzMatNum_L%>';
		var plzInvNum_L = '<%=plzInvNum_L%>';
		var plzDcNum_L = '<%=plzDcNum_L%>';
		var plzSchAgrNum_L = '<%=plzSchAgrNum_L%>';
	
	
	</Script>
	
	<Script src="../../Library/JavaScript/Misc/ezSearch.js"></Script>
		
	<Script>
		var tabHeadWidth=90
		var tabHeight="79%"
	</Script>
	<Script src="../../Library/JavaScript/Misc/ezTabScroll.js"></Script>	
	
	<Script LANGUAGE = JAVASCRIPT>
	
	img1 = new Image(); img_new1 = new Image();
	img2 = new Image(); img_new2 = new Image();
	img3 = new Image(); img_new3 = new Image();
	img4 = new Image(); img_new4 = new Image();
	
	img1.src="../../Images/Others/purchaseorder1.gif";
	img2.src="../../Images/Others/invoice1.gif";
	img3.src="../../Images/Others/deliverychallan1.gif";
	img4.src="../../Images/Others/scheduleagreement1.gif";
	
	img_new1.src="../../Images/Others/purchase_order2.gif";
	img_new2.src="../../Images/Others/invoice2.gif";
	img_new3.src="../../Images/Others/deliverychallan2.gif";
	img_new4.src="../../Images/Others/scheduleagreement2.gif";
	
	
	var plzMatDesc_L = '<%=plzMatDesc_L%>';
	function changeNewImage(obj,num)
	{
		obj.src = eval("img_new"+num).src
	}
	function changeImage(obj,num)
	{
		obj.src = eval("img"+num).src
	}
		
	function searchForMaterial()
	{
		document.myForm.searchStr.value = document.myForm.PO.value;
		var matValue = document.myForm.PO.value;
		matValue = matValue.substring(0,matValue.indexOf("*"));

		if(isNaN(matValue))
		{
			searchMatByDesc();					
		}	
		else	
		{
			searchMatByNumber();			
		}
		
	}
	function searchMatByNumber()
	{	
		var plzMatNum_L = '<%=plzMatNum_L%>';
		var matNo		= document.myForm.searchStr.value; 
		var searchFlagObj	= document.myForm.searchFlag
		var searchFlag

		if(searchFlagObj!=null)
			searchFlag = document.myForm.searchFlag.value;
		else
			searchFlag = "Y";
		if(matNo=="")
		{
			alert(plzMatNum_L);
			return;
		}		
		var url="../RFQ/ezListMaterials.jsp?matCode="+matNo+"&searchFlag="+searchFlag;
		newWindow=window.open(url,"ReportWin","width=700,height=500,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
	}
	
	function searchMatByDesc()
	{			
		var matDesc 		= document.myForm.searchStr.value; 
		var searchFlagObj	= document.myForm.searchFlag
		var searchFlag
		
		if(searchFlagObj!=null)
			searchFlag = document.myForm.searchFlag.value;
		else
			searchFlag = "Y";
			
		if(matDesc=="")
		{
			alert(plzMatDesc_L);
			return;
		}
	
		var url="../RFQ/ezSearchMaterial.jsp?matDesc="+matDesc+"&searchFlag="+searchFlag;
		newWindow=window.open(url,"ReportWin","width=700,height=500,left=100,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
	}
	</Script>

<style>
td.pagestyle {
	color: #00355D;
	font-family: verdana, arial;
    	font-size: 10px;
    	background-color: #ffffff
    	
}
A:hover {
	 
	 TEXT-DECORATION: underline; COLOR:red 
}

</style>
</HEAD>


<BODY scroll=no  text=#000000 vLink=#336699 aLink=#6496c8 link=#4276aa bgcolor=#F696CA leftMargin=0 background="" topMargin=0 marginwidth="0" marginheight="0%">
<FORM name=myForm action="" method="POST">
<%
	String 	display_header = srch_L;
	String userType  	= (String)session.getValue("UserType");
	String dispContent = uCanSer_L ;
	
	if("3".equals(userType) ){
		
		dispContent = uCanSer_Vend_L ;
	}
	
	
	
	
	
	
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<BR>


<TABLE style="background:#ffffff" style="BORDER-RIGHT: #4374a6 1px solid; BORDER-TOP: #4374a6 1px solid; BORDER-LEFT: #4374a6 1px solid; BORDER-BOTTOM: #4374a6 1px solid" align=center cellSpacing=0 cellPadding=0 width="80%"  height=80% border=0>
<TR>
	<TD border=2 width="100%" align=center valign=middle style="background:#ffffff">
	
<TABLE style="background:#ffffff" align=center cellSpacing=0 cellPadding=0 width="100%"  height=100% border=0>
<TR>
	<TD class="pagestyle" border=2 width="40%" align=center valign=middle style="background:#ffffff">
		<img src="../../Images/Others/searchmain3.jpg">

	</TD>
	<TD class="pagestyle"  border=2  width="60%" align=left valign=top style="background:#ffffff">
		<TABLE cellSpacing=1 cellPadding=1 width=100% border=0 valign=top>
		<TBODY>
			<TR>
				<TD class="pagestyle" align=right colspan=4 style="background:#ffffff"><img src="../../Images/Others/search1.gif" border=0></TD>
			</TR>
			<TR>
				<TD class="pagestyle" style="background:#ffffff" vAlign=center align=right><A  title="Find a PO Status" href="javaScript:funActivate('PO')" ><font  class=footerlinkcell size=1><b><%=pur_order_L%></font></b><!--<img src="../../Images/Others/purchaseorder1.gif" border=0 onmouseover=changeNewImage(this,1) onmouseout = changeImage(this,1)>--></A>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp</TD>
				<TD class="pagestyle" style="background:#ffffff" vAlign=center align=right><A  title="Find a Invoice" href="javaScript:funActivate('INV')"><font  class=footerlinkcell size=1><b><%=invs_L%></font></b><!--<img src="../../Images/Others/invoice1.gif" border=0 onmouseover=changeNewImage(this,2) onmouseout = changeImage(this,2)>--></A></TD>
				<TD class="pagestyle" style="background:#ffffff" vAlign=center align=right><A  title="Find a DC" href="javaScript:funActivate('DC')"><font  class=footerlinkcell size=1><b><%=del_note_L%></font></b><!--<img src="../../Images/Others/deliverychallan1.gif" border=0 onmouseover=changeNewImage(this,3) onmouseout = changeImage(this,3)>--></A></TD>
				<!--<TD class="pagestyle" vAlign=center align=right><A  title="Find a Schedule Agreement"  href="javaScript:funActivate('SA')"><font  class=footerlinkcell size=1><b>Schedule Agreement</b><img src="../../Images/Others/scheduleagreement1.gif" border=0 onmouseover=changeNewImage(this,4) onmouseout = changeImage(this,4)></A></TD>-->
				<TD class="pagestyle" style="background:#ffffff" vAlign=center align=right>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
				
			</TR>
			<TR>
				<td colspan=4 style="background:#ffffff">
				<DIV  id ="defDIV" style="position:absolute;top:28%;width:100%;visibility:visible">  
					<TABLE class=Tablestyle-Outline2-Alt cellSpacing=0 cellPadding=3 width=95% border=0>
								<TBODY>
									<TR>
										<TD class="pagestyle" style="background:#ffffff">
											<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
												<TBODY>
													<TR>
														<TD class="pagestyle"><SPAN class=Heading-Options><%=dearUsr_L%></SPAN></TD>
													</TR>
													<TR>

														<TD class="pagestyle"><SPAN class=Heading-Options><%=dispContent%></SPAN></TD>
													</TR>

												</TBODY>
											</TABLE>
										</TD>
									 </TR>
							  </TBODY>
					</TABLE>
				</DIV>
				<DIV  id ="PODIV" style="position:absolute;top:26%;width:100%;visibility:hidden">
					<SPAN class=Heading-Options><%=rULkPoStat_L%></SPAN><BR>
					<TABLE class=Tablestyle-Outline2-Alt cellSpacing=0 cellPadding=3 width=80% border=0>
						<TBODY>
							<TR>
								<TD class="pagestyle" style="background:#ffffff">
									<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
										<TBODY>
											<TR>
												<TD class="pagestyle" width=27>&nbsp;</TD>
												<TD class="pagestyle" width=15><SPAN class=Body-Text><INPUT onclick="funClick('PO')" type=radio value=PObyMat name=PObySel></SPAN></TD>
												<TD class="pagestyle"><SPAN class=Body-Text><%=fndPoStatMat_L%></SPAN></TD>
											</TR>
											<TR>
												<TD class="pagestyle" width=27>&nbsp;</TD>
												<TD class="pagestyle"><SPAN class=Body-Text><INPUT onclick="funClick('PO')" type=radio value=PObyNo name=PObySel ></SPAN></TD>
												<TD class="pagestyle"><SPAN class=Body-Text><%=fndPoStatPo_L%></SPAN></TD>
											</TR>
										</TBODY>
									</TABLE>
								</TD>
							 </TR>
						</TBODY>
					</TABLE>	
					<TABLE cellSpacing=0 cellPadding=0 width=100% border=0>
						<TBODY>
							<TR >
								<TD class="pagestyle" style="background:#ffffff"><SPAN class=spacer style="WIDTH:1%;HEIGHT:12%"></SPAN></TD>
							</TR>
							<TR>
								<TD class="pagestyle" style="background:#ffffff">
									<label class=frmlabel id="label1">
										<span id="POLabel1" style="display: inline;"><%=mnoOrDesc_L%></span>
										<span id="POLabel2" style="display: none;"><%=poNumStr_L%></span>
									</label>
								</TD>
							</TR>
							<TR>

								
								<TD class="pagestyle" style="background:#ffffff" width=40%><INPUT onfocus="funFocus('PO')" size=18 name=PO></TD>
								
								<TD class="pagestyle" style="background:#ffffff" width=15% align=left>
								
								<span id="POLabel3" style="display:inline;">
									<img src="../../Images/Others/find.gif" alt ='<%=clkToFnd_L%>' style="cursor:hand" height="18" onClick="javascript:searchForMaterial()"></img>
								</span>	
								
								</TD>
							
								<TD class="pagestyle" width=45% align=left>
									<!--<IMG src="../../Images/Others/search.jpg" onclick="funSubmit('PO')" style="cursor:hand" title="Click here to Search">-->
									<%
										buttonName = new java.util.ArrayList();
										buttonMethod = new java.util.ArrayList();
									
										buttonName.add("Submit");
										buttonMethod.add("funSubmit(\"PO\")");
											
										out.println(getButtonStr(buttonName,buttonMethod));
									%>		

								</TD>
							</TR>
							<TR height=10%>
								<TD class="pagestyle"><SPAN class=spacer style="WIDTH: 1%; HEIGHT:12%"></SPAN></TD>
							</TR>
							<TR>
								<TD class="pagestyle"><SPAN class=Body-Text><%=strReq_L%></SPAN></TD>
							</TR>
						</TBODY>
					</TABLE>
					<input type="hidden" name="POSearch" value="">
					<input type="hidden" name="PurchaseOrder" value="">
					<input type="hidden" name="MaterialNumber" value="">
					<input type="hidden" name="matNo" value="">
					<input type="hidden" name="matDesc" value="">
					<input type="hidden" name="searchFlag" value="N">
					<input type="hidden" name="searchStr" value="">
				</DIV>
				<DIV  id ="INVDIV" style="position:absolute;top:27%;width:100%;visibility:hidden">
						<SPAN class=Heading-Options><%=areLokInvst_L%></SPAN>
				<TABLE class=Tablestyle-Outline2-Alt cellSpacing=0 cellPadding=3 width=300 border=0>
					<TBODY>
						<TR>
							<TD class="pagestyle">
								<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
									<TBODY>
										<TR>
											<TD class="pagestyle" width=27>&nbsp;</TD>
											<TD class="pagestyle" width=15><SPAN class=Body-Text><INPUT onclick="funClick('INV')" type=radio value="INVbyNO" name=INVbySel ></SPAN></TD>
											<TD class="pagestyle"><SPAN class=Body-Text><%=fndInvStatInvno_L%></SPAN></TD>
										</TR>
										<TR>
											<TD class="pagestyle" width=27>&nbsp;</TD>
											<TD class="pagestyle"><SPAN class=Body-Text><INPUT onclick="funClick('INV')" type=radio value="INVbyPO" name=INVbySel ></SPAN></TD>
											<TD class="pagestyle"><SPAN class=Body-Text><%=fndInvStatPonum_L%></SPAN></TD>
										</TR>
									</TBODY>
								</TABLE>
							</TD>
						 </TR>
					</TBODY>
					<TABLE cellSpacing=0 cellPadding=0 width=234 border=0>
						<TBODY>
							<TR height=8>
								<TD class="pagestyle"><SPAN class=spacer style="WIDTH: 1px; HEIGHT: 8px"></SPAN></TD>
							</TR>
							<TR>
								<TD class="pagestyle">
									<label class=frmlabel id="label1">
										<span id="INVLabel1" style="display: inline;"><%=vanInvNo_L%>*</span>
										<span id="INVLabel2" style="display: none;"><%=poNum_L%>*</span>
									</label>
								</TD>
						   </TR>
							<TR>
								<TD class="pagestyle"><INPUT onfocus="funFocus('INV')" size=15 name=INV ></TD>
								<TD class="pagestyle" align=right>
								<!--<IMG src="../../Images/Others/search.jpg" onclick="funSubmit('INV')" style="cursor:hand" title="Click here to Search">-->
								<%
									buttonName = new java.util.ArrayList();
									buttonMethod = new java.util.ArrayList();

									buttonName.add("Submit");
									buttonMethod.add("funSubmit(\"INV\")");

									out.println(getButtonStr(buttonName,buttonMethod));
								%>
								</TD>
							</TR>
							<TR height=8>
								<TD class="pagestyle"><SPAN class=spacer style="WIDTH: 1px; HEIGHT: 8px"></SPAN></TD>
							</TR>

							<TR>
								<TD class="pagestyle"><SPAN class=Body-Text><%=strReq_L%></SPAN></TD>
							</TR>
						</TBODY>
					  </TABLE>
					</DIV>				

					<DIV  id ="DCDIV" style="position:absolute;top:27%;width:100%;visibility:hidden">
								<SPAN class=Heading-Options><%=ruLkDnStat_L%></SPAN>
								<BR><BR>
								<TABLE class=Tablestyle-Outline2-Alt cellSpacing=0 cellPadding=3 width=300 border=0>
									<TBODY>
										<TR>
											<TD class="pagestyle">
												<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
													<TBODY>
														<TR>
															<!--<TD class="pagestyle" width=27>&nbsp;</TD>
															<TD class="pagestyle" width=15><SPAN class=Body-Text><INPUT onclick="funClick('DC')" type=radio value="DCforPO" name=DCbySel  ></SPAN></TD>-->
															<TD class="pagestyle"><SPAN class=Body-Text><%=fndDcStatPo_L%></SPAN></TD>
														</TR>
														<!---
														<TR>
															<TD class="pagestyle" width=27>&nbsp;</TD>
															<TD class="pagestyle"><SPAN class=Body-Text><INPUT onclick="funClick('DC')" type=radio value="DCforSA" name=DCbySel></SPAN></TD>
															<TD class="pagestyle"><SPAN class=Body-Text><%=fndDcStatSchAgr_L%></SPAN></TD>
														</TR>
														--->
													</TBODY>
												</TABLE>
											</TD>
										 </TR>
									</TBODY>
									<TABLE cellSpacing=0 cellPadding=0 width=234 border=0>
										<TBODY>
											<TR height=8>
												<TD class="pagestyle"><SPAN class=spacer style="WIDTH: 1px; HEIGHT: 8px"></SPAN></TD>
											</TR>
											<TR>
												<TD class="pagestyle">
													<label class=frmlabel id="label1">
														<span id="DCLabel1" style="display: inline;"><%=dcNumber_L%>*</span>
														<span id="DCLabel2" style="display: none;"><%=dcNumber_L%>*</span>
													</label>
												</TD>
											</TR>
											<TR>
												<TD class="pagestyle"><INPUT onfocus="funFocus('DC')" size=15 name=DC></TD>
												<TD class="pagestyle" align=right>
												<!--<IMG src="../../Images/Others/search.jpg" onclick="funSubmit('DC')" style="cursor:hand" title="Click here to Search" >-->
												<%
													buttonName = new java.util.ArrayList();
													buttonMethod = new java.util.ArrayList();

													buttonName.add("Submit");
													buttonMethod.add("funSubmit(\"DC\")");

													out.println(getButtonStr(buttonName,buttonMethod));
												%>
												</TD>
											</TR>
											<TR height=8>     
												<TD class="pagestyle"><SPAN class=spacer style="WIDTH: 1px; HEIGHT: 8px"></SPAN></TD>

											</TR>
											<TR>
												<TD class="pagestyle"><SPAN class=Body-Text><%=strReq_L%></SPAN></TD>
											</TR>
										</TBODY>
									  </TABLE>
						</DIV>
						
						<DIV  id ="SADIV" style="position:absolute;top:28%;width:100%;visibility:hidden">
							<SPAN class=Heading-Options>Are you looking for Schedule Agreement?</SPAN>
							<BR><input type="hidden" name="SAbySel" value="">
							<TABLE cellSpacing=0 cellPadding=0 width=234 border=0>
								<TBODY>
									<TR height=8>
										<TD class="pagestyle"><SPAN class=spacer style="WIDTH: 1px; HEIGHT: 8px"></SPAN></TD>
									</TR>
									<TR>
											<TD class="pagestyle">
												<label class=frmlabel id="label1">
													<span id="DCLabel1" style="display: inline;">Schedule Agreement No*</span>
												</label>
											</TD>
									</TR>
									<TR>
										<TD class="pagestyle"><INPUT onfocus="funFocus('SA')" size=15 name=SA></TD>
										<TD class="pagestyle" align=right>
											<!--<IMG src="../../Images/Others/search.jpg" onclick="funSubmit('SA')" style="cursor:hand" title="Click here to Search" >-->
											<%
												buttonName = new java.util.ArrayList();
												buttonMethod = new java.util.ArrayList();

												buttonName.add("Submit");
												buttonMethod.add("funSubmit(\"SA\")");

												out.println(getButtonStr(buttonName,buttonMethod));
											%>
										</TD>
									</TR>
									<TR height=8>
										<TD class="pagestyle"><SPAN class=spacer style="WIDTH: 1px; HEIGHT: 8px"></SPAN></TD>
									</TR>
									<TR>
											<TD class="pagestyle"><SPAN class=Body-Text>*Required</SPAN></TD>
									</TR>
								</TBODY>
							  </TABLE>
						<input type="hidden" name="SchSearch" value="yes">
						<input type="hidden" name="contractNum" value="" >
						</DIV>
						<input type="hidden" name="searchField" >
						<input type="hidden" name="base" >
						<input type="hidden" name="InvStat">
						<input type="hidden" name="SearchFlag">
						<input type="hidden" name="DCNO" value="">

									</td>
			</TR>
		</TBODY>
		</TABLE>
	</TD>
</TR>
</TBODY>
</TABLE>
</TD>
</TR>

</TABLE>



</FORM>
<Div id="MenuSol"></Div>
</BODY>
</HTML>
