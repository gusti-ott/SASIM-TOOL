import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en')
  ];

  /// No description provided for @that_are_the_true_costs_header.
  ///
  /// In en, this message translates to:
  /// **'These are the true costs of your mobility'**
  String get that_are_the_true_costs_header;

  /// No description provided for @these_are_external_costs.
  ///
  /// In en, this message translates to:
  /// **'These are the external costs of your route'**
  String get these_are_external_costs;

  /// No description provided for @what_is_mobi_score.
  ///
  /// In en, this message translates to:
  /// **'What is the Mobi-Score?'**
  String get what_is_mobi_score;

  /// No description provided for @calculator.
  ///
  /// In en, this message translates to:
  /// **'Calculator'**
  String get calculator;

  /// No description provided for @information.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get information;

  /// No description provided for @about_us.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get about_us;

  /// No description provided for @start_address.
  ///
  /// In en, this message translates to:
  /// **'Start Address'**
  String get start_address;

  /// No description provided for @end_address.
  ///
  /// In en, this message translates to:
  /// **'Destination Address'**
  String get end_address;

  /// No description provided for @please_insert_address.
  ///
  /// In en, this message translates to:
  /// **'Please insert address'**
  String get please_insert_address;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @from_hint.
  ///
  /// In en, this message translates to:
  /// **'From (e.g. Arcisstraße 21, München)'**
  String get from_hint;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @to_hint.
  ///
  /// In en, this message translates to:
  /// **'To (e.g. Ostbahnhof, München)'**
  String get to_hint;

  /// No description provided for @new_route.
  ///
  /// In en, this message translates to:
  /// **'New Route'**
  String get new_route;

  /// No description provided for @show_route.
  ///
  /// In en, this message translates to:
  /// **'Show Route'**
  String get show_route;

  /// No description provided for @car.
  ///
  /// In en, this message translates to:
  /// **'Car'**
  String get car;

  /// No description provided for @ecar.
  ///
  /// In en, this message translates to:
  /// **'Electric Car'**
  String get ecar;

  /// No description provided for @bike.
  ///
  /// In en, this message translates to:
  /// **'Bike'**
  String get bike;

  /// No description provided for @ebike.
  ///
  /// In en, this message translates to:
  /// **'Electric Bike'**
  String get ebike;

  /// No description provided for @moped.
  ///
  /// In en, this message translates to:
  /// **'Moped'**
  String get moped;

  /// No description provided for @e_moped.
  ///
  /// In en, this message translates to:
  /// **'Electric Moped'**
  String get e_moped;

  /// No description provided for @tier.
  ///
  /// In en, this message translates to:
  /// **'TIER E-Scooter'**
  String get tier;

  /// No description provided for @cab.
  ///
  /// In en, this message translates to:
  /// **'Call a Bike'**
  String get cab;

  /// No description provided for @flinkster.
  ///
  /// In en, this message translates to:
  /// **'Flinkster'**
  String get flinkster;

  /// No description provided for @emmy.
  ///
  /// In en, this message translates to:
  /// **'Emmy'**
  String get emmy;

  /// No description provided for @sharenow.
  ///
  /// In en, this message translates to:
  /// **'Sharenow'**
  String get sharenow;

  /// No description provided for @pt.
  ///
  /// In en, this message translates to:
  /// **'Public Transport'**
  String get pt;

  /// No description provided for @metro.
  ///
  /// In en, this message translates to:
  /// **'Metro'**
  String get metro;

  /// No description provided for @tram.
  ///
  /// In en, this message translates to:
  /// **'Tram'**
  String get tram;

  /// No description provided for @bus.
  ///
  /// In en, this message translates to:
  /// **'Bus'**
  String get bus;

  /// No description provided for @e_bus.
  ///
  /// In en, this message translates to:
  /// **'E-Bus'**
  String get e_bus;

  /// No description provided for @pt_and_bike.
  ///
  /// In en, this message translates to:
  /// **'Public Transport + Bike'**
  String get pt_and_bike;

  /// No description provided for @walk.
  ///
  /// In en, this message translates to:
  /// **'Walk'**
  String get walk;

  /// No description provided for @not_available.
  ///
  /// In en, this message translates to:
  /// **'Not Available'**
  String get not_available;

  /// No description provided for @description_fullcosts.
  ///
  /// In en, this message translates to:
  /// **'The total costs incurred when using a mode of transportation, including both direct and indirect costs such as fuel, maintenance, insurance, and environmental impacts.'**
  String get description_fullcosts;

  /// No description provided for @description_external_costs.
  ///
  /// In en, this message translates to:
  /// **'Costs incurred by using a mode of transportation but not directly borne by the users. These include environmental damage, health issues, and social costs.'**
  String get description_external_costs;

  /// No description provided for @description_internal_costs.
  ///
  /// In en, this message translates to:
  /// **'The direct costs borne by users of a mode of transportation, such as fuel costs, maintenance, and insurance.'**
  String get description_internal_costs;

  /// No description provided for @descripton_accidents.
  ///
  /// In en, this message translates to:
  /// **'Accident costs are the costs arising from personal injuries in accidents. Since physical damage to cars and infrastructure is predominantly covered by motor vehicle insurance or borne by the parties causing the damage, they are not considered here.'**
  String get descripton_accidents;

  /// No description provided for @description_air.
  ///
  /// In en, this message translates to:
  /// **'The calculation of air pollution costs includes various aspects. These include material damage, crop failure, biodiversity loss, and health damage caused by air pollution.'**
  String get description_air;

  /// No description provided for @description_noise.
  ///
  /// In en, this message translates to:
  /// **'The effects of noise are noticeable in various areas of life. Thus, traffic noise causes costs for a national economy in several respects.'**
  String get description_noise;

  /// No description provided for @description_space.
  ///
  /// In en, this message translates to:
  /// **'Transport uses land in two different traffic situations. Land is used for moving traffic via streets or rail systems. At the same time, vehicles that are not moved occupy space for parking.'**
  String get description_space;

  /// No description provided for @description_congestion.
  ///
  /// In en, this message translates to:
  /// **'Congestion is mostly known for blocked streets by cars and other road users. However, there are also a lot of congested public transport networks which lead to delays. For both cases, time is lost and thus costs are generated.'**
  String get description_congestion;

  /// No description provided for @description_barrier.
  ///
  /// In en, this message translates to:
  /// **'The barrier effect describes the time delay that motorized transport imposes on active mobility forms. This could be in the form of big streets pedestrians have to cross or circumvent to reach their destination.'**
  String get description_barrier;

  /// No description provided for @description_environment.
  ///
  /// In en, this message translates to:
  /// **'Costs due to environmental damage include all damages caused today and in the future by climate change, associated with uncertainties. They depend on the propulsion type of the vehicle and include costs from the operation of the vehicle as well as from the fuel and power production.'**
  String get description_environment;

  /// No description provided for @external_costs.
  ///
  /// In en, this message translates to:
  /// **'external costs'**
  String get external_costs;

  /// No description provided for @internal_costs.
  ///
  /// In en, this message translates to:
  /// **'internal costs'**
  String get internal_costs;

  /// No description provided for @fullcosts.
  ///
  /// In en, this message translates to:
  /// **'fullcosts'**
  String get fullcosts;

  /// No description provided for @accidents.
  ///
  /// In en, this message translates to:
  /// **'accidents'**
  String get accidents;

  /// No description provided for @air_pollution.
  ///
  /// In en, this message translates to:
  /// **'air pollution'**
  String get air_pollution;

  /// No description provided for @noise.
  ///
  /// In en, this message translates to:
  /// **'noise'**
  String get noise;

  /// No description provided for @space_use.
  ///
  /// In en, this message translates to:
  /// **'space use'**
  String get space_use;

  /// No description provided for @congestion.
  ///
  /// In en, this message translates to:
  /// **'congestion'**
  String get congestion;

  /// No description provided for @barrier_effects.
  ///
  /// In en, this message translates to:
  /// **'barrier effects'**
  String get barrier_effects;

  /// No description provided for @environmental_damages.
  ///
  /// In en, this message translates to:
  /// **'environmental\ndamages'**
  String get environmental_damages;

  /// No description provided for @mobi_score.
  ///
  /// In en, this message translates to:
  /// **'Mobi-Score'**
  String get mobi_score;

  /// No description provided for @header_external_costs.
  ///
  /// In en, this message translates to:
  /// **'External\nCosts'**
  String get header_external_costs;

  /// No description provided for @header_internal_costs.
  ///
  /// In en, this message translates to:
  /// **'Internal\nCosts'**
  String get header_internal_costs;

  /// No description provided for @header_fullcosts.
  ///
  /// In en, this message translates to:
  /// **'Full\nCosts'**
  String get header_fullcosts;

  /// No description provided for @header_mobi_score.
  ///
  /// In en, this message translates to:
  /// **'Mobi-\nScore'**
  String get header_mobi_score;

  /// No description provided for @something_went_wrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get something_went_wrong;

  /// No description provided for @please_try_again.
  ///
  /// In en, this message translates to:
  /// **'Please reload or select a different route.'**
  String get please_try_again;

  /// No description provided for @try_again.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get try_again;

  /// No description provided for @research.
  ///
  /// In en, this message translates to:
  /// **'Research'**
  String get research;

  /// No description provided for @by.
  ///
  /// In en, this message translates to:
  /// **'by'**
  String get by;

  /// No description provided for @de.
  ///
  /// In en, this message translates to:
  /// **'de'**
  String get de;

  /// No description provided for @en.
  ///
  /// In en, this message translates to:
  /// **'en'**
  String get en;

  /// No description provided for @electric.
  ///
  /// In en, this message translates to:
  /// **'Electric'**
  String get electric;

  /// No description provided for @calculate.
  ///
  /// In en, this message translates to:
  /// **'Calculate'**
  String get calculate;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @show_detailed_info.
  ///
  /// In en, this message translates to:
  /// **'Detailed Route Information'**
  String get show_detailed_info;

  /// No description provided for @these_are_the_costs_of_your_journey_with.
  ///
  /// In en, this message translates to:
  /// **'These are the real costs of mobility with'**
  String get these_are_the_costs_of_your_journey_with;

  /// No description provided for @private_car.
  ///
  /// In en, this message translates to:
  /// **'a private car'**
  String get private_car;

  /// No description provided for @private_ecar.
  ///
  /// In en, this message translates to:
  /// **'a private electric car'**
  String get private_ecar;

  /// No description provided for @shared_car.
  ///
  /// In en, this message translates to:
  /// **'car-sharing'**
  String get shared_car;

  /// No description provided for @private_bike.
  ///
  /// In en, this message translates to:
  /// **'a private bike'**
  String get private_bike;

  /// No description provided for @private_ebike.
  ///
  /// In en, this message translates to:
  /// **'a private electric bike'**
  String get private_ebike;

  /// No description provided for @shared_bike.
  ///
  /// In en, this message translates to:
  /// **'bike-sharing'**
  String get shared_bike;

  /// No description provided for @public_transport.
  ///
  /// In en, this message translates to:
  /// **'public transport'**
  String get public_transport;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @fullcosts_of_trip.
  ///
  /// In en, this message translates to:
  /// **'Fullcosts of the Trip'**
  String get fullcosts_of_trip;

  /// No description provided for @social_costs.
  ///
  /// In en, this message translates to:
  /// **'Social Costs'**
  String get social_costs;

  /// No description provided for @social_costs_two_line.
  ///
  /// In en, this message translates to:
  /// **'Social\nCosts'**
  String get social_costs_two_line;

  /// No description provided for @personal_costs.
  ///
  /// In en, this message translates to:
  /// **'Personal Costs'**
  String get personal_costs;

  /// No description provided for @personal_costs_two_line.
  ///
  /// In en, this message translates to:
  /// **'Personal\nCosts'**
  String get personal_costs_two_line;

  /// No description provided for @back_to_results.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back_to_results;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share or Leave some Feedback'**
  String get share;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get health;

  /// No description provided for @environment.
  ///
  /// In en, this message translates to:
  /// **'Environment'**
  String get environment;

  /// No description provided for @fixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed'**
  String get fixed;

  /// No description provided for @variable.
  ///
  /// In en, this message translates to:
  /// **'Variable'**
  String get variable;

  /// No description provided for @route_is_loading.
  ///
  /// In en, this message translates to:
  /// **'Routes are loading...'**
  String get route_is_loading;

  /// No description provided for @learn_about.
  ///
  /// In en, this message translates to:
  /// **'Learn about the true cost of your mobility'**
  String get learn_about;

  /// No description provided for @input_instructions.
  ///
  /// In en, this message translates to:
  /// **'Choose among the available travel modes and enter a start and end point in Munich to calculate the true costs of your trip.'**
  String get input_instructions;

  /// No description provided for @total_costs.
  ///
  /// In en, this message translates to:
  /// **'Total Costs'**
  String get total_costs;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @social.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get social;

  /// No description provided for @overall.
  ///
  /// In en, this message translates to:
  /// **'Overall'**
  String get overall;

  /// No description provided for @personal.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get personal;

  /// No description provided for @time_costs.
  ///
  /// In en, this message translates to:
  /// **'Time Costs'**
  String get time_costs;

  /// No description provided for @health_costs.
  ///
  /// In en, this message translates to:
  /// **'Health Costs'**
  String get health_costs;

  /// No description provided for @environment_costs.
  ///
  /// In en, this message translates to:
  /// **'Environment Costs'**
  String get environment_costs;

  /// No description provided for @fixed_costs.
  ///
  /// In en, this message translates to:
  /// **'Fixed Costs'**
  String get fixed_costs;

  /// No description provided for @variable_costs.
  ///
  /// In en, this message translates to:
  /// **'Variable Costs'**
  String get variable_costs;

  /// No description provided for @by_mode.
  ///
  /// In en, this message translates to:
  /// **'by mode'**
  String get by_mode;

  /// No description provided for @total_description.
  ///
  /// In en, this message translates to:
  /// **'The true costs - or full costs - of mobility are the sum of personal costs and external costs. The external costs are not carried by the traveler, but society as a whole.'**
  String get total_description;

  /// No description provided for @social_description.
  ///
  /// In en, this message translates to:
  /// **'Externalities arise when the activities of a person or company have an impact on third parties that are not included in the price. This effect can be both positive (external benefits) and negative (external costs). \nIn terms of mobility, external costs mean that the costs of transport activities are not carried by the travelers themselves, but by society in general.'**
  String get social_description;

  /// No description provided for @personal_description.
  ///
  /// In en, this message translates to:
  /// **'Personal costs – or internal costs - are borne by the users themselves. These internal costs can be both tangible and intangible. In terms of mobility, these might be monetary costs for vehicles (purchase, operation, disposal or repurchase) or for a public transport ticket.'**
  String get personal_description;

  /// No description provided for @detail_social_description.
  ///
  /// In en, this message translates to:
  /// **'The external costs are clustered into three categories: time, health, and environment. The time dimension includes congestion costs and time losses due to barrier effects (infrastructure can also act as a physical barrier, requiring detours, for example, in the case of railways, a level crossing must be used). The health dimension includes the costs caused by noise, accidents, and air pollution. The environment dimension includes costs due to climate damage and space consumption.'**
  String get detail_social_description;

  /// No description provided for @detail_social_time_description.
  ///
  /// In en, this message translates to:
  /// **'The time dimension includes congestion costs and time losses due to barrier effects.'**
  String get detail_social_time_description;

  /// No description provided for @what_are_congestion_costs.
  ///
  /// In en, this message translates to:
  /// **'What are congestion costs?'**
  String get what_are_congestion_costs;

  /// No description provided for @detail_social_time_description_congestion.
  ///
  /// In en, this message translates to:
  /// **'Congestion in road traffic or delays in public transport lead to time losses, which can be assessed in monetary terms with the help of willingness-to-pay approaches. Other negative effects of congestion are increased fuel consumption and wear and tear on roads and vehicles.\n\nThe total congestion costs for Munich (INRIX Traffic Scorecard) are allocated to individual modes of transport based on the space required and the vehicle kilometers traveled. In public transportation, average delays are used to calculate congestion costs.'**
  String get detail_social_time_description_congestion;

  /// No description provided for @what_are_barrier_costs.
  ///
  /// In en, this message translates to:
  /// **'What are costs due to barrier effects?'**
  String get what_are_barrier_costs;

  /// No description provided for @detail_social_time_description_barrier.
  ///
  /// In en, this message translates to:
  /// **'Wide road and rail routes with high traffic loads lead to restrictions for other forms of mobility. For example, pedestrians and cyclists must take detours to cross the infrastructure barrier. In addition, the spatial separation of districts can result in reduced economic productivity.\n\nThe monetary costs of these barrier effects have been estimated in various studies. Corresponding cost rates per vehicle kilometer have been adopted for the online tool.'**
  String get detail_social_time_description_barrier;

  /// No description provided for @detail_social_health_description.
  ///
  /// In en, this message translates to:
  /// **'The health dimension includes the costs caused by noise, accidents, and air pollution.'**
  String get detail_social_health_description;

  /// No description provided for @what_are_noise_costs.
  ///
  /// In en, this message translates to:
  /// **'What are noise costs?'**
  String get what_are_noise_costs;

  /// No description provided for @detail_social_health_description_noise.
  ///
  /// In en, this message translates to:
  /// **'Noise from road and rail traffic causes disturbances and harms human health. This causes damage to society in the form of loss of value of real estate, reduced quality of life, as well as treatment costs and productivity losses due to physical, cognitive, or psychological impairments.\n\nThe amount of the noise costs is determined by the number of persons affected per level class, measured in dB(A). The total costs are then divided among the individual means of transport using weighting factors and mileage.'**
  String get detail_social_health_description_noise;

  /// No description provided for @what_are_accident_costs.
  ///
  /// In en, this message translates to:
  /// **'What are accident costs?'**
  String get what_are_accident_costs;

  /// No description provided for @detail_social_health_description_accidents.
  ///
  /// In en, this message translates to:
  /// **'Traffic accidents cause medical costs, property damage, losses due to work absences, administrative expenses, and intangible costs (e.g., suffering and shock).\n\nOnly personal injury is included when calculating external costs, as property damage is largely covered by motor vehicle insurance and is therefore part of the personal costs.\nThe police accident statistics provide information on the accident’s severity, road users involved, and the causer.\n\nWith the help of appropriate cost rates, the total cost of each accident can be determined. The accident costs are allocated to the modes of transport according to the polluter pays principle (costs are allocated to the mode of transport causing the accident) and the damage potential principle (allocation is based on mass and speed).'**
  String get detail_social_health_description_accidents;

  /// No description provided for @what_are_air_costs.
  ///
  /// In en, this message translates to:
  /// **'What are costs due to air pollution'**
  String get what_are_air_costs;

  /// No description provided for @detail_social_health_description_air.
  ///
  /// In en, this message translates to:
  /// **'Air pollution occurs both in vehicle operation through fuel combustion and abrasion and during fuel production. The consequences are material damage (e.g. to buildings), crop damage, biodiversity loss and damage to health (especially due to respiratory diseases).\n\nThe cost rates for various air pollutants, such as particulate matter, nitrogen oxides or ammonia, come from the Federal Environment Agency\'s Methodological Convention 3.1.\n'**
  String get detail_social_health_description_air;

  /// No description provided for @detail_social_environment_description.
  ///
  /// In en, this message translates to:
  /// **'The environment dimension includes costs due to climate damage and space consumption.'**
  String get detail_social_environment_description;

  /// No description provided for @what_are_climate_costs.
  ///
  /// In en, this message translates to:
  /// **'What are costs due to climate damage?'**
  String get what_are_climate_costs;

  /// No description provided for @detail_social_environment_description_climate.
  ///
  /// In en, this message translates to:
  /// **'Greenhouse gas emissions are generated during fuel combustion in the vehicle and during the production of fuels and energy. In the atmosphere, greenhouse gases lead to a change in the climate – with negative consequences for ecosystems, human health, and food production.\n\nThe Federal Environment Agency recommends the damage cost approach for determining climate damage. This involves estimating the damage caused by a given amount of greenhouse gases emitted. For this purpose, greenhouse gases such as carbon dioxide, methane, and nitrous oxide are converted into CO2 equivalents.'**
  String get detail_social_environment_description_climate;

  /// No description provided for @what_are_space_costs.
  ///
  /// In en, this message translates to:
  /// **'What are costs due to space consumption?'**
  String get what_are_space_costs;

  /// No description provided for @detail_social_environment_description_space.
  ///
  /// In en, this message translates to:
  /// **'Transportation needs space for driving and parking. The calculations in this online tool consider the city of Munich’s investments in road traffic, public transport, and bicycle traffic. In addition, so-called opportunity costs arise, as the space cannot be used for other purposes. In the case of cars, the costs for construction and maintenance of parking, as well as the income from parking fees, are also considered.'**
  String get detail_social_environment_description_space;

  /// No description provided for @detail_personal_description.
  ///
  /// In en, this message translates to:
  /// **'These costs consist of fixed costs and variable costs. Fixed costs include costs such as vehicle depreciation. The variable costs are kilometre-dependent costs, such as fuel costs. The cost rates for bicycles and e-bikes include depreciation (fixed costs) as well as tyres, maintenance/repairs and electricity costs (variable costs). The fixed costs for the car include the subcategories depreciation, insurance, tax, MOT and parking. The variable costs include fuel costs, maintenance, repairs, tyres and care.'**
  String get detail_personal_description;

  /// No description provided for @detail_personal_fixed_description.
  ///
  /// In en, this message translates to:
  /// **'Fixed costs include costs such as the depreciation of vehicles.'**
  String get detail_personal_fixed_description;

  /// No description provided for @detail_personal_variable_description.
  ///
  /// In en, this message translates to:
  /// **'Variable costs are kilometer-dependent costs, such as fuel costs.'**
  String get detail_personal_variable_description;

  /// No description provided for @get_started.
  ///
  /// In en, this message translates to:
  /// **'Start Full Cost Calculation'**
  String get get_started;

  /// No description provided for @diagram.
  ///
  /// In en, this message translates to:
  /// **'Diagram'**
  String get diagram;

  /// No description provided for @about_us_title.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get about_us_title;

  /// No description provided for @about_us_content.
  ///
  /// In en, this message translates to:
  /// **'We are an interdisciplinary team consisting of five chairs from TU Munich and several external partners.\n\nOur goal is to transparently present and communicate the true costs of urban traffic in Munich.\n\nWe want to raise awareness of the costs of air pollutants, climate damage, accidents, congestion, land consumption, and noise caused by our mobility.\n\nWith this, we aim to promote sustainable and fair mobility behavior.'**
  String get about_us_content;

  /// No description provided for @research_content.
  ///
  /// In en, this message translates to:
  /// **'The full cost calculator uses scientific methods to enable a cost comparison of different forms of mobility.'**
  String get research_content;

  /// No description provided for @note_address.
  ///
  /// In en, this message translates to:
  /// **'*Please only enter addresses in Munich, otherwise not every route can be calculated.'**
  String get note_address;

  /// No description provided for @mode_of_transport.
  ///
  /// In en, this message translates to:
  /// **'mode'**
  String get mode_of_transport;

  /// No description provided for @reload.
  ///
  /// In en, this message translates to:
  /// **'Reload'**
  String get reload;

  /// No description provided for @error_empty.
  ///
  /// In en, this message translates to:
  /// **'Enter an address.'**
  String get error_empty;

  /// No description provided for @error_shorter_than_2.
  ///
  /// In en, this message translates to:
  /// **'Enter a longer address.'**
  String get error_shorter_than_2;

  /// No description provided for @copy_url.
  ///
  /// In en, this message translates to:
  /// **'Copy URL'**
  String get copy_url;

  /// No description provided for @url_copied.
  ///
  /// In en, this message translates to:
  /// **'URL copied to clipboard'**
  String get url_copied;

  /// No description provided for @tell_a_friend.
  ///
  /// In en, this message translates to:
  /// **'Do you like Mobi-Score? Tell a friend!'**
  String get tell_a_friend;

  /// No description provided for @field_empty_alert.
  ///
  /// In en, this message translates to:
  /// **'The address field cannot be empty'**
  String get field_empty_alert;

  /// No description provided for @input_short_alert.
  ///
  /// In en, this message translates to:
  /// **'Input must be longer than 2 characters'**
  String get input_short_alert;

  /// No description provided for @shared.
  ///
  /// In en, this message translates to:
  /// **'Sharing'**
  String get shared;

  /// No description provided for @private.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get private;

  /// No description provided for @header_image_label.
  ///
  /// In en, this message translates to:
  /// **'The title image shows an urban scene with multiple modes of transport: a teal bus, a cyclist on a teal bicycle, and an elevated white-and-orange train. People are walking in the background, and a large profile of a woman with dark hair is shown to the right, overlooking the city. The city has modern buildings, greenery, and statues.'**
  String get header_image_label;

  /// No description provided for @what_are.
  ///
  /// In en, this message translates to:
  /// **'What are'**
  String get what_are;

  /// No description provided for @start_new_route.
  ///
  /// In en, this message translates to:
  /// **'Start a new route'**
  String get start_new_route;

  /// No description provided for @mobi_score_description_1.
  ///
  /// In en, this message translates to:
  /// **'In addition to private, internal costs (e.g. fuel costs or insurance), our individual mobility also causes external costs such as accident costs or noise costs. The Mobi-Score assesses precisely these external costs of our individual mobility. It is intended to raise awareness of the fact that the costs of our mobility are not distributed fairly - as there are costs that are not borne by the person who causes them, but by society as a whole.'**
  String get mobi_score_description_1;

  /// No description provided for @mobi_score_description_2.
  ///
  /// In en, this message translates to:
  /// **'The Mobi-Score depends on the chosen mode of transport and the distance traveled. This can vary significantly between different modes of transport.'**
  String get mobi_score_description_2;

  /// No description provided for @mobi_score_description_3.
  ///
  /// In en, this message translates to:
  /// **'If a route has comparatively high external costs, it receives the Mobi-Score E (red). On the other hand, if the route has low external costs, it receives the Mobi-Score A (green).'**
  String get mobi_score_description_3;

  /// No description provided for @imprint.
  ///
  /// In en, this message translates to:
  /// **'Imprint'**
  String get imprint;

  /// No description provided for @imprint_content.
  ///
  /// In en, this message translates to:
  /// **'Munich Cluster for the Future of Mobility in Metropolitan Regions (MCube)'**
  String get imprint_content;

  /// No description provided for @contact_details.
  ///
  /// In en, this message translates to:
  /// **'Contact Details'**
  String get contact_details;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Publisher'**
  String get contact;

  /// No description provided for @imprint_contact_details_content.
  ///
  /// In en, this message translates to:
  /// **'Technical University Munich\nTUM School of Engineering and Design\nChair of Urban Structure and Transport Planning\nArcisstraße 21\n80333 Munich'**
  String get imprint_contact_details_content;

  /// No description provided for @authorized_to_represent.
  ///
  /// In en, this message translates to:
  /// **'Authorized to Represent'**
  String get authorized_to_represent;

  /// No description provided for @imprint_authorized_content.
  ///
  /// In en, this message translates to:
  /// **'The Technical University of Munich is legally represented by the President, Prof. Dr. Thomas F. Hofmann.\nThe Technical University of Munich is, according to Art. 11 para. 1 sentence 1 BayHSchG, a public corporation with the right of self-administration within the framework of the laws and at the same time, according to Art. 1 para. 2 sentence 1 no. 1 BayHSchG, a state university (state institution). The Technical University of Munich handles its own matters as a corporation (corporate matters) under the legal supervision of the supervisory authority and state matters as a state institution (Art. 12 para. 1 BayHSchG).\nVAT DE811193231 (in accordance with § 27a of the Value Added Tax Act)'**
  String get imprint_authorized_content;

  /// No description provided for @responsible_for_content.
  ///
  /// In en, this message translates to:
  /// **'Responsible for Content'**
  String get responsible_for_content;

  /// No description provided for @imprint_responsible_content.
  ///
  /// In en, this message translates to:
  /// **'Julia Kinigadner\nE-Mail: sasim@mcube-cluster.com'**
  String get imprint_responsible_content;

  /// No description provided for @more_information.
  ///
  /// In en, this message translates to:
  /// **'More information at:'**
  String get more_information;

  /// No description provided for @more_information_content.
  ///
  /// In en, this message translates to:
  /// **'www.mcube-cluster.de\nhttps://www.mos.ed.tum.de/sv'**
  String get more_information_content;

  /// No description provided for @disclaimer.
  ///
  /// In en, this message translates to:
  /// **'Disclaimer'**
  String get disclaimer;

  /// No description provided for @imprint_disclaimer_content.
  ///
  /// In en, this message translates to:
  /// **'Despite careful content control, we assume no liability for the content of external links. The operators of the linked pages are solely responsible for their content. Articles marked by name in the discussion areas reflect the author\'s opinion. The authors are solely responsible for the content of their contributions.'**
  String get imprint_disclaimer_content;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @general_information.
  ///
  /// In en, this message translates to:
  /// **'General Information'**
  String get general_information;

  /// No description provided for @privacy_general_content.
  ///
  /// In en, this message translates to:
  /// **'We take the protection of your personal data very seriously and treat your personal information confidentially and in accordance with legal data protection regulations as well as this privacy policy. This app does not require registration and does not store any personal data.'**
  String get privacy_general_content;

  /// No description provided for @responsible_person.
  ///
  /// In en, this message translates to:
  /// **'Responsible Person'**
  String get responsible_person;

  /// No description provided for @privacy_responsible_content.
  ///
  /// In en, this message translates to:
  /// **'The entity responsible for data processing in accordance with the General Data Protection Regulation (GDPR) is:\n\nMCube\nFreddie-Mercury-Straße 5\n80797 Munich\nPhone: +49 89 289-01\nE-Mail: sasim@mcube-cluster.com'**
  String get privacy_responsible_content;

  /// No description provided for @collection_and_processing_personal_data.
  ///
  /// In en, this message translates to:
  /// **'Collection and Processing of Personal Data'**
  String get collection_and_processing_personal_data;

  /// No description provided for @privacy_collection_content.
  ///
  /// In en, this message translates to:
  /// **'No personal data is stored or processed in the SASIM app. The use of the app does not require registration, and no user data that allows identification is stored.'**
  String get privacy_collection_content;

  /// No description provided for @processing_user_data.
  ///
  /// In en, this message translates to:
  /// **'Processing of User Data'**
  String get processing_user_data;

  /// No description provided for @privacy_processing_content.
  ///
  /// In en, this message translates to:
  /// **'The app only processes start and destination addresses entered by the user for routing purposes. These addresses are stored anonymously with a timestamp in log files, without any personal reference. This data is only used to provide the requested service and is not stored permanently.'**
  String get privacy_processing_content;

  /// No description provided for @third_party_services.
  ///
  /// In en, this message translates to:
  /// **'Third-Party Services'**
  String get third_party_services;

  /// No description provided for @photon_header.
  ///
  /// In en, this message translates to:
  /// **'Photon API'**
  String get photon_header;

  /// No description provided for @privacy_photon_content.
  ///
  /// In en, this message translates to:
  /// **'For geocoding addresses, the Photon API is used, which is licensed under the **Apache License, Version 2.0**. For more information about Photon API and its licensing, please visit: https://photon.komoot.io/.'**
  String get privacy_photon_content;

  /// No description provided for @efa_header.
  ///
  /// In en, this message translates to:
  /// **'EFA API of MVV'**
  String get efa_header;

  /// No description provided for @privacy_efa_content.
  ///
  /// In en, this message translates to:
  /// **'For route planning and finding transportation options, we use the **EFA API** from the Munich Transport and Tariff Association (MVV). Through this API, information about public transport and sharing services from **ShareNow** and **Call a Bike** is provided. No personal data is stored or passed on to these providers.'**
  String get privacy_efa_content;

  /// No description provided for @data_security.
  ///
  /// In en, this message translates to:
  /// **'Data Security'**
  String get data_security;

  /// No description provided for @privacy_security_content.
  ///
  /// In en, this message translates to:
  /// **'We implement technical and organizational measures to ensure the security of the data processed by the app. As no personal data is stored, the risk of a data protection breach is minimal.'**
  String get privacy_security_content;

  /// No description provided for @cookies.
  ///
  /// In en, this message translates to:
  /// **'Cookies'**
  String get cookies;

  /// No description provided for @privacy_cookies_content.
  ///
  /// In en, this message translates to:
  /// **'This app does not use cookies or similar tracking technologies.'**
  String get privacy_cookies_content;

  /// No description provided for @your_rights.
  ///
  /// In en, this message translates to:
  /// **'Your Rights'**
  String get your_rights;

  /// No description provided for @privacy_rights_content.
  ///
  /// In en, this message translates to:
  /// **'Since no personal data is processed in this app, the rights of access, rectification, deletion, or restriction of processing according to Art. 15-18 GDPR are not applicable. If you still have questions regarding data protection in relation to the use of the app, you can contact us using the above contact information.'**
  String get privacy_rights_content;

  /// No description provided for @changes_to_privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Changes to this Privacy Policy'**
  String get changes_to_privacy_policy;

  /// No description provided for @privacy_changes_content.
  ///
  /// In en, this message translates to:
  /// **'We reserve the right to adjust this privacy policy to ensure it always complies with current legal requirements or to reflect changes to the app. Users will be informed of any changes in due time.'**
  String get privacy_changes_content;

  /// No description provided for @the_project.
  ///
  /// In en, this message translates to:
  /// **'The Project'**
  String get the_project;

  /// No description provided for @the_project_content.
  ///
  /// In en, this message translates to:
  /// **'This tool was developed as part of the SASIM research project, which is one of 14 projects in the first implementation phase of the Munich Cluster for the Future of Mobility in Metropolitan Regions (MCube). MCube is a future cluster funded by the BMBF, aiming to establish sustainable and transformative mobility innovations.\n\nOur goal is to make the true costs of urban transportation transparent and communicate them effectively. We aim to raise awareness about the costs of air pollutants, climate damage, accidents, traffic congestion, land use, and noise generated by our mobility. By doing so, we want to promote sustainable and fair mobility behavior.'**
  String get the_project_content;

  /// No description provided for @the_project_content_bold_1.
  ///
  /// In en, this message translates to:
  /// **'SASIM'**
  String get the_project_content_bold_1;

  /// No description provided for @the_project_content_bold_2.
  ///
  /// In en, this message translates to:
  /// **'MCube'**
  String get the_project_content_bold_2;

  /// No description provided for @the_project_content_bold_3.
  ///
  /// In en, this message translates to:
  /// **'sustainable and transformative mobility innovations'**
  String get the_project_content_bold_3;

  /// No description provided for @the_project_content_bold_4.
  ///
  /// In en, this message translates to:
  /// **'true costs of urban transportation'**
  String get the_project_content_bold_4;

  /// No description provided for @the_project_content_bold_5.
  ///
  /// In en, this message translates to:
  /// **'air pollutants, climate damage, accidents, traffic congestion, land use, and noise'**
  String get the_project_content_bold_5;

  /// No description provided for @the_project_content_bold_6.
  ///
  /// In en, this message translates to:
  /// **'sustainable and fair mobility behavior'**
  String get the_project_content_bold_6;

  /// No description provided for @the_web_app.
  ///
  /// In en, this message translates to:
  /// **'The Web App'**
  String get the_web_app;

  /// No description provided for @the_web_app_content.
  ///
  /// In en, this message translates to:
  /// **'The current status quo is that the costs caused by our mobility behavior are not fairly distributed. At the moment, we only pay for the private, internal costs of our mobility (e.g. fuel costs, ticket prices, or repair costs), but not the societal, external costs such as accident costs or noise costs. These are borne by society! Thus, those who cause high external costs through their mobility behavior are just as involved as those who cause low costs.\n\nThis freely available online tool evaluates individual route requests depending on the means of transportation. For now, the tool only calculates and evaluates routes within the city of Munich.'**
  String get the_web_app_content;

  /// No description provided for @the_web_app_content_bold_1.
  ///
  /// In en, this message translates to:
  /// **'not fairly distributed'**
  String get the_web_app_content_bold_1;

  /// No description provided for @the_web_app_content_bold_2.
  ///
  /// In en, this message translates to:
  /// **'not the societal, external costs'**
  String get the_web_app_content_bold_2;

  /// No description provided for @the_web_app_content_bold_3.
  ///
  /// In en, this message translates to:
  /// **'This freely available online tool evaluates individual route requests depending on the means of transportation.'**
  String get the_web_app_content_bold_3;

  /// No description provided for @the_mobi_score.
  ///
  /// In en, this message translates to:
  /// **'The Mobi-Score'**
  String get the_mobi_score;

  /// No description provided for @the_mobi_score_content.
  ///
  /// In en, this message translates to:
  /// **'The evaluation in this tool takes into account the costs of air pollutants, climate damage, accidents, traffic congestion, land use, and noise. For each request, these costs are then illustrated for each selected mode of transport using the MobiScore.'**
  String get the_mobi_score_content;

  /// No description provided for @the_mobi_score_content_bold_1.
  ///
  /// In en, this message translates to:
  /// **'air pollutants, climate damage, accidents, traffic congestion, land use, and noise'**
  String get the_mobi_score_content_bold_1;

  /// No description provided for @the_mobi_score_content_bullet_1.
  ///
  /// In en, this message translates to:
  /// **'The MobiScore evaluates the true costs of our individual mobility and raises awareness of “invisible” costs.'**
  String get the_mobi_score_content_bullet_1;

  /// No description provided for @the_mobi_score_content_bullet_2.
  ///
  /// In en, this message translates to:
  /// **'It provides an indication of how fair certain modes of transport are for any given route.'**
  String get the_mobi_score_content_bullet_2;

  /// No description provided for @the_team_behind.
  ///
  /// In en, this message translates to:
  /// **'Who else is behind Mobi-Score?'**
  String get the_team_behind;

  /// No description provided for @the_team_behind_content.
  ///
  /// In en, this message translates to:
  /// **'The Mobi-Score was developed as part of the SASIM research project by an interdisciplinary team of five chairs from the Technical University of Munich (TUM) and several external partners.'**
  String get the_team_behind_content;

  /// No description provided for @the_team_behind_content_hyperlink_1.
  ///
  /// In en, this message translates to:
  /// **'SASIM research project'**
  String get the_team_behind_content_hyperlink_1;

  /// No description provided for @out_partners.
  ///
  /// In en, this message translates to:
  /// **'Our Partners'**
  String get out_partners;

  /// No description provided for @personal_costs_research_content.
  ///
  /// In en, this message translates to:
  /// **'The calculations of personal costs are largely based on the study by König et al. (2021). The full cost calculator uses the following cost rates (in euros per passenger-kilometer, unless otherwise stated):'**
  String get personal_costs_research_content;

  /// No description provided for @personal_costs_research_content_hyperlink_1.
  ///
  /// In en, this message translates to:
  /// **'König et al. (2021)'**
  String get personal_costs_research_content_hyperlink_1;

  /// No description provided for @social_costs_research_content.
  ///
  /// In en, this message translates to:
  /// **'The calculations of external costs are based on the study by Schröder et. al (2023). The full cost calculator uses the following cost rates (in cents per passenger-kilometer):'**
  String get social_costs_research_content;

  /// No description provided for @social_costs_research_content_hyperlink_1.
  ///
  /// In en, this message translates to:
  /// **'Schröder et al. (2023)'**
  String get social_costs_research_content_hyperlink_1;

  /// No description provided for @routing_research.
  ///
  /// In en, this message translates to:
  /// **'Routing'**
  String get routing_research;

  /// No description provided for @routing_research_content.
  ///
  /// In en, this message translates to:
  /// **'The full cost calculator uses the software OpenTripPlanner (OTP) for route planning.\nBased on the inputs (start and destination address and selected travel mode), distance, travel time and the waypoints of the route are calculated.\n\nIn order to calculate routes and travel costs by public transportation, the timetable information system DEFAS is accessed via an API.'**
  String get routing_research_content;

  /// No description provided for @development_by.
  ///
  /// In en, this message translates to:
  /// **'Frontent und Backend Development by'**
  String get development_by;

  /// No description provided for @illustrations_by.
  ///
  /// In en, this message translates to:
  /// **'Illustrations by'**
  String get illustrations_by;

  /// No description provided for @ui_by.
  ///
  /// In en, this message translates to:
  /// **'UI/UX Design by'**
  String get ui_by;

  /// No description provided for @routing_research_content_hyperlink_1.
  ///
  /// In en, this message translates to:
  /// **'OpenTripPlanner (OTP)'**
  String get routing_research_content_hyperlink_1;

  /// No description provided for @routing_research_content_hyperlink_2.
  ///
  /// In en, this message translates to:
  /// **'DEFAS'**
  String get routing_research_content_hyperlink_2;

  /// No description provided for @want_to_help_us.
  ///
  /// In en, this message translates to:
  /// **'Want to help us improve?'**
  String get want_to_help_us;

  /// No description provided for @want_to_help_us_explanation.
  ///
  /// In en, this message translates to:
  /// **'Click on the button below or scan the QR code to participate in our survey. Your feedback is important to us!'**
  String get want_to_help_us_explanation;

  /// No description provided for @to_the_survey.
  ///
  /// In en, this message translates to:
  /// **'To the survey'**
  String get to_the_survey;

  /// No description provided for @mode_not_available.
  ///
  /// In en, this message translates to:
  /// **'This mode of transportation is not available for this route.'**
  String get mode_not_available;

  /// No description provided for @x_not_available.
  ///
  /// In en, this message translates to:
  /// **' is not available for this route.'**
  String get x_not_available;

  /// No description provided for @try_another_route.
  ///
  /// In en, this message translates to:
  /// **'If you still want to compare the true costs of this mode of transportation, please choose another route'**
  String get try_another_route;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Weiter'**
  String get resume;

  /// No description provided for @address_not_found_text.
  ///
  /// In en, this message translates to:
  /// **'This address could not be found. Is it located in Munich? Try again with a different one!'**
  String get address_not_found_text;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
