package com.project.hot.common;

import org.springframework.stereotype.Component;

@Component
public class PageFactory {
	//페이지바 생성용 클래스
	public String getpage(int cPage, int numPerpage, int totalData, String url) {
		int pageBarSize=5;
		int totalPage=(int)Math.ceil((double)totalData/numPerpage);
		int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
		int pageEnd=pageNo+pageBarSize-1;
		
		StringBuffer sb=new StringBuffer();
		sb.append("<ul class='pagination'>");
		if(pageNo==1) {
			sb.append("<li class='paginate_button page-item disabled'>");
			sb.append("<a class='page-link' href='#' tabindex='0' data-dt-idx='0' aria-controls='dataTable'>이전</a>");
			sb.append("</li>");
		}else {
			sb.append("<li class='paginate_button page-item previous' id='dataTable_previous'>");
			sb.append("<a class='page-link' href='javascript:fn_paging("+(pageNo-1)+")' tabindex='0' data-dt-idx='0' aria-controls='dataTable'>이전</a>");
			sb.append("</li>");
		}
		
		while(!(pageNo>pageEnd||pageNo>totalPage)) {
			if(pageNo==cPage) {
				sb.append("<li class='paginate_button page-item active'>");
				sb.append("<a class='page-link' href='#' tabindex='0' data-dt-idx='"+pageNo+"' aria-controls='dataTable'>"+pageNo+"</a>");
				sb.append("</li>");
			}else {
				sb.append("<li class='paginate_button page-item'>");
				sb.append("<a class='page-link' href='javascript:fn_paging("+pageNo+")' tabindex='0' data-dt-idx='"+pageNo+"' aria-controls='dataTable'>"+pageNo+"</a>");
				sb.append("</li>");
			}
			pageNo++;
		}
		
		if(pageNo>totalPage) {
			sb.append("<li class='paginate_button page-item disabled'>");
			sb.append("<a class='page-link' href='#'>다음</a>");
			sb.append("</li>");
		}else {
			sb.append("<li class='paginate_button page-item next' id='dataTable_next'>");
			sb.append("<a class='page-link' href='javascript:fn_paging("+pageNo+")' tabindex='0' data-dt-idx='"+pageNo+"' aria-controls='dataTable'>다음</a>");
			sb.append("</li>");
		}
		sb.append("</ul>");
		sb.append("<script>");
		sb.append("function fn_paging(pageNo){");
		sb.append("location.assign('"+url+"?cPage='+pageNo+'&numPerpage="+numPerpage+"')");
		sb.append("}");
		sb.append("</script>");
		
		return sb.toString();
	}
}
