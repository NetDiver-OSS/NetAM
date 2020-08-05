import Cookies from 'js-cookie';

const DARK_MODE_COOKIE = 'dark_mode'

window.addEventListener('load', function () {
  document.getElementById("dark_mode").addEventListener("click", () => {
    const parseBoolean = value => (value && value.toString()) === 'true';
    const dark_mode = parseBoolean(Cookies.get(DARK_MODE_COOKIE));

    Cookies.set(DARK_MODE_COOKIE, !dark_mode, {expires: 365 * 10});
  });
})

