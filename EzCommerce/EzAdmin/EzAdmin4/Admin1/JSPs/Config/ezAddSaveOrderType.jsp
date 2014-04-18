<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import="java.util.*,javax.xml.bind.*,java.io.*,ezc.ezadmin.ordertypes.*" %>
<%
	String SystemKey = request.getParameter("SystemKey");
	String prdGrp =request.getParameter("prdGrp");
	String[] ordNature =request.getParameterValues("ordNature");
	String creation,list="";

	java.util.List salesAreas =null;
	java.util.List prdgroups=null;
	java.util.List ordNatures = null;
	boolean addprodGroup=true;
	boolean addsalesList =true;
	String SalesA="";
	String prdG="";
	
	ezc.ezadmin.ordertypes.OrdNatures ordNat=null;
	SalesAreaListType.SalesAreasType.PrdGroupsType prdgroup=null;
	SalesAreaListType.SalesAreasType.PrdGroupsType prdgroup1=null;
	SalesAreaListType.SalesAreasType salesareas=null;
	SalesAreaListType.SalesAreasType salesareas1=null;
	SalesAreaList salesareaList=null;
	
	java.util.ResourceBundle bundle=java.util.ResourceBundle.getBundle("Site");
	String filePath=bundle.getString("XSLTEMPDIR") + "EzSales\\";

	JAXBContext jc = JAXBContext.newInstance("ezc.ezadmin.ordertypes");
	ObjectFactory objFactory = new ObjectFactory();
	try
	{
		Unmarshaller u =jc.createUnmarshaller();
		salesareaList = (SalesAreaList)u.unmarshal(new FileInputStream(filePath+"ordertypes.xml"));
	
		// this part of code is to create new Node
		salesareas1=objFactory.createSalesAreaListTypeSalesAreasType();
		java.util.List prdgroups1 =salesareas1.getPrdGroups();

		salesareas1.setSalesArea(SystemKey);
		salesareas1.setSalesOrg("100");
		salesareas1.setDivision("100");
		salesareas1.setDC("100");
		prdgroup1 =objFactory.createSalesAreaListTypeSalesAreasTypePrdGroupsType();
		prdgroup1.setPrdGroup(prdGrp);
		java.util.List ordNatures1= prdgroup1.getOrdNatures();

		for(int i=0;i<ordNature.length;i++)
		{
			creation=request.getParameter("Creation_"+i);
			list =request.getParameter("List_"+i);
			ordNat=  objFactory.createOrdNatures();
			ordNat.setOrdNature(ordNature[i]);
			ordNat.setListType(list);
			ordNat.setCreationType(creation);
			ordNatures1.add(ordNat);
		}
		// code ends here

		salesAreas = salesareaList.getSalesAreas();
		for( Iterator iter = salesAreas.iterator(); iter.hasNext(); )
		{
			salesareas= (SalesAreaListType.SalesAreasType)iter.next();
		 	SalesA=salesareas.getSalesArea();
			if(SystemKey.equals(SalesA))
			{
				salesareas.setSalesArea(SystemKey);
				//salesareas.setSalesOrg("100");
				//salesareas.setDivision("100");
				//salesareas.setDC("100");
				addsalesList=false;
			}
			prdgroups =salesareas.getPrdGroups();
			for( Iterator iter1 = prdgroups.iterator(); iter1.hasNext(); )
			{
				prdgroup =(SalesAreaListType.SalesAreasType.PrdGroupsType)iter1.next();
				prdG =prdgroup.getPrdGroup();
				if(SystemKey.equals(SalesA) && prdG.equals(prdGrp))
				{
					prdgroup.setPrdGroup(prdGrp);
					ordNatures= prdgroup.getOrdNatures();
					int i=0;
					for( Iterator iter2 = ordNatures.iterator(); iter2.hasNext(); )
					{
						ordNat =(ezc.ezadmin.ordertypes.OrdNatures)iter2.next();
						creation=request.getParameter("Creation_"+i);
						list =request.getParameter("List_"+i);
	
						ordNat.setOrdNature(ordNature[i]);
						ordNat.setListType(list);
						ordNat.setCreationType(creation);
						i++;
	   				}
				 	addprodGroup=false;
				}
				else
				{
					ordNatures = prdgroup.getOrdNatures();
					for( Iterator iter2 = ordNatures.iterator(); iter2.hasNext(); )
					{
						ordNat =(ezc.ezadmin.ordertypes.OrdNatures)iter2.next();
					}
				}
			}
			if(addprodGroup && SystemKey.equals(SalesA))
			{
				prdgroups.add(prdgroup1);
			}
		}
		if(addsalesList)
		{
			prdgroups1.add(prdgroup1);
			salesAreas.add(salesareas1);
		}
	}
	catch(Exception e)
	{
		salesareaList=objFactory.createSalesAreaList();
		salesAreas = salesareaList.getSalesAreas();
		salesareas=objFactory.createSalesAreaListTypeSalesAreasType();
		prdgroups =salesareas.getPrdGroups();
	
		salesareas.setSalesArea(SystemKey);
		salesareas.setSalesOrg("100");
		salesareas.setDivision("100");
		salesareas.setDC("100");

		prdgroup =objFactory.createSalesAreaListTypeSalesAreasTypePrdGroupsType();
		prdgroup.setPrdGroup(prdGrp);
		ordNatures= prdgroup.getOrdNatures();
	
		for(int i=0;i<ordNature.length;i++)
		{
			creation=request.getParameter("Creation_"+i);
			list =request.getParameter("List_"+i);
	
			ordNat=  objFactory.createOrdNatures();
			ordNat.setOrdNature(ordNature[i]);
			ordNat.setListType(list);
			ordNat.setCreationType(creation);
			ordNatures.add(ordNat);
		}
		prdgroups.add(prdgroup);
		salesAreas.add(salesareas);
	}

	Marshaller m = jc.createMarshaller();
	FileOutputStream fos= new  FileOutputStream(new File(filePath+"ordertypes.xml"));
	m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT,Boolean.TRUE);
	m.marshal(salesareaList,fos);
	fos.close();
	response.sendRedirect("ezAddOrderType.jsp?SystemKey="+SystemKey+"&prdGrp="+prdGrp+"&Area=C&alert=a");
%>

