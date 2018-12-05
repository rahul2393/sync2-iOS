// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: ingress.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers.h>
#else
 #import "GPBProtocolBuffers.h"
#endif

#if GOOGLE_PROTOBUF_OBJC_VERSION < 30002
#error This file was generated by a newer version of protoc which is incompatible with your Protocol Buffer library sources.
#endif
#if 30002 < GOOGLE_PROTOBUF_OBJC_MIN_SUPPORTED_VERSION
#error This file was generated by an older version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

@class Activity;
@class Configuration;
@class IBeacon;
@class IBeaconListItem;
@class Location;
@class Power;
@class Property;
@class Push;
@class Rule;
@class Wifi;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - IngressRoot

/**
 * Exposes the extension registry for this file.
 *
 * The base class provides:
 * @code
 *   + (GPBExtensionRegistry *)extensionRegistry;
 * @endcode
 * which is a @c GPBExtensionRegistry that includes all the extensions defined by
 * this file and all files that it depends on.
 **/
@interface IngressRoot : GPBRootObject
@end

#pragma mark - Location

typedef GPB_ENUM(Location_FieldNumber) {
  Location_FieldNumber_Timestamp = 1,
  Location_FieldNumber_Latitude = 2,
  Location_FieldNumber_Longitude = 3,
  Location_FieldNumber_Velocity = 4,
  Location_FieldNumber_Course = 5,
  Location_FieldNumber_Accuracy = 6,
};

@interface Location : GPBMessage

@property(nonatomic, readwrite) int64_t timestamp;

@property(nonatomic, readwrite) float latitude;

@property(nonatomic, readwrite) float longitude;

@property(nonatomic, readwrite) float velocity;

@property(nonatomic, readwrite) float course;

@property(nonatomic, readwrite) float accuracy;

@end

#pragma mark - Wifi

typedef GPB_ENUM(Wifi_FieldNumber) {
  Wifi_FieldNumber_Timestamp = 1,
  Wifi_FieldNumber_Mac = 2,
  Wifi_FieldNumber_Ssid = 3,
  Wifi_FieldNumber_Rssi = 4,
};

@interface Wifi : GPBMessage

@property(nonatomic, readwrite) int64_t timestamp;

@property(nonatomic, readwrite, copy, null_resettable) NSString *mac;

@property(nonatomic, readwrite, copy, null_resettable) NSString *ssid;

@property(nonatomic, readwrite) int32_t rssi;

@end

#pragma mark - IBeacon

typedef GPB_ENUM(IBeacon_FieldNumber) {
  IBeacon_FieldNumber_Timestamp = 1,
  IBeacon_FieldNumber_Uuid = 2,
  IBeacon_FieldNumber_Rssi = 3,
  IBeacon_FieldNumber_Major = 4,
  IBeacon_FieldNumber_Minor = 5,
  IBeacon_FieldNumber_Proximity = 6,
  IBeacon_FieldNumber_Accuracy = 7,
};

@interface IBeacon : GPBMessage

@property(nonatomic, readwrite) int64_t timestamp;

@property(nonatomic, readwrite, copy, null_resettable) NSString *uuid;

@property(nonatomic, readwrite) int64_t rssi;

@property(nonatomic, readwrite) int64_t major;

@property(nonatomic, readwrite) int64_t minor;

@property(nonatomic, readwrite, copy, null_resettable) NSString *proximity;

@property(nonatomic, readwrite) float accuracy;

@end

#pragma mark - Power

typedef GPB_ENUM(Power_FieldNumber) {
  Power_FieldNumber_Timestamp = 1,
  Power_FieldNumber_Charging = 2,
  Power_FieldNumber_BatteryLife = 3,
};

@interface Power : GPBMessage

@property(nonatomic, readwrite) int64_t timestamp;

@property(nonatomic, readwrite) BOOL charging;

@property(nonatomic, readwrite) int64_t batteryLife;

@end

#pragma mark - Activity

