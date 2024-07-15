$(document).ready(function() {
    // 페이지 로드 시 피드 목록 불러오기
    loadFeeds();

    // 피드 작성 폼 제출 이벤트
    $("#feedForm").submit(function(e) {
        e.preventDefault();
        submitFeed();
    });

    // 트리 아이템 클릭 이벤트
    $(document).on('click', '.tree-item', function(e) {
        e.stopPropagation();
        $(this).toggleClass('selected');
    });

    // 검색 기능
    $('#participantSearch').on('input', function() {
        const searchTerm = $(this).val().toLowerCase();
        $('.tree-item').each(function() {
            const itemText = $(this).text().toLowerCase();
            $(this).toggle(itemText.includes(searchTerm));
        });
    });

    // 부서 선택 시 사원 목록 로드
    $('#departmentSelect').change(function() {
        loadEmployees($(this).val());
    });

    // 참석자 추가 버튼 클릭 이벤트
    $('#addParticipantBtn').click(function() {
        addParticipant();
    });

	$('#inviteButton').click(function() {
	    const participants = getSelectedParticipants();
	    if (participants.length > 0) {
	        inviteParticipants(participants);
	    } else {
	        alert("초대할 참석자를 선택해주세요.");
	    }
	});

	function inviteParticipants(participants) {
	    const communityNo = $("#community-container").data("id");
	    $.ajax({
	        url: '/community/feed/invite',
	        method: 'POST',
	        contentType: 'application/json',
	        data: JSON.stringify({
	            communityNo: communityNo,
	            participants: participants
	        }),
	        success: function(response) {
	            if (response.success) {
	                alert(response.message);
	                $('#addParticipantModal').hide();
	                // 필요하다면 여기서 참석자 목록을 갱신하는 함수를 호출할 수 있습니다.
	            } else {
	                alert('참석자 초대에 실패했습니다: ' + response.message);
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error('참석자 초대 오류:', error);
	            alert('참석자 초대 중 오류가 발생했습니다.');
	        }
	    });
	}

    // 모달 닫기 기능
    $('.close').click(function() {
        $('#addParticipantModal').hide();
    });

    // 모달 외부 클릭 시 닫기
    $(window).click(function(event) {
        if (event.target == $('#addParticipantModal')[0]) {
            $('#addParticipantModal').hide();
        }
    });
});

function loadFeeds() {
    const communityNo = $("#community-container").data("id");
    $.ajax({
        url: '/community/feed/list',
        method: 'GET',
        data: { communityNo: communityNo },
        success: function(response) {
            if (response.success) {
                displayFeeds(response.feeds);
            } else {
                alert('피드를 불러오는 데 실패했습니다: ' + response.message);
            }
        },
        error: function(xhr, status, error) {
            console.error('피드 불러오기 오류:', error);
            alert('피드를 불러오는 중 오류가 발생했습니다.');
        }
    });
}

function displayFeeds(feeds) {
    const container = $("#feed-container");
    container.empty();
    feeds.forEach(feed => {
        container.append(createFeedHtml(feed));
    });
}

function createFeedHtml(feed) {
    const isAuthor = feed.employeeNo === getCurrentEmployeeNo();
    let menuHtml = '';
    if (isAuthor) {
        menuHtml = `
            <div class="feed-menu">
                <img src="/images/menuicon.png" class="menu-icon" onclick="toggleFeedMenu(${feed.feedNo})">
                <div class="feed-menu-options" id="feedMenu-${feed.feedNo}" style="display:none;">
                    <button class="btn btn-sm btn-outline-primary edit-btn" onclick="showEditForm(${feed.feedNo})">수정</button><br>
                    <button class="btn btn-sm btn-outline-danger" onclick="deleteFeed(${feed.feedNo})">삭제</button>
                </div>
            </div>
        `;
    }
    return `
        <div class="feed-item" id="feed-${feed.feedNo}">
            <div class="feed-header">
                <h5>${feed.employeeName}</h5>
                ${menuHtml}
            </div>
            <p class="feed-content">${feed.feedContent}</p>
            <div class="edit-form" style="display: none;">
                <input type="text" class="form-control edit-input" value="${feed.feedContent}">
                <button class="btn btn-sm btn-primary save-btn" onclick="updateFeed(${feed.feedNo})">저장</button>
                <button class="btn btn-sm btn-secondary cancel-btn" onclick="cancelEdit(${feed.feedNo})">취소</button>
            </div>
            <small class="text-muted">${feed.feedEnrollDate}</small>
        </div>
    `;
}

//피드 ...(메뉴) 토글
function toggleFeedMenu(feedNo) {
    $(`#feedMenu-${feedNo}`).toggle();
}

$(document).click(function(event) {
    if (!$(event.target).closest('.feed-menu').length) {
        $('.feed-menu-options').hide();
    }
});

function getCurrentEmployeeNo() {
    // JSP에서 설정한 전역 변수 사용
    return currentEmployeeNo;
}

function submitFeed() {
    const communityNo = $("#community-container").data("id");
    const feedContent = $("#feedContent").val().trim();
    const fileInput = $("#file-upload")[0];
    const file = fileInput.files[0];

    if (!feedContent) {
        alert('피드 내용을 입력해주세요.');
        return;
    }

    const formData = new FormData();
    formData.append('feedContent', feedContent);
    formData.append('communityNo', communityNo);
    if (file) {
        formData.append('file', file);
    }

    $.ajax({
        url: '/community/feed/insert',
        method: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            if (response.success) {
                alert('피드가 성공적으로 작성되었습니다.');
                $("#feedContent").val('');
                fileInput.value = '';
                loadFeeds();  // 피드 목록 새로고침
            } else {
                alert('피드 작성에 실패했습니다: ' + response.message);
            }
        },
        error: function(xhr, status, error) {
            console.error('피드 작성 오류:', error);
            alert('피드 작성 중 오류가 발생했습니다.');
        }
    });
}

