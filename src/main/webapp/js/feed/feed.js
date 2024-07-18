$(document).ready(function() {
    loadFeeds();

    $("#feedForm").submit(function(e) {
        e.preventDefault();
        submitFeed();
    });

    $('#inviteButton').click(function() {
        const participants = getSelectedParticipants();
        if (participants.length > 0) {
            inviteParticipants(participants);
        } else {
            alert("초대할 참석자를 선택해주세요.");
        }
    });

    $('.close').click(function() {
        $('#addParticipantModal').hide();
    });

    $(window).click(function(event) {
        if (event.target == $('#addParticipantModal')[0]) {
            $('#addParticipantModal').hide();
        }
    });

    $('#participantSearch').on('input', function() {
        const searchTerm = $(this).val().toLowerCase();
        $('.tree-item').each(function() {
            const itemText = $(this).text().toLowerCase();
            $(this).toggle(itemText.includes(searchTerm));
        });
    });

    $(document).on('click', '.employee-checkbox', function(e) {
        e.stopPropagation();
        updateSelectedParticipants();
    });

    $(document).on('click', '.department-name', function(e) {
        e.stopPropagation();
        $(this).siblings('ul').toggle();
    });

    $('#file-upload').change(function() {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                $('#image-preview').attr('src', e.target.result).show();
            }
            reader.readAsDataURL(file);
        }
    });
});

function submitFeed() {
    const feedContent = $("#feedContent").val().trim();
    if (feedContent === "") {
        alert("내용을 입력해주세요.");
        return;
    }

    const formData = new FormData();
    formData.append("feedContent", feedContent);
    formData.append("communityNo", $("#community-container").data("id"));

    const fileInput = document.getElementById('file-upload');
    if (fileInput.files.length > 0) {
        formData.append("file", fileInput.files[0]);
    }

    $.ajax({
        url: '/community/feed/insert',
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            if (response.success) {
                alert("피드가 성공적으로 작성되었습니다.");
                $("#feedContent").val("");
                $("#file-upload").val("");
                $("#image-preview").hide();
                loadFeeds();
            } else {
                alert("피드 작성에 실패했습니다: " + response.message);
            }
        },
        error: function(xhr, status, error) {
            console.error('피드 작성 오류:', error);
            alert("피드 작성 중 오류가 발생했습니다.");
        }
    });
}

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

