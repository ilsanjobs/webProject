function showCategoryStores(category) {
	// 선택한 카테고리에 따라 서블릿 호출
	window.location.href = "TypeController?category=" + category;
}

function validateSearchForm() {
	var searchName = document.getElementById("searchName").value;

	if (searchName.trim() === "") {
		alert("검색어를 입력해 주세요.");
		return false; // 폼 제출을 막음
	}

	return true; // 폼 제출을 허용
}

function updateAddress(location) {
	var address = "";  // Default empty address
	// Set the address based on the selected location
	if (location == "신공학관") {
		address = "28-27 Pil-dong, Jung-gu, Seoul"; // Replace with the actual address
	} else if (location == "학림관") {
		address = "19-3 Pil-dong 3(sam)-ga, Jung-gu, Seoul"; // Replace with the actual address
	} else if (location == "만해관") {
		address = "192-5 Jangchung-dong 2(i)-ga"; // Replace with the actual address
	}
	document.getElementById("currentAddress").value = address;


}

