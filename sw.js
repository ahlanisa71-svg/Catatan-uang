/* Service worker minimal; app sudah offline-first lewat penyimpanan lokal */
self.addEventListener('install',()=>self.skipWaiting());
self.addEventListener('activate',e=>e.waitUntil(self.clients.claim()));
