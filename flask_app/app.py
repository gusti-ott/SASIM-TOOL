import csv
import os
from datetime import datetime

from apscheduler.schedulers.background import BackgroundScheduler
from flask import Flask, request, redirect, jsonify
from flask import render_template
from flask import send_from_directory
from flask_caching import Cache
from flask_cors import CORS

from controllers.efa_mvv.EfaMvvCoordController import EfaMvvCoordController
from controllers.efa_mvv.EfaMvvStopFinderController import EfaMvvStopFinder
from controllers.geocoding.GeocodingController import GeocodingController
from controllers.trip.TripController import TripController
from controllers.otp.OtpController import OtpController
from config.definitions import ROOT_DIR
from helpers.ApiHelper import ApiHelper
from model.entities.location.Location import Location
from model.entities.segment.Segment import Segment

config = {
    "DEBUG": True,  # some Flask specific configs
    "CACHE_TYPE": "SimpleCache",  # Flask-Caching related configs
    "CACHE_DEFAULT_TIMEOUT": 300
}

server = Flask(__name__)

server.config.from_mapping(config)
cache = Cache(server)
CORS(server)

FLUTTER_WEB_APP = 'templates'

# In-memory storage for detailed logs and daily summary
detailed_logs = []
daily_summary = {
    "date": datetime.now().strftime('%Y-%m-%d'),
    "total_calls": 0,
    "successful_calls": 0,
    "error_calls": 0
}

# Scheduler for daily log writing task
scheduler = BackgroundScheduler()


@scheduler.scheduled_job('cron', minute=45)
def save_logs_to_csv():
    global detailed_logs, daily_summary

    tracking_dir_path = os.path.join(ROOT_DIR, 'tracking')
    detailed_log_path = os.path.join(ROOT_DIR, 'tracking', 'detailed_logs.csv')
    daily_summary_path = os.path.join(ROOT_DIR, 'tracking', 'daily_summary.csv')

    # Ensure 'tracking' directory exists
    if not os.path.exists(tracking_dir_path):
        os.makedirs(tracking_dir_path)

    # Write detailed logs to CSV file
    file_exists = os.path.isfile(detailed_log_path)

    with open(detailed_log_path, mode='a', newline='') as file:
        writer = csv.writer(file)
        if not file_exists:
            writer.writerow(['Date', 'Start Address', 'End Address', 'Mode', 'Success'])  # Write header only once
        for log in detailed_logs:
            writer.writerow([log['date'], log['start_address'], log['end_address'], log['mode'], log['success']])

    # Write daily summary to CSV file
    file_exists = os.path.isfile(daily_summary_path)

    with open(daily_summary_path, mode='a', newline='') as file:
        writer = csv.writer(file)
        if not file_exists:
            writer.writerow(['Date', 'Total Calls', 'Successful Calls', 'Error Calls'])  # Write header only once
        writer.writerow([daily_summary['date'], daily_summary['total_calls'], daily_summary['successful_calls'], daily_summary['error_calls']])

    # Reset in-memory logs for the next day
    detailed_logs = []
    daily_summary = {
        "date": datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
        "total_calls": 0,
        "successful_calls": 0,
        "error_calls": 0
    }
    print('Logs saved to CSV at ' + datetime.now().strftime('%Y-%m-%d %H:%M:%S'))


scheduler.start()


@server.route('/web/')
def render_page_web():
    return render_template('index.html')


@server.route('/')
def redirect_internally_to_page_web():
    return redirect('/web/', code=302)


@server.route('/web/<path:name>')
def return_flutter_doc(name):
    datalist = str(name).split('/')
    DIR_NAME = FLUTTER_WEB_APP

    if len(datalist) > 1:
        for i in range(0, len(datalist) - 1):
            DIR_NAME += '/' + datalist[i]

    return send_from_directory(DIR_NAME, datalist[-1])


@server.route('/', methods=['GET'])
def home_page():
    return render_page_web()


