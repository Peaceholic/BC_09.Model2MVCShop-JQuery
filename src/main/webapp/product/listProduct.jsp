<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<% System.out.println("* [ listProduct.jsp ] "); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	

<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

	/*
 	function fncGetProductList(currentPage) {
		document.getElementById("currentPage").value = currentPage;
	   	document.detailForm.submit();	
	} 
	*/
	
	//=====기존Code 주석 처리 후  jQuery 변경 ======//
	// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
	function fncGetProductList(currentPage) {
		//document.getElementById("currentPage").value = currentPage;
		$("#currentPage").val(currentPage)
	   	//document.detailForm.submit();
		
		var menu = $("input[name='menu']").val();
		
		$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu="+menu).submit();
	}
	
	
	//===========================================//
	//==> 추가된부분 : "검색" ,  userId link  Event 연결 및 처리
	 $(function() {
		 
		 var menu = $("input[name='menu']").val();
		//==> 검색 Event 연결처리부분
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함. 
		 $( "td.ct_btn01:contains('검색')" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('검색')" ).html() );
			fncGetProductList(1);
		});
		
		//==> userId LINK Event 연결처리
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 3 과 1 방법 조합 : $(".className tagName:filter함수") 사용함.
		
		if(menu == "manage"){
			
			$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
				//Debug..
				//alert(  $( this ).text().trim() );
				self.location ="/product/updateProductView?prodNo="+$(this).find("input[name=prodNo]").val()+"&menu="+$(this).find("input[name=menu]");
				
			});
			
		}
		
		if(menu == "search"){
			
			$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
				//Debug..
				//alert(  $( this ).text().trim() );
				self.location ="/product/getProduct?prodNo="+$(this).find("input[name=prodNo]").val()+"&menu="+$(this).find("input[name=menu]");				
			});
			
		}                               
		
		$("#ship").on("click" , function() {
			//Debug..
			//alert(  $( this ).text().trim() );
			self.location ="/purchase/updateTranCodeByProd?prodNo=" + $(this).attr("data-prodNo")+"&tranCode=" +$(this).attr("data-tranCode");
		}); 
				
		//==> UI 수정 추가부분  :  userId LINK Event End User 에게 보일수 있도록 
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
		$("h7").css("color" , "red");
		
		
		//==> 아래와 같이 정의한 이유는 ??
		//==> 아래의 주석을 하나씩 풀어 가며 이해하세요.					
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		//console.log ( $(".ct_list_pop:nth-child(1)" ).html() );
		//console.log ( $(".ct_list_pop:nth-child(2)" ).html() );
		//console.log ( $(".ct_list_pop:nth-child(3)" ).html() );
		//console.log ( $(".ct_list_pop:nth-child(4)" ).html() ); //==> ok
		//console.log ( $(".ct_list_pop:nth-child(5)" ).html() ); 
		//console.log ( $(".ct_list_pop:nth-child(6)" ).html() ); //==> ok
		//console.log ( $(".ct_list_pop:nth-child(7)" ).html() ); 
	});	
	
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<div style="width: 98%; margin-left: 10px;">

		<%-- <form name="detailForm" action="/product/listProduct?menu=${menu}" method="post"> --%>
		<form name="detailForm">
		<input type="hidden" name="menu" value="${param.menu}">

			<table width="100%" height="37" border="0" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
						width="15" height="37"></td>
					<td background="/images/ct_ttl_img02.gif" width="100%"
						style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
							
								<%-- if (menu == null || menu.equals("manage")) { %>
							
								<td width="93%" class="ct_ttl01">상품 관리</td>
								
								<% } else { %>
								
								<td width="93%" class="ct_ttl01">상품 목록조회</td>
								
								<% } --%>
							<c:choose>
								<c:when test="${ empty param.menu || param.menu == 'manage'}"> 
									<td width="93%" class="ct_ttl01">상품 관리</td>
								</c:when>
								<c:otherwise>
									<td width="93%" class="ct_ttl01">상품 목록조회</td>
								</c:otherwise>
							</c:choose>

							</tr>

						</table>
					</td>
					<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
						width="12" height="37"></td>
				</tr>
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="right"><select name="searchCondition"
						class="ct_input_g" style="width: 80px">
							<option value="0" ${search.searchCondition eq '0' ? "selected" : "" }>상품번호</option>
							<option value="1" ${search.searchCondition eq '1' ? "selected" : "" }>상품명</option>
							<option value="2" ${search.searchCondition eq '2' ? "selected" : "" }>가격</option>
					</select> 
					
						<input type="text" name="searchKeyword" 
						value="${! empty search.searchKeyword ? search.searchKeyword : ''}"  
						class="ct_input_g" style="width:200px; height:20px" >
										
					
					<td align="right" width="70">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="17" height="23"><img
									src="/images/ct_btnbg01.gif" width="17" height="23"></td>
								<td background="/images/ct_btnbg02.gif" class="ct_btn01"
									style="padding-top: 3px;">
									
								<!-- <a href="javascript:fncGetProductList(1);">검색</a> -->
								검색
								</td>
								
								<td width="14" height="23"><img
									src="/images/ct_btnbg03.gif" width="14" height="23"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td colspan="11">전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage }페이지
					</td>
				</tr>
				<tr>
					<td class="ct_list_b" width="50">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">상품명</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="80">가격</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="100">등록일</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">현재상태</td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="808285" height="1"></td>
				</tr>
			
	<c:set var="i" value="0" />
	<c:forEach var="product" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>
						
			<c:choose>
				<c:when test="${ !empty user && user.role == 'admin' || product.proTranCode == '0' }"> 
					<td align="left">
					<%-- <a href="/product/getProduct?prodNo=${product.prodNo}&menu=${param.menu}">${product.prodName}</a> --%>
					${product.prodName}
					
					<input type="hidden" name="prodNo" value="${product.prodNo}">
					<input type="hidden" name="menu" value="${param.menu}">
					
					</td>
					
				</c:when>
				<c:otherwise>
					<td align="left">
					<%-- <a href="/product/getProduct?prodNo=${product.prodNo}&menu=${param.menu}">${product.prodName}</a> --%>
					${product.prodName}
					
					<input type="hidden" name="prodNo" value="${product.prodNo}">
					<input type="hidden" name="menu" value="${param.menu}">
					
					</td>
				
				</c:otherwise>
			</c:choose>	
		
			<td></td>
			<td align="center">${product.price}</td>
			<td></td>
			<td align="center">${product.regDate}			
			<td></td>
			<td align="left" >   
			
			<c:choose>
				<c:when test="${ empty product.proTranCode || product.proTranCode == '0' }"> 
					판매중
				</c:when>				
				<c:when test="${ product.proTranCode == '1' }"> 
					<c:choose>
    					<c:when test="${ param.menu == 'manage' }"> 
    						<%-- 구매완료 <a href="/purchase/updateTranCodeByProd?prodNo=${product.prodNo }&tranCode=2">배송하기</a> --%>
    						구매완료&nbsp;&nbsp;&nbsp;
    						<span id="ship" data-prodNo="${product.prodNo}" data-tranCode="2"> [ 배송하기 : 여기를 누르세요 ]</span>
    					</c:when>
    					<c:otherwise> 
    						구매완료
    					</c:otherwise>
    				</c:choose>
				</c:when>
				<c:when test="${ product.proTranCode == '2' }"> 
					배송중
				</c:when>							
				<c:otherwise>
					배송완료
				</c:otherwise>
				</c:choose>		
						
			</td>		
		</tr>
		<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
	</c:forEach>
			</table>

			<!-- PageNavigation Start... -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="center"><input type="hidden" id="currentPage"
						name="currentPage" value="" /> 
												
						<jsp:include page="../common/pageNavigatorProd.jsp"/>
					</td>
				</tr>
			</table>		
			<!-- PageNavigation End... -->
		</form>
	</div>

</body>
</html>