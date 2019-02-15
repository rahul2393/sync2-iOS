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
@class Error;
@class Event;
@class GatewayRegistrationRequest_SystemInfo;
@class GatewaySyncRequest_Summary;
@class GatewaySyncResponse_Deleted;
@class IBeacon;
@class Landmark;
@class Location;
@class Notification;
@class Notification_Actions;
@class Notification_Options;
@class Power;
@class Property;
@class Push;
@class Rule;
@class RuleXChannel;
@class Wifi;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum GenericEvent_Source

typedef GPB_ENUM(GenericEvent_Source) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  GenericEvent_Source_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  GenericEvent_Source_Mobile = 0,
  GenericEvent_Source_Iot = 1,
};

GPBEnumDescriptor *GenericEvent_Source_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL GenericEvent_Source_IsValidValue(int32_t value);

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

#pragma mark - Error

typedef GPB_ENUM(Error_FieldNumber) {
  Error_FieldNumber_ErrorCode = 1,
  Error_FieldNumber_ErrorMessage = 2,
};

@interface Error : GPBMessage

@property(nonatomic, readwrite) int32_t errorCode;

@property(nonatomic, readwrite, copy, null_resettable) NSString *errorMessage;

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
  Event_FieldNumber_ErrorArray = 11,
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

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Error*> *errorArray;
/** The number of items in @c errorArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger errorArray_Count;

@end

#pragma mark - GenericEvent

typedef GPB_ENUM(GenericEvent_FieldNumber) {
  GenericEvent_FieldNumber_Id_p = 1,
  GenericEvent_FieldNumber_OrganizationId = 2,
  GenericEvent_FieldNumber_ChannelId = 3,
  GenericEvent_FieldNumber_DeviceId = 4,
  GenericEvent_FieldNumber_ServerRecievedAt = 5,
  GenericEvent_FieldNumber_ClientSentAt = 6,
  GenericEvent_FieldNumber_Source = 7,
  GenericEvent_FieldNumber_Payload = 8,
};

@interface GenericEvent : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *id_p;

@property(nonatomic, readwrite, copy, null_resettable) NSString *organizationId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *channelId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *deviceId;

@property(nonatomic, readwrite) int64_t serverRecievedAt;

@property(nonatomic, readwrite) int64_t clientSentAt;

@property(nonatomic, readwrite) GenericEvent_Source source;

@property(nonatomic, readwrite, copy, null_resettable) NSData *payload;

@end

/**
 * Fetches the raw value of a @c GenericEvent's @c source property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t GenericEvent_Source_RawValue(GenericEvent *message);
/**
 * Sets the raw value of an @c GenericEvent's @c source property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetGenericEvent_Source_RawValue(GenericEvent *message, int32_t value);

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

#pragma mark - IBeaconsResponse

typedef GPB_ENUM(IBeaconsResponse_FieldNumber) {
  IBeaconsResponse_FieldNumber_UuidsArray = 1,
};

@interface IBeaconsResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *uuidsArray;
/** The number of items in @c uuidsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger uuidsArray_Count;

@end

#pragma mark - Rule

typedef GPB_ENUM(Rule_FieldNumber) {
  Rule_FieldNumber_Id_p = 1,
  Rule_FieldNumber_Name = 2,
  Rule_FieldNumber_Type = 3,
  Rule_FieldNumber_Enabled = 4,
  Rule_FieldNumber_Conditions = 5,
  Rule_FieldNumber_ConditionObject = 6,
  Rule_FieldNumber_ActionsJson = 7,
  Rule_FieldNumber_Description_p = 8,
  Rule_FieldNumber_CreatedAt = 9,
  Rule_FieldNumber_UpdatedAt = 10,
  Rule_FieldNumber_Generator = 11,
  Rule_FieldNumber_OrganizationId = 12,
  Rule_FieldNumber_ChannelIdsArray = 13,
  Rule_FieldNumber_ProjectId = 14,
  Rule_FieldNumber_TagsArray = 15,
};

@interface Rule : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *id_p;

@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

@property(nonatomic, readwrite, copy, null_resettable) NSString *type;

@property(nonatomic, readwrite) BOOL enabled;

@property(nonatomic, readwrite, copy, null_resettable) NSString *conditions;

@property(nonatomic, readwrite, copy, null_resettable) NSString *conditionObject;

@property(nonatomic, readwrite, copy, null_resettable) NSString *actionsJson;

@property(nonatomic, readwrite, copy, null_resettable) NSString *description_p;

@property(nonatomic, readwrite) int64_t createdAt;

@property(nonatomic, readwrite) int64_t updatedAt;

@property(nonatomic, readwrite, copy, null_resettable) NSString *generator;

@property(nonatomic, readwrite, copy, null_resettable) NSString *organizationId;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *channelIdsArray;
/** The number of items in @c channelIdsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger channelIdsArray_Count;

@property(nonatomic, readwrite, copy, null_resettable) NSString *projectId;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *tagsArray;
/** The number of items in @c tagsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger tagsArray_Count;

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

#pragma mark - GatewayRegistrationRequest

typedef GPB_ENUM(GatewayRegistrationRequest_FieldNumber) {
  GatewayRegistrationRequest_FieldNumber_ApiKey = 1,
  GatewayRegistrationRequest_FieldNumber_MachineId = 2,
  GatewayRegistrationRequest_FieldNumber_SystemInfo = 3,
};

@interface GatewayRegistrationRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *apiKey;

@property(nonatomic, readwrite, copy, null_resettable) NSString *machineId;

@property(nonatomic, readwrite, strong, null_resettable) GatewayRegistrationRequest_SystemInfo *systemInfo;
/** Test to see if @c systemInfo has been set. */
@property(nonatomic, readwrite) BOOL hasSystemInfo;

