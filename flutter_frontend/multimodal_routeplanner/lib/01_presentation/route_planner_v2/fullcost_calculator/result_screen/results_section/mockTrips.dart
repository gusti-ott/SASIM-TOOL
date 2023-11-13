// mock data for trips

import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/Costs.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/ExternalCosts.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/InternalCosts.dart';

Trip mock_trip1 = Trip(
  distance: 1.3,
  duration: 1.1,
  costs: Costs(
    internalCosts: InternalCosts(all: 2.5),
    externalCosts: ExternalCosts(
      air: 1.4,
      noise: 1.2,
      climate: 1.1,
      accidents: 1.1,
      space: 1.1,
      barrier: 1.1,
      congestion: 1.1,
      all: 5.5,
    ),
  ),
  segments: [],
  mode: 'CAR',
  mobiScore: 'D',
);

Trip mock_trip = Trip(
  distance: 1.5,
  duration: 1.2,
  costs: Costs(
    internalCosts: InternalCosts(all: 0.8),
    externalCosts: ExternalCosts(
      air: 0.4,
      noise: 5.2,
      climate: 0.1,
      accidents: 0.1,
      space: 0.1,
      barrier: 0.1,
      congestion: 0.1,
      all: 0.6,
    ),
  ),
  segments: [],
  mode: 'BICYCLE',
  mobiScore: 'B',
);

Trip trip3_trip = Trip(
  distance: 1.7,
  duration: 1.1,
  costs: Costs(
    internalCosts: InternalCosts(all: 3.7),
    externalCosts: ExternalCosts(
      air: 0.4,
      noise: 0.2,
      climate: 3.1,
      accidents: 0.1,
      space: 2.1,
      barrier: 0.1,
      congestion: 0.1,
      all: 0.1,
    ),
  ),
  segments: [],
  mode: 'PT',
  mobiScore: 'A',
);

Trip trip4_trip = Trip(
  distance: 1.6,
  duration: 0.9,
  costs: Costs(
    internalCosts: InternalCosts(all: 0.0),
    externalCosts: ExternalCosts(
      air: 2.4,
      noise: 0.2,
      climate: 0.1,
      accidents: 0.1,
      space: 0.1,
      barrier: 0.1,
      congestion: 0.1,
      all: 0.3,
    ),
  ),
  segments: [],
  mode: 'WALK',
  mobiScore: 'A',
);

// List<Trip> mockListTrips = [trip1, trip2, trip3, trip4];
