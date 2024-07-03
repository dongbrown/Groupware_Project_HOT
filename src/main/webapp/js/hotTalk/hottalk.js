// 드롭다운 메뉴 기능
const dropdowns = document.querySelectorAll('.dropdown-toggle');
dropdowns.forEach(dropdown => {
    dropdown.addEventListener('click', function(e) {
        e.preventDefault();
        this.nextElementSibling.classList.toggle('show');
    });
});