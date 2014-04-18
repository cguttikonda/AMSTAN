<%@ page import="javax.xml.bind.*,java.io.*,ezc.ezadmin.ordertypes.*" %>
<%

String RET="";
String BRE="";
String ORD="";
String FRS="";

ArrayList slsprdgroups=new ArrayList();
java.util.List ordNatures = null;
ezc.ezadmin.ordertypes.OrdNatures ordNat=null;
SalesAreaListType.SalesAreasType.PrdGroupsType prdgroupT=null;
SalesAreaList salesareaList=null;

int rcount= 0;
if(retCatManager!=null) rcount = retCatManager.getRowCount();
for(int i=0;i<rcount;i++)
{
    if("Y".equals(retCatManager.getFieldValueString(i,"ISCHECKED")))
    {
	String grp = retCatManager.getFieldValueString(i,"EPG_NO");
	if(grp != null && !"null".equals(grp))
	{
		slsprdgroups.add(grp);
	}
    }
}
try
{
	java.util.ResourceBundle bundle=java.util.ResourceBundle.getBundle("Site");
	String filePath=bundle.getString("XSLTEMPDIR") + "EzSales\\";
	JAXBContext jc =JAXBContext.newInstance("ezc.ezadmin.ordertypes");
	Unmarshaller u =jc.createUnmarshaller();

	FileInputStream fis=new FileInputStream("ordertypes.xml");
	salesareaList = (SalesAreaList)u.unmarshal(fis);
	//salesareaList = (SalesAreaList)u.unmarshal("ordertypes.xml");
	SalesAreaListType.SalesAreasType salesareas = null;

		if(salesareaList != null)
		{
			java.util.List salesAreas = salesareaList.getSalesAreas();
			String salesarea=null;
			String prdgroup=null;
			boolean flag=false;

			for( Iterator iter = salesAreas.iterator(); iter.hasNext(); )
			{
				salesareas= (SalesAreaListType.SalesAreasType)iter.next();
				salesarea=salesareas.getSalesArea();
				if(salesAreaCode.equals(salesarea))
				{
					java.util.List prdgroups =salesareas.getPrdGroups();
					for( Iterator iter1 = prdgroups.iterator(); iter1.hasNext(); )
					{
						prdgroupT =(SalesAreaListType.SalesAreasType.PrdGroupsType)iter1.next();
						prdgroup=prdgroupT.getPrdGroup();
						if(slsprdgroups.contains(prdgroup))
						{
							ordNatures =prdgroupT.getOrdNatures();

							for( Iterator iter2 = ordNatures.iterator(); iter2.hasNext(); )
							{
								ordNat =(ezc.ezadmin.ordertypes.OrdNatures)iter2.next();
								if("RET".equals(ordNat.getOrdNature()))
								{
									RET+=ordNat.getListType()+",";
								}
								else if("BRE".equals(ordNat.getOrdNature()))
								{
									BRE+=ordNat.getListType()+",";
								}
								else if("ORD".equals(ordNat.getOrdNature()))
								{
									ORD+=ordNat.getListType()+",";
								}
								else if("FRS".equals(ordNat.getOrdNature()))
								{
									FRS+=ordNat.getListType()+",";
								}

							}
						}

					  }break;

				}

			}
		}

	}catch(Exception e){
		e.printStackTrace();
	}
%>
