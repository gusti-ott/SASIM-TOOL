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

Follow these steps to set up and run the project locally:

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd sasim-web-app
   ```

2. **Create an Environment File**
   Add an `.env` file at the root of the project. Refer to the `.env.example` file in the `flask_app` folder.

3. **Prepare the Frontend**
   Navigate to the frontend directory:
   ```bash
   cd flutter_frontend/multimodal_routeplanner
   ```

   Generate localization files:
   ```bash
   flutter gen-l10n
   ```

   Build the web application:
   ```bash
   flutter build web --web-renderer canvaskit
   ```

4. **Update Build Configuration**
   Go to the `build/web` directory:
   ```bash
   cd build/web
   ```

   Modify the `index.html` file. Replace:
   ```html
   <base href="/">
   ```
   with:
   ```html
   <base href="/web/">
   ```

5. **Start the Backend**
   From the `flask_app` directory, launch the Flask server:
   ```bash
   python wsgi.py
   ```

### Region-Specific Data

The `flask_app/db` directory contains region-specific constants and MobiScore values. If you are setting up the project for a different city, these values can be recalculated based on the methodology outlined in the paper:  
**Ending the Myth of Mobility at Zero Costs: An External Cost Analysis**  
[https://linkinghub.elsevier.com/retrieve/pii/S0739885922000713](https://linkinghub.elsevier.com/retrieve/pii/S0739885922000713)

## Contributors

### Project Partners

Key partners include:
- Bavarian Ministry of Housing, Construction and Transport
- BMW Group
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
