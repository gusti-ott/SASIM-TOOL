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

---

## A) Deployment with Docker Compose

### 1. Clone the Repository

```bash
git clone <repository-url>
cd SASIM-TOOL
```

### 2. Configure Environment

Copy the example file and fill in your values:

```bash
cp .env.example .env
```

> ⚠️ The MVV API credentials (`MVV_API_*`) are confidential and not publicly accessible. Without them the app will not function. Contact the SASIM team at **sasim@mcube-cluster.com** to obtain access, or replace the MVV integration with your own public transport API (see `flask_app/controllers/efa_mvv/`).

| Variable | Description |
|---|---|
| `APP_BASE_URL` | URL the app is served at (e.g. `https://sasim.mcube-cluster.de`) |
| `APP_BACKEND_PATH` | Backend endpoint path — set to `platform` |
| `OTP_BASE_URL` | OTP instance URL — use `http://otp:8080` when running via Docker Compose |
| `OTP_ROUTE_PATH` | OTP routing path — set to `otp/routers/default/plan` |
| `OTP_ENDPOINT_PATH` | A random path that creates a dedicated OTP endpoint in the Flask app |
| `JAVA_TOOL_OPTIONS` | JVM memory for OTP — `-Xmx4g` recommended minimum |
| `MVV_API_BASE_URL` | Confidential — contact the SASIM team |
| `MVV_API_STOP_FINDER_PATH` | Confidential — contact the SASIM team |
| `MVV_API_STOP_FINDER_PATH_COORD` | Confidential — contact the SASIM team |
| `MVV_API_COORDS_PATH` | Confidential — contact the SASIM team |
| `MVV_API_COORDS_PATH_QUICK` | Confidential — contact the SASIM team |
| `MVV_API_ROUTE_PATH` | Confidential — contact the SASIM team |

### 3. Add OTP Data

Place both required files in the `otp/` directory. The `.pbf` filename does not matter, but the GTFS file **must be named `gtfs.zip`** — OTP 2.2.0 does not reliably detect GTFS feeds with other filenames.

For Munich/Oberbayern:

```bash
wget https://download.geofabrik.de/europe/germany/bayern/oberbayern-latest.osm.pbf -P otp/
wget https://www.mvg.de/static/gtfs/google_transit.zip -O otp/gtfs.zip
```

### 4. Build OTP Graph and Start

First, build and save the OTP graph (one-off, only needed when map data changes):

```bash
docker compose run --rm otp --build --save
```

> ℹ️ Graph building can take several minutes. `-Xmx4g` is the recommended minimum for `JAVA_TOOL_OPTIONS`. If your server has less than 4 GB of available RAM, enable swap before building:
> ```bash
> sudo fallocate -l 4G /swapfile
> sudo chmod 600 /swapfile
> sudo mkswap /swapfile
> sudo swapon /swapfile
> ```
> Swap is lost on reboot — re-enable it if you ever need to rebuild the graph.

Then start the full stack:

```bash
docker compose up -d --build --remove-orphans
```

The `--build` flag rebuilds the Flask image to pick up backend or template changes. The OTP graph does **not** need to be rebuilt unless the `.pbf` or GTFS data changes.

The app is now available at the URL defined in `APP_BASE_URL`.

To use a different env file (e.g. for staging):

```bash
docker compose --env-file .env.staging up -d --build --remove-orphans
```

---

## B) Local Development

### Running Locally

**1. OTP** — run OTP locally using the Docker image. Place the `.pbf` and `gtfs.zip` files in the `otp/` directory and refer to the [OTP 2.2.0 documentation](https://docs.opentripplanner.org/en/v2.2.0/) and [container image docs](https://docs.opentripplanner.org/en/v2.2.0/Container-Image/) for setup.

**2. Flutter frontend** — if you made frontend changes, rebuild before running Flask:

```bash
cd flutter_frontend/multimodal_routeplanner
bash build.sh
```

The script reads `APP_BASE_URL` and `APP_BACKEND_PATH` from the root `.env`, builds Flutter web, patches `index.html`, and copies the output to `flask_app/templates/`. To use a different env file:

```bash
ENV_FILE=../../.env.dev bash build.sh
```

**3. Flask backend** — start the Flask server from the `flask_app` directory:

```bash
cd flask_app
python wsgi.py
```

### CI/CD

The GitHub Actions workflow (`.github/workflows/deploy.yml`) automates build checks and deployment:

- **On pull request to main** — runs two checks in parallel:
  - Flask backend syntax check
  - Flutter web build check
- **On merge to main** — runs the same checks, then builds Flutter with the production URL, patches `index.html`, and commits the output into `flask_app/templates/` with `[skip ci]` to avoid loops

`flask_app/templates/` and Flutter build output are gitignored locally — you never need to commit them manually. After a merge, the server just needs `git pull` + `docker compose up` to pick up the new build.

The following secrets must be configured in GitHub (Settings → Secrets and variables → Actions) and correspond to the same variables in your `.env`:

| Secret | Description |
|---|---|
| `APP_BASE_URL` | Production URL (e.g. `https://sasim.mcube-cluster.de`) |
| `APP_BACKEND_PATH` | Backend endpoint path (e.g. `platform`) |

---

## Region-Specific Data

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
