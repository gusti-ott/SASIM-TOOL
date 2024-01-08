from dataclasses import dataclass
from enum import Enum, auto
from typing import List
import logging

import pandas as pd
from model.entities.location.Location import Location
from model.enums.mode.IndividualMode import IndividualMode
from model.enums.mode.PublicTransportMode import PublicTransportMode
from model.enums.mode.TripMode import TripMode
from model.enums.tarif_zone.MvvTarifZone import MvvTarifZone


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

        elif (mode_name == 'Bus' or mode_name == 'MetroBus'):
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

    def efa_sharing_mode_to_trip_mode(self, mode: str) -> TripMode or None:
        if (mode == 'CALL_A_BIKE'):
            return TripMode.CAB

        elif (mode == 'SHARE NOW'):
            return TripMode.SHARENOW

        elif (mode == 'Emmy'):
            return TripMode.EMMY

        elif (mode == 'MILES Mobility'):
            return TripMode.MILES

        elif (mode == 'MVG Rad'):
            return TripMode.MVG_BIKE

        elif (mode == 'Lime'):
            return TripMode.LIME

        elif (mode == 'TIER e-scooter'):
            return TripMode.TIER

        elif (mode == 'TIER e-bike'):
            return TripMode.TIER_EBIKE

        else:
            return None

    def trip_mode_to_efa_sharing_mode(self, trip_mode: TripMode) -> str or None:
        if (trip_mode.value == TripMode.CAB.value):
            return 'CALL_A_BIKE'

        elif (trip_mode.value == TripMode.SHARENOW.value):
            return 'SHARE NOW'

        elif (trip_mode.value == TripMode.EMMY.value):
            return 'Emmy'

        elif (trip_mode.value == TripMode.MILES.value):
            return 'MILES Mobility'

        elif (trip_mode.value == TripMode.MVG_BIKE.value):
            return 'MVG Rad'

        elif (trip_mode.value == TripMode.LIME.value):
            return 'Lime'

        elif (trip_mode.value == TripMode.TIER.value):
            return 'TIER e-scooter'

        elif (trip_mode.value == TripMode.TIER_EBIKE.value):
            return 'TIER e-bike'

        else:
            return None
