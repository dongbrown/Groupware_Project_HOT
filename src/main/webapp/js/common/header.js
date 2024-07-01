// 설명  text 크기 카운트
    $('#floatingTextarea-project').on('input', function() {
        let textLength = $(this).val().length;
        $('#project-contents-count').text(textLength + '/1000');
    });

    const currentYear = new Date().getFullYear();
    const nextYear = currentYear + 1;

    for (let year = currentYear; year <= nextYear; year++) {
        $('#year1').append('<option value="' + year + '">' + year + '</option>');
    };

    for (let month = 1; month <= 12; month++) {
        $('#month1').append('<option value="' + month + '">' + month + '</option>');
    }

    for (let day = 1; day <= 31; day++) {
        $('#day1').append('<option value="' + day + '">' + day + '</option>');
    }

    $('#project-budget').keyup(e=>{
        let value = e.target.value;
        let value1 = value.replace(/,/g,'');
        let result = Number(value1).toLocaleString('ko-KR');
        e.target.value=result;
    });

    $(document).ready(function() {
        let checkedTotalCount = 1;

    $('#select-dept').on('change', function() {
        const selectedText = $("#select-dept option:selected").val();
        const inputMember = $("#input-member");
        //선택하세요 선택시 맴버 비워주기
        if(selectedText === '선택하세요.'){
            inputMember.text('');
        }else{
            inputMember.empty();

            const inputDept = $('<div>', { id:'input-member-title'});
            const inputMemberList = $('<div>', { id: 'input-member-list' });
            const inputMemberTitle = $('<div>', { text: selectedText, class: 'input-group-text' });
            const memberSaveBtn = $('<button>', {id:'member-save-btn', class:'btn btn-primary', text:"저장"})

            // 부서 선택시 모달창 가로폭 늘어나는 코드
            $("#modal-size").addClass('modal-lg');

            inputDept.append(inputMemberTitle);
            inputMember.append(inputDept);
            inputMember.append(inputMemberList);
            inputMember.append(memberSaveBtn);

            for (let i = 0; i < 10; i++) {
                const checkboxId = 'flexCheckDefault' + i;
                const inputMemberWrab = $('<div>');
                const inputMemberDetail = $('<input>', { class: 'form-check-input', type: 'checkbox', id: checkboxId });
                const inputMemberDetailText = $('<label>', { class: 'form-check-label', for: checkboxId, text:selectedText + ': 홍길동 사번 / ' +i+"12341234"});

                // 이미 선택된 항목인지 확인
                if($('#saved-members').find('.saved-item:contains("' + inputMemberDetailText.text() + '")').length > 0) {
                    inputMemberDetail.prop('checked', true);
                }

                inputMemberWrab.append(inputMemberDetail);
                inputMemberWrab.append(inputMemberDetailText);
                inputMemberList.append(inputMemberWrab);
            }
        }

        // 저장버튼 누르면 체크된 직원들 추가

        $('#member-save-btn').on('click', function() {
            const checkedItems = $('#input-member-list input:checked');
            const savedMembers = $('#saved-members');

            checkedItems.each(function() {
                const label = $(this).next('label').text();
                const totalMember = 0;
                checkedTotalCount++;
                // 이미 존재하는 항목인지 확인
                if(savedMembers.find('.saved-item:contains("' + label + '")').length > 0) {
                    checkedTotalCount--;
                    return true; // continue to next iteration
                }
                $("#totalMember").val(checkedTotalCount);


                const checkedMembersDel = $('<button>', {class:'btn-close', type:'button'});
                const savedItem = $('<div>', { text: label, id:'checked-member-wrab', class:'saved-item' });
                savedItem.append(checkedMembersDel);
                savedMembers.append(savedItem);
            });
        });
    });
    // debugger;
    // x 버튼 클릭 시 해당 항목 삭제

    $(document).on('click', '.btn-close', function() {
        $(this).closest('.saved-item').remove();
        // 총 인원수 차감 출력
        checkedTotalCount--;


        $("#totalMember").val(checkedTotalCount);
        // 삭제된 항목의 체크박스 해제
        const removedText = $(this).parent().text();
        $('#input-member-list input:checkbox').each(function() {
            if($(this).next('label').text() === removedText) {
                $(this).prop('checked', false);

            }
        });
    });
});

    $(".project-choice").click(e=>{
        const projectNo = e.target.parentElement.children[1].textContent;
        console.log(projectNo); // 프로젝트 고유번호 넘겨서 프로젝트 수정페이지로 이동
        location.assign("/final/projectupdate.html?projectNo="+projectNo);

    });
    $(document).ready(function() {
    $("#updateProject").click(e=>{
    // 진행도 애니메이션
        const bars = document.querySelectorAll('.bar');
        bars.forEach(bar => {
            const percentage = bar.getAttribute('data-percentage');
            setTimeout(() => {
                bar.style.width = `${percentage}%`;
            }, 300);// 속도 조절
        });
    });
});

    // 설명  text 크기 카운트
    $('#floatingTextarea-work').on('input', function() {
        let textLength = $(this).val().length;
        $('#work-contents-count').text(textLength + '/1000');
    });

    const currentYear1 = new Date().getFullYear();
    const nextYear1 = currentYear + 1;

    for (let year = currentYear; year <= nextYear; year++) {
        $('#year').append('<option value="' + year + '">' + year + '</option>');
    };

    for (let month = 1; month <= 12; month++) {
        $('#month').append('<option value="' + month + '">' + month + '</option>');
    }

    for (let day = 1; day <= 31; day++) {
        $('#day').append('<option value="' + day + '">' + day + '</option>');
    }
