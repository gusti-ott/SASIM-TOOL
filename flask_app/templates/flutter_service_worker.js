'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "888483df48293866f9f41d3d9274a779",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/flutter_map/lib/assets/flutter_map_logo.png": "208d63cc917af9713fc9572bd5c09362",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/assets/research_data/personal_costs_data_en.png": "0047b338f0394612ffaa79cdcdac7a3f",
"assets/assets/research_data/social_costs_data_de.png": "cf80bdb86c830217bf91448f65d79164",
"assets/assets/research_data/social_costs_data_en.png": "1f78243e237ec3e865129ed763888485",
"assets/assets/research_data/survey_qr.png": "311ba09f9f03825a9c1b40e99e0d9283",
"assets/assets/research_data/personal_costs_data_de.png": "26aa6e40ba611346281dddbace4b455e",
"assets/assets/partners_logos/muenchen_logo.png": "d50f59d66c2fd1d20e8221489e82ee3b",
"assets/assets/partners_logos/bayrisches_ministerium_logo.png": "d2c9deb03289c215aa1205fbf86f332d",
"assets/assets/partners_logos/tum_logo.png": "eef1d4be137b8f861a968c3a4a1a45a9",
"assets/assets/partners_logos/bmw_logo.png": "2a36295b288ae70e8c752e2e1176eb0f",
"assets/assets/partners_logos/c4f_logo.png": "8b7d5eb81c2e260d1b382c6a416ff8c9",
"assets/assets/partners_logos/mvv_logo.png": "4d32581d42e27c8277a70fb4f169bd74",
"assets/assets/icons/icon_tier.jpg": "9e9f145e421a1ed1a804a4d741b8ea29",
"assets/assets/icons/personal_variable/personal_variable_null.png": "75724cad163485fdd0e6ee400685befe",
"assets/assets/icons/icon_flinkster.png": "d50f289d00d77a9ecabac33bb99842c9",
"assets/assets/icons/launcher_icon.png": "52a66e8d587fd4454973cca9316cfad4",
"assets/assets/icons/icon_sharenow.jpg": "e0134ced83c587e5797eba77c49590b3",
"assets/assets/icons/icon_mvv_plus_bike.png": "6c3a99536629bf148aab190d3e7dae1c",
"assets/assets/icons/personal_null.png": "467497967b6fb19e7ad583613468bc30",
"assets/assets/icons/social_air/social_air_C.png": "85e3b45d90dc9b329ec3362cf149239f",
"assets/assets/icons/social_air/social_air_A.png": "2a5384e6cea59fa806080fc663ffd061",
"assets/assets/icons/social_air/social_air_E.png": "fdf90c1f98e78439938beaf28bdb81f6",
"assets/assets/icons/social_air/social_air_B.png": "c0f6311086bd6e756e3779f6916a4b7c",
"assets/assets/icons/social_air/social_air_D.png": "eb7ec3b6566998f29711e478597ac723",
"assets/assets/icons/icon_cab.png": "af0e4b58e7a744e42604f9e4e8d5e7bf",
"assets/assets/icons/social_B.png": "408cab6bf7be1111aae857f23d43527c",
"assets/assets/icons/social_space/social_space_A.png": "01cd9ca75e86eddb82bde810f21141cb",
"assets/assets/icons/social_space/social_space_E.png": "8cb173fa2eda656027fa1043f7823d87",
"assets/assets/icons/social_space/social_space_B.png": "d0d19a5451373fd615181f77be4ffeab",
"assets/assets/icons/social_space/social_space_D.png": "2e330f1ad40e0f2ab06e2d87bf01a52e",
"assets/assets/icons/social_space/social_space_C.png": "9708c52d20cb95b09d89ae453832b6a1",
"assets/assets/icons/social_C.png": "eb1da68afead234b7a9014e5c3557e51",
"assets/assets/icons/icon_mvv.png": "bb3b20182892957e5f194f125f2a8e26",
"assets/assets/icons/personal_E.png": "8b74dd903a802c56f1d7dfc41fd444df",
"assets/assets/icons/icon_emmy.png": "a78b14ce6cc261dcea9bbdf256f2bf1a",
"assets/assets/icons/social_E.png": "6bb71da4518bd140ed7de32099eaed2a",
"assets/assets/icons/personal_D.png": "776ac0efc6f4853d76acad45ec724247",
"assets/assets/icons/personal_A.png": "66447499f841e9d0a800c2f00e6b99b2",
"assets/assets/icons/personal_B.png": "bd6d0c84ad837bf35c99964bf9a91c85",
"assets/assets/icons/social_A.png": "5fd75caa9b427e70713980271e8ba531",
"assets/assets/icons/social_null.png": "e433c7a8e025dd2bd17290137dcd6ccb",
"assets/assets/icons/social_time/social_time_E.png": "dad6a10ba6d1135f500a81dfa84f4237",
"assets/assets/icons/social_time/social_time_B.png": "c5c22c53522df97340aa141962a05aef",
"assets/assets/icons/social_time/social_time_C.png": "95526b91a8d228886dd52cec688ec6a0",
"assets/assets/icons/social_time/social_time_D.png": "b42cb070a80bb9ff85f246d52c2efbe0",
"assets/assets/icons/social_time/social_time_A.png": "0b68fbb4e21ac2c7ac7f1acb3b191abb",
"assets/assets/icons/personal_fixed/personal_fixed_null.png": "769892c80e424cd87bb0c94e1646d8dd",
"assets/assets/icons/social_D.png": "426f936e50dbd1a4c2d4b4e453d8a261",
"assets/assets/icons/personal_C.png": "b7f902144c3946af2f8c30d2d2908aec",
"assets/assets/mobiscore/mobiscore_d.png": "e33cb4dd815ec435eeae534f8c2317ba",
"assets/assets/mobiscore/mobiscore_b.png": "db7cc60e3233ec7b2b4253bee55cd96b",
"assets/assets/mobiscore/mobiscore_c.png": "d9f500868f23e929e1fd514429e829d2",
"assets/assets/mobiscore/mobiscore_e.png": "cbe536d84808f466665374a00f9711c2",
"assets/assets/mobiscore/mobiscore_a.png": "d77320c00940e05eb41686992c90c0ce",
"assets/assets/mcube_logos/mcube_logo_with_text_white_en.png": "d2b7ea0a90f159b5828ec6b5d6dff4b1",
"assets/assets/mcube_logos/mobiscore_logo.png": "7135287a668cd56535887f87fce1c743",
"assets/assets/mcube_logos/mcube_logo_with_text_blue_de.png": "6a587de63501ae87300c5dbfc0b8d6b1",
"assets/assets/mcube_logos/mcube_logo_grey.png": "926b8edf5f24a55864a497fbbf831863",
"assets/assets/mcube_logos/mcube_logo.png": "3796a80be29056e3102f83ed90d0768a",
"assets/assets/mcube_logos/mcube_logo_with_text_black_en.png": "d651323ab2d3676dd90aed47271b6e6e",
"assets/assets/mcube_logos/mcube_logo_with_text_black_de.png": "49a33d4e6c32960665b711e6832dd891",
"assets/assets/mcube_logos/mcube_logo_with_text_blue_en.png": "ef6ca3ff84df4b3b620797ce5828d87e",
"assets/assets/mobiscore_logos/logo_with_text_primary.png": "0bb99d55200ee603e4e3891ccd1b9c68",
"assets/assets/mobiscore_logos/logo_white.png": "535065a8e44c83146564914db0c1e153",
"assets/assets/mobiscore_logos/logo_primary.png": "0488e6854fb71d0e558845fe61bda6e3",
"assets/assets/mobiscore_logos/logo_with_text_white.png": "14df3e64180628d5e99d366d0f4b80cc",
"assets/assets/mobiscore_logos/logo_black.png": "d382cbd0261044d48893ffe6a753e702",
"assets/assets/mobiscore_logos/logo_with_text_black.png": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/flags/flag_us.png": "163a7676b718218ef1ed6f431c9b0c0e",
"assets/assets/flags/flag_de.png": "9ca1aad0b74d2c0e6421bcd2b24ea68c",
"assets/assets/title_image/mobiscore_header_1.png": "d1d06765c70554b100b9a8a24b94d1b4",
"assets/assets/title_image/mobiscore_header_1.jpg": "71540336daa9ae9a1b801f63c27082b1",
"assets/assets/title_image/titelbild_ubahn.png": "506c5b280ac7428b3290b5ff36442c45",
"assets/assets/title_image/mcube_team_image.jpg": "94b5876bf971ad39898b6f1449bb4f95",
"assets/AssetManifest.bin.json": "ed9449dd601ec4e9ea3dd1a5a36548b7",
"assets/lib/l10n/app_localizations.dart": "fecae5b20e748c61ff585b18d7eb8c61",
"assets/lib/l10n/app_localizations_de.dart": "5f40053632134bd25f5a157ec1e5af44",
"assets/lib/l10n/app_en.arb": "93fcb231baa99223b3d2e8eeb547a55e",
"assets/lib/l10n/app_localizations_en.dart": "b313fef049532240b826f59be8861a79",
"assets/lib/l10n/app_de.arb": "200ce5cbda3e916095ca5248a99ac0c9",
"assets/fonts/MaterialIcons-Regular.otf": "2365babe7f513b619ce07be9a16f80be",
"assets/AssetManifest.bin": "d13d1e2a1fed8105fdd7af3adadabfbf",
"assets/NOTICES": "134291800c4cd7cd1e1bce5da6ce1cdd",
"assets/AssetManifest.json": "59b4ae466e0648af18ed160b85577262",
"icons/Icon-512.png": "c0808d10f4d260867f0a6975fefc9beb",
"icons/Icon-48.png.png": "c50db24086576417dbd3b5ba401926a7",
"icons/Icon-maskable-512.png": "c0808d10f4d260867f0a6975fefc9beb",
"icons/Icon-maskable-192.png": "ae514e7ebf6b301b107036972be7f3b7",
"icons/Icon-maskable-48.png.png": "c50db24086576417dbd3b5ba401926a7",
"icons/Icon-192.png": "ae514e7ebf6b301b107036972be7f3b7",
"flutter_bootstrap.js": "44443fe8539a5f80e254c5fd845952dd",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"index.html": "7f955f3f947619dc8f88dc9774798149",
"/": "7f955f3f947619dc8f88dc9774798149",
"main.dart.js": "272061e4cb9920bcb638402b4e4fe42c",
"favicon.png": "0488e6854fb71d0e558845fe61bda6e3",
"manifest.json": "01334291420899e99078f08492363951",
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