function showEditForm(feedNo) {
    const feedElement = $(`#feed-${feedNo}`);
    feedElement.find('.feed-content').hide();
    feedElement.find('.edit-form').show();
    feedElement.find('.edit-btn').hide();
}

function cancelEdit(feedNo) {
    const feedElement = $(`#feed-${feedNo}`);
    feedElement.find('.feed-content').show();
    feedElement.find('.edit-form').hide();
    feedElement.find('.edit-btn').show();
}

function updateFeed(feedNo) {
    const feedElement = $(`#feed-${feedNo}`);
    const updatedContent = feedElement.find('.edit-input').val().trim();

    if (updatedContent === '') {
        alert('피드 내용을 입력해주세요.');
        return;
    }

    $.ajax({
        url: '/community/feed/update',
        method: 'PUT',
        contentType: 'application/json',
        data: JSON.stringify({ feedNo: feedNo, feedContent: updatedContent }),
        success: function(response) {
            if (response.success) {
                alert('피드가 성공적으로 수정되었습니다.');
                feedElement.find('.feed-content').text(updatedContent).show();
                feedElement.find('.edit-form').hide();
                feedElement.find('.edit-btn').show();
            } else {
                alert('피드 수정에 실패했습니다: ' + response.message);
            }
        },
        error: function(xhr, status, error) {
            console.error('피드 수정 오류:', error);
            alert('피드 수정 중 오류가 발생했습니다.');
        }
    });
}

function deleteFeed(feedNo) {
    if (!confirm('정말로 이 피드를 삭제하시겠습니까?')) return;

    $.ajax({
        url: '/community/feed/delete',
        method: 'DELETE',
        contentType: 'application/json',
        data: JSON.stringify({ feedNo: feedNo }),
        success: function(response) {
            if (response.success) {
                alert('피드가 성공적으로 삭제되었습니다.');
                $(`#feed-${feedNo}`).remove();
            } else {
                alert('피드 삭제에 실패했습니다: ' + response.message);
            }
        },
        error: function(xhr, status, error) {
            console.error('피드 삭제 오류:', error);
            alert('피드 삭제 중 오류가 발생했습니다.');
        }
    });
}

function showAddParticipant() {
    $('#addParticipantModal').css('display', 'block');
    loadDepartments();
	loadNonParticipants(); //커뮤니티 가입자가 아닌 사람만 불러오기

}

//커뮤니티 가입자가 아닌 사람만 불러오기
function loadNonParticipants() {
    const communityNo = $("#community-container").data("id");
    $.ajax({
        url: '/community/feed/nonParticipants',
        type: 'GET',
        data: { communityNo: communityNo },
        dataType: 'json',
        success: function(response) {
            if (response.success) {
                const nonParticipants = response.nonParticipants;
                updateEmployeeSelect(nonParticipants);
            } else {
                console.error('비참여 사원 목록 로드 실패:', response.message);
            }
        },
        error: function(xhr, status, error) {
            console.error('비참여 사원 목록 로드 오류:', error);
        }
    });
}

function loadDepartments() {
    $.ajax({
        url: '/api/departmentList',
        type: 'GET',
        dataType: 'json',
        success: function(departments) {
            const $select = $('#departmentSelect');
            $select.empty().append('<option value="">부서 선택</option>');
            departments.forEach(dept => {
                $select.append(`<option value="${dept.departmentCode}">${dept.departmentTitle}</option>`);
            });
        },
        error: function(xhr, status, error) {
            console.error('부서 목록 로드 오류:', error);
            alert('부서 목록을 불러오는 중 오류가 발생했습니다.');
        }
    });
}

