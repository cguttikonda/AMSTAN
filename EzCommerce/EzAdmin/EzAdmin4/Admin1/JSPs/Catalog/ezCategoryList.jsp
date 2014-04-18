<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,javax.xml.transform.*,javax.xml.transform.dom.DOMSource,java.io.FileOutputStream,javax.xml.transform.stream.StreamResult,java.util.*;" %>
<%
		Vector v=new Vector();
		try
		{
		
			String Catnum=request.getParameter("Cat");
			
			DocumentBuilderFactory docFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = docFactory.newDocumentBuilder();

			String filePath=request.getRealPath("ezAddOrderPlant.jsp");
			filePath=filePath.substring(0,filePath.indexOf("EzCommerce"));
			filePath += "\\EzCommerce\\EzCommon\\XMLs\\ezOrderPlantDefaults.xml";

			Document doc = docBuilder.parse("file:"+filePath);

			Element root = doc.getDocumentElement();
			NodeList list = root.getElementsByTagName("Category");
			NodeList nodeList1= doc.getElementsByTagName("Default0");
			NodeList nodeList2= doc.getElementsByTagName("Default1");
			NodeList nodeList3= doc.getElementsByTagName("Default2");
			NodeList nodeList4= doc.getElementsByTagName("Default3");
			NodeList nodeList5= doc.getElementsByTagName("Default4");
			
			int n = list.getLength();
			Element element=null;

			String xmlcatid="";
			String xmlDefault0="";
			String xmlDefault1="";
			String xmlDefault2="";
			String xmlDefault3="";
			String xmlDefault4="";

			Node node=null;
			Node node1= null;
			Node node2= null;
			Node node3= null;
			Node node4= null;
			Node node5= null;
					
		
			for(int i=0;i<n;i++)
			{


				element=(Element)list.item(i);
				xmlcatid= element.getAttribute("id");
				if(xmlcatid.equals(Catnum))
				{
				node1=nodeList1.item(i).getFirstChild();
				node2=nodeList2.item(i).getFirstChild();
				node3=nodeList3.item(i).getFirstChild();
				node4=nodeList4.item(i).getFirstChild();
				node5=nodeList5.item(i).getFirstChild();

				xmlDefault0=(String)node1.getNodeValue();
				xmlDefault1=(String)node2.getNodeValue();
				xmlDefault2=(String)node3.getNodeValue();
				xmlDefault3=(String)node4.getNodeValue();
				xmlDefault4=(String)node5.getNodeValue();
				
				
				if(xmlDefault0==null || "null".equalsIgnoreCase(xmlDefault0) || "N/A-N/A".equalsIgnoreCase(xmlDefault0.trim())) xmlDefault0 = "";
				if(xmlDefault1==null || "null".equalsIgnoreCase(xmlDefault1) || "N/A-N/A".equalsIgnoreCase(xmlDefault1.trim())) xmlDefault1 = "";	
				if(xmlDefault2==null || "null".equalsIgnoreCase(xmlDefault2) || "N/A-N/A".equalsIgnoreCase(xmlDefault2.trim())) xmlDefault2 = "";	
				if(xmlDefault3==null || "null".equalsIgnoreCase(xmlDefault3) || "N/A-N/A".equalsIgnoreCase(xmlDefault3.trim())) xmlDefault3 = "";
				if(xmlDefault4==null || "null".equalsIgnoreCase(xmlDefault4) || "N/A-N/A".equalsIgnoreCase(xmlDefault4.trim())) xmlDefault4 = "";	

				
				v.addElement(xmlDefault0);
				v.addElement(xmlDefault1);
				v.addElement(xmlDefault2);
				v.addElement(xmlDefault3);
				v.addElement(xmlDefault4);



				}

			}
			
		
				TransformerFactory factory = TransformerFactory.newInstance();
				Transformer transformer = factory.newTransformer();
				transformer.transform(new DOMSource(root),new StreamResult(new FileOutputStream(filePath)));
		}		
		catch(Exception e)
		{
			System.out.println(e);
		}
		
		
	
   %>