@end

#pragma mark - GatewayRegistrationRequest_SystemInfo

typedef GPB_ENUM(GatewayRegistrationRequest_SystemInfo_FieldNumber) {
  GatewayRegistrationRequest_SystemInfo_FieldNumber_Os = 1,
  GatewayRegistrationRequest_SystemInfo_FieldNumber_Arch = 2,
  GatewayRegistrationRequest_SystemInfo_FieldNumber_Cpu = 3,
  GatewayRegistrationRequest_SystemInfo_FieldNumber_Gpu = 4,
  GatewayRegistrationRequest_SystemInfo_FieldNumber_Memory = 5,
  GatewayRegistrationRequest_SystemInfo_FieldNumber_Storage = 6,
  GatewayRegistrationRequest_SystemInfo_FieldNumber_Make = 7,
};

@interface GatewayRegistrationRequest_SystemInfo : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *os;

@property(nonatomic, readwrite, copy, null_resettable) NSString *arch;

@property(nonatomic, readwrite, copy, null_resettable) NSString *cpu;

@property(nonatomic, readwrite, copy, null_resettable) NSString *gpu;

@property(nonatomic, readwrite, copy, null_resettable) NSString *memory;

@property(nonatomic, readwrite, copy, null_resettable) NSString *storage;

@property(nonatomic, readwrite, copy, null_resettable) NSString *make;

@end

#pragma mark - GatewayRegistrationResponse

typedef GPB_ENUM(GatewayRegistrationResponse_FieldNumber) {
  GatewayRegistrationResponse_FieldNumber_Token = 1,
};

@interface GatewayRegistrationResponse : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *token;

@end

#pragma mark - GatewaySyncRequest

typedef GPB_ENUM(GatewaySyncRequest_FieldNumber) {
  GatewaySyncRequest_FieldNumber_LastSyncedAt = 1,
  GatewaySyncRequest_FieldNumber_TotalDeviceRegistration = 2,
  GatewaySyncRequest_FieldNumber_DevicesArray = 3,
};

@interface GatewaySyncRequest : GPBMessage

@property(nonatomic, readwrite) int64_t lastSyncedAt;

