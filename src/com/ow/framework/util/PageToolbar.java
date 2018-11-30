package com.ow.framework.util;

import java.io.*;

/**
 *
 * <p>Title: NCLAgentSMS</p>
 *
 * <p>Description: 新华人寿专属经理人系统</p>
 *
 * <p>Copyright: Copyright (c) 2008</p>
 *
 * <p>Company: 北京东方般若</p>
 *
 * @author allen
 * @version 1.0
 */


public class PageToolbar implements Serializable {
	private static final long serialVersionUID = 2494228982065770807L;
	private int currentPage; //当前页
    private int rowCount; //总记录数
    private int pageCount; //总页数
    private int pageSize; //页的大小,即每页显示的记录数
    private String pageText;

    public PageToolbar() {
    }

    public PageToolbar(int currentPage, int rowCount, int pageSize) {
        if (rowCount % pageSize == 0) {
            this.pageCount = rowCount / pageSize;
        } else {
            this.pageCount = (rowCount / pageSize) + 1;
        }

        if (pageCount < 1) {
            this.currentPage = 0;
        } else if (currentPage >= this.pageCount) {
            if (this.pageCount != 0) {
                this.currentPage = this.pageCount;
            }
        } else {
            this.currentPage = currentPage;
        }
        this.rowCount = rowCount;
        this.pageSize = pageSize;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentpage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getRowCount() {
        return rowCount;
    }

    public void setRowCount(int rowCount) {
        this.rowCount = rowCount;
    }

    public int getPageCount() {
        return pageCount;
    }

    public void setPageCount(int pageCount) {
        this.pageCount = pageCount;
    }

    public int getPageSize() {
        return pageSize;
    }

    public String getPageText() {
        return pageText;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public void setPageText(String pageText) {
        this.pageText = pageText;
    }

    public void getButtonPageToolBar(String fileNametemp, String increaseValue) {
        if (increaseValue == null)
            increaseValue = "";
        String fileName = "";
        if (fileNametemp != null && !fileNametemp.equalsIgnoreCase("null")) {
            fileName = fileNametemp;
        }
        String temp = "";
        if (fileName.indexOf("?") == -1) {
            temp = "?";
        } else {
            temp = "&";
        }

        StringBuffer stylesheet = new StringBuffer("");
        stylesheet.append("\n<STYLE type=text/css>\n")
                .append(".frmPageunnamed1 {FONT-SIZE: 9pt; FILTER: DropShadow(Color=#7C7C7C, OffX=1, OffY=1, Positive=1); ")
                //stylesheet.append(" COLOR: #ffffff; FONT-FAMILY: \"Verdana\", \"Arial\", \"Helvetica\", \"sans-serif\"; HEIGHT: 1px; }");
                .append(" COLOR: #ffffff; HEIGHT: 1px; }")
                .append(" input.NumberPageSize{ width:10px; border:1 solid #cecece; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px;  text-align: left;  font-size: 10pt; ; padding-top: 0px; padding-right: 1px; padding-bottom: 0px; padding-left: 0px}")
                .append("\n</STYLE>\n")
                .append("<SCRIPT LANGUAGE=\"JavaScript\"> \n")
                .append("function jump(param,pagecount)\n{ \n")
                .append(" var page_id_value = document.all.targetPage.value;\n")
                .append(" if (page_id_value <= 0 || page_id_value > pagecount)\n{\n")
                .append("     alert(\"您输入的页数不正确！\")\n")
                .append("     document.all.targetPage.select();\n")
                .append("     document.all.targetPage.focus();\n")
                .append("     return false;\n}\n")
                .append(" if (!page_id_value.match(/\\d/))\n{\n")
                .append("     alert(\"请输入正确的数字！\")\n")
                .append("     document.all.targetPage.select();\n")
                .append("     document.all.targetPage.focus();\n")
                .append("     return false;\n}\n")
                .append("document.location=param+'&targetPage='+page_id_value")
                .append("\n}\n")
                .append("function funcKeydown(param,pagecount)\n{ \n")
                .append(" var page_id_value = document.all.targetPage.value;\n")
                .append(" if (window.event.keyCode == 13)\n{\n")
                .append(" if (page_id_value <= 0 || page_id_value > pagecount)\n{\n")
                .append("     alert(\"您输入的页数不正确！\")\n")
                .append("     document.all.targetPage.select();\n")
                .append("     document.all.targetPage.focus();\n")
                .append("     return false;\n}\n")
                .append(" if (!page_id_value.match(/\\d/))\n{\n")
                .append("     alert(\"请输入正确的数字！\")\n")
                .append("     document.all.targetPage.select();\n")
                .append("     document.all.targetPage.focus();\n")
                .append("     return false;\n}\n")
                .append("     document.location=param+'&targetPage='+page_id_value")
//                  .append("\n}\n else \n{\n")
//                  .append("\n return false;\n")
                .append("\n}\n")
                .append("\n}\n")
                .append("function funcJump(url)\n{ \n")
                .append(" window.location = url;\n")
                .append("\n}\n")
                .append("function funcover(obj)\n{ \n")
                .append("obj.className = 'btnover2'\n")
                .append("\n}\n")
                .append("function funcout(obj)\n{ \n")
                .append("obj.className = 'btnover'\n")
                .append("\n}\n")
                .append("</SCRIPT>\n");

        StringBuffer sbf = new StringBuffer("");
        sbf.append("\n<table width=\"100%\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" class=\"ziti\">");
        sbf.append("\n<tr><td align='center' valign=\"middle\" nowrap class=\"\">\n");
        sbf.append("第 <font color=\"#FF0000\"> ")
                .append(currentPage)
                .append("</font>/<font color=\"#FF0000\">")
                .append(pageCount)
                .append("</font> 页")
                .append(" 每页<font color=\"#FF0000\"> ")
                .append(pageSize)
                .append("</font> 条")
                .append(" 共 <font color=\"#FF0000\"> ")
                .append(rowCount)
                .append("</font> 条&nbsp;");
        if (currentPage <= 1) {
            sbf.append("<input type='button' class='btnover' disabled='disabled' value='首&nbsp;页'>")
                    .append("&nbsp;<input type='button' disabled='disabled' class='btnover' value='上一页'>&nbsp;");
        } else {
            sbf.append("<input type='button' onmousemove='funcover(this)' onmouseout ='funcout(this)' class='btnover' onclick=\"funcJump('")
                    .append(fileName)
                    .append(temp)
                    .append("targetPage=1&")
                    .append(increaseValue)
                    .append("');\" value='首&nbsp;页'>&nbsp;")
                    .append("<input type='button' onmousemove='funcover(this)' onmouseout ='funcout(this)' class='btnover' onclick=\"funcJump('")
                    .append(fileName)
                    .append(temp)
                    .append("targetPage=")
                    .append((currentPage - 1))
                    .append("&")
                    .append(increaseValue)
                    .append("');\" value='上一页'>&nbsp;");
        }

        if (currentPage == pageCount || pageCount == 0) {
            sbf.append("<input type='button' disabled='disabled' class='btnover' value='下一页' >")
                    .append("&nbsp;<input type='button' disabled='disabled' class='btnover' value='尾&nbsp;页'>");
        } else {
            sbf.append("<input type='button' onmousemove='funcover(this)' onmouseout ='funcout(this)' class='btnover' onclick=\"funcJump('")
                    .append(fileName)
                    .append(temp)
                    .append("targetPage=")
                    .append((currentPage + 1))
                    .append("&")
                    .append(increaseValue)
                    .append("');\" value='下一页'>&nbsp;")
                    .append("<input type='button' onmousemove='funcover(this)' onmouseout ='funcout(this)' class='btnover' onclick=\"funcJump('")
                    .append(fileName)
                    .append(temp)
                    .append("targetPage=")
                    .append(pageCount)
                    .append("&")
                    .append(increaseValue)
                    .append("');\" value='尾&nbsp;页'>");
        }

        sbf.append("&nbsp;转<input type='text' onkeypress=\"return funcKeydown('")
                .append(fileName)
                .append(temp)
                .append(increaseValue)
                .append("',")
                .append(pageCount)
                .append(
                ");\" id='targetPage' name='targetPage'  class='page'  maxlength='10' value='")
                .append(this.currentPage)
                .append("'>页")
                .append(
                "<input type='button' class='btn3' name='go_button' value='Go' ")
                .append("onClick=\"jump('")
                .append(fileName)
                .append(temp)
                .append(increaseValue)
                .append("',")
                .append(pageCount)
                .append(")\" >")
                .append("\n</td></tr>")
                .append("\n</table>\n");
        this.setPageText(stylesheet.toString() + sbf.toString());
    }

    /**
     * 普通翻页
     * @param url String
     * @param urlParameter String
     */
    public void getCommonToolbar(String url, String urlParameter)
    {
        if (urlParameter == null)
            urlParameter = "";
        String tempUrl = "";
        if (url != null && !url.equalsIgnoreCase("null")) {
            tempUrl = url;
        }
        String temp = "";
        if (tempUrl.indexOf("?") == -1) {
            temp = "?";
        } else {
            temp = "&";
        }
        StringBuffer sbf = new StringBuffer();
        sbf.append("\n<table width=\"100%\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" class=\"ziti\">");
        sbf.append("\n<tr><td align='center' valign=\"middle\" nowrap class=\"\">\n");
        sbf.append("第 <font color=\"#FF0000\"> ")
                .append(currentPage)
                .append("</font>/<font color=\"#FF0000\">")
                .append(pageCount)
                .append("</font> 页")
                .append(" 每页<font color=\"#FF0000\"> ")
                .append(pageSize)
                .append("</font> 条")
                .append(" 共 <font color=\"#FF0000\"> ")
                .append(rowCount)
                .append("</font> 条&nbsp;");
        if (currentPage <= 1) {
            sbf.append("<input type='button' class='btnover' disabled='disabled' value='首&nbsp;页'>")
                    .append("&nbsp;<input type='button' disabled='disabled' class='btnover' value='上一页'>&nbsp;");
        } else {
            sbf.append("<input type='button' onmousemove='funcover(this)' onmouseout ='funcout(this)' class='btnover' onclick=\"funcJump('")
                    .append(tempUrl)
                    .append(temp)
                    .append("currentPage=1")
                    .append("&")
                    .append(urlParameter)
                    .append("');\" value='首&nbsp;页'>&nbsp;")
                    .append("<input type='button' onmousemove='funcover(this)' onmouseout ='funcout(this)' class='btnover' onclick=\"funcJump('")
                    .append(tempUrl)
                    .append(temp)
                    .append("currentPage=")
                    .append((currentPage - 1))
                    .append("&")
                    .append(urlParameter)
                    .append("');\" value='上一页'>&nbsp;");
        }

        if (currentPage == pageCount || pageCount == 0) {
            sbf.append("<input type='button' disabled='disabled' class='btnover' value='下一页' >")
                    .append("&nbsp;<input type='button' disabled='disabled' class='btnover' value='尾&nbsp;页'>");
        } else {
            sbf.append("<input type='button' onmousemove='funcover(this)' onmouseout ='funcout(this)' class='btnover' onclick=\"funcJump('")
                    .append(tempUrl)
                    .append(temp)
                    .append("currentPage=")
                    .append((currentPage + 1))
                    .append("&")
                    .append(urlParameter)
                    .append("');\" value='下一页'>&nbsp;")
                    .append("<input type='button' onmousemove='funcover(this)' onmouseout ='funcout(this)' class='btnover' onclick=\"funcJump('")
                    .append(tempUrl)
                    .append(temp)
                    .append("currentPage=")
                    .append(pageCount)
                    .append("&")
                    .append(urlParameter)
                    .append("');\" value='尾&nbsp;页'>");
        }
        sbf.append("&nbsp;<select name='selectJump' onchange=funcSelectJump(this,'")
                .append(tempUrl)
                .append("','")
                .append(urlParameter)
                .append("'); class='buttonclass' stype='width:100px;' id='selectJump'>");
        for (int i = 0; i < pageCount; i++) {
            if (i + 1 == currentPage) {
                sbf.append("<option selected='selected' value='")
                        .append(i + 1)
                        .append("'>第")
                        .append(i + 1)
                        .append("页</option>");
            } else {
                sbf.append("<option value='")
                        .append(i + 1)
                        .append("'>第")
                        .append(i + 1)
                        .append("页</option>");
            }
        }
        if (pageCount == 0)
            sbf.append("<option value=''>&nbsp;&nbsp;&nbsp;&nbsp;</option>");
        sbf.append("</select>")
                .append("\n</td></tr>")
                .append("\n</table>\n");
        this.setPageText(sbf.toString());
    }
}
