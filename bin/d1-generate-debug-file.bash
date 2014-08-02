#!/bin/bash

if [ "$BuildRoot" == "" ];
then
	echo "d1-generate-debug-file.bash: no BuildRoot defined"
	exit
fi

if [ "$1" == "" ];
then
	echo "usage: d1-generate-debug-file.bash [prefix]"
	exit
fi

echo "//
// Begin Emacs abbrev-generated debugging header
//
// Replace $1 with the prefix of your choice
//
// Wrap all debugging code in #if ($1_DEBUG > 0)/#endif, or:
//
// nlLogDebug$1_P0(...) for CRITICAL messages (will show up even if $1_DEBUG is 0)
// nlLogDebug$1_P1(...) for very important messages
// nlLogDebug$1_P2(...) for slightly important messages
// nlLogDeclareFunctionTracer$1_P1 for very important function traces
// nlLogDeclareFunctionTracer$1_P2 for slightly important function traces
//

#ifndef WEAVE_PLATFORM_DEBUG_$1
#define WEAVE_PLATFORM_DEBUG_$1

//
// Set $1_DEBUG to 1 for P1 debugging, 2 for P1 and P2 debugging
//
#define $1_DEBUG (0)

//
// Max length of log messages
//
#define $1_MAX_LOG_MSG_LEN (100)

//
// DO NOT MODIFY BELOW THIS LINE, other than to replace $1 with your prefix
//

#if ($1_DEBUG == 1) && defined(BUILD_CONFIG_DEVELOPMENT)
nlDeclareDebugLogger($1_P1, $1_MAX_LOG_MSG_LEN);
#define nlLogDeclareFunctionTracer$1_P1() nlLogDebug$1(\"%s\\n\");
static void nlLogDebug$1_P2(const char *str, ...) {}
#define nlLogDeclareFunctionTracer$1_P2() {}
#elif ($1_DEBUG == 1) && defined(BUILD_CONFIG_RELEASE)
#define nlDeclareDebugLogger(LOGGER_PREFIX, MAXLEN)                     \\
    static void nlLogDebug##LOGGER_PREFIX(const char *str, ...) {       \\
        char prefixed_str [MAXLEN];                                     \\
        va_list vl;                                                     \\
        va_start(vl, str);                                              \\
        snprintf(prefixed_str, MAXLEN, #LOGGER_PREFIX \": %s\", str);\\
        vprintf(prefixed_str, vl);                                      \\
    }
nlDeclareDebugLogger($1_P1, $1_MAX_LOG_MSG_LEN);
#define nlLogDeclareFunctionTracer$1_P1() printf(\"$1_P1: --> %s\", __PRETTY_FUNCTION__);
static void nlLogDebug$1_P2(const char *str, ...) {}
#define nlLogDeclareFunctionTracer$1_P2() {}
#elif ($1_DEBUG == 2) && defined(BUILD_CONFIG_DEVELOPMENT)
nlDeclareDebugLogger($1_P1, $1_MAX_LOG_MSG_LEN);
#define nlLogDeclareFunctionTracer$1_P1() 
nlDeclareDebugLogger($1_P2, $1_MAX_LOG_MSG_LEN);
#define nlLogDeclareFunctionTracer$1_P2() nlLogDeclareFunctionTracer(tracer)
#elif ($1_DEBUG == 2) && defined(BUILD_CONFIG_RELEASE)
#define nlDeclareDebugLogger(LOGGER_PREFIX, MAXLEN)                     \\
    static void nlLogDebug##LOGGER_PREFIX(const char *str, ...) {       \\
        char prefixed_str [MAXLEN];                                     \\
        va_list vl;                                                     \\
        va_start(vl, str);                                              \\
        snprintf(prefixed_str, MAXLEN, #LOGGER_PREFIX \": %s\", str);\\
        vprintf(prefixed_str, vl);                                      \\
    }
nlDeclareDebugLogger($1_P1, $1_MAX_LOG_MSG_LEN);
#define nlLogDeclareFunctionTracer$1_P1() printf(\"$1_P1: --> %s\", __PRETTY_FUNCTION__);
nlDeclareDebugLogger($1_P2, $1_MAX_LOG_MSG_LEN);
#define nlLogDeclareFunctionTracer$1_P2() printf(\"$1_P2: --> %s\", __PRETTY_FUNCTION__);
#else
static void nlLogDebug$1_P1(const char *str, ...) {}
#define nlLogDeclareFunctionTracer$1_P1() {}
static void nlLogDebug$1_P2(const char *str, ...) {}
#define nlLogDeclareFunctionTracer$1_P2() {}
#endif

//
// Set this to 1 only if you intend to have any P0 logging
//
#define $1_ALLOW_P0_LOGGING (0)

#if $1_ALLOW_P0_LOGGING && !defined(nlDeclareDebugLogger)
#define nlDeclareDebugLogger(LOGGER_PREFIX, MAXLEN)                     \\
    static void nlLogDebug##LOGGER_PREFIX(const char *str, ...) {       \\
        char prefixed_str [MAXLEN];                                     \\
        va_list vl;                                                     \\
        va_start(vl, str);                                              \\
        snprintf(prefixed_str, MAXLEN, #LOGGER_PREFIX \": %s\", str);\\
        vprintf(prefixed_str, vl);                                      \\
    }
nlDeclareDebugLogger($1_P0, $1_MAX_LOG_MSG_LEN);
#endif

#endif // WEAVE_PLATFORM_DEBUG_$1
//
// End Emacs abbrev-generated debugging header
//
"