@property(nonatomic, readwrite) int64_t totalDeviceRegistration;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<GatewaySyncRequest_Summary*> *devicesArray;
/** The number of items in @c devicesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger devicesArray_Count;

@end

#pragma mark - GatewaySyncRequest_Summary

typedef GPB_ENUM(GatewaySyncRequest_Summary_FieldNumber) {
  GatewaySyncRequest_Summary_FieldNumber_Id_p = 1,
  GatewaySyncRequest_Summary_FieldNumber_TotalEvents = 2,
  GatewaySyncRequest_Summary_FieldNumber_SuccessfulEvents = 3,
  GatewaySyncRequest_Summary_FieldNumber_ActionExecuted = 4,
};

@interface GatewaySyncRequest_Summary : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *id_p;

@property(nonatomic, readwrite) int64_t totalEvents;

@property(nonatomic, readwrite) int64_t successfulEvents;

@property(nonatomic, readwrite) int64_t actionExecuted;

@end

#pragma mark - RuleXChannel

typedef GPB_ENUM(RuleXChannel_FieldNumber) {
  RuleXChannel_FieldNumber_RuleId = 1,
  RuleXChannel_FieldNumber_ChannelId = 2,
};

@interface RuleXChannel : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *ruleId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *channelId;

@end

#pragma mark - Landmark

typedef GPB_ENUM(Landmark_FieldNumber) {
  Landmark_FieldNumber_Id_p = 1,
  Landmark_FieldNumber_Type = 2,
  Landmark_FieldNumber_Shape = 3,
};

@interface Landmark : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *id_p;

@property(nonatomic, readwrite, copy, null_resettable) NSString *type;

@property(nonatomic, readwrite, copy, null_resettable) NSData *shape;

@end

#pragma mark - GatewaySyncResponse

typedef GPB_ENUM(GatewaySyncResponse_FieldNumber) {
  GatewaySyncResponse_FieldNumber_RulesArray = 1,
  GatewaySyncResponse_FieldNumber_RuleXChannelArray = 2,
  GatewaySyncResponse_FieldNumber_LandmarksArray = 3,
  GatewaySyncResponse_FieldNumber_Deleted = 4,
};

@interface GatewaySyncResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Rule*> *rulesArray;
/** The number of items in @c rulesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger rulesArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<RuleXChannel*> *ruleXChannelArray;
/** The number of items in @c ruleXChannelArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger ruleXChannelArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Landmark*> *landmarksArray;
/** The number of items in @c landmarksArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger landmarksArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) GatewaySyncResponse_Deleted *deleted;
/** Test to see if @c deleted has been set. */
@property(nonatomic, readwrite) BOOL hasDeleted;

@end

#pragma mark - GatewaySyncResponse_Deleted

typedef GPB_ENUM(GatewaySyncResponse_Deleted_FieldNumber) {
  GatewaySyncResponse_Deleted_FieldNumber_LandmarksArray = 1,
  GatewaySyncResponse_Deleted_FieldNumber_RulesArray = 2,
  GatewaySyncResponse_Deleted_FieldNumber_ChannelsArray = 3,
};

