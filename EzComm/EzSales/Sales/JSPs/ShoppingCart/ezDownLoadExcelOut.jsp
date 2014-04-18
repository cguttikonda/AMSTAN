<%@ page import="jxl.Sheet,jxl.Workbook,jxl.read.biff.BiffException,jxl.write.*,jxl.format.*"%>
<%@ page import="java.awt.image.BufferedImage,java.io.ByteArrayOutputStream,javax.imageio.ImageIO,java.io.*,ezc.ezparam.*,java.util.*,java.io.*"%>

<%
	String fileName = "UPLOADTEMPLATE.xls";
	WritableWorkbook workbook = null;
	response.setContentType("application/vnd.ms-excel");
	response.setHeader("Content-Disposition", "attachment; filename="+fileName);

	try
	{
		int row=0;

		workbook = Workbook.createWorkbook(response.getOutputStream());
		WritableSheet ws = workbook.createSheet("SampleTemp", 0);
		
		WritableFont custHeadFont = new WritableFont(jxl.write.WritableFont.TIMES, 11 , jxl.write.WritableFont.BOLD);
		WritableCellFormat custHeadCellFormat = new WritableCellFormat(custHeadFont);

		ws.addCell(new Label(0, row, "Product Code", custHeadCellFormat));
		ws.addCell(new Label(1, row, "Quantity", custHeadCellFormat));
		//ws.addCell(new Label(2, row, "Desired Date", custHeadCellFormat));
		//ws.addCell(new Label(3, row, "Program Type", custHeadCellFormat));
		ws.addCell(new Label(2, row, "My PO Line", custHeadCellFormat));
		ws.addCell(new Label(3, row, "My SKU", custHeadCellFormat));
		ws.addCell(new Label(4, row, "Job Quote", custHeadCellFormat));
		ws.addCell(new Label(5, row, "Job Quote Line", custHeadCellFormat));

		//WritableFont custDetFont = new WritableFont(jxl.write.WritableFont.TIMES, 12, jxl.write.WritableFont.BOLD);
		//WritableCellFormat custDetCellFormat = new WritableCellFormat(custDetFont);
		//custDetCellFormat.setBackground(jxl.format.Colour.YELLOW);	
		
		//ws.addCell(new Label(8, 12, "Program Type", custDetCellFormat));
		//ws.addCell(new Label(8, 13, "'QS' for Qucik Ship Items", custDetCellFormat));   
		//ws.addCell(new Label(8, 14, "'Disp' for Display Items", custDetCellFormat));
		//ws.addCell(new Label(8, 15, "'VIP' for VIP items", custDetCellFormat));
		

			
	}
	catch(Exception e)
	{
		System.out.println("Exception in result set"+e);
	}
	finally
	{
		try{
			workbook.write();
			workbook.close();
		}catch(Exception ex){}
	}

%>

