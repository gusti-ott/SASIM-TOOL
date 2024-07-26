import json
import time

import pandas as pd
import requests
from controllers.efa_mvv.EfaMvvHelper import EfaMvvHelper
from helpers.GeoHelper import GeoHelper
from model.entities.location.Location import Location
from model.enums.mode.TripMode import TripMode


class EfaMvvCoordController:

    def __init__(self):
        self.geo_helper = GeoHelper()
        self.efaMvvHelper = EfaMvvHelper()

    # input parameters
    # - location: Location (center of search radius - type Location, contains latitude and logitude variables)
    # - radius: int (search radius in meters)
    def get_response(self, location: Location, quick_response: bool, radius: int = 1000) -> json:

        start = time.time()

        if not quick_response:
            url = 'BASE_URL/MVV_API_COORDS_PATH/ 
                   
                   
                  '1&coordRadius=' + str(location.lon) + ':' + str(location.lat) + ':WGS84[dd.ddddd]:' + str(
                radius) + '&vehSR=1'

        else:
            url = ('BASE_URL/MVV_API_COORDS_PATH/'
                   ''
                   ***REMOVED***
                location.lon) + ':' + str(location.lat) + ':WGS84[dd.ddddd]:' + str(radius) + '&vehSR=1'

        response = requests.get(url)
        print("Efa MVV API Coord response: " + str(response))
        end = time.time()
        print("Efa MVV API Coord time: " + str(end - start))
        response = response.json()

        return response

    def get_closest_vehicles_each(self, response, my_location: Location) -> pd.DataFrame:

        pins = response.get('pins')
        df_closest_vehicles = pd.DataFrame(columns=['vehicle_location', 'mode', 'distance'])

        if pins is not None:
            for i in range(len(pins)):

                mode = pins[i].get('type')
                coords = pins[i].get('coords')
                coords_array = coords.split(',')
                location_new = Location(lat=float(coords_array[1]), lon=float(coords_array[0]))

                # print(location_list)
                if (mode not in df_closest_vehicles['mode'].unique()):
                    distance = self.geo_helper.get_distance(my_location, location_new)
                    dict_location = {'vehicle_location': location_new, 'mode': mode, 'distance': distance}
                    df_closest_vehicles.loc[len(df_closest_vehicles)] = dict_location

                if (mode in df_closest_vehicles['mode'].unique()):

                    distance_old = df_closest_vehicles.loc[df_closest_vehicles['mode'] == mode, 'distance'].iloc[0]
                    distance_new = self.geo_helper.get_distance(my_location, location_new)

                    if (distance_new < distance_old):
                        # print('its closer! Old ' + str(mode) + ' is ' + str(distance_old) + ' m away and new is ' + str(distance_new) + ' m away')
                        df_closest_vehicles.loc[
                            df_closest_vehicles['mode'] == mode, ['vehicle_location', 'mode', 'distance']] = [
                            location_new, mode, distance_new]

        return df_closest_vehicles

    def get_location_closest_vehicle_single(self, df_vehicles: pd.DataFrame, trip_mode: TripMode):

        mode = self.efaMvvHelper.trip_mode_to_efa_sharing_mode(trip_mode)
        vehicle_location = df_vehicles.loc[df_vehicles['mode'] == str(mode), 'vehicle_location'].values[0]
        return vehicle_location

# ### Example with Stop Finder & Coord
# # 1. Geocode address with Stop Finder
#
# efaMvvStopFinder = EfaMvvStopFinder()
# response = efaMvvStopFinder.get_response('Ansprengerstr.22, München')
# search_location = efaMvvStopFinder.get_location(response)
# # print(search_location)
#
# # 2. use location to find the closest sharing vehicles
# efaMvvCoordController = EfaMvvCoordController()
# response = efaMvvCoordController.get_response(search_location, radius=500)
# df_vehicles = efaMvvCoordController.get_closest_vehicles_each(response, search_location)
# # print(df_vehicles)
# vehicle_location = efaMvvCoordController.get_location_closest_vehicle_single(df_vehicles, TripMode.LIME)
# print(vehicle_location)
