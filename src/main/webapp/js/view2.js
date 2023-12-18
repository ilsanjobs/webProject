
function goToView3(address) {
	// Redirect to view3.jsp with the address as a parameter
	window.location.href = 'view3.jsp?address=' + encodeURIComponent(address);
}


function validateSearchForm() {
	var searchName = document.getElementById("searchName").value;

	if (searchName.trim() === "") {
		alert("검색어를 입력해 주세요.");
		return false; // 폼 제출을 막음
	}

	return true; // 폼 제출을 허용
}