function withdrawCommunity() {
    const communityNo = $("#community-container").data("id");
    $.ajax({
        type: 'DELETE',
        url: '/community/feed/withdrawCommunity',
        contentType: 'application/json', // JSON 형식으로 보냄
        data: JSON.stringify({ id: communityNo }),
        success: function(response) {
            alert('커뮤니티를 탈퇴하였습니다.');
            location.href = '/community/';
        },
        error: function(xhr, status, error) {
            console.log('커뮤니티 탈퇴 오류:', error);
            alert('커뮤니티 탈퇴 중 오류가 발생했습니다.');
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
                    <button class="btn btn-sm btn-outline-primary edit-btn" onclick="showEditForm(${feed.feedNo})">수정</button>
                    <button class="btn btn-sm btn-outline-danger" onclick="deleteFeed(${feed.feedNo})">삭제</button>
                </div>
            </div>
        `;
    }

    let imageHtml = '';
    if (feed.hasImage) {
        imageHtml = `<img src="/community/feed/image/${feed.feedNo}" alt="Feed Image" class="img-fluid mt-2">`;
    }

    return `
        <div class="feed-item" id="feed-${feed.feedNo}">
            <div class="feed-header">
                <h5>${feed.employeeName}</h5>
                ${menuHtml}
            </div>
            <p class="feed-content">${feed.feedContent}</p>
            ${imageHtml}
            <div class="edit-form" style="display: none;">
                <input type="text" class="form-control edit-input" value="${feed.feedContent}">
                <button class="btn btn-sm btn-primary save-btn" onclick="updateFeed(${feed.feedNo})">저장</button>
                <button class="btn btn-sm btn-secondary cancel-btn" onclick="cancelEdit(${feed.feedNo})">취소</button>
            </div>
            <small class="text-muted">${feed.feedEnrollDate}</small>
            <div class="feed-actions">
                <button class="btn btn-sm btn-outline-primary like-btn" onclick="likeFeed(${feed.feedNo})">
                    <i class="far fa-thumbs-up"></i> 좋아요 <span class="like-count">${feed.likeCount || 0}</span>
                </button>
                <button class="btn btn-sm btn-outline-secondary comment-btn" onclick="toggleComments(${feed.feedNo})">
                    <i class="far fa-comment"></i> 댓글 <span class="comment-count">${feed.commentCount || 0}</span>
                </button>
            </div>
            <div class="comments-section" style="display: none;">
                <div class="comments-list"></div>
                <div class="comment-form">
                    <input type="text" class="form-control comment-input" placeholder="댓글을 입력하세요...">
                    <button class="btn btn-sm btn-primary submit-comment" onclick="submitComment(${feed.feedNo})">작성</button>
                </div>
            </div>
        </div>
    `;
}

function toggleFeedMenu(feedNo) {
    $(`#feedMenu-${feedNo}`).toggle();
}

function getCurrentEmployeeNo() {
    return currentEmployeeNo;
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
    loadNonParticipants();
}

function loadDepartments() {
    $.ajax({
        url: '/api/employee/departmentList',
        type: 'GET',
        dataType: 'json',
        success: function(departments) {
            const treeHtml = generateDepartmentTreeHtml(departments);
            $('#organizationTree').html(treeHtml);
        },
        error: function(xhr, status, error) {
            console.error('부서 목록 로드 오류:', error);
            alert('부서 목록을 불러오는 중 오류가 발생했습니다.');
        }
    });
}

function loadNonParticipants() {
    const communityNo = $("#community-container").data("id");
    $.ajax({
        url: '/community/feed/nonParticipants',
        type: 'GET',
        data: { communityNo: communityNo },
        dataType: 'json',
        success: function(response) {
            if (response.success) {
                const employees = response.nonParticipants;
                const groupedEmployees = groupEmployeesByDepartment(employees);
                const treeHtml = generateTreeHtml(groupedEmployees);
                $('#organizationTree').html(treeHtml);
            } else {
                console.error('비참여 사원 목록 로드 실패:', response.message);
                alert('비참여 사원 목록을 불러오는 중 오류가 발생했습니다.');
            }
        },
        error: function(xhr, status, error) {
            console.error('비참여 사원 목록 로드 오류:', error);
            alert('비참여 사원 목록을 불러오는 중 오류가 발생했습니다.');
        }
    });
}

function groupEmployeesByDepartment(employees) {
    const departments = {};
    employees.forEach(emp => {
        const deptCode = emp.departmentCode.departmentCode;
        if (!departments[deptCode]) {
            departments[deptCode] = {
                departmentCode: deptCode,
                departmentTitle: emp.departmentCode.departmentTitle,
                employees: []
            };
        }
        departments[deptCode].employees.push(emp);
    });
    return Object.values(departments);
}

function generateTreeHtml(departments) {
    let html = '<ul class="tree-root">';
    departments.forEach(dept => {
        html += `
            <li class="tree-item" data-id="${dept.departmentCode}" data-type="department">
                <span class="department-name">${dept.departmentTitle}</span>
                <ul class="employee-list">
        `;
        dept.employees.forEach(emp => {
            html += `
                <li class="tree-item" data-id="${emp.employeeNo}" data-type="employee">
                    <label>
                        <input type="checkbox" class="employee-checkbox" id="emp-${emp.employeeNo}"
                               value="${emp.employeeNo}" data-name="${emp.employeeName}">
                        ${emp.employeeName}
                    </label>
                </li>
            `;
        });
        html += '</ul></li>';
    });
    html += '</ul>';
    return html;
}

function updateSelectedParticipants() {
    const $participantList = $('#participantList');
    $participantList.empty();

    $('.employee-checkbox:checked').each(function() {
        const empId = $(this).val();
        const empName = $(this).data('name');
        const deptName = $(this).closest('.employee-list').siblings('.department-name').text();
        $participantList.append(`
            <li data-id="${empId}" class="list-group-item d-flex justify-content-between align-items-center">
                ${empName} <small class="text-muted">(${deptName})</small>
                <button type="button" class="btn-close remove-participant" aria-label="Close"></button>
            </li>
        `);
    });
}

$(document).on('click', '.remove-participant', function() {
    const empId = $(this).parent().data('id');
    $(`#emp-${empId}`).prop('checked', false);
    $(this).parent().remove();
});

function getSelectedParticipants() {
    return $('.employee-checkbox:checked').map(function() {
        const $employee = $(this);
        const deptName = $employee.closest('.employee-list').siblings('.department-name').text();
        return {
            id: $employee.val(),
            name: $employee.data('name'),
            department: deptName
        };
    }).get();
}

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
                // 여기서 참석자 목록을 갱신하는 함수 호출하기
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


function likeFeed(feedNo) {
    $.ajax({
        url: '/community/feed/like',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({ feedNo: feedNo }),
        success: function(response) {
            if (response.success) {
                const likeButton = $(`#feed-${feedNo} .like-btn`);
                const likeCount = likeButton.find('.like-count');
                likeCount.text(parseInt(likeCount.text()) + 1);
                likeButton.addClass('liked');
            } else {
                alert('좋아요 실패: ' + response.message);
            }
        },
        error: function(xhr, status, error) {
            console.error('좋아요 오류:', error);
            alert('좋아요 처리 중 오류가 발생했습니다.');
        }
    });
}

function toggleComments(feedNo) {
    const commentsSection = $(`#feed-${feedNo} .comments-section`);
    if (commentsSection.is(':visible')) {
        commentsSection.hide();
    } else {
        loadComments(feedNo);
        commentsSection.show();
    }
}

function loadComments(feedNo) {
    $.ajax({
        url: '/community/feed/comments',
        method: 'GET',
        data: { feedNo: feedNo },
        success: function(response) {
            if (response.success) {
                displayComments(feedNo, response.comments);
            } else {
                alert('댓글을 불러오는 데 실패했습니다: ' + response.message);
            }
        },
        error: function(xhr, status, error) {
            console.error('댓글 불러오기 오류:', error);
            alert('댓글을 불러오는 중 오류가 발생했습니다.');
        }
    });
}

function displayComments(feedNo, comments) {
    const commentsList = $(`#feed-${feedNo} .comments-list`);
    commentsList.empty();
    comments.forEach(comment => {
        commentsList.append(`
            <div class="comment">
                <strong>${comment.employeeName}</strong>
                <p>${comment.commentContent}</p>
                <small class="text-muted">${comment.commentDate}</small>
            </div>
        `);
    });
}

function submitComment(feedNo) {
    const commentInput = $(`#feed-${feedNo} .comment-input`);
    const commentContent = commentInput.val().trim();
    if (commentContent === '') {
        alert('댓글 내용을 입력해주세요.');
        return;
    }

    $.ajax({
        url: '/community/feed/comment',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({ feedNo: feedNo, commentContent: commentContent }),
        success: function(response) {
            if (response.success) {
                commentInput.val('');
                loadComments(feedNo);
                updateCommentCount(feedNo, 1);
            } else {
                alert('댓글 작성에 실패했습니다: ' + response.message);
            }
        },
        error: function(xhr, status, error) {
            console.error('댓글 작성 오류:', error);
            alert('댓글 작성 중 오류가 발생했습니다.');
        }
    });
}

function updateCommentCount(feedNo, increment) {
    const commentButton = $(`#feed-${feedNo} .comment-btn`);
    const commentCount = commentButton.find('.comment-count');
    commentCount.text(parseInt(commentCount.text()) + increment);
}

$(document).click(function(event) {
    if (!$(event.target).closest('.feed-menu').length) {
        $('.feed-menu-options').hide();
    }
});

// 유틸리티 함수
function formatDate(dateString) {
    const options = { year: 'numeric', month: 'long', day: 'numeric', hour: '2-digit', minute: '2-digit' };
    return new Date(dateString).toLocaleDateString('ko-KR', options);
}

function escapeHtml(unsafe) {
    return unsafe
         .replace(/&/g, "&amp;")
         .replace(/</g, "&lt;")
         .replace(/>/g, "&gt;")
         .replace(/"/g, "&quot;")
         .replace(/'/g, "&#039;");
}

// 이미지 미리보기 함수
function previewImage(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            $('#image-preview').attr('src', e.target.result).show();
        }
        reader.readAsDataURL(input.files[0]);
    }
}

// 초기화 함수
function initializeFeed() {
    loadFeeds();
    $('#file-upload').on('change', function() {
        previewImage(this);
    });
}

// 문서 로드 완료 시 초기화 함수 호출
$(document).ready(function() {
    initializeFeed();
});