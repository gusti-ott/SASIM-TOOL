from enum import Enum

class TripMode(Enum):
    CAR = 'CAR'
    ECAR = 'ECAR'
    MOPED = 'MOPED'
    EMOPED = 'EMOPED'
    BICYCLE = 'BICYCLE'
    EBICYCLE = 'EBICYCLE'
    WALK = 'WALK'

    EMMY = 'EMMY'
    TIER = 'TIER'
    CAB = 'CAB'
    FLINKSTER = 'FLINKSTER'
    SHARENOW = 'SHARENOW'

    # new since MENTZ API
    MILES = 'MILES'
    MVG_BIKE = 'MVG_BIKE'
    LIME = 'LIME'
    TIER_EBIKE = 'TIER_EBIKE'

    PT = 'PT'
    INTERMODAL_PT_BIKE = 'INTERMODAL_PT_BIKE'
