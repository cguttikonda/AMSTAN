<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*" %>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%
	String defCat = request.getParameter("defCat");
	String defFlag = request.getParameter("defFlag");

	EzcParams focParamsMisc = new EzcParams(false);
	EziMiscParams focParams = new EziMiscParams();

	ReturnObjFromRetrieve retObjDefCat = null;

	if(defFlag!=null && !"null".equalsIgnoreCase(defFlag) && !"".equals(defFlag))
	{
		focParams.setIdenKey("MISC_SELECT");

		String query = "SELECT MAP_TYPE,VALUE1,VALUE2 FROM EZC_VALUE_MAPPING WHERE MAP_TYPE IN ('DEFCATL1','DEFCATL2','DEFCATL3') ORDER BY MAP_TYPE,VALUE1,VALUE2";

		focParams.setQuery(query);

		focParamsMisc.setLocalStore("Y");
		focParamsMisc.setObject(focParams);
		Session.prepareParams(focParamsMisc);

		try
		{
			retObjDefCat = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(focParamsMisc);
		}
		catch(Exception e){ezc.ezcommon.EzLog4j.log("Error in ezGetDefCategories.jsp::::::::::::","I");}
	}
	ezc.ezcommon.EzLog4j.log("defCat in ezGetDefCategories.jsp::::::::::::"+defCat,"I");
	ezc.ezcommon.EzLog4j.log("defFlag in ezGetDefCategories.jsp::::::::::::"+defFlag,"I");

	String buffer = "";
	if(defFlag!=null)
	{
		if("defCat1".equals(defFlag))
		{
			buffer = "<select id='defCat1' name='defCat1' title='Category Level 1' onChange='selDefCategory()'><option value=''>------Select------</option>";
			if(retObjDefCat!=null)
			{
				for(int i=0;i<retObjDefCat.getRowCount();i++)
				{
					String mapType = retObjDefCat.getFieldValueString(i,"MAP_TYPE");
					if("DEFCATL1".equals(mapType))
					{
						String value1 = retObjDefCat.getFieldValueString(i,"VALUE1");
						String value2 = retObjDefCat.getFieldValueString(i,"VALUE2");

						buffer = buffer+"<option value='"+value1+"'>"+value1+"</option>";
					}
				}
			}
		}
		else if("defCat2".equals(defFlag))
		{
			buffer = "<select id='defCat2' name='defCat2' title='Category Level 2' onChange='selDefCategory()'><option value=''>------Select------</option>";
			if(retObjDefCat!=null)
			{
				for(int i=0;i<retObjDefCat.getRowCount();i++)
				{
					String mapType = retObjDefCat.getFieldValueString(i,"MAP_TYPE");
					String value1 = retObjDefCat.getFieldValueString(i,"VALUE1");

					if("DEFCATL2".equals(mapType) && defCat.equals(value1))
					{
						String value2 = retObjDefCat.getFieldValueString(i,"VALUE2");

						buffer = buffer+"<option value='"+value2+"'>"+value2+"</option>";
					}
				}
			}
		}
		else if("defCat3".equals(defFlag))
		{
			buffer = "<select id='defCat3' name='defCat3' title='Category Level 3'><option value=''>------Select------</option>";
			if(retObjDefCat!=null)
			{
				for(int i=0;i<retObjDefCat.getRowCount();i++)
				{
					String mapType = retObjDefCat.getFieldValueString(i,"MAP_TYPE");
					String value1 = retObjDefCat.getFieldValueString(i,"VALUE1");
					if("DEFCATL3".equals(mapType) && defCat.equals(value1))
					{
						String value2 = retObjDefCat.getFieldValueString(i,"VALUE2");

						buffer = buffer+"<option value='"+value2+"'>"+value2+"</option>";
					}
				}
			}
		}
	}
	buffer = buffer+"</select>";
	response.getWriter().println(buffer);
%>