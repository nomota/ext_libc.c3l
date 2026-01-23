// sys.time.h.c3

module c::sys::time;

// ========== Linux ==========

module c::sys::time @if(env::LINUX);

// Structures
struct Timeval {
    long tv_sec;   // Seconds
    long tv_usec;  // Microseconds
}

struct Timezone {
    int tz_minuteswest;  // Minutes west of Greenwich
    int tz_dsttime;      // Type of DST correction
}

struct Itimerval {
    Timeval it_interval;  // Timer interval
    Timeval it_value;     // Current value
}

// Function Declarations
extern fn int gettimeofday(Timeval* tv, Timezone* tz);
extern fn int settimeofday(Timeval* tv, Timezone* tz);
extern fn int adjtime(Timeval* delta, Timeval* olddelta);

extern fn int getitimer(int which, Itimerval* curr_value);
extern fn int setitimer(int which, Itimerval* new_value, Itimerval* old_value);

extern fn int utimes(char* filename, Timeval[2] times);
extern fn int lutimes(char* filename, Timeval[2] times);
extern fn int futimes(int fd, Timeval[2] times);
extern fn int futimesat(int dirfd, char* pathname, Timeval[2] times);

// Timer types for setitimer/getitimer
const int ITIMER_REAL = 0;     // Real time
const int ITIMER_VIRTUAL = 1;  // Process virtual time
const int ITIMER_PROF = 2;     // Process and system time

// Macros for timeval operations
macro void timerclear(Timeval* tvp) {
    tvp.tv_sec = 0;
    tvp.tv_usec = 0;
}

macro bool timerisset(Timeval* tvp) => (tvp.tv_sec || tvp.tv_usec);

macro void timeradd(Timeval* a, Timeval* b, Timeval* result) {
    result.tv_sec = a.tv_sec + b.tv_sec;
    result.tv_usec = a.tv_usec + b.tv_usec;
    if (result.tv_usec >= 1000000) {
        result.tv_sec++;
        result.tv_usec -= 1000000;
    }
}

macro void timersub(Timeval* a, Timeval* b, Timeval* result) {
    result.tv_sec = a.tv_sec - b.tv_sec;
    result.tv_usec = a.tv_usec - b.tv_usec;
    if (result.tv_usec < 0) {
        result.tv_sec--;
        result.tv_usec += 1000000;
    }
}

// ========== Darwin (macOS) ==========

module c::sys::time @if(env::DARWIN);

// Structures
struct Timeval {
    long tv_sec;   // Seconds
    int tv_usec;   // Microseconds (note: int on macOS, not long)
}

struct Timezone {
    int tz_minuteswest;
    int tz_dsttime;
}

struct Itimerval {
    Timeval it_interval;
    Timeval it_value;
}

// Function Declarations
extern fn int gettimeofday(Timeval* tv, Timezone* tz);
extern fn int settimeofday(Timeval* tv, Timezone* tz);
extern fn int adjtime(Timeval* delta, Timeval* olddelta);

extern fn int getitimer(int which, Itimerval* curr_value);
extern fn int setitimer(int which, Itimerval* new_value, Itimerval* old_value);

extern fn int utimes(char* filename, Timeval[2] times);
extern fn int lutimes(char* filename, Timeval[2] times);
extern fn int futimes(int fd, Timeval[2] times);

// Timer types
const int ITIMER_REAL = 0;
const int ITIMER_VIRTUAL = 1;
const int ITIMER_PROF = 2;

// Macros for timeval operations
macro void timerclear(Timeval* tvp) {
    tvp.tv_sec = 0;
    tvp.tv_usec = 0;
}

macro bool timerisset(Timeval* tvp) => (tvp.tv_sec || tvp.tv_usec);


macro void timeradd(Timeval* a, Timeval* b, Timeval* result) {
    result.tv_sec = a.tv_sec + b.tv_sec;
    result.tv_usec = a.tv_usec + b.tv_usec;
    if (result.tv_usec >= 1000000) {
        result.tv_sec++;
        result.tv_usec -= 1000000;
    }
}