function loadEmployees(deptCode) {
    $.ajax({
        url: '/schedule/selectEmpByDept',
        type: 'GET',
        data: { deptCode: deptCode },
        dataType: 'json',
        success: function(employees) {
            const $select = $('#employeeSelect');
            $select.empty().append('<option value="">사원 선택</option>');
            employees.forEach(emp => {
                $select.append(`<option value="${emp.employeeNo}">${emp.employeeName}</option>`);
            });
        },
        error: function(xhr, status, error) {
            console.error('사원 목록 로드 오류:', error);
            alert('사원 목록을 불러오는 중 오류가 발생했습니다.');
        }
    });
}

function addParticipant() {
    const $employeeSelect = $('#employeeSelect');
    const employeeNo = $employeeSelect.val();
    const employeeName = $employeeSelect.find('option:selected').text();

    if (!employeeNo) {
        alert('사원을 선택해주세요.');
        return;
    }

   const $participantList = $('#participantList');
    if ($participantList.find(`li[data-id="${employeeNo}"]`).length === 0) {
        $participantList.append(`
            <li data-id="${employeeNo}" class="list-group-item d-flex justify-content-between align-items-center">
                ${employeeName}
                <button type="button" class="btn-close remove-participant" aria-label="Close"></button>
            </li>
        `);
    } else {
        alert('이미 선택된 사원입니다.');
    }
}

$(document).on('click', '.remove-participant', function() {
    $(this).parent().remove();
});

function getSelectedParticipants() {
    return $('#participantList li').map(function() {
        return {
            id: $(this).data('id'),
            name: $(this).contents().filter(function() {
                return this.nodeType === 3;
            }).text().trim()
        };
    }).get();
}

function loadOrganizationTree() {
    $.ajax({
        url: '/api/departmentList',
        type: 'GET',
        dataType: 'json',
        success: function(departments) {
            const treeData = buildDepartmentTree(departments);
            const treeHtml = generateTreeHtml(treeData);
            $('#organizationTree').html(treeHtml);

            // 부서 클릭 이벤트 추가
            $('.tree-item[data-type="department"]').click(function(e) {
                e.stopPropagation();
                const deptCode = $(this).data('id');
                const $childrenContainer = $(this).children('ul');
                if ($childrenContainer.length === 0) {
                    loadEmployeesForTree(deptCode, $(this));
                } else {
                    $childrenContainer.toggle();
                }
            });
        },
        error: function(xhr, status, error) {
            console.error('부서 목록 로드 오류:', error);
            alert('부서 목록을 불러오는 중 오류가 발생했습니다.');
        }
    });
}

function buildDepartmentTree(departments) {
    const departmentMap = new Map();
    const rootDepartments = [];

    // 모든 부서를 맵에 추가
    departments.forEach(dept => {
        departmentMap.set(dept.departmentCode, {
            id: dept.departmentCode,
            name: dept.departmentTitle,
            type: 'department',
            children: []
        });
    });

    // 부서 계층 구조 생성
    departments.forEach(dept => {
        const departmentNode = departmentMap.get(dept.departmentCode);
        if (dept.departmentHighCode) {
            const parentDept = departmentMap.get(dept.departmentHighCode);
            if (parentDept) {
                parentDept.children.push(departmentNode);
            }
        } else {
            rootDepartments.push(departmentNode);
        }
    });

    return rootDepartments;
}

function generateTreeHtml(items, level = 0) {
    let html = '<ul' + (level === 0 ? ' class="tree-root"' : '') + '>';
    items.forEach(item => {
        html += `<li class="tree-item" data-id="${item.id}" data-type="${item.type}">`;
        html += '  '.repeat(level) + item.name;
        if (item.children && item.children.length > 0) {
            html += generateTreeHtml(item.children, level + 1);
        }
        html += '</li>';
    });
    html += '</ul>';
    return html;
}

function loadEmployeesForTree(deptCode, $parentElement) {
    $.ajax({
        url: '/schedule/selectEmpByDept',
        type: 'GET',
        data: { deptCode: deptCode },
        dataType: 'json',
        success: function(employees) {
            const employeesHtml = generateTreeHtml(employees.map(emp => ({
                id: emp.employeeNo,
                name: emp.employeeName,
                type: 'employee'
            })));
            $parentElement.append(employeesHtml);
        },
        error: function(xhr, status, error) {
            console.error('사원 목록 로드 오류:', error);
            alert('사원 목록을 불러오는 중 오류가 발생했습니다.');
        }
    });
}