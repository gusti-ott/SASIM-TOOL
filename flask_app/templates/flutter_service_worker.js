'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "960576ffa15772e7474dfcdc2c9edc47",
"assets/AssetManifest.bin.json": "0474d7eb792e7c0869314ebb8b0ea6d9",
"assets/AssetManifest.json": "e56326114da8a9f2faac9343b86ef9a7",
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
"assets/assets/icons/personal_fixed/personal_fixed_A.png": "78f657eda9599e456159c917f7888ee6",
"assets/assets/icons/personal_fixed/personal_fixed_B.png": "27c18e48f35ef48b0aa8e9bd3fcd71de",
"assets/assets/icons/personal_fixed/personal_fixed_C.png": "f481d044b1e3dadb69a02cfec7212167",
"assets/assets/icons/personal_fixed/personal_fixed_D.png": "d9041b5eec0e5d9ae3a21ab152d6f89c",
"assets/assets/icons/personal_fixed/personal_fixed_E.png": "ffcab74126149dc4d70b715154e0f94a",
"assets/assets/icons/personal_fixed/personal_fixed_null.png": "029cb4939446b3d22322646d5b41f731",
"assets/assets/icons/personal_null.png": "1b6cc7503313b699934db2bd60946553",
"assets/assets/icons/personal_time/personal_time_A.png": "6832aa3f599b7a3e1da2bc0ecab07ccc",
"assets/assets/icons/personal_time/personal_time_B.png": "ae9a2b6fa4e3ed3ebb75bf250564efbb",
"assets/assets/icons/personal_time/personal_time_C.png": "66db63b77782943ab17f129c50232231",
"assets/assets/icons/personal_time/personal_time_D.png": "9ffb71c408e282072a17d158d4245915",
"assets/assets/icons/personal_time/personal_time_E.png": "0defdd62fcdd7f02be9ded3dc503fb0c",
"assets/assets/icons/personal_time/personal_time_null.png": "cbe35959ae50cb7a6e6d6de71ac20312",
"assets/assets/icons/personal_variable/personal_variable_A.png": "4ee5308b9c27b93ce58b4e2504f640c0",
"assets/assets/icons/personal_variable/personal_variable_B.png": "4c5395c02bd50500a06f79de183d674a",
"assets/assets/icons/personal_variable/personal_variable_C.png": "a1f8eaeba4d2c5ac1c184ce8be9cac92",
"assets/assets/icons/personal_variable/personal_variable_D.png": "ff1606d3a0600b594952f6ef8031e12c",
"assets/assets/icons/personal_variable/personal_variable_E.png": "20a609dbf72d7a7e6552b486d8303954",
"assets/assets/icons/personal_variable/personal_variable_null.png": "d5db9a26134df440bcd0db9ba7c1224c",
"assets/assets/icons/social_A.png": "f1907a04d694dd62734308a3f330f28c",
"assets/assets/icons/social_air/social_air_A.png": "1de38e447d0c14992186c4baccc25a92",
"assets/assets/icons/social_air/social_air_B.png": "7480a701cc70e95ce8592923744f9cb3",
"assets/assets/icons/social_air/social_air_C.png": "79c5acb4da96327706c8acb7086ec143",
"assets/assets/icons/social_air/social_air_D.png": "90b85190a399cbf3106d80899522b896",
"assets/assets/icons/social_air/social_air_E.png": "2ffa09443dec76394f3fd50d693cd831",
"assets/assets/icons/social_air/social_air_null.png": "69b15f117731bc6bccc3e2084a1b4ee1",
"assets/assets/icons/social_B.png": "3988c2a78c8468532aa1b012a185506c",
"assets/assets/icons/social_C.png": "df47a524534c063716fdf8992fceebff",
"assets/assets/icons/social_D.png": "a54ff91ed8bf947dc38f0bc448d9c748",
"assets/assets/icons/social_E.png": "f0458fc20abe8ef052bfe3e00bebc88a",
"assets/assets/icons/social_null.png": "a99bbd600d97411470edf91c160abdec",
"assets/assets/icons/social_space/social_space_A.png": "bdd35d4caa3397387821acd4dd84c5eb",
"assets/assets/icons/social_space/social_space_B.png": "b6f26469ab46725745d071fee5178f51",
"assets/assets/icons/social_space/social_space_C.png": "9426d00de4e2df53a99f6db6544a3390",
"assets/assets/icons/social_space/social_space_D.png": "769a615b099bbc77bf6cac5f5c822c4e",
"assets/assets/icons/social_space/social_space_E.png": "9e2e5ac3cb8f369b8f46287caeca53ca",
"assets/assets/icons/social_space/social_space_null.png": "5e1d4af7128cd1333d2ac443eef8d2b7",
"assets/assets/icons/social_time/social_time_A.png": "6174c0ff561f14e6dfc408f6debbf097",
"assets/assets/icons/social_time/social_time_B.png": "dcf2c5d5c468171c86bb3e1123b195d6",
"assets/assets/icons/social_time/social_time_C.png": "1a6daf8596e6b7229bfb92f772b32d36",
"assets/assets/icons/social_time/social_time_D.png": "e3005fe9b5d3f72cf958b087eed13c1d",
"assets/assets/icons/social_time/social_time_E.png": "24bd5fca81a29e09b6f4d11d0cdfd87e",
"assets/assets/icons/social_time/social_time_null.png": "3b55327197f52eb0edec3f0d8aefdb42",
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
"assets/fonts/MaterialIcons-Regular.otf": "5c205a3088919d184aa1d847f53c6284",
"assets/NOTICES": "144da07ab3ecb37f9a0630d58d4414a5",
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
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"flutter_bootstrap.js": "7a48442040a7d86d9707e489e14e616b",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "6390242da030329eaa637a8324521891",
"/": "6390242da030329eaa637a8324521891",
"main.dart.js": "10b918a7a0d89386cd65b07ef43e688d",
"manifest.json": "88ad21eb83b8a8f1e4be3942a432c9d0",
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