typedef GPB_ENUM(Activity_FieldNumber) {
  Activity_FieldNumber_Timestamp = 1,
  Activity_FieldNumber_Type = 2,
  Activity_FieldNumber_ConfidenceLevel = 3,
};

@interface Activity : GPBMessage

@property(nonatomic, readwrite) int64_t timestamp;

@property(nonatomic, readwrite, copy, null_resettable) NSString *type;

@property(nonatomic, readwrite, copy, null_resettable) NSString *confidenceLevel;

@end

#pragma mark - Configuration

typedef GPB_ENUM(Configuration_FieldNumber) {
  Configuration_FieldNumber_Uuid = 1,
  Configuration_FieldNumber_Enabled = 2,
  Configuration_FieldNumber_Cadence = 3,
  Configuration_FieldNumber_UseSensorsArray = 4,
  Configuration_FieldNumber_EventTtl = 5,
  Configuration_FieldNumber_MaxStorage = 6,
};

@interface Configuration : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *uuid;

@property(nonatomic, readwrite) BOOL enabled;

@property(nonatomic, readwrite) int64_t cadence;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *useSensorsArray;
/** The number of items in @c useSensorsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger useSensorsArray_Count;

@property(nonatomic, readwrite) int64_t eventTtl;

@property(nonatomic, readwrite) int64_t maxStorage;

@end

#pragma mark - Property

typedef GPB_ENUM(Property_FieldNumber) {
  Property_FieldNumber_Timestamp = 1,
  Property_FieldNumber_Manufacturer = 2,
  Property_FieldNumber_Model = 3,
  Property_FieldNumber_Os = 4,
  Property_FieldNumber_OsVersion = 5,
  Property_FieldNumber_SoftwareVersion = 6,
  Property_FieldNumber_Type = 7,
  Property_FieldNumber_SensorsArray = 8,
};

@interface Property : GPBMessage

@property(nonatomic, readwrite) int64_t timestamp;

@property(nonatomic, readwrite, copy, null_resettable) NSString *manufacturer;

@property(nonatomic, readwrite, copy, null_resettable) NSString *model;

@property(nonatomic, readwrite, copy, null_resettable) NSString *os;

@property(nonatomic, readwrite, copy, null_resettable) NSString *osVersion;

@property(nonatomic, readwrite, copy, null_resettable) NSString *softwareVersion;

@property(nonatomic, readwrite, copy, null_resettable) NSString *type;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *sensorsArray;
/** The number of items in @c sensorsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger sensorsArray_Count;

@end

#pragma mark - Push

typedef GPB_ENUM(Push_FieldNumber) {
  Push_FieldNumber_Timestamp = 1,
  Push_FieldNumber_Token = 2,
  Push_FieldNumber_Type = 3,
};

@interface Push : GPBMessage

@property(nonatomic, readwrite) int64_t timestamp;

@property(nonatomic, readwrite, copy, null_resettable) NSString *token;

@property(nonatomic, readwrite, copy, null_resettable) NSString *type;

@end

#pragma mark - Event

typedef GPB_ENUM(Event_FieldNumber) {
  Event_FieldNumber_Timestamp = 1,
  Event_FieldNumber_LocationsArray = 2,
  Event_FieldNumber_WifisArray = 3,
  Event_FieldNumber_IbeaconsArray = 4,
  Event_FieldNumber_PowersArray = 5,
  Event_FieldNumber_ActivitiesArray = 6,
  Event_FieldNumber_Configurations = 7,
  Event_FieldNumber_Properties = 8,
  Event_FieldNumber_Push = 9,
  Event_FieldNumber_Attributes = 10,
};

@interface Event : GPBMessage

@property(nonatomic, readwrite) int64_t timestamp;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Location*> *locationsArray;
/** The number of items in @c locationsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger locationsArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Wifi*> *wifisArray;
/** The number of items in @c wifisArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger wifisArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<IBeacon*> *ibeaconsArray;
/** The number of items in @c ibeaconsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger ibeaconsArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Power*> *powersArray;
/** The number of items in @c powersArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger powersArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Activity*> *activitiesArray;
/** The number of items in @c activitiesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger activitiesArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) Configuration *configurations;
/** Test to see if @c configurations has been set. */
@property(nonatomic, readwrite) BOOL hasConfigurations;

