<%@ page contentType="text/html; charset=EUC-KR" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>구매 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
/* 
 function fncGetPurchaseList(currentPage) {
	document.getElementById("currentPage").value = currentPage;
   	document.detailForm.submit();	
 } 
*/

function fncGetPurchaseList(currentPage) {
	$("#currentPage").val(currentPage)
   	$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase").submit();
}

$(function() {
	
	$("#tranNo").on("click" , function() {
		//Debug..
		self.location ="/purchase/getPurchase?tranNo="+$(this).attr("data-tranNo");
	}); 
	
	$("#userId").on("click" , function() {
		//Debug..
		self.location ="/user/getUser?userId="+$(this).attr("data-userId");
	});  
	
	$("#deliveried").on("click" , function() {
		//Debug..
		self.location ="/purchase/updateTranCodeByTran?tranNo="+$(this).attr("data-tranNo")+"&tranCode=" +$(this).attr("data-tranCode");
	}); 
	
	$( ".ct_list_pop td:nth-child(1)" ).css("color" , "red");
	$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
	$("h7").css("color" , "red");
	$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
	
});
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<!-- <form name="detailForm" action="/purchase/listPurchase" method="post"> -->
<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">구매 목록조회</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage }
						페이지
					</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">전화번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">배송현황</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">정보수정</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>

	<%--
		int no=list.size();
		for(int i=0;i<list.size();i++){
			Purchase purchase = list.get(i);
	--%>
	<c:set var="i" value="0" />
	<c:forEach var="purchase" items="${list}">
	<c:set var="i" value="${ i+1 }" />
	
	<tr class="ct_list_pop">
		<td align="center" id="tranNo" data-tranNo="${purchase.tranNo}">
			<%-- <a href="/purchase/getPurchase?tranNo=${purchase.tranNo}">${purchase.tranNo}</a> --%>
			${purchase.tranNo}
		</td>
		<td></td>
		<td align="left" id="userId" data-userId="${user.userId}">
			<%-- <a href="/user/getUser?userId=${user.userId}">${user.userId}</a> --%>
			${user.userId}
		</td>
		<td></td>
		<td align="left">${purchase.receiverName}</td>
		<td></td>
		<td align="left">${purchase.receiverPhone}</td>
		<td></td>
		<td align="left">현재
				
				<%-- <%if(purchase.getTranCode().trim().equals("1")){%>
					구매완료
				<%}else if(purchase.getTranCode().trim().equals("2")){	%>
					배송중
				<%}else if(purchase.getTranCode().trim().equals("3")){	%>
					배송완료
				<%}%> --%>
		<c:choose>
			<c:when test="${purchase.tranCode == '1'}"> 
				구매완료
			</c:when>
			<c:when test="${purchase.tranCode == '2'}"> 
				배송중
			</c:when>				
			<c:otherwise>
				배송완료
			</c:otherwise>
		</c:choose>				
				상태 입니다.</td>
		<td></td>
			<c:choose>
				<c:when test="${purchase.tranCode == '2'}"> 
					<%-- <a href="/purchase/updateTranCodeByTran?tranNo=${purchase.tranNo}&tranCode=3">물건도착</a> --%>
					<td id="deliveried" align="left" data-tranNo="${purchase.tranNo}" data-tranCode="3">[ 물건도착 : 여기를 누르세요 ]</td>
				</c:when>
				<c:otherwise>
					<td align="left"></td>				
				</c:otherwise>
			</c:choose>		
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	<%--
	}
	--%>
	</c:forEach>
</table>
			<!-- PageNavigation Start... -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="center"><input type="hidden" id="currentPage"
						name="currentPage" value="" /> 
												
						<jsp:include page="../common/pageNavigatorPurchase.jsp"/>
					</td>
				</tr>
			</table>			
			<!-- PageNavigation End... -->
</form>

</div>

</body>
</html>