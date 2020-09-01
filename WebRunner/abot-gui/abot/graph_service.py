from pymongo import MongoClient  # import mongo client to connect
from bson.json_util import dumps, loads
from flask import jsonify
from datetime import datetime, timedelta
from bson.objectid import ObjectId
import json
import datetime

interval_in_milliseconds = 1000.0000
# Creating instance of mongoclient
client = MongoClient('localhost', 27017)
# Creating/switching database
db = client.abot


def packet_counters():
    global db
    # Creating/reading document
    packet_counters = db.abot_packet_counters
    # Fetching data
    try:
        packet_counters_rows = packet_counters.find()
        json_string = dumps(packet_counters_rows)
        if json_string is None or json_string == '[]':
            return None
        json_data = loads(json_string)
        messages = []
        counts = []
        for data in json_data:
            messages.append(data['message_name'])
            counts.append(data['count'])
        response = {}
        response['messages'] = messages
        response['counts'] = counts
        return dumps(response)

    except Exception:
        return None


def transaction_counts():
    global interval_in_milliseconds
    global db
    current_timestamp = datetime.datetime.now()
    time_delta = timedelta(milliseconds=interval_in_milliseconds)
    current_timestamp_objectid = ObjectId.from_datetime(current_timestamp)
    previous_timestamp_objectid = ObjectId.from_datetime(
        current_timestamp - time_delta)
    # transaction_counts = db.abot_transaction_counters.aggregate([{'$match': {'_id': {'$lt': current_timestamp_objectid, '$gt': previous_timestamp_objectid}}}, {
                                                                # '$group': {'_id': 'null', 'average': {'$avg': '$count'}, 'total': {'$sum': '$count'}}}])
    s1ap_transaction_counts = db.abot_transaction_counters.aggregate([{'$match': {'_id': {'$lt': current_timestamp_objectid, '$gt': previous_timestamp_objectid}, 'counter': {
                                                                      '$regex': 'S1AP'}}}, {'$group': {'_id': 'null', 'average': {'$avg': '$count'}, 'total': {'$sum': '$count'}}}])
    gtpv1u_transaction_counts = db.abot_transaction_counters.aggregate([{'$match': {'_id': {'$lt': current_timestamp_objectid, '$gt': previous_timestamp_objectid}, 'counter': {
                                                                      '$regex': 'GTPV1U'}}}, {'$group': {'_id': 'null', 'average': {'$avg': '$count'}, 'total': {'$sum': '$count'}}}])
    gtpv2c_transaction_counts = db.abot_transaction_counters.aggregate([{'$match': {'_id': {'$lt': current_timestamp_objectid, '$gt': previous_timestamp_objectid}, 'counter': {
                                                                      '$regex': 'GTPV2C'}}}, {'$group': {'_id': 'null', 'average': {'$avg': '$count'}, 'total': {'$sum': '$count'}}}])
    s1ap_tc = loads(dumps(s1ap_transaction_counts))
    gtpv1u_tc = loads(dumps(gtpv1u_transaction_counts))
    gtpv2c_tc = loads(dumps(gtpv2c_transaction_counts))
    response = {}
        
    response['s1ap'] = 0
    response['gtpv1u'] = 0
    response['gtpv2c'] = 0

    if len(s1ap_tc) > 0:
        response['s1ap'] = dumps(s1ap_tc[0]['average'])

    if len(gtpv1u_tc) > 0:
        response['gtpv1u'] = dumps(gtpv1u_tc[0]['average'])

    if len(gtpv2c_tc) > 0:
        response['gtpv2c'] = dumps(gtpv2c_tc[0]['average'])
    return dumps(response)


def procedure_completions():
    global interval_in_milliseconds
    global db
    current_timestamp = datetime.datetime.now()
    time_delta = timedelta(milliseconds=interval_in_milliseconds)
    current_timestamp_objectid = ObjectId.from_datetime(current_timestamp)
    previous_timestamp_objectid = ObjectId.from_datetime(
        current_timestamp - time_delta)
    procedures_counts = db.abot_procedure_counters.aggregate([{'$match': {'_id': {'$lt': current_timestamp_objectid, '$gt': previous_timestamp_objectid}}}, {
                                                             '$group': {'_id': 'null', 'total': {'$sum': '$count'}}}])
    tc = loads(dumps(procedures_counts))
    if len(tc) > 0:
        d = dumps(tc[0]['total'])
        return d
    return dumps(0)


