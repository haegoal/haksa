<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<div class="row">
	<div class="col">
		<h1 class="text-center">강좌수정목록</h1>
<form name="frm1" method="post" action="/cou/update">
	<div class="input-group mb-2">
		<span class="input-group-text">강좌코드</span>
		<input class="form-control" name="lcode" value="${vo.lcode}" readonly>	
	</div>
	<div class="input-group mb-2">
		<span class="input-group-text">강좌이름</span>
		<input class="form-control" name="lname" value="${vo.lname}">	
	</div>
	<div class="input-group mb-2">
		<span class="input-group-text">강의시수</span>
		<input class="form-control" name="hour" value="${vo.hours}" oninput="isNumber(this)">
	</div>
	<div class="input-group mb-2">
		<span class="input-group-text">강의실</span>
		<input class="form-control" name="room" value="${vo.room}">
	</div>
	<div class="input-group mb-2">
		<span class="input-group-text">교수</span>
		<select name="instructor" class="form-select">
		<c:forEach items="${parray}" var= "p">
			<option value="${p.pcode}" <c:out value="${p.pcode==vo.instructor?'selected':''}"/>>${p.pname}:${p.dept}</option>
		</c:forEach>
		</select>
	</div>
	<div class="input-group mb-2">
		<span class="input-group-text">최대인원</span>
		<input class="form-control" name="capacity" value="${vo.capacity}" oninput="isNumber(this)">
	</div>
	<div class="input-group mb-2">
		<span class="input-group-text">수강인원</span>
		<input class="form-control" name="persons" value="${vo.persons}" oninput="isNumber(this)">
	</div>
	<div class="text-center">
		<input class="btn btn-primary" type="submit" value="등록">
		<input class="btn btn-secondary" type="reset" value="취소">
	</div>
</form>
	</div>
</div>
<script>
	//숫자인 경우에만 입력
	function isNumber(item){
	    item.value=item.value.replace(/[^0-9]/g,'');
	}
	
	$(frm1).on("submit", function(e){
		e.preventDefault();
		if(confirm("등록하시겠습니까?")){
			frm1.submit();
		}else{
			alert("취소했따잉")
		}
	})
</script>