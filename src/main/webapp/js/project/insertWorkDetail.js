
//종료 날짜 설정
//오늘 날짜 생성
function getTodayDate() {
    const today = new Date();
    const year = today.getFullYear();
    const month = String(today.getMonth() + 1).padStart(2, '0');
    const day = String(today.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
  }

  // 1년 후 날짜를 가져오는 함수
      function getOneYearLaterDate() {
        const today = new Date();
        const nextYear = new Date(today.setFullYear(today.getFullYear() + 1));
        const year = nextYear.getFullYear();
        const month = String(nextYear.getMonth() + 1).padStart(2, '0');
        const day = String(nextYear.getDate()).padStart(2, '0');
        return `${year}-${month}-${day}`;
      }

// 날짜 입력 필드에 오늘 날짜 설정
  $("#project-end-date").val(getTodayDate());
  $("#project-end-date").attr('min', getTodayDate());
  $("#project-end-date").attr('max', getOneYearLaterDate());