macro void timersub(Timeval* a, Timeval* b, Timeval* result) {
    result.tv_sec = a.tv_sec - b.tv_sec;
    result.tv_usec = a.tv_usec - b.tv_usec;
    if (result.tv_usec < 0) {
        result.tv_sec--;
        result.tv_usec += 1000000;
    }
}

// Darwin-specific: clock selection for gettimeofday
const int CLOCK_REALTIME = 0;
const int CLOCK_MONOTONIC = 6;

// ========== FreeBSD ==========

module c::sys::time @if(env::FREEBSD);

// Structures
struct Timeval {
    long tv_sec;
    long tv_usec;
}

struct Timezone {
    int tz_minuteswest;
    int tz_dsttime;
}

struct Itimerval {
    Timeval it_interval;
    Timeval it_value;
}

// Function Declarations
extern fn int gettimeofday(Timeval* tv, Timezone* tz);
extern fn int settimeofday(Timeval* tv, Timezone* tz);
extern fn int adjtime(Timeval* delta, Timeval* olddelta);

extern fn int getitimer(int which, Itimerval* curr_value);
extern fn int setitimer(int which, Itimerval* new_value, Itimerval* old_value);

extern fn int utimes(char* filename, Timeval[2] times);
extern fn int lutimes(char* filename, Timeval[2] times);
extern fn int futimes(int fd, Timeval[2] times);
extern fn int futimesat(int dirfd, char* pathname, Timeval[2] times);

// Timer types
const int ITIMER_REAL = 0;
const int ITIMER_VIRTUAL = 1;
const int ITIMER_PROF = 2;

// Macros for timeval operations
macro void timerclear(Timeval* tvp) {
    tvp.tv_sec = 0;
    tvp.tv_usec = 0;
}

macro bool timerisset(Timeval* tvp) => (tvp.tv_sec || tvp.tv_usec);


macro void timeradd(Timeval* a, Timeval* b, Timeval* result) {
    result.tv_sec = a.tv_sec + b.tv_sec;
    result.tv_usec = a.tv_usec + b.tv_usec;
    if (result.tv_usec >= 1000000) {
        result.tv_sec++;
        result.tv_usec -= 1000000;
    }
}

macro void timersub(Timeval* a, Timeval* b, Timeval* result) {
    result.tv_sec = a.tv_sec - b.tv_sec;
    result.tv_usec = a.tv_usec - b.tv_usec;
    if (result.tv_usec < 0) {
        result.tv_sec--;
        result.tv_usec += 1000000;
    }
}

// FreeBSD-specific
extern fn int bintime(Bintime* bt);
extern fn int nanotime(Timespec* ts);
extern fn int microtime(Timeval* tv);

struct Bintime {
    long sec;
    ulong frac;
}

// ========== NetBSD ==========

module c::sys::time @if(env::NETBSD);

// Structures
struct Timeval {
    long tv_sec;
    int tv_usec;
}

struct Timezone {
    int tz_minuteswest;
    int tz_dsttime;
}

struct Itimerval {
    Timeval it_interval;
    Timeval it_value;
}

// Function Declarations
extern fn int gettimeofday(Timeval* tv, Timezone* tz);
extern fn int settimeofday(Timeval* tv, Timezone* tz);
extern fn int adjtime(Timeval* delta, Timeval* olddelta);

extern fn int getitimer(int which, Itimerval* curr_value);
extern fn int setitimer(int which, Itimerval* new_value, Itimerval* old_value);

extern fn int utimes(char* filename, Timeval[2] times);
extern fn int lutimes(char* filename, Timeval[2] times);
extern fn int futimes(int fd, Timeval[2] times);

// Timer types
const int ITIMER_REAL = 0;
const int ITIMER_VIRTUAL = 1;
const int ITIMER_PROF = 2;

// Macros for timeval operations
macro void timerclear(Timeval* tvp) {
    tvp.tv_sec = 0;
    tvp.tv_usec = 0;
}

macro bool timerisset(Timeval* tvp) => (tvp.tv_sec || tvp.tv_usec);


