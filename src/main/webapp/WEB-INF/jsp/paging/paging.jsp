<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="crt" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${pagination.totalPage >0}">
	<li><a href="javascript:goPage(1)">&lt;&lt;</a></li>
	
	<c:choose>
		<c:when test="${pagination.currentPage > 1 }">
			<li><a href="javascript:goPage('${pagination.currentPage - 1}');" class="mr_20">&lt;</a></li>
		</c:when>
		<c:otherwise>
			<!-- <span class="numno mr_20">&lt;</span> -->
		</c:otherwise>
	</c:choose>

	<c:forEach  begin="${pagination.firstPage }" end="${pagination.lastPage }" step="1" var="pageNum">
		<c:choose>
			<c:when test="${pagination.currentPage == pageNum }">
				<li class="active"><a href="javascript:goPage('${pageNum}');" class="on">${pageNum }</a></li></c:when>
			<c:otherwise><li><a href="javascript:goPage('${pageNum}');">${pageNum }</a></li></c:otherwise>
		</c:choose>
	</c:forEach>

	<c:choose>
		<c:when test="${pagination.currentPage < pagination.totalPage}">
			<li ><a href="javascript:goPage('${pagination.currentPage + 1}');" class="ml_20">&gt;</a></li>
		</c:when>
		<c:otherwise>
			<!-- <span class="numno ml_20">&gt;</span> -->
		</c:otherwise>
	</c:choose>
	<li><a href="javascript:goPage('${pagination.totalPage}')">&gt;&gt;</a></li>
	
</c:if>