@interface GatewaySyncResponse_Deleted : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *landmarksArray;
/** The number of items in @c landmarksArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger landmarksArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *rulesArray;
/** The number of items in @c rulesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger rulesArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *channelsArray;
/** The number of items in @c channelsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger channelsArray_Count;

@end

#pragma mark - MqttEventRequest

typedef GPB_ENUM(MqttEventRequest_FieldNumber) {
  MqttEventRequest_FieldNumber_Token = 1,
  MqttEventRequest_FieldNumber_Event = 2,
};

@interface MqttEventRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *token;

@property(nonatomic, readwrite, copy, null_resettable) NSData *event;

@end

#pragma mark - Notification

typedef GPB_ENUM(Notification_FieldNumber) {
  Notification_FieldNumber_Id_p = 1,
  Notification_FieldNumber_Timestamp = 2,
  Notification_FieldNumber_DeviceId = 3,
  Notification_FieldNumber_Subject = 4,
  Notification_FieldNumber_Message = 5,
  Notification_FieldNumber_Type = 6,
  Notification_FieldNumber_Title = 7,
  Notification_FieldNumber_Body = 8,
  Notification_FieldNumber_ActionTitle = 9,
  Notification_FieldNumber_SubmitURL = 10,
  Notification_FieldNumber_CommentHint = 11,
  Notification_FieldNumber_ButtonText = 12,
  Notification_FieldNumber_LandmarkId = 13,
  Notification_FieldNumber_Address = 14,
  Notification_FieldNumber_AddressTitle = 15,
  Notification_FieldNumber_ActionsArray = 16,
  Notification_FieldNumber_OptionsArray = 17,
  Notification_FieldNumber_RuleId = 18,
  Notification_FieldNumber_ActionId = 19,
  Notification_FieldNumber_ScheduleTitle = 20,
};

@interface Notification : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *id_p;

@property(nonatomic, readwrite) int64_t timestamp;

@property(nonatomic, readwrite, copy, null_resettable) NSString *deviceId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *subject;

@property(nonatomic, readwrite, copy, null_resettable) NSString *message;

@property(nonatomic, readwrite, copy, null_resettable) NSString *type;

@property(nonatomic, readwrite, copy, null_resettable) NSString *title;

@property(nonatomic, readwrite, copy, null_resettable) NSString *body;

@property(nonatomic, readwrite, copy, null_resettable) NSString *actionTitle;

@property(nonatomic, readwrite, copy, null_resettable) NSString *submitURL;

@property(nonatomic, readwrite, copy, null_resettable) NSString *commentHint;

@property(nonatomic, readwrite, copy, null_resettable) NSString *buttonText;

@property(nonatomic, readwrite, copy, null_resettable) NSString *landmarkId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *address;

@property(nonatomic, readwrite, copy, null_resettable) NSString *addressTitle;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Notification_Actions*> *actionsArray;
/** The number of items in @c actionsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger actionsArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Notification_Options*> *optionsArray;
/** The number of items in @c optionsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger optionsArray_Count;

@property(nonatomic, readwrite, copy, null_resettable) NSString *ruleId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *actionId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *scheduleTitle;

@end

#pragma mark - Notification_Actions

typedef GPB_ENUM(Notification_Actions_FieldNumber) {
  Notification_Actions_FieldNumber_Text = 1,
  Notification_Actions_FieldNumber_Message = 2,
  Notification_Actions_FieldNumber_Type = 3,
};

@interface Notification_Actions : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *text;

@property(nonatomic, readwrite, copy, null_resettable) NSString *message;

@property(nonatomic, readwrite, copy, null_resettable) NSString *type;

@end

#pragma mark - Notification_Options

typedef GPB_ENUM(Notification_Options_FieldNumber) {
  Notification_Options_FieldNumber_Label = 1,
  Notification_Options_FieldNumber_Value = 2,
};

@interface Notification_Options : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *label;

@property(nonatomic, readwrite) int64_t value;

@end

#pragma mark - NotificationResponse

typedef GPB_ENUM(NotificationResponse_FieldNumber) {
  NotificationResponse_FieldNumber_NotificationsArray = 1,
  NotificationResponse_FieldNumber_HasMoreData = 2,
};

@interface NotificationResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Notification*> *notificationsArray;
/** The number of items in @c notificationsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger notificationsArray_Count;

@property(nonatomic, readwrite) BOOL hasMoreData;

@end

#pragma mark - MobileEvents

typedef GPB_ENUM(MobileEvents_FieldNumber) {
  MobileEvents_FieldNumber_EventsArray = 1,
};

@interface MobileEvents : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Event*> *eventsArray;
/** The number of items in @c eventsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger eventsArray_Count;

@end

#pragma mark - Response

typedef GPB_ENUM(Response_FieldNumber) {
  Response_FieldNumber_Id_p = 1,
  Response_FieldNumber_RuleId = 2,
  Response_FieldNumber_DeviceId = 3,
  Response_FieldNumber_ActionId = 4,
  Response_FieldNumber_Type = 5,
  Response_FieldNumber_ResponseData = 6,
};

@interface Response : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *id_p;

@property(nonatomic, readwrite, copy, null_resettable) NSString *ruleId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *deviceId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *actionId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *type;

@property(nonatomic, readwrite, copy, null_resettable) NSData *responseData;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
