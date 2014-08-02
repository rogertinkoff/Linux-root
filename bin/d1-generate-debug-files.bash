#!/bin/bash

if [ "$BuildRoot" == "" ];
then
	echo "d1-generate-debug-files.bash: no BuildRoot defined"
	exit
fi

DEBUG_FILES="\
    $BuildRoot/sw/nestlabs/lib/nlweave-platform/Weave6LoWPANConnectionModeDebug.h \
    $BuildRoot/sw/nestlabs/lib/nlweave-platform/Weave6LoWPANSeriveConnectionModeDebug.h \
    $BuildRoot/sw/nestlabs/lib/nlweave-platform/WeaveDeviceControlFeatureDebug.h \
    $BuildRoot/sw/nestlabs/lib/nlweave-platform/WeaveDeviceDescriptionFeatureDebug.h \
    $BuildRoot/sw/nestlabs/lib/nlweave-platform/WeaveFabricProvisioningFeatureDebug.h \
    $BuildRoot/sw/nestlabs/lib/nlweave-platform/WeaveNetworkProvisioningFeatureDebug.h \
    $BuildRoot/sw/nestlabs/lib/nlweave-platform/WeaveSensorDataUploadFeatureDebug.h \
    $BuildRoot/sw/nestlabs/lib/nlweave-platform/WeaveServiceProvisioningFeatureDebug.h \
    $BuildRoot/sw/nestlabs/lib/nlweave-platform/WeaveStateManagerDebug.h \
    $BuildRoot/sw/nestlabs/lib/nlweave-platform/WeaveStationConnectionModeDebug.h \
    $BuildRoot/sw/nestlabs/lib/nlweave-platform/WeaveWiFiConnectionModeDebug.h \
    $BuildRoot/sw/nestlabs/apps/topaz/app/src/weavefeatures/nltopazweavesensordatauploadfeaturedebug.h \
    "

DEBUG_FILES_TO_PROCESS="\
    $BuildRoot/sw/nestlabs/lib/nlweave-platform/Weave6LoWPANConnectionModeDebug.h \
"

DEBUG_PREFIXES="\
    SIXLOWP \
    SIXLOWPSVC \
    AP \
    DEVCNTL \
    DEVDESC \
    FABPROV \
    NETPROV \
    BDX \
    SERVPROV \
    STATEMGR \
    STATION \
    WIFI \
    "

DEBUG_USE_P0="\
    FALSE \
    FALSE \
    FALSE \
    FALSE \
    FALSE \
    FALSE \
    TRUE \
    FALSE \
    FALSE \
    FALSE \
    FALSE \
    FALSE \
    "

DEBUG_USE_P2="\
    TRUE \
    TRUE \
    TRUE \
    TRUE \
    TRUE \
    TRUE \
    TRUE \
    TRUE \
    TRUE \
    TRUE \
    TRUE \
    TRUE \
    "

for i in $DEBUG_FILES_TO_PROCESS;
do
    echo "//
// Begin Emacs abbrev-generated debugging header
//
// Replace XXXX with the prefix of your choice
//
// Wrap all debugging code in #if (XXXX_DEBUG > 0)/#endif, or:
//
// nlLogDebugXXXX_P0(...) for CRITICAL messages (will show up even if XXXX_DEBUG is 0)
// nlLogDebugXXXX_P1(...) for very important messages
// nlLogDebugXXXX_P2(...) for slightly important messages
// nlLogDeclareFunctionTracerXXXX_P1 for very important function traces
// nlLogDeclareFunctionTracerXXXX_P2 for slightly important function traces
//

#ifndef WEAVE_PLATFORM_DEBUG_XXXX
#define WEAVE_PLATFORM_DEBUG_XXXX

//
// Set XXXX_DEBUG to 1 for P1 debugging, 2 for P1 and P2 debugging
//
#define XXXX_DEBUG (0)

//
// Max length of log messages
//
#define XXXX_MAX_LOG_MSG_LEN (100)

//
// DO NOT MODIFY BELOW THIS LINE, other than to replace XXXX with your prefix
//

