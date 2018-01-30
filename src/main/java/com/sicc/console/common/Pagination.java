package com.sicc.console.common;

import org.apache.commons.lang.builder.ToStringBuilder; 
import org.apache.commons.lang.builder.ToStringStyle;
import org.apache.commons.lang.math.NumberUtils;
import org.codehaus.jackson.annotate.JsonIgnore;


public class Pagination {

	static final int ROW_PER_PAGE = 10;
	private static final int PAGE_PER_BLOCK = 10;

	/**
	 * 페이지당 글 수
	 */
	private int rowPerPage = ROW_PER_PAGE;
	/**
	 * 블럭(페이징)당 페이지 수
	 */
	private int pagePerBlock = PAGE_PER_BLOCK;
	/**
	 * 총 글 수
	 */
	private int totalRow = 0;
	/**
	 * 현재 페이지
	 */
	private int currentPage = 1;

	/** */
	public Pagination() {
	}

	/**
	 * @param totalRow the totalRow to set
	 * @return PageDomain
	 */
	public Pagination setTotalRow(int totalRow) {
		this.totalRow = totalRow;
		return this;
	}
	/**
	 * @param totalRow the totalRow to set
	 * @return PageDomain
	 */
	public Pagination setTotalRow(String totalRow) {
		return setTotalRow(NumberUtils.toInt(totalRow, 0));
	}
	/**
	 * @param currentPage the currentPage to set
	 * @return PageDomain
	 */
	public Pagination setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
		return this;
	}
	/**
	 * @param currentPage the currentPage to set
	 * @return PageDomain
	 */
	public Pagination setCurrentPage(String currentPage) {
		return setCurrentPage(NumberUtils.toInt(currentPage, 1));
	}
	/**
	 * @param rowPerPage the rowPerPage to set
	 * @return PageDomain
	 */
	public Pagination setRowPerPage(int rowPerPage) {
		this.rowPerPage = rowPerPage;
		return this;
	}
	/**
	 * @param rowPerPage the rowPerPage to set
	 * @return PageDomain
	 */
	public Pagination setRowPerPage(String rowPerPage) {
		return setRowPerPage(NumberUtils.toInt(rowPerPage, ROW_PER_PAGE));
	}
	/**
	 * @param pagePerBlock the pagePerBlock to set
	 * @return PageDomain
	 */
	public Pagination setPagePerBlock(int pagePerBlock) {
		this.pagePerBlock = pagePerBlock;
		return this;
	}
	/**
	 * @param pagePerBlock the pagePerBlock to set
	 * @return PageDomain
	 */
	public Pagination setPagePerBlock(String pagePerBlock) {
		return setPagePerBlock(NumberUtils.toInt(pagePerBlock, PAGE_PER_BLOCK));
	}
	/**
	 * @return the totalRow
	 */
	public int getTotalRow() {
		return totalRow;
	}

	/**
	 * @return the currentPage
	 */
	public int getCurrentPage() {
		int totalPage = getTotalPage();
		return currentPage <= 0 ? 1 : (totalPage > 0 && totalPage < currentPage ? totalPage : currentPage);
	}
	/**
	 * @return the rowPerPage
	 */
	public int getRowPerPage() {
		return this.rowPerPage;
	}
	/**
	 * @return the totalPage
	 */
	public int getTotalPage() {
		return (int) Math.ceil((totalRow * 1.0) / (rowPerPage * 1.0));
	}
	
	public int getFirstPage(){
		return (currentPage - 1) / pagePerBlock * pagePerBlock	+ 1;
	}
	
	public int getLastPage(){
		int end = getTotalPage() - getFirstPage() + 1;
		return (end < pagePerBlock) ? getTotalPage() : pagePerBlock + getFirstPage() -1;
	}
	
//	/**
//	 * @return the currentBlock
//	 */
//	public int getCurrentBlock() {
//		return (int) Math.ceil((getCurrentPage() * 1.0) / (pagePerBlock * 1.0));
//	}
//	/**
//	 * @return the firstPage
//	 */
//	public int getFirstPage() {
//		return (getCurrentBlock() + 1) * pagePerBlock - pagePerBlock + 1;
//		
//		
//	}
//	/**
//	 * @return the lastPage
//	 */
//	public int getLastPage() {
//		int totalPage = getTotalPage();
//		int lastPage = (getCurrentBlock() + 1) * pagePerBlock;
//		lastPage = lastPage > totalPage ? totalPage : lastPage;
//		lastPage = getFirstPage() > lastPage ? getFirstPage() : lastPage;
//		return lastPage;
//	}
//
//	/**
//	 * @return the skipCount
//	 */
	public int getSkipCount() {
		int skipCount = rowPerPage * (getCurrentPage() - 1);
		skipCount = skipCount < 0 ? 0 : skipCount;
		return skipCount;
	}
//	/**
//	 * @return the seq
//	 */
//	public int getSeq() {
//		return totalRow - ((getCurrentPage() - 1) * rowPerPage);
//	}
//
//	/**
//	 * @return the pagePerBlock
//	 */
//	public int getPagePerBlock() {
//		return pagePerBlock;
//	}
//	/**
//	 *
//	 * @return the startRow
//	 */
//	public int getStartRow() {
//		return getSkipCount() + 1;
//	}
//	/**
//	 *
//	 * @return the totalBlock
//	 */
//	public int getTotalBlock() {
//		return (int) Math.ceil((getTotalPage() * 1.0) / (pagePerBlock * 1.0));
//	}
//	/**
//	 *
//	 * @return the boolean
//	 */
//	public boolean hasNextPage() {
//		return (getCurrentPage() * rowPerPage) < totalRow;
//	}
//	/**
//	 *
//	 * @return the boolean
//	 */
//	public boolean getHasNextPage() {
//		return hasNextPage();
//	}
//	/**
//	 *
//	 * @return the boolean
//	 */
//	public boolean hasNextBlock() {
//		return (getCurrentBlock() + 1) <= getTotalBlock();
//	}
//	/**
//	 *
//	 * @return the boolean
//	 */
//	public boolean getHasNextBlock() {
//		return hasNextBlock();
//	}
	
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
	}
	
	/**
	 * @return String
	 */
	@JsonIgnore
	public String getPostLimit() {
		return " LIMIT " + this.getRowPerPage() + " OFFSET " + this.getSkipCount() + " ";
	}
	
}
