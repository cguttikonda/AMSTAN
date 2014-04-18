<%@ page import="javax.xml.parsers.*,
		 org.w3c.dom.*,
		 javax.xml.transform.*,
		 javax.xml.transform.dom.DOMSource,
		 java.io.FileOutputStream,
		 javax.xml.transform.stream.StreamResult"
%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%
	String flag = request.getParameter("flag");
	String type = request.getParameter("type").trim();
	String chooseFile = "";
	
	if("V"==type || "V".equals(type))
	{
				
		chooseFile = "default-web-app/EzCommerce/EzVendor/EzRanbaxyVendor/Vendor2/JSPs/Misc/ezVendorMenu.xml";
	}
	else if("PP"==type || "PP".equals(type))
	{
		chooseFile = "default-web-app/EzCommerce/EzVendor/EzRanbaxyVendor/Vendor2/JSPs/Misc/ezVendorPPMenu.xml";
	}
	else if("DM"==type || "DM".equals(type))
	{
		chooseFile = "default-web-app/EzCommerce/EzVendor/EzRanbaxyVendor/Vendor2/JSPs/Misc/ezVendIntMenu.xml";
	}
%>
<Html>
<Head>

<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
<Script language="JavaScript">
	var flag = "<%=flag%>";
	
function chk()
{
	var aDom	= new ActiveXObject("MSXML.DOMDocument");
	aDom.async	= false;
	var filePath	= "";
	
	if("V"=='<%=type%>')
		filePath	= "../../../../../EzVendor/EzRanbaxyVendor/Vendor2/JSPs/Misc/ezVendorMenu.xml";
	else if("PP"=='<%=type%>')
		filePath	= "../../../../../EzVendor/EzRanbaxyVendor/Vendor2/JSPs/Misc/ezVendorPPMenu.xml";
	else if("DM"=='<%=type%>')
		filePath	= "../../../../../EzVendor/EzRanbaxyVendor/Vendor2/JSPs/Misc/ezVendIntMenu.xml";
	
	aDom.load(filePath);
	var h		= aDom.documentElement;

	if(document.myForm.rdo!=null)
	{
		for(var i=0;i<document.myForm.rdo.length;i++) //document.myForm.rdo.length
		{
			var str		= document.myForm.rdo[i].value;
			var str1	= str.split('#');
			var id		= str1[0];
			var childs	= str1[2];
			
			var nodeName	= str1[1];
			var nodeNameArray= nodeName.split('$');

		
			if(nodeNameArray!=null)
				nodeName			= nodeNameArray[0];
				
			var currentArray	= h.getElementsByTagName(nodeName);
			var currenArr;
			for(var k=0; k<currentArray.length; k++)
			{
				currenArr	= currentArray.item(k);
				
				if(currenArr.getAttribute("status")=='Y' && currenArr.getAttribute("id")==id)
				{
					document.myForm.rdo[i].checked=true;
				}
				else if(currenArr.getAttribute("status")=='N' && currenArr.getAttribute("id")==id)
				{
					for(var j=0;j<childs;j++)
					{
						document.myForm.rdo[i].checked=false;
						i++;
					}
				}
			}
		}
	}
	if(flag =="true")
		alert("Updated Successfully");
}
function update()
{
	if(document.myForm.rdo!=null)
	{
		var str1="";
		for(var i=0;i<document.myForm.rdo.length;i++) //document.myForm.rdo.length
		{
			if(!document.myForm.rdo[i].checked)
			{
				var str	= document.myForm.rdo[i].value;
				str1	= str1+str+"*";
			}
		}
	}
	document.myForm.updtvls.value	= str1;
	document.myForm.action		= "ezChangeOptions.jsp";
	document.myForm.submit();
}
function chkChilds(obj)
{

	var str 	= obj.value;
	var str1	= str.split('#');

	if(str1[2]!=null)
	{
		var index	= str1[3]
		for(var i=1;i<=str1[2];i++)
		{
			var index1	= parseInt(index)+parseInt(i);
			if(document.myForm.rdo[index].checked==false)
			{
				document.myForm.rdo[index1].checked=false;
			}
			else
			{
				document.myForm.rdo[index1].checked=true;
			}
		}
	}
	else
	{
		var parentIndexArray	= str1[1].split('$');

		if(parentIndexArray!=null)
		{
			parentIndex	=parentIndexArray[1];
			if(parentIndex!=null)
			{
				if(obj.checked && document.myForm.rdo[parentIndex].checked==false)
				{
					document.myForm.rdo[parentIndex].checked=true;
				}
			}
		}
	}

}
</Script>
<link href="../Library/Styles/Theme1.css" rel="stylesheet">
</Head>
<Body onLoad='scrollInit();chk()' onResize='scrollInit()' scroll="no">
<Form name="myForm" method="POST">
<Input type="hidden" name="updtvls" value="">

<Table  align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
	<Tr class=trClass>
		<Td align=center class=displayheader>Adding/Deleting Menu Options</Td>
	</Tr>
</Table>

<div id="theads" >
	<Table  id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th  width=33%>Main Menu</Th>
			<Th  width=33%>Sub Options</Th>
			<Th  width=34%>Sub Options1</Th>
		</Tr>
	</Table>
</div>
<DIV id="InnerBox1Div" style="position:absolute;height:100%;width:100%">
<Table  id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
	
	String fileName 	= chooseFile;
	
	java.io.File file	= new java.io.File(fileName); 
	
	try
	{
		DocumentBuilderFactory docFactory	= javax.xml.parsers.DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder 		= docFactory.newDocumentBuilder();
		Document doc	= docBuilder.parse(file);
		Element root	= doc.getDocumentElement();

		NodeList level1List 	= null;
		NodeList level2List 	= null;
		Node node 		= null; 
		Node node1 		= null; 
		Element	level1Ele 	= null;
		Element	level2Ele 	= null;
		String level1Str	= "";
		String level2Str	= "";
		int count		= 0;
		int level1childs	= 0;
		int level2childs	= 0;
		int parentIndex		= 0;
		int level1Len		= 0;
		int level2Len		= 0;
		//String[] mainArr	= 
		
		//if("V"==type || "V".equals(type))
		//{
			//mainArr	= new String[6]; 
			//mainArr 	= {"Requisitions","Purchase Orders","Shcd.Agreements","Shipments","Invoices","Self Services","Web Stats","Options"};
		//}	
		//else
		//{
			//mainArr	= new String[8]; 
			String[] mainArr= {"Requisitions","Purchase Orders","Shcd.Agreements","Shipments","Invoices","Self Services","Web Stats","Options"};
		//}	
		level1List		= root.getChildNodes();
		level1Len		= level1List.getLength();
		
		String tagName1		= "";
		int tagCount 		= 0;
		
		for(int i=0;i<level1Len;i++)
		{
			
				node 	= level1List.item(i);
				if((node.getNodeName().trim())!="#text" )
				{
				
					String tagName2	= node.getNodeName();

					if(tagName1 != tagName2 && !tagName1.equals(tagName2))
					{
%>
						<tr>
							<td width="33%"><%=mainArr[tagCount]%></td>
							<td width="33%">&nbsp;</Td>
							<td width="34%">&nbsp;</td>
						</tr>
<%
						tagCount++;
					}
					
					
					level1Ele	= (Element)level1List.item(i);	
					level1childs 	= level1Ele.getChildNodes().getLength()-5;
					level1childs 	= level1childs/2;
					level1Str 	= level1Ele.getAttribute("id")+"#"+level1Ele.getTagName()+"#"+level1childs+"#"+count;	
								
%>
					<tr>
						<td width="33%">&nbsp;</td>
						<td width="33%"><Input type=checkbox name="rdo" value="<%=level1Str%>" onClick="chkChilds(this)"><%=level1Ele.getAttribute("id")%></Td>
						<td width="34%">&nbsp;</td>
					</tr>	
<%		
					parentIndex = count;
					count++;
					if(node.hasChildNodes())
					{
						level2List 	= node.getChildNodes();
						level2Len 	= level2List.getLength();

						for(int j=0;j<level2Len;j++)
						{
							node1 = level2List.item(j);
							
							if((node1.getNodeName().trim())!="#text" )
							{
								level2Ele	= (Element)level2List.item(j);	
								level2childs 	= level2Ele.getChildNodes().getLength()-5;
								level2childs 	= level2childs/2;
								level2Str = level2Ele.getAttribute("id")+"#"+level2Ele.getTagName();

								if(j>5 && j<=level2Len)
								{
									level2Str = level2Ele.getAttribute("id")+"#"+level2Ele.getTagName()+"$"+parentIndex;
	%>
									<tr>
										<td width="33%">&nbsp;</td>
										<td width="33%">&nbsp;</td>
										<td width="34%"><Input type=checkbox name="rdo" value="<%=level2Str%>" onClick="chkChilds(this)"><%=level2Ele.getAttribute("id")%></Td>
									</tr>
	<%	
									count++;		
								}
							}	
						}
					}
					tagName1 = tagName2;
						

				}
		}
	}				
	catch(Exception e)
	{
		System.out.println(e);
	}
%>
</table>
</div>
	<Div style="position:absolute;top:90%;width:100%" align="center">
		<Table>
			<Tr>
				<Td>
					<a href="JavaScript:update()"><img src="../../Images/Buttons/<%= ButtonDir%>/update.gif" border=none></img></a>
				</Td>
			</Tr>
		</Table>
	</Div>
</form>
</body>
</html>