const original = {
    title: document.title,
    icon: document.querySelector("link[rel*='icon']")?.href || '',
    type: 'image/x-icon'
};

const getServices = () => ({
    calendar: () => {
        const day = new Date().getDate();
        return {
            title: `Google Calendar - ${new Date().toLocaleDateString('en-US', { weekday: 'long', day: 'numeric' })}`,
            favicon: `calendar_${day}.ico`,
            type: 'image/x-icon'
        };
    },
    gmail: () => {
        const count = Math.floor(Math.random() * 10) + 1;
        const displayCount = count === 10 ? '10+' : count;
        return {
            title: `Inbox (${displayCount}) - root@davidfegyver.hu`,
            favicon: `gmail_${count}.png`,
            type: 'image/png'
        };
    },
    gemini: () => ({
        title: "Google Gemini",
        favicon: `gemini.svg`,
        type: 'image/svg+xml'
    }),
    github: () => ({
        title: "GitHub",
        favicon: `github.svg`,
        type: 'image/svg+xml'
    }),
    youtube: () => ({
        title: "YouTube",
        favicon: `youtube.png`,
        type: 'image/png'
    }),
    smile: () => ({
        title: "^^",
        favicon: `smile.png`,
        type: 'image/png'
    })
});

const updateDOM = ({ title, favicon, type }) => {
    document.title = title;

   document.querySelectorAll("link[rel*='icon']").forEach(el => el.remove());

    const link = document.createElement('link');
    link.type = type || original.type;
    link.rel = 'shortcut icon';
    link.href = favicon ? `./assets/icons/${favicon}` : original.icon;

    document.getElementsByTagName('head')[0].appendChild(link);
};

const enable = () => {
    const services = getServices();
    const keys = Object.keys(services);
    const randomKey = keys[Math.floor(Math.random() * keys.length)];

    updateDOM(services[randomKey]());
};

const disable = () => {
    updateDOM({
        title: original.title
    });
};

const handleVisibility = () => {
    if (document.hidden) {
        enable();
    } else {
        disable();
    }
};

document.addEventListener('visibilitychange', handleVisibility);