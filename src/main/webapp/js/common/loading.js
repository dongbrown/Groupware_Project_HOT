/*
	Loading 중임을 나타내는 스피너 생성, 삭제 함수
*/

function showLoadingSpinner($div) {
    // 스피너를 화면에 추가하는 코드 (예: 특정 요소의 내부에 추가)
    const $spinner = $('<div>').addClass('spinner-border text-primary').attr('role', 'status');
    const $spinnerSpan = $('<span>').addClass('visually-hidden spinner-text').text('Loading...');
    const $spinnerDiv = $('<div>').addClass('spinner-div');
    $spinnerDiv.append($spinner);
    $spinnerDiv.append($spinnerSpan);
    $div.append($spinnerDiv);
}

function hideLoadingSpinner() {
    $('.spinner-div').remove(); // 스피너를 화면에서 제거하는 코드
}