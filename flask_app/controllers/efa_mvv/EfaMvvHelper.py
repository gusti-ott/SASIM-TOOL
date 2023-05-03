from dataclasses import dataclass
from enum import Enum, auto
from typing import List

import pandas as pd

from flask_app.model.entities.location.Location import Location
from flask_app.model.enums.mode.IndividualMode import IndividualMode
from flask_app.model.enums.mode.PublicTransportMode import PublicTransportMode
from flask_app.model.enums.tarif_zone.MvvTarifZone import MvvTarifZone


class PtSegmentType(Enum):
    INTERCHANGE = auto()
    WALK_THERE = auto()
    WALK_AWAY = auto()
    TRANSPORTATION = auto()


@dataclass
class EfaSegmentData:
    waypoints: List[Location]
    duration: float
    distance: float
    segment_type: PtSegmentType
    mode: PublicTransportMode or IndividualMode


@dataclass
class EfaTripData:
    efa_segments: List[EfaSegmentData]
    ticket_price: float
    from_tarif_zone: MvvTarifZone
    to_tarif_zone: MvvTarifZone
    total_duration: float


class EfaMvvHelper:

    def get_mode(self, mode_name: str) -> PublicTransportMode or IndividualMode:
        if (mode_name == 'U-Bahn'):
            mode = PublicTransportMode.METRO

        elif (mode_name == 'Tram'):
            mode = PublicTransportMode.TRAM

        elif (mode_name == 'Bus'):
            mode = PublicTransportMode.BUS

        elif (mode_name == 'S-Bahn' or mode_name == 'Bahn'):
            mode = PublicTransportMode.REGIONAL_TRAIN

        elif (mode_name == 'footway'):
            mode = IndividualMode.WALK
        else:
            print("MVG segment Typ " + str(mode_name) + " unbekannt")
            mode = None

        return mode

    def get_path_as_locations(self, path: List[List[float]]) -> List[Location]:
        df_path = pd.DataFrame(path)
        df_locations = df_path.apply(lambda x: Location(lat=x[0], lon=x[1]), axis=1)
        list_locations = df_locations.values.tolist()
        return list_locations
