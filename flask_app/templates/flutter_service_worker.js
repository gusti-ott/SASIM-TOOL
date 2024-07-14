'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "0dce33d6b62b9209308f8521ab49b7b0",
"assets/AssetManifest.bin.json": "9998d46293185b4be69f13a35e8fa47c",
"assets/AssetManifest.json": "edb0114cda16898d71ee9a9950e169c8",
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
"assets/assets/icons/personal_A.png": "0aef734ad158140b21f5e9a32a503c1e",
"assets/assets/icons/personal_B.png": "3a32bc02b10ec6d87c506910509b8db0",
"assets/assets/icons/personal_C.png": "928ca989765a8d9154e7b049b2b0ee2e",
"assets/assets/icons/personal_D.png": "f0a8c83016e082e543e986bf9ac3863e",
"assets/assets/icons/personal_E.png": "2606fa13ab8942add241a03d9ba98934",
"assets/assets/icons/personal_null.png": "1b6cc7503313b699934db2bd60946553",
"assets/assets/icons/social_A.png": "f1907a04d694dd62734308a3f330f28c",
"assets/assets/icons/social_B.png": "3988c2a78c8468532aa1b012a185506c",
"assets/assets/icons/social_C.png": "df47a524534c063716fdf8992fceebff",
"assets/assets/icons/social_D.png": "a54ff91ed8bf947dc38f0bc448d9c748",
"assets/assets/icons/social_E.png": "f0458fc20abe8ef052bfe3e00bebc88a",
"assets/assets/icons/social_null.png": "a99bbd600d97411470edf91c160abdec",
"assets/assets/logos/mcube_logo.png": "3796a80be29056e3102f83ed90d0768a",
"assets/assets/logos/mobiscore_logo.png": "7135287a668cd56535887f87fce1c743",
"assets/assets/mobiscore/mobiscore_a.png": "d77320c00940e05eb41686992c90c0ce",
"assets/assets/mobiscore/mobiscore_b.png": "db7cc60e3233ec7b2b4253bee55cd96b",
"assets/assets/mobiscore/mobiscore_c.png": "d9f500868f23e929e1fd514429e829d2",
"assets/assets/mobiscore/mobiscore_d.png": "e33cb4dd815ec435eeae534f8c2317ba",
"assets/assets/mobiscore/mobiscore_e.png": "cbe536d84808f466665374a00f9711c2",
"assets/assets/mobiscore_logos/logo_black.png": "d382cbd0261044d48893ffe6a753e702",
"assets/assets/mobiscore_logos/logo_primary.png": "0488e6854fb71d0e558845fe61bda6e3",
"assets/assets/mobiscore_logos/logo_white.png": "535065a8e44c83146564914db0c1e153",
"assets/assets/mobiscore_logos/logo_with_text_black.png": "3e8dc94df9ceebdebc9b222bd4a778a3",
"assets/assets/mobiscore_logos/logo_with_text_primary.png": "0bb99d55200ee603e4e3891ccd1b9c68",
"assets/assets/mobiscore_logos/logo_with_text_white.png": "14df3e64180628d5e99d366d0f4b80cc",
"assets/assets/title_image/mobiscore_header_1.png": "4c7e5484cc98ec5bb75cbc3a44df7c5f",
"assets/assets/title_image/titelbild_ubahn.png": "506c5b280ac7428b3290b5ff36442c45",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "a06098fb7b564173aa2874a13734b0c4",
"assets/NOTICES": "774ceb8b933d4519f0b964fa2dbde039",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/flutter_map/lib/assets/flutter_map_logo.png": "208d63cc917af9713fc9572bd5c09362",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "6c5a74af0eff79a2dbeb4ad6a28711b3",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"flutter_bootstrap.js": "d18760071cc8cc725a1e32e19aa4c012",
"icons/Icon-192.png": "8c56fa343814deaf9db97a063715b296",
"icons/Icon-512.png": "c8c19d9095b9120f95c1ee3032d108b5",
"icons/Icon-maskable-192.png": "8c56fa343814deaf9db97a063715b296",
"icons/Icon-maskable-512.png": "c8c19d9095b9120f95c1ee3032d108b5",
"index.html": "6eec6ee75eca1e25a3d45a1ad31924d9",
"/": "6eec6ee75eca1e25a3d45a1ad31924d9",
"main.dart.js": "cd0390ef80eac46947986df229489386",
"manifest.json": "47fcf85f8114c016aa55030fc7dfbba9",
"version.json": "3da1e54aad724a9f1042a066766c3af3"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
