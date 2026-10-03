const { app, BrowserWindow } = require("electron");

// Performance
app.commandLine.appendSwitch("disable-frame-rate-limit");
app.commandLine.appendSwitch("enable-gpu-rasterization");
app.commandLine.appendSwitch("enable-zero-copy");

let win;

function createWindow() {
    win = new BrowserWindow({
        width: 1280,
        height: 720,
        title: "Tribals",
        autoHideMenuBar: true,
        fullscreen: true,

        webPreferences: {
            contextIsolation: true,
            nodeIntegration: false,
            backgroundThrottling: false
        }
    });

    // Open Tribals
    win.loadURL("https://tribals.io/");

    // Start in fullscreen
    win.once("ready-to-show", () => {
        win.setFullScreen(true);
        win.focus();
    });

    // If the user presses Esc and leaves fullscreen,
    // clicking/focusing the game again will restore fullscreen.
    win.on("focus", () => {
        if (!win.isDestroyed() && !win.isFullScreen()) {
            win.setFullScreen(true);
        }
    });

    // Close properly with X
    win.on("close", () => {
        if (!win.isDestroyed()) {
            win.destroy();
        }
    });
}

app.whenReady().then(createWindow);

app.on("window-all-closed", () => {
    if (process.platform !== "darwin") {
        app.quit();
    }
});