def uplink_downlink_bandwidth():
    global interval_in_milliseconds
    global db
    current_timestamp = datetime.datetime.now()
    time_delta = timedelta(milliseconds=interval_in_milliseconds)
    current_timestamp_objectid = ObjectId.from_datetime(current_timestamp)
    previous_timestamp_objectid = ObjectId.from_datetime(
        current_timestamp - time_delta)
    s1ap_downlink_bandwidth_coursor = db.abot_transaction_counters.aggregate([{'$match': {'_id': {'$lt': current_timestamp_objectid, '$gt': previous_timestamp_objectid}, 'counter': {
                                                                        '$eq': 'S1AP_recv'}}}, {'$group': {'_id': 'null', 'total': {'$sum': '$bytes'}}}])
    s1ap_uplink_bandwidth_coursor = db.abot_transaction_counters.aggregate([{'$match': {'_id': {'$lt': current_timestamp_objectid, '$gt': previous_timestamp_objectid}, 'counter': {
                                                                      '$eq': 'S1AP_send'}}}, {'$group': {'_id': 'null', 'total': {'$sum': '$bytes'}}}])

    gtpv1u_downlink_bandwidth_coursor = db.abot_transaction_counters.aggregate([{'$match': {'_id': {'$lt': current_timestamp_objectid, '$gt': previous_timestamp_objectid}, 'counter': {
                                                                        '$eq': 'GTPV1U_recv'}}}, {'$group': {'_id': 'null', 'total': {'$sum': '$bytes'}}}])
    gtpv1u_uplink_bandwidth_coursor = db.abot_transaction_counters.aggregate([{'$match': {'_id': {'$lt': current_timestamp_objectid, '$gt': previous_timestamp_objectid}, 'counter': {
                                                                      '$eq': 'GTPV1U_send'}}}, {'$group': {'_id': 'null', 'total': {'$sum': '$bytes'}}}])
    
    gtpv2c_downlink_bandwidth_coursor = db.abot_transaction_counters.aggregate([{'$match': {'_id': {'$lt': current_timestamp_objectid, '$gt': previous_timestamp_objectid}, 'counter': {
                                                                        '$eq': 'GTPV2C_recv'}}}, {'$group': {'_id': 'null', 'total': {'$sum': '$bytes'}}}])
    gtpv2c_uplink_bandwidth_coursor = db.abot_transaction_counters.aggregate([{'$match': {'_id': {'$lt': current_timestamp_objectid, '$gt': previous_timestamp_objectid}, 'counter': {
                                                                      '$eq': 'GTPV2C_send'}}}, {'$group': {'_id': 'null', 'total': {'$sum': '$bytes'}}}])
    
    s1ap_downlink_bandwidth = loads(dumps(s1ap_downlink_bandwidth_coursor))
    s1ap_uplink_bandwidth = loads(dumps(s1ap_uplink_bandwidth_coursor))

    gtpv1u_downlink_bandwidth = loads(dumps(gtpv1u_downlink_bandwidth_coursor))
    gtpv1u_uplink_bandwidth = loads(dumps(gtpv1u_uplink_bandwidth_coursor))
    
    gtpv2c_downlink_bandwidth = loads(dumps(gtpv2c_downlink_bandwidth_coursor))
    gtpv2c_uplink_bandwidth = loads(dumps(gtpv2c_uplink_bandwidth_coursor))
    
    s1ap_response_map = {}
    s1ap_response_map['uplink'] = 0
    s1ap_response_map['downlink'] = 0
    if len(s1ap_downlink_bandwidth) > 0:
        s1ap_response_map['downlink'] = dumps(s1ap_downlink_bandwidth[0]['total'])
    if len(s1ap_uplink_bandwidth) > 0:
        s1ap_response_map['uplink'] = dumps(s1ap_uplink_bandwidth[0]['total'])
    
    gtpv1u_response_map = {}
    gtpv1u_response_map['uplink'] = 0
    gtpv1u_response_map['downlink'] = 0
    if len(gtpv1u_downlink_bandwidth) > 0:
        gtpv1u_response_map['downlink'] = dumps(gtpv1u_downlink_bandwidth[0]['total'])
    if len(gtpv1u_uplink_bandwidth) > 0:
        gtpv1u_response_map['uplink'] = dumps(gtpv1u_uplink_bandwidth[0]['total'])

    gtpv2c_response_map = {}
    gtpv2c_response_map['uplink'] = 0
    gtpv2c_response_map['downlink'] = 0
    if len(gtpv2c_downlink_bandwidth) > 0:
        gtpv2c_response_map['downlink'] = dumps(gtpv2c_downlink_bandwidth[0]['total'])
    if len(gtpv2c_uplink_bandwidth) > 0:
        gtpv2c_response_map['uplink'] = dumps(gtpv2c_uplink_bandwidth[0]['total'])
    
    response = {}
    response['s1ap'] = s1ap_response_map
    response['gtpv1u'] = gtpv1u_response_map
    response['gtpv2c'] = gtpv2c_response_map
    return dumps(response)
