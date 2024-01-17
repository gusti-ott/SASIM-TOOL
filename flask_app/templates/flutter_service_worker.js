'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "5ae6c76822ae4fead00de10d53a49eae",
"assets/AssetManifest.bin.json": "d1be351770599f08e73a40fd5777b291",
"assets/AssetManifest.json": "e1e1679c727acb8d19f09f85b7a2cf2e",
"assets/assets/flags/flag_de.png": "9ca1aad0b74d2c0e6421bcd2b24ea68c",
"assets/assets/flags/flag_us.png": "163a7676b718218ef1ed6f431c9b0c0e",
"assets/assets/icons/icon_cab.png": "af0e4b58e7a744e42604f9e4e8d5e7bf",
"assets/assets/icons/icon_emmy.png": "a78b14ce6cc261dcea9bbdf256f2bf1a",
"assets/assets/icons/icon_flinkster.png": "d50f289d00d77a9ecabac33bb99842c9",
"assets/assets/icons/icon_mvv.png": "bb3b20182892957e5f194f125f2a8e26",
"assets/assets/icons/icon_mvv_plus_bike.png": "6c3a99536629bf148aab190d3e7dae1c",
"assets/assets/icons/icon_sharenow.jpg": "e0134ced83c587e5797eba77c49590b3",
"assets/assets/icons/icon_tier.jpg": "9e9f145e421a1ed1a804a4d741b8ea29",
"assets/assets/icons/launcher_icon.png": "52a66e8d587fd4454973cca9316cfad4",
"assets/assets/logos/mcube_logo.png": "3796a80be29056e3102f83ed90d0768a",
"assets/assets/logos/mobiscore_logo.png": "7135287a668cd56535887f87fce1c743",
"assets/assets/mobiscore/mobiscore_a.png": "d77320c00940e05eb41686992c90c0ce",
"assets/assets/mobiscore/mobiscore_b.png": "db7cc60e3233ec7b2b4253bee55cd96b",
"assets/assets/mobiscore/mobiscore_c.png": "d9f500868f23e929e1fd514429e829d2",
"assets/assets/mobiscore/mobiscore_d.png": "e33cb4dd815ec435eeae534f8c2317ba",
"assets/assets/mobiscore/mobiscore_e.png": "cbe536d84808f466665374a00f9711c2",
"assets/assets/title_image/titelbild_ubahn.png": "506c5b280ac7428b3290b5ff36442c45",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "55d9e62fce31bfaf744d0fa3aa4ddbae",
"assets/NOTICES": "9567d1c3f62ef2274121a383d11bd62f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/flutter_map/lib/assets/flutter_map_logo.png": "208d63cc917af9713fc9572bd5c09362",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "6c5a74af0eff79a2dbeb4ad6a28711b3",
"flutter.js": "59a12ab9d00ae8f8096fffc417b6e84f",
"icons/Icon-192.png": "8c56fa343814deaf9db97a063715b296",
"icons/Icon-512.png": "c8c19d9095b9120f95c1ee3032d108b5",
"icons/Icon-maskable-192.png": "8c56fa343814deaf9db97a063715b296",
"icons/Icon-maskable-512.png": "c8c19d9095b9120f95c1ee3032d108b5",
"index.html": "59a2e41cdd35f698dc0e1b5eba3f579f",
"/": "59a2e41cdd35f698dc0e1b5eba3f579f",
"main.dart.js": "86c53500e494562d7f56110bfea1af7c",
"manifest.json": "47fcf85f8114c016aa55030fc7dfbba9",
"version.json": "3da1e54aad724a9f1042a066766c3af3"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
