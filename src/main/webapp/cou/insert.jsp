<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<form name="frm1" method="post" action="/cou/insert">
	<div class="input-group mb-2">
		<span class="input-group-text">강좌이름</span>
		<input class="form-control" name="lname">
	</div>
	<div class="input-group mb-2">
		<span class="input-group-text">강의시수</span>
		<input class="form-control" name="hour" value="3" oninput="isNumber(this)">
	</div>
	<div class="input-group mb-2">
		<span class="input-group-text">강의실</span>
		<input class="form-control" name="room">
	</div>
	<div class="input-group mb-2">
		<span class="input-group-text">교수</span>
		<select name="instructor" class="form-select">
		<c:forEach items="${parray}" var= "vo">
			<option value="${vo.pcode}" >${vo.pname}:${vo.dept}</option>
		</c:forEach>
		</select>
	</div>
	<div class="input-group mb-2">
		<span class="input-group-text">최대인원</span>
		<input class="form-control" name="capacity" value="30" oninput="isNumber(this)">
	</div>
	<div class="input-group mb-2">
		<span class="input-group-text">수강인원</span>
		<input class="form-control" name="persons" value="0" oninput="isNumber(this)">
	</div>
	<div class="text-center">
		<input class="btn btn-primary" type="submit" value="등록">
		<input class="btn btn-secondary" type="reset" value="취소">
	</div>
</form>
<script>
	//숫자인 경우에만 입력
	function isNumber(item){
	    item.value=item.value.replace(/[^0-9]/g,'');
	}
</script>
<script>
	$(frm1).on("click", function(e){
		e.preventDefault();

			if(confirm("등록하시겠습니까?")){
				frm1.submit();
			}else{
				alert("등록을 취소하였습니다.")
			}
	})
</script>