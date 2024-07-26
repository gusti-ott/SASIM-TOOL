import json
import os
import time
from datetime import datetime
from typing import List

import requests
from controllers.efa_mvv.EfaMvvHelper import EfaMvvHelper, EfaTripData, EfaSegmentData, PtSegmentType
from controllers.mvv.MvvHelper import MvvSegmentData
from helpers.GeoHelper import GeoHelper
from model.enums.mode.IndividualMode import IndividualMode


class EfaMvvRouteController:

    def __init__(self):
        self._efa_mvv_helper = EfaMvvHelper()
        self._geo_helper = GeoHelper()
        self.base_url = os.getenv('MVV_API_BASE_URL')
        self.path = os.getenv('MVV_API_ROUTE_PATH')

    def get_response(self, start_id: str, end_id: str) -> json:
        start = time.time()

        url = self.base_url + self.path + start_id + '&name_destination=' + end_id

        response = requests.get(url)
        print("Efa MVV API Trip response: " + str(response))
        end = time.time()
        print("Efa MVV API Trip time:  " + str(end - start))
        response = response.json()

        return response

    def get_mvv_trip_data(self, response) -> EfaTripData:

        efa_trip = response.get('journeys')[0]
        efa_legs = response.get('journeys')[0].get('legs')

        segments: List[MvvSegmentData] = []

        # loop over whole set of trip
        for i in range(len(efa_legs)):

            leg_mode = efa_legs[i].get('transportation').get('product').get('name')

            if (leg_mode != 'footpath'):
                # 1. create pt segment
                pt_mode = self._efa_mvv_helper.get_mode(
                    mode_name=efa_legs[i].get('transportation').get('product').get('name'))
                pt_waypoints = self._efa_mvv_helper.get_path_as_locations(efa_legs[i].get('coords'))
                pt_distance = self._geo_helper.calculate_total_distance_from_location_list(pt_waypoints)

                if (efa_legs[i].get('interchange') != None):
                    # 2. create interchange segment
                    interchange_mode = IndividualMode.WALK
                    interchange_waypoints = self._efa_mvv_helper.get_path_as_locations(
                        efa_legs[i].get('interchange').get('coords'))

                    interchange_duration = efa_legs[i].get('footPathInfo')[0].get('duration') / 60
                    interchange_distance = self._geo_helper.calculate_total_distance_from_location_list(
                        interchange_waypoints)

                    # duration != sum of ride times because there is also waiting time ...
                    pt_duration = (efa_legs[i].get('duration') / 60)

                    interchange_segment = EfaSegmentData(waypoints=interchange_waypoints, duration=interchange_duration,
                                                         distance=interchange_distance,
                                                         segment_type=PtSegmentType.INTERCHANGE,
                                                         mode=interchange_mode)

                    if (efa_legs[i].get('footPathInfo')[0].get('position') == 'BEFORE'):
                        segments.append(interchange_segment)

                    pt_segment = EfaSegmentData(waypoints=pt_waypoints, duration=pt_duration, distance=pt_distance,
                                                segment_type=PtSegmentType.TRANSPORTATION, mode=pt_mode)
                    segments.append(pt_segment)

                    if (efa_legs[i].get('footPathInfo')[0].get('position') == 'AFTER'):
                        segments.append(interchange_segment)





                else:
                    pt_duration = (efa_legs[i].get('duration') / 60)
                    pt_segment = EfaSegmentData(waypoints=pt_waypoints, duration=pt_duration, distance=pt_distance,
                                                segment_type=PtSegmentType.TRANSPORTATION, mode=pt_mode)
                    segments.append(pt_segment)

            else:
                mode = IndividualMode.WALK
                waypoints = self._efa_mvv_helper.get_path_as_locations(efa_legs[i].get('coords'))
                distance = efa_legs[i].get('distance')
                if (distance == None):
                    distance = self._geo_helper.calculate_total_distance_from_location_list(waypoints)
                duration = efa_legs[i].get('duration') / 60

                if (i == 0):
                    segment_type = PtSegmentType.WALK_THERE
                else:
                    segment_type = PtSegmentType.WALK_AWAY

                segment = EfaSegmentData(waypoints=waypoints, duration=duration, distance=distance,
                                         segment_type=segment_type, mode=mode)
                segments.append(segment)

        # second [1] entry in api response is the single ticket
        ticket_price = efa_trip.get('fare').get('tickets')[1].get('priceBrutto')
        from_tarif_zone = efa_trip.get('fare').get('zones')[0].get('fromLeg')
        to_tarif_zone = efa_trip.get('fare').get('zones')[0].get('toLeg')

        # calculate total trip duration
        departure_time_string = efa_legs[0].get('origin').get('departureTimePlanned')
        arrival_time_string = efa_legs[-1].get('destination').get('arrivalTimePlanned')

        datetime_format = '%Y-%m-%dT%H:%M:%SZ'
        departure_time = datetime.strptime(departure_time_string, datetime_format)
        arrival_time = datetime.strptime(arrival_time_string, datetime_format)
        total_duration = (arrival_time - departure_time).total_seconds() / 60

        efa_trip_data = EfaTripData(efa_segments=segments, ticket_price=ticket_price, from_tarif_zone=from_tarif_zone,
                                    to_tarif_zone=to_tarif_zone, total_duration=total_duration)

        return efa_trip_data

# # Testing
# efaMvvTripController = EfaMvvRouteController()
# start_id ='streetID:1500002452:52:9162000:-1:Meggendorferstraße:München:Meggendorferstraße::Meggendorferstraße:80992:ANY:DIVA_SINGLEHOUSE:1283172:5863105:MRCV:BAY'
# end_id = 'streetID:1500004516:47:9162000:-1:Warngauer Straße:München:Warngauer Straße::Warngauer Straße:81539:ANY:DIVA_SINGLEHOUSE:1290289:5874258:MRCV:BAY'
# response = efaMvvTripController.get_response(start_id=start_id, end_id=end_id)
# trip = efaMvvTripController.get_mvv_trip_data(response)
#
# print(trip)
