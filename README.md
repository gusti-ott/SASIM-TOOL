# SASIM Web App

### Multimodal Route Planner with Full-Cost Insights

The SASIM Web App is a versatile tool for planning and comparing multimodal routes within the city of Munich. It helps users make informed decisions by highlighting the external costs associated with different transport modes, including private vehicles, shared mobility, and public transit. The app is part of the SASIM research project under the The Munich Cluster for the Future of Mobility in Metropolitan Regions (MCube) initiative.

Version: **1.1.0**  
Access the app: [https://sasim.mcube-cluster.de/](https://sasim.mcube-cluster.de/)

<img width="1277" alt="image" src="https://github.com/user-attachments/assets/5ff3be07-5462-4246-8218-b4c6dbad1985">

**Important Note:**  
While the code is open source, it is currently not possible to fully set up the project locally using the provided MVV EFA API, as this API is not publicly accessible. If you are interested in setting up the application for Munich or adapting it for another city, feel free to contact the SASIM team. Alternatively, you can replace the API with your local public transport provider’s API. The affected files can be found in the `flask_app/controllers/efa_mvv/` directory.

## Developer Guide

### Tech Stack

- **Backend**: Flask (Python)
- **Frontend**: Flutter (Dart)
- **Routing Engine**: Local OpenTripPlanner (OTP) instance for all non-public transport routes.
- **Geocoding**: [Komoot Photon API](https://photon.komoot.io/) for search suggestions.
- **Public Transit Routing**: [EFA MVV API](https://www.mvv-muenchen.de/fahrplanauskunft/fuer-entwickler/index.html) (not publicly accessible).
- **Mapping**: [OpenStreetMap](https://www.openstreetmap.org/) with the [FlutterMap library](https://pub.dev/packages/flutter_map).

### Local Setup Instructions

#### 1. Clone the Repository

```bash
git clone <repository-url>
cd sasim-web-app
```

#### 2. Create an Environment File

Copy the example file and fill in your values:

```bash
cp .env.example .env
```

Copy the example and fill in your values:

```bash
cp .env.example .env
```

Key variables to set:

```env
APP_BASE_URL=http://127.0.0.1:5000   # or your server URL for production
APP_BACKEND_PATH=platform
OTP_BASE_URL=http://localhost:8080    # or http://otp:8080 when using docker-compose
```

See [Environment Files](#environment-files) below if you want to maintain multiple env files.

#### 3. Build the Flutter Frontend

Navigate to the frontend directory and run the build script, which reads `APP_BASE_URL` and `APP_BACKEND_PATH` from the root `.env` automatically:

```bash
cd flutter_frontend/multimodal_routeplanner
bash build.sh
```

To build against a different environment file (e.g. staging):

```bash
ENV_FILE=../../.env.dev bash build.sh
```

The script handles localization generation, patching `index.html`, and copying the output to `flask_app/templates/`.

#### 4a. Run Locally Without Docker

Start the Flask server from the `flask_app` directory:

```bash
cd flask_app
python wsgi.py
```

OTP must be running separately. Before starting OTP, place both required data files in the `otp/` directory:

- **OSM `.pbf` file** — road network for your region (e.g. from [Geofabrik](https://download.geofabrik.de/))
- **GTFS file** — must be named **`gtfs.zip`** — public transit schedules for your region (e.g. from your local transit authority); required so OTP can determine the correct timezone. OTP 2.2.0 does not reliably detect GTFS feeds with other zip filenames.

The `.pbf` filename does not matter. For Munich/Oberbayern, download both directly into the `otp/` directory:

```bash
wget https://download.geofabrik.de/europe/germany/bayern/oberbayern-latest.osm.pbf -P otp/
wget https://www.mvg.de/static/gtfs/google_transit.zip -O otp/gtfs.zip
```

Then start OTP:

**First run — build and save the graph:**
```bash
docker run --rm -v $(pwd)/otp:/var/opentripplanner opentripplanner/opentripplanner:latest --build --save --serve
```

**Subsequent runs — load the saved graph:**
```bash
docker run --rm -v $(pwd)/otp:/var/opentripplanner -p 8080:8080 opentripplanner/opentripplanner:latest --load --serve
```

Once OTP and Flask are both running, the app is available at the URL defined in `APP_BASE_URL` in your env file.

#### 4b. Run Locally With Docker Compose

`docker-compose.local.yml` starts both the Flask app and OTP together, reading your root `.env`.

Before starting, place both required data files in the `otp/` directory:

- **OSM `.pbf` file** — road network for your region (e.g. from [Geofabrik](https://download.geofabrik.de/))
- **GTFS file** — must be named **`gtfs.zip`** — public transit schedules for your region (e.g. from your local transit authority); required so OTP can determine the correct timezone. OTP 2.2.0 does not reliably detect GTFS feeds with other zip filenames.

The `.pbf` filename does not matter. For Munich/Oberbayern, download both directly into the `otp/` directory:

```bash
wget https://download.geofabrik.de/europe/germany/bayern/oberbayern-latest.osm.pbf -P otp/
wget https://www.mvg.de/static/gtfs/google_transit.zip -O otp/gtfs.zip
```

**First run — build and save the OTP graph:**

Run OTP as a one-off to build `graph.obj` from the `.pbf` file and save it to the `otp/` directory:

```bash
docker compose -f docker-compose.local.yml run --rm otp --build --save
```

**Subsequent runs — load the saved graph:**

Start the full stack. OTP will load the existing `graph.obj` and the Flask app will be available at the URL defined in `APP_BASE_URL`:

```bash
docker compose -f docker-compose.local.yml up -d --build --remove-orphans
```

The `--build` flag rebuilds the Flask image to pick up any backend or template changes. The OTP graph does **not** need to be rebuilt unless you change the `.pbf` or GTFS data. The `--remove-orphans` flag cleans up containers for any services removed from the compose file.

To use a different env file (e.g. for a dev environment):

```bash
docker compose --env-file .env.dev -f docker-compose.local.yml up -d --build --remove-orphans
```

> Graph building can take several minutes depending on the size of the OSM data.
>
> OTP memory usage is controlled by `JAVA_TOOL_OPTIONS` in your `.env`. **`-Xmx4g` is the recommended minimum** for building the Oberbayern graph. If your server has less than 4 GB of available RAM, enable swap first to make up the difference:
> ```bash
> sudo fallocate -l 4G /swapfile
> sudo chmod 600 /swapfile
> sudo mkswap /swapfile
> sudo swapon /swapfile
> ```
> The graph build is the most memory-intensive step — once built, OTP uses significantly less memory in serve mode. Swap is only needed for the graph build and is lost on reboot, so if you ever need to rebuild the graph you will need to re-enable it.

---

### CI/CD

The GitHub Actions workflow (`.github/workflows/deploy.yml`) runs on every pull request and every merge to `main`:

- **On pull request** — runs two checks in parallel:
  - Flask backend syntax check
  - Flutter web build check
- **On merge to main** — runs the same checks, then builds Flutter with the production URL, patches `index.html`, and commits the output into `flask_app/templates/` with `[skip ci]` to avoid loops

`flask_app/templates/` is gitignored locally so you never accidentally commit build output yourself. On the server, a `git pull` after a merge will include the freshly built templates, and a `docker compose up` brings the new version live.

The following secrets must be set in GitHub (Settings → Secrets and variables → Actions):

| Secret | Description |
|---|---|
| `APP_BASE_URL` | Production URL of the app (e.g. `https://sasim.mcube-cluster.de`) |
| `APP_BACKEND_PATH` | Backend endpoint path (e.g. `platform`) |

---

### Environment Files

`.env.example` is the only env file committed to the repo. All others are gitignored.

By default, `build.sh` and `docker-compose.local.yml` read from `.env`. If you want to maintain multiple env files (e.g. one per environment), pass the path explicitly when building:

```bash
ENV_FILE=../../.env.dev bash build.sh
```

For `docker-compose.local.yml`, swap the `env_file` path in the file or copy your preferred env file to `.env` before running.

### Region-Specific Data

The `flask_app/db` directory contains region-specific constants and MobiScore values. If you are setting up the project for a different city, these values can be recalculated based on the methodology outlined in the paper:  
**Ending the Myth of Mobility at Zero Costs: An External Cost Analysis**  
[https://linkinghub.elsevier.com/retrieve/pii/S0739885922000713](https://linkinghub.elsevier.com/retrieve/pii/S0739885922000713)

## Contributors

### Project Partners

Key partners include:
- Bavarian Ministry of Housing, Construction and Transport
- MVV
- TUM
- Mobility Department of the City of Munich

### Individual Contributors

- **Design**: [Anelli Studio](https://anelli.studio/)
- **Illustrations**: [Chiara Vercesi](https://www.chiaravercesi.com/)
- **Development**: [Gusztáv Ottrubay](https://github.com/gusti-ott)

## API Usage

This project relies on the following APIs and services:

- **[Komoot Photon API](https://photon.komoot.io/)**: For geocoding and search suggestions.
- **[EFA MVV API](https://www.mvv-muenchen.de/fahrplanauskunft/fuer-entwickler/index.html)**: For public transport routing.
- **[OpenStreetMap](https://www.openstreetmap.org/)**: Integrated via the **[FlutterMap](https://pub.dev/packages/flutter_map)** library.

Please ensure compliance with the terms of use for each service.

## License

This project is licensed under the **MIT License**. See the `LICENSE` file for more information.

## Contact

For support or questions, please contact:  
**sasim@mcube-cluster.com**
