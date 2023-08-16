<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
 <div class="row my-5">
        <div class="col">
            <h1 class="text-center mb-5">학생정보수정</h1>
            <form name="frm1" method="post" action="/stu/update">
            <div class="input-group">
		<span class="input-group-text">학생번호</span>
		<input name="scode" class="form-control" value="${vo.scode}" readonly>
	</div>
	<div class="input-group">
		<span class="input-group-text">학생이름</span>
		<input name="sname" class="form-control" value="${vo.sname}">
	</div>
	<div class="input-group mb-2">
		<span class="input-group-text">학생학과</span>
		<select name="dept" class="form-select">
			<option value="전산" <c:out value="${vo.dept== '전산' ? 'selected' :'' }"/>>전산계산학과</option>
			<option value="컴정" <c:out value="${vo.dept== '컴정' ? 'selected' :'' }"/>>컴퓨터정보공학</option>
			<option value="전자" <c:out value="${vo.dept== '전자' ? 'selected' :'' }"/>>전자공학</option>
			<option value="건축" <c:out value="${vo.dept== '건축' ? 'selected' :'' }"/>>건축공학과</option>
		</select>
	</div>
	<div class="input-group mb-2">
		<span class="input-group-text">생년월일</span>
		<input name="birthday" class="form-control" type="date" value="${vo.birthday}">
	</div>
	<div class="input-group mb-2">
		<span class="input-group-text">학생학년</span>
		<input name="year" type="radio" class="px-3" value="1" checked <c:out value="${vo.year==1?'checked':''}"/>>
		<span class="p-2">1학년</span>
		<input name="year" type="radio" class="px-3" value="2" <c:out value="${vo.year==2?'checked':''}"/>>
		<span class="p-2">2학년</span>
		<input name="year" type="radio" class="px-3" value="3" <c:out value="${vo.year==3?'checked':''}"/>>
		<span class="p-2">3학년</span>
		<input name="year" type="radio" class="px-3" value="4" <c:out value="${vo.year==4?'checked':''}"/>>
		<span class="p-2">4학년</span>
	</div>
	<div class="input-group mb-2">
		<span class="input-group-text">지도교수</span>
		<select name="advisor" class="form-select">
			<c:forEach items="${parray}" var="v">
				<option value="${v.pcode}" <c:out value="${v.pcode==vo.advisor?'selected':''}"/>>${v.pname}:${v.dept}</option>
			</c:forEach>
		</select>
	</div>
	<div class="text-center">
		<input type="submit" value="등록" class="btn btn-primary">
		<input type="reset" value="취소" class="btn btn-secondary">
	</div>
</form>
        </div>
    </div>
    <script>
    	$(frm1).on("submit", function(e){
    		e.preventDefault();
    		if(confirm("학생정보를 수정하실래요?")){
    			frm1.submit();
    		}
    	})
    </script>