<Html>
	<Head>
		<Title>ezCategoryList</Title>
		
		<meta http-equiv="Content-Type" content=" text/html; charset=iso-8859-1">

		<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
		<Script>
					function funSelect()
					{
					 var index=document.myForm.Cat.selectedIndex;
					 document.myForm.myIndex.value=index;
					 document.myForm.action="ezCategoryList.jsp";
					 document.myForm.submit();
					 
					
					}
					function funSubmit()
					{
						var ordobj=document.myForm.Order;
						var plantobj=document.myForm.Plant;
											
						for(i=0;i<ordobj.length;i++)
						{
							if(document.myForm.Order[i].value!="")
							{	
								if(document.myForm.Plant[i].value=="")	
								{
									alert("Please enter Plant to update");	
									document.myForm.Plant[i].focus();
									return false;
								}
							}
							else
							{	
								if(document.myForm.Plant[i].value!="")							
								{
									alert("Please enter Order to update");	
									document.myForm.Order[i].focus();
									return false;
								}
							}
						
						}
						
									
						document.myForm.action="ezAddOrderPlant.jsp";
						document.myForm.submit();
						
						
						
					}
					
					
		</Script>
		
	</Head>
	

<Body scrollInit()" onResize = 'scrollInit()' scroll="no">

   <Form name=myForm method=post>
   <Br>
   <Br>
   <%
   
String cat=request.getParameter("Cat");
cat=(cat==null)?"sel":cat;

String myIndex=request.getParameter("myIndex");


%>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
		<Tr>
		    <Th width="30%" class="labelcell" bordercolor="#CCCCCC">Categories List</Th>
		    
		    <Td width="70%" bordercolor="#CCCCCC">
		    
		    
			<Select name="Cat" id = "FullListBox" style="width:100%" onChange="funSelect()">
			    <option value="sel" >--Select Category--</option>
<%			    
			   // for (int i=1;i<=5;i++ )
			    //  {
			      
%>			      
			      	<option   value='ECONOMY' >ECONOMY</option>
			      	<option   value='LUXURY' >LUXURY</option>

<%			         
			     // }
			     
			      
			     
%>	
 
			   </Select>
		     </Td>
		</Tr>
        </Table>
	<br><br>
	<input type=hidden name=myIndex >
	
<%
 	if(cat!=null && cat.equals("sel"))
			   	{
%>

	    <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="75%">
		<Tr>
			<Td class = "labelcell">
			<div align="center"><b>Please Select Category</b></div>
			</Td>
		</Tr>
	    </Table>
<%	
		
		}


		else
		{
%>
				
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="50%">
			<Tr align="center">
			 <Th> Category&nbsp&nbsp&nbspDefaults</Th>
			</Tr>
		</Table>


			<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="50%">
			 <Tr>
				<Th valign="middle" align="center" width="25%">Order Type</Th>
				<Th valign="middle" align="center" width="25%">Plant/Location </Th>
			 </Tr>
<%
		for(int j=0;j<1;j++)
		{
		
		String defaultsStr="";
		String orderType ="",plant="";

		if(v!=null && !"null".equals(v) && v.size()>0)
		{
			defaultsStr = (String)v.elementAt(j);
			if(defaultsStr!=null && !"null".equals(defaultsStr.trim()) && !"".equals(defaultsStr.trim()))
			{
				String ord[] = defaultsStr.split("-");
				
				orderType = ord[0];
				try{
				plant = ord[1];
				}catch(Exception e){}

			}		
		}
%>
			 <Tr>
			    	<Td width="50%" align=center>
				<input type=text  name="Order" style="width:50%" maxlength="10" value="<%=orderType%>">
				</Td>
				<Td width="50%" align=center>
				  <input type=text  name="Plant" style="width:50%" maxlength="10" value="<%=plant%>">
				</Td>
		      	  </Tr>
<%		
		
		}
%>
			</Table>
			<Br><Br>
			<Center>
				<img src = "../../Images/Buttons/<%= ButtonDir%>/update.gif" style = "cursor:hand" onClick = "funSubmit()">
			</Center>


<%
		}

%>		
			
</Form>

	<Script>
<%
	if(!"sel".equals(cat))
	{
%>
	document.myForm.Cat.value='<%=cat%>'
	
<%
	}
%>
   	</Script>
</Body>


</Html>