macro void timeradd(Timeval* a, Timeval* b, Timeval* result) {
    result.tv_sec = a.tv_sec + b.tv_sec;
    result.tv_usec = a.tv_usec + b.tv_usec;
    if (result.tv_usec >= 1000000) {
        result.tv_sec++;
        result.tv_usec -= 1000000;
    }
}

macro void timersub(Timeval* a, Timeval* b, Timeval* result) {
    result.tv_sec = a.tv_sec - b.tv_sec;
    result.tv_usec = a.tv_usec - b.tv_usec;
    if (result.tv_usec < 0) {
        result.tv_sec--;
        result.tv_usec += 1000000;
    }
}

// ========== OpenBSD ==========

module c::sys::time @if(env::OPENBSD);

// Structures
struct Timeval {
    long tv_sec;
    long tv_usec;
}

struct Timezone {
    int tz_minuteswest;
    int tz_dsttime;
}

struct Itimerval {
    Timeval it_interval;
    Timeval it_value;
}

// Function Declarations
extern fn int gettimeofday(Timeval* tv, Timezone* tz);
extern fn int settimeofday(Timeval* tv, Timezone* tz);
extern fn int adjtime(Timeval* delta, Timeval* olddelta);

extern fn int getitimer(int which, Itimerval* curr_value);
extern fn int setitimer(int which, Itimerval* new_value, Itimerval* old_value);

extern fn int utimes(char* filename, Timeval[2] times);
extern fn int lutimes(char* filename, Timeval[2] times);
extern fn int futimes(int fd, Timeval[2] times);

// Timer types
const int ITIMER_REAL = 0;
const int ITIMER_VIRTUAL = 1;
const int ITIMER_PROF = 2;

// Macros for timeval operations
macro void timerclear(Timeval* tvp) {
    tvp.tv_sec = 0;
    tvp.tv_usec = 0;
}

macro bool timerisset(Timeval* tvp) => (tvp.tv_sec || tvp.tv_usec);


macro void timeradd(Timeval* a, Timeval* b, Timeval* result) {
    result.tv_sec = a.tv_sec + b.tv_sec;
    result.tv_usec = a.tv_usec + b.tv_usec;
    if (result.tv_usec >= 1000000) {
        result.tv_sec++;
        result.tv_usec -= 1000000;
    }
}

macro void timersub(Timeval* a, Timeval* b, Timeval* result) {
    result.tv_sec = a.tv_sec - b.tv_sec;
    result.tv_usec = a.tv_usec - b.tv_usec;
    if (result.tv_usec < 0) {
        result.tv_sec--;
        result.tv_usec += 1000000;
    }
}

// ========== Windows ==========

// Note: Windows does not have sys/time.h
// For Windows, use the following alternatives:
// - GetSystemTime() / GetLocalTime() for current time
// - QueryPerformanceCounter() for high-resolution timing
// - _ftime() / _ftime64() for timeval-like functionality (in sys/timeb.h)
// - SetTimer() / timeSetEvent() for timers

module c::sys::time @if(env::WIN32);

// Windows does not have native sys/time.h
// However, some compatibility layers (like MinGW) may provide it
// Here we define minimal compatibility structures

// Compatibility structures (if needed)
struct Timeval {
    long tv_sec;
    long tv_usec;
}

// Note: The following functions are NOT native to Windows
// They may be provided by compatibility layers like MinGW or Cygwin
// For native Windows code, use Windows API instead

// Example of what you might need to implement for Windows:
/*
extern fn int gettimeofday(Timeval* tv, void* tz) @extern("gettimeofday") @if(env::MINGW);

// Or implement yourself:
fn int gettimeofday(Timeval* tv, void* tz) @if(!env::MINGW) {
    // Use GetSystemTimeAsFileTime() or similar
    // Convert FILETIME to timeval
    return -1; // Not implemented
}
*/

// For native Windows timing, use these instead:
// - GetSystemTime() / GetLocalTime() - in windows.h
// - QueryPerformanceCounter() / QueryPerformanceFrequency() - in windows.h
// - _ftime() / _ftime64() - provides millisecond resolution
