<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<form name="frm1" method="post" action="/stu/insert">
	<div class="input-group">
		<span class="input-group-text">학생이름</span>
		<input name="sname" class="form-control">
	</div>
	<div class="input-group mb-2">
		<span class="input-group-text">학생학과</span>
		<select name="dept" class="form-select">
			<option value="전산">전자계산학과</option>
			<option value="컴정">컴퓨터정보공학</option>
			<option selected value="전자">전자공학</option>
			<option value="건축">건축공학과</option>
		</select>
	</div>
	<div class="input-group mb-2">
		<span class="input-group-text">생년월일</span>
		<input name="birthday" class="form-control" type="date" value="2012-12-12">
	</div>
	<div class="input-group mb-2">
		<span class="input-group-text">학생학년</span>
		<input name="year" type="radio" class="px-3" value="1" checked>
		<span class="p-2">1학년</span>
		<input name="year" type="radio" class="px-3" value="2">
		<span class="p-2">2학년</span>
		<input name="year" type="radio" class="px-3" value="3">
		<span class="p-2">3학년</span>
		<input name="year" type="radio" class="px-3" value="4">
		<span class="p-2">4학년</span>
	</div>
	<div class="input-group mb-2">
		<span class="input-group-text">지도교수</span>
		<select name="advisor" class="form-select">
			<c:forEach items="${parray}" var="vo">
				<option value="${vo.pcode}">${vo.pname}:${vo.dept}</option>
			</c:forEach>
		</select>
	</div>
	<div class="text-center">
		<input type="submit" value="등록" class="btn btn-primary">
		<input type="reset" value="취소" class="btn btn-secondary">
	</div>
</form>
<script>
$(frm1).on("submit", function(e){
	e.preventDefault();
	const sname= $(frm1.sname).val();
	if(sname==""){
		alert("이름입력바람");
		$(frm1.sname).focus();
	}else{
		if(confirm("등록하시겠습니까?")){
			frm1.submit();
		}else{
			alert("등록이 취소되었땅")
		}
	}
});

$(frm1).on("reset", function(){
	$("#modal-stu").modal("hide")
});
</script>