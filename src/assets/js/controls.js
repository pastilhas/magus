var player;
var time_played;
var time_left;

window.addEventListener("load", (event) => {
    player = document.querySelector("#audio");
    time_played = document.querySelector("#played");
    time_left = document.querySelector("#left");

    player.play();

    update_time()
});

function play() {
    player.play();
}

function pause() {
    player.pause();
}

function format_time(time) {
    const hr = Math.floor(time / 3600);
    const min = Math.floor((time % 3600) / 60);
    const sec = time % 60;

    const hours = String(hr).padStart(2, '0');
    const minutes = String(min).padStart(2, '0');
    const seconds = String(sec).padStart(2, '0');

    return `${hours}:${minutes}:${seconds}`;
}

function update_time() {
    const played = Math.round(player.currentTime);
    const left = Math.round(player.duration - player.currentTime);

    time_played.innerText = format_time(played);
    time_left.innerText = "-" + format_time(left);

    setTimeout(update_time, 100)
}
