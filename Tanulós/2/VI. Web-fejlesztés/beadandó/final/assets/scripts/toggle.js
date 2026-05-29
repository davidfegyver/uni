document.body.onload = () => {
    if (localStorage.getItem('accessible') === 'true') {
        document.body.classList.add('accessible');
    }
}

function meow() {
    document.body.classList.toggle('accessible');
    localStorage.setItem('accessible', document.body.classList.contains('accessible'));
}