@property(nonatomic, readwrite, strong, null_resettable) Property *properties;
/** Test to see if @c properties has been set. */
@property(nonatomic, readwrite) BOOL hasProperties;

@property(nonatomic, readwrite, strong, null_resettable) Push *push;
/** Test to see if @c push has been set. */
@property(nonatomic, readwrite) BOOL hasPush;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableDictionary<NSString*, NSString*> *attributes;
/** The number of items in @c attributes without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger attributes_Count;

@end

#pragma mark - RegistrationRequest

typedef GPB_ENUM(RegistrationRequest_FieldNumber) {
  RegistrationRequest_FieldNumber_ApiKey = 1,
  RegistrationRequest_FieldNumber_Properties = 2,
  RegistrationRequest_FieldNumber_Aliases = 3,
};

@interface RegistrationRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *apiKey;

@property(nonatomic, readwrite, strong, null_resettable) Property *properties;
/** Test to see if @c properties has been set. */
@property(nonatomic, readwrite) BOOL hasProperties;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableDictionary<NSString*, NSString*> *aliases;
/** The number of items in @c aliases without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger aliases_Count;

@end

#pragma mark - RegistrationResponse

typedef GPB_ENUM(RegistrationResponse_FieldNumber) {
  RegistrationResponse_FieldNumber_Token = 1,
  RegistrationResponse_FieldNumber_DeviceId = 2,
  RegistrationResponse_FieldNumber_OrganizationId = 3,
};

@interface RegistrationResponse : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *token;

@property(nonatomic, readwrite, copy, null_resettable) NSString *deviceId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *organizationId;

@end

#pragma mark - IBeaconListItem

typedef GPB_ENUM(IBeaconListItem_FieldNumber) {
  IBeaconListItem_FieldNumber_Uuid = 1,
  IBeaconListItem_FieldNumber_Major = 2,
  IBeaconListItem_FieldNumber_Minor = 3,
};

@interface IBeaconListItem : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *uuid;

@property(nonatomic, readwrite) int64_t major;

@property(nonatomic, readwrite) int64_t minor;

@end

#pragma mark - IBeaconsResponse

typedef GPB_ENUM(IBeaconsResponse_FieldNumber) {
  IBeaconsResponse_FieldNumber_IbeaconsArray = 1,
};

@interface IBeaconsResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<IBeaconListItem*> *ibeaconsArray;
/** The number of items in @c ibeaconsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger ibeaconsArray_Count;

@end

#pragma mark - Rule

typedef GPB_ENUM(Rule_FieldNumber) {
  Rule_FieldNumber_Id_p = 1,
  Rule_FieldNumber_Name = 2,
  Rule_FieldNumber_Enabled = 3,
  Rule_FieldNumber_Conditions = 4,
  Rule_FieldNumber_ThrottleInSeconds = 5,
  Rule_FieldNumber_ActionsJson = 6,
};

@interface Rule : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *id_p;

@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

@property(nonatomic, readwrite) BOOL enabled;

@property(nonatomic, readwrite, copy, null_resettable) NSString *conditions;

@property(nonatomic, readwrite) int64_t throttleInSeconds;

@property(nonatomic, readwrite, copy, null_resettable) NSData *actionsJson;

@end

#pragma mark - RulesResponse

typedef GPB_ENUM(RulesResponse_FieldNumber) {
  RulesResponse_FieldNumber_RulesArray = 1,
};

@interface RulesResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Rule*> *rulesArray;
/** The number of items in @c rulesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger rulesArray_Count;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