@server.route('/' + os.getenv('OTP_ENDPOINT_PATH'), methods=['GET'])
def return_otp_trip():
    otp_controller = OtpController()

    if request.method == 'OPTIONS':
        # CORS preflight request handler
        response = jsonify({'status': 'CORS preflight successful'})
        response.headers.add('Access-Control-Allow-Origin', '*')
        response.headers.add('Access-Control-Allow-Methods', 'GET, OPTIONS')
        response.headers.add('Access-Control-Allow-Headers', 'Content-Type, referrer-policy')
        return response

    input_start_coordinates = str(request.args['startCoordinates'])
    input_end_coordinates = str(request.args['endCoordinates'])
    input_otp_mode = str(request.args['otpMode'])

    response = otp_controller.get_response_from_coordinates(start_coordinates=input_start_coordinates,
                                                            end_coordinates=input_end_coordinates,
                                                            otp_mode=input_otp_mode)

    return response

@server.route('/plattform', methods=['GET'])
def return_trip():
    global daily_summary

    # increment for each call of this endpoint
    daily_summary['total_calls'] += 1

    if request.method == 'OPTIONS':
        # CORS preflight request handler
        response = jsonify({'status': 'CORS preflight successful'})
        response.headers.add('Access-Control-Allow-Origin', '*')
        response.headers.add('Access-Control-Allow-Methods', 'GET, OPTIONS')
        response.headers.add('Access-Control-Allow-Headers', 'Content-Type, referrer-policy')
        return response

    api_helper = ApiHelper()

    input_start_address = str(request.args['inputStartAddress'])
    input_end_address = str(request.args['inputEndAddress'])
    input_trip_mode = str(request.args['tripMode'])

    try:
        # start_location = get_geolocation(input_start_address)
        start_location_and_id = get_efa_geolocation(input_start_address)
        start_location = start_location_and_id[0]
        start_id = start_location_and_id[1]

        # end_location = get_geolocation(input_end_address)
        end_location_and_id = get_efa_geolocation(input_end_address)
        end_location = end_location_and_id[0]
        end_id = end_location_and_id[1]

        trip_mode = api_helper.get_trip_mode_from_input(input_trip_mode)
        quick_response_arg = request.args.get('quickResponse')
        if quick_response_arg is None or quick_response_arg.strip() == '':
            quick_response = False
        else:
            quick_response = quick_response_arg.lower() == 'true'

        df_sharing_vehicles = get_efa_sharing_vehicles(start_location, quick_response)

        trip_controller = TripController(df_sharing_vehicles)
        trip = trip_controller.get_trip(
            start_location=start_location,
            end_location=end_location,
            trip_mode=trip_mode,
            start_id=start_id,
            end_id=end_id,
            df_sharing_vehicels=df_sharing_vehicles
        )
        list_segments = []

        segments = trip.segments

        # if trip consists of multiple segments, iterate over segments to return a list of segments in the rest-api response
        if type(segments) == list:
            for j in range(len(trip.segments)):

                new_segment: Segment = trip.segments[j]
                segment_waypoints = []
                for k in range(len(new_segment.waypoints)):
                    lat = new_segment.waypoints[k].lat
                    lon = new_segment.waypoints[k].lon

                    dict_waypoint = {
                        'lat': float(lat),
                        'lon': float(lon)
                    }

                    segment_waypoints.append(dict_waypoint)

                dict_segment = {

                    'mode': new_segment.mode.value,
                    'distance': new_segment.distance,
                    'duration': new_segment.duration,
                    'costs': {
                        'externalCosts': {
                            'all': new_segment.costs.external_costs.external_costs,
                            'air': new_segment.costs.external_costs.air,
                            'noise': new_segment.costs.external_costs.noise,
                            'climate': new_segment.costs.external_costs.climate,
                            'accidents': new_segment.costs.external_costs.accidents,
                            'space': new_segment.costs.external_costs.space,
                            'barrier': trip.costs.external_costs.barrier,
                            'congestion': trip.costs.external_costs.congestion
                        },
                        'internalCosts': {
                            'all': new_segment.costs.internal_costs.variable + new_segment.costs.internal_costs.fixed,
                            'variable': new_segment.costs.internal_costs.variable,
                            'fixed': new_segment.costs.internal_costs.fixed}
                    },
                    'waypoints': segment_waypoints

                }

                list_segments.append(dict_segment)

        else:
            new_segment = segments

            segment_waypoints = []
            for k in range(len(new_segment.waypoints)):
                lat = new_segment.waypoints[k].lat
                lon = new_segment.waypoints[k].lon

                dict_waypoint = {
                    'lat': float(lat),
                    'lon': float(lon)
                }

                segment_waypoints.append(dict_waypoint)

            dict_segment = {

                'mode': new_segment.mode.value,
                'distance': new_segment.distance,
                'duration': new_segment.duration,
                'costs': {
                    'externalCosts': {
                        'all': new_segment.costs.external_costs.external_costs,
                        'air': new_segment.costs.external_costs.air,
                        'noise': new_segment.costs.external_costs.noise,
                        'climate': new_segment.costs.external_costs.climate,
                        'accidents': new_segment.costs.external_costs.accidents,
                        'space': new_segment.costs.external_costs.space,
                        'barrier': trip.costs.external_costs.barrier,
                        'congestion': trip.costs.external_costs.congestion
                    },
                    'internalCosts': {
                        'all': new_segment.costs.internal_costs.variable + new_segment.costs.variable.variable,
                        'variable': new_segment.costs.internal_costs.variable,
                        'fixed': new_segment.costs.internal_costs.fixed}
                },
                'waypoints': segment_waypoints

            }

            list_segments.append(dict_segment)

        dict_new_result = {
            'tripMode': trip_mode.value,
            'distance': trip.distance,
            'duration': trip.duration,
            'costs': {
                'externalCosts': {
                    'all': trip.costs.external_costs.external_costs,
                    'air': trip.costs.external_costs.air,
                    'noise': trip.costs.external_costs.noise,
                    'climate': trip.costs.external_costs.climate,
                    'accidents': trip.costs.external_costs.accidents,
                    'space': trip.costs.external_costs.space,
                    'barrier': trip.costs.external_costs.barrier,
                    'congestion': trip.costs.external_costs.congestion
                },
                'internalCosts': {'all': trip.costs.internal_costs.variable + trip.costs.internal_costs.fixed,
                                  'variable': trip.costs.internal_costs.variable,
                                  'fixed': trip.costs.internal_costs.fixed}

            },
            'mobiScore': trip.mobi_score.value,
            'segments': list_segments

        }

        response = jsonify(dict_new_result)
        response.headers.add('Access-Control-Allow-Origin', '*')

        daily_summary['successful_calls'] += 1

        log_entry = {
            "date": datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
            "start_address": input_start_address,
            "end_address": input_end_address,
            "mode": input_trip_mode,
            "success": "true"
        }
        detailed_logs.append(log_entry)

        return response

    except Exception as e:
        daily_summary['error_calls'] += 1
        log_entry = {
            "date": datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
            "start_address": input_start_address,
            "end_address": input_end_address,
            "mode": input_trip_mode,
            "success": "false"
        }
        detailed_logs.append(log_entry)


@cache.memoize(300)
def get_geolocation(address: str):
    geocoding_controller = GeocodingController()

    return geocoding_controller.get_location(address)


@cache.memoize(300)
def get_efa_geolocation(address: str):
    efa_stop_finder = EfaMvvStopFinder()
    response = efa_stop_finder.get_response(address=address)
    location = efa_stop_finder.get_location(response=response)
    id = efa_stop_finder.get_efa_location_id(response=response)

    return location, id


@cache.memoize(300)
def get_efa_sharing_vehicles(start_address: Location, quick_response: bool):
    efa_coords_controller = EfaMvvCoordController()
    response = efa_coords_controller.get_response(start_address, quick_response)
    df_sharing_vehices = efa_coords_controller.get_closest_vehicles_each(response, start_address)

    return df_sharing_vehices