#if (XXXX_DEBUG == 1) && defined(BUILD_CONFIG_DEVELOPMENT)
nlDeclareDebugLogger(XXXX_P1, XXXX_MAX_LOG_MSG_LEN);
#define nlLogDeclareFunctionTracerXXXX_P1() nlLogDeclareFunctionTracer(tracer)
static void nlLogDebugXXXX_P2(const char *str, ...) {}
#define nlLogDeclareFunctionTracerXXXX_P2() {}
#elif (XXXX_DEBUG == 1) && defined(BUILD_CONFIG_RELEASE)
#define nlDeclareDebugLogger(LOGGER_PREFIX, MAXLEN)                     \\
    static void nlLogDebug##LOGGER_PREFIX(const char *str, ...) {       \\
        char prefixed_str [MAXLEN];                                     \\
        va_list vl;                                                     \\
        va_start(vl, str);                                              \\
        snprintf(prefixed_str, MAXLEN, #LOGGER_PREFIX \": %s\", str);\\
        vprintf(prefixed_str, vl);                                      \\
    }
nlDeclareDebugLogger(XXXX_P1, XXXX_MAX_LOG_MSG_LEN);
#define nlLogDeclareFunctionTracerXXXX_P1() printf(\"XXXX_P1: --> %s\", __PRETTY_FUNCTION__);
static void nlLogDebugXXXX_P2(const char *str, ...) {}
#define nlLogDeclareFunctionTracerXXXX_P2() {}
#elif (XXXX_DEBUG == 2) && defined(BUILD_CONFIG_DEVELOPMENT)
nlDeclareDebugLogger(XXXX_P1, XXXX_MAX_LOG_MSG_LEN);
#define nlLogDeclareFunctionTracerXXXX_P1() nlLogDeclareFunctionTracer(tracer)
nlDeclareDebugLogger(XXXX_P2, XXXX_MAX_LOG_MSG_LEN);
#define nlLogDeclareFunctionTracerXXXX_P2() nlLogDeclareFunctionTracer(tracer)
#elif (XXXX_DEBUG == 2) && defined(BUILD_CONFIG_RELEASE)
#define nlDeclareDebugLogger(LOGGER_PREFIX, MAXLEN)                     \\
    static void nlLogDebug##LOGGER_PREFIX(const char *str, ...) {       \\
        char prefixed_str [MAXLEN];                                     \\
        va_list vl;                                                     \\
        va_start(vl, str);                                              \\
        snprintf(prefixed_str, MAXLEN, #LOGGER_PREFIX \": %s\", str);\\
        vprintf(prefixed_str, vl);                                      \\
    }
nlDeclareDebugLogger(XXXX_P1, XXXX_MAX_LOG_MSG_LEN);
#define nlLogDeclareFunctionTracerXXXX_P1() printf(\"XXXX_P1: --> %s\", __PRETTY_FUNCTION__);
nlDeclareDebugLogger(XXXX_P2, XXXX_MAX_LOG_MSG_LEN);
#define nlLogDeclareFunctionTracerXXXX_P2() printf(\"XXXX_P2: --> %s\", __PRETTY_FUNCTION__);
#else
static void nlLogDebugXXXX_P1(const char *str, ...) {}
#define nlLogDeclareFunctionTracerXXXX_P1() {}
static void nlLogDebugXXXX_P2(const char *str, ...) {}
#define nlLogDeclareFunctionTracerXXXX_P2() {}
#endif

//
// Set this to 1 only if you intend to have any P0 logging
//
#define XXXX_ALLOW_P0_LOGGING (0)

#if XXXX_ALLOW_P0_LOGGING && !defined(nlDeclareDebugLogger)
#define nlDeclareDebugLogger(LOGGER_PREFIX, MAXLEN)                     \\
    static void nlLogDebug##LOGGER_PREFIX(const char *str, ...) {       \\
        char prefixed_str [MAXLEN];                                     \\
        va_list vl;                                                     \\
        va_start(vl, str);                                              \\
        snprintf(prefixed_str, MAXLEN, #LOGGER_PREFIX \": %s\", str);\\
        vprintf(prefixed_str, vl);                                      \\
    }
#endif

nlDeclareDebugLogger(XXXX_P0, XXXX_MAX_LOG_MSG_LEN);

#endif // WEAVE_PLATFORM_DEBUG_XXXX
//
// End Emacs abbrev-generated debugging header
//
"
done