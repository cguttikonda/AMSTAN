


<%@ include file="iURLs.jsp"%>

<Html>
<Head>
<Title>Materials List...</Title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>

	   var tabHeadWidth=95
 	   var tabHeight="45%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<Script>
function gotoURL(url,fname)
{
	var url_array=url.split("&");
	var newurl='';
	for (var i=0;i<url_array.length;i++)
	{
		newurl +=url_array[i]+'¥'
	}
 	newurl = newurl.substring(0,newurl.length-1);
 	document.myForm.action="ezContentServerDoc.jsp?URL="+newurl+"&fname="+fname	
	//document.myForm.action="ezContentServer.jsp?URL="+newurl
	document.myForm.submit();
	
}
</Script>
<Head>
<Body onLoad="scrollInit(10);" scroll=no onresize="scrollInit()">
<Form method="post"  name="myForm">
<br><br>
<Table  width="95%" align=center id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th width="20%" >Material</th>
		<Td width="20%" ><%=objectKey%></td>
		<Th width="20%" >Description</th>
		<Td width="40%" ><%=objectDesc%></td>
		
	</Tr>	
</Table>

<%

	if(retURlObjCount>0)
	{

	//All display columns setting here
	java.util.Hashtable myValues	= new java.util.Hashtable();
	java.util.ArrayList dispColumns	= new ArrayList();
	java.util.ArrayList dispSizes  	= new java.util.ArrayList();
	java.util.ArrayList dispAlign  	= new java.util.ArrayList();
	
	//dispColumns.add("DOC_NR");		dispSizes.add("'10%'");		dispAlign.add("Left");	
	//dispColumns.add("DOC_TYPE");		dispSizes.add("'10%'");		dispAlign.add("Left");	
	//dispColumns.add("ORIGFILENAME");	dispSizes.add("'10%'");		dispAlign.add("Left");	
	dispColumns.add("CONTSERVURL");	dispSizes.add("'100%'");		dispAlign.add("left");	
	
	
%>
	<Div id="theads">
		<Table  width="95%" align=center id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th width="100%" >Images and Literature</th>
		</Tr>	
		</Table>
	</Div>
	
	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:95%;height:45%;left:8%">
	<Table align=center id="InnerBox1Tab"  border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">

<%
		String doc_nr_Temp="",doc_type_Temp="",origfilename_Temp="",contservurl_Temp="";
		boolean imgFlag=false;
		
		for (int i=0;i<retURlObjCount;i++)
		{
		imgFlag=false;
		doc_nr_Temp  	= retURlObj.getFieldValueString(i,"DOC_NR");
		doc_type_Temp  	= retURlObj.getFieldValueString(i,"DOC_TYPE");
		origfilename_Temp  	= retURlObj.getFieldValueString(i,"ORIGFILENAME");
		contservurl_Temp  	= retURlObj.getFieldValueString(i,"CONTSERVURL");
		contservurl_Temp=contservurl_Temp.replace('%','®');
		//origfilename_Temp="11000004.jpg";
		//contservurl_Temp="http://65.112.215.108/Sign/11000004.jpg";
		
		myValues.put("DOC_NR",doc_nr_Temp);
		myValues.put("DOC_TYPE",doc_type_Temp);
		myValues.put("ORIGFILENAME",origfilename_Temp);
		String tempfilename_Temp=origfilename_Temp.toUpperCase();
		if(tempfilename_Temp.lastIndexOf(".")!=-1)
		tempfilename_Temp=objectKey+tempfilename_Temp.substring(tempfilename_Temp.lastIndexOf("."),tempfilename_Temp.length());
		
		
		if(tempfilename_Temp.endsWith(".gif")||tempfilename_Temp.endsWith(".jpg")){
			imgFlag=true;
			myValues.put("CONTSERVURL","<img src='"+ contservurl_Temp +"'  border=2 usemap='#"+origfilename_Temp+"'>");
			//myValues.put("CONTSERVURL","<img  src='"+contservurl_Temp+"' >");
		}else{
			//myValues.put("CONTSERVURL","<a href="+contservurl_Temp+" target='new'>"+origfilename_Temp+"</a>");
			myValues.put("CONTSERVURL","<a style='text-decoration:none' href=\"Javascript:gotoURL('"+contservurl_Temp+"','"+origfilename_Temp+"')\" ><b>"+tempfilename_Temp+"</a>");
		}	
%>			
		<Tr>
<%
			for(int k=0;k<dispColumns.size();k++)
			{
				out.println("<Td width=" + dispSizes.get(k) + " align=" + dispAlign.get(k) + ">");
				if(imgFlag&&k==(dispColumns.size()-1)){
					try{
						session.putValue("ImgURL",contservurl_Temp);
									
%>
						<img align="center" src="ezGetImage.jsp" alt="<%=origfilename_Temp%>" width=100 height=100 border=1 usemap="#<%=origfilename_Temp%>"/>
<%
						
					}catch(Exception ioe){}
				}else{
					out.println(myValues.get(dispColumns.get(k)));
				}	
				out.println("&nbsp;</Td>");
			}
%>
		</Tr>
<%
		}
%>
		</Table>
	</Div>	
	
	<Div id="buttonDiv" style="position:absolute;top:90%;width:100%" align="center">
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Close");
		buttonMethod.add("JavaScript:window.close()");
		out.println(getButtonStr(buttonName,buttonMethod));
%>	
			
	</Div>
	
<%
	}else
	{
%>
		<Br><Br><Br><Br>
		<Table align=center><Tr>
			<Td class=displayalert>
				No document URLs for this material
			</Td></Tr>
		</Table>
		<Div id="buttonDiv" style="position:absolute;top:90%;width:100%" align="center">
<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			buttonName.add("Close");
			buttonMethod.add("JavaScript:window.close()");
			out.println(getButtonStr(buttonName,buttonMethod));
%>	
		</Div>
<%
	}
%>	
</Form>
</Body>
</Html>

