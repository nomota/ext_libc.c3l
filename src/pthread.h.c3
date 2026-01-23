// pthread.h.c3 

// C3 extern mappings for pthread.h functions and types.

module c::pthread;

// Thread Creation and Management

// Create a new thread.
alias ThreadFn = fn void*(void*);

extern fn CInt pthread_create(Pthread_t* thread, Pthread_attr_t* attr, ThreadFn start_routine, void* arg);

// Wait for thread termination
extern fn CInt pthread_join(Pthread_t thread, void** retval);

// Detach a thread (automatically release resources on termination)
extern fn CInt pthread_detach(Pthread_t thread);

// Terminate calling thread
extern fn void pthread_exit(void* retval);

// Return thread ID of calling thread
extern fn Pthread_t pthread_self();

// Compare two thread IDs
extern fn CInt pthread_equal(Pthread_t t1, Pthread_t t2);

// Send cancellation request to a thread
extern fn CInt pthread_cancel(Pthread_t thread);

// Set thread cancellation state
extern fn CInt pthread_setcancelstate(CInt state, CInt* oldstate);

// Set thread cancellation type
extern fn CInt pthread_setcanceltype(CInt type, CInt* oldtype);

// Create cancellation point
extern fn void pthread_testcancel();

// Thread Attribute Management

// Initialize thread attributes
extern fn CInt pthread_attr_init(Pthread_attr_t* attr);

// Destroy thread attributes
extern fn CInt pthread_attr_destroy(Pthread_attr_t* attr);

// Set/get detach state
extern fn CInt pthread_attr_setdetachstate(Pthread_attr_t* attr, CInt detachstate);
extern fn CInt pthread_attr_getdetachstate(Pthread_attr_t* attr, CInt* detachstate);

// Set/get stack size
extern fn CInt pthread_attr_setstacksize(Pthread_attr_t* attr, CSize stacksize);
extern fn CInt pthread_attr_getstacksize(Pthread_attr_t* attr, CSize* stacksize);

// Set/get stack address and size
extern fn CInt pthread_attr_setstack(Pthread_attr_t* attr, void* stackaddr, CSize stacksize);
extern fn CInt pthread_attr_getstack(Pthread_attr_t* attr, void** stackaddr, CSize* stacksize);

// Set/get scheduling policy
extern fn CInt pthread_attr_setschedpolicy(Pthread_attr_t* attr, CInt policy);
extern fn CInt pthread_attr_getschedpolicy(Pthread_attr_t* attr, CInt* policy);

// Mutex Functions

// Initialize mutex
extern fn CInt pthread_mutex_init(Pthread_mutex_t* mutex, Pthread_mutexattr_t* attr);

// Destroy mutex
extern fn CInt pthread_mutex_destroy(Pthread_mutex_t* mutex);

// Lock mutex
extern fn CInt pthread_mutex_lock(Pthread_mutex_t* mutex);

// Try to lock mutex (non-blocking)
extern fn CInt pthread_mutex_trylock(Pthread_mutex_t* mutex);

// Lock mutex with timeout
extern fn CInt pthread_mutex_timedlock(Pthread_mutex_t* mutex, Timespec* abstime);

// Unlock mutex
extern fn CInt pthread_mutex_unlock(Pthread_mutex_t* mutex);

// Mutex Attribute Management

// Initialize/destroy mutex attributes
extern fn CInt pthread_mutexattr_init(Pthread_mutexattr_t* attr);
extern fn CInt pthread_mutexattr_destroy(Pthread_mutexattr_t* attr);

// Set/get mutex type
extern fn CInt pthread_mutexattr_settype(Pthread_mutexattr_t* attr, CInt type);
extern fn CInt pthread_mutexattr_gettype(Pthread_mutexattr_t* attr, CInt* type);

// Set/get process-shared attribute
extern fn CInt pthread_mutexattr_setpshared(Pthread_mutexattr_t* attr, CInt pshared);
extern fn CInt pthread_mutexattr_getpshared(Pthread_mutexattr_t* attr, CInt* pshared);

// Set/get protocol attribute
extern fn CInt pthread_mutexattr_setprotocol(Pthread_mutexattr_t* attr, CInt protocol);
extern fn CInt pthread_mutexattr_getprotocol(Pthread_mutexattr_t* attr, CInt* protocol);

// Condition Variable Functions

// Initialize/destroy condition variable
extern fn CInt pthread_cond_init(Pthread_cond_t* cond, Pthread_condattr_t* attr);
extern fn CInt pthread_cond_destroy(Pthread_cond_t* cond);

// Wait on condition variable
extern fn CInt pthread_cond_wait(Pthread_cond_t* cond, Pthread_mutex_t* mutex);

// Wait on condition variable with timeout
extern fn CInt pthread_cond_timedwait(Pthread_cond_t* cond, Pthread_mutex_t* mutex, Timespec* abstime);

// Wake up one waiting thread
extern fn CInt pthread_cond_signal(Pthread_cond_t* cond);

// Wake up all waiting threads
extern fn CInt pthread_cond_broadcast(Pthread_cond_t* cond);

// Condition Variable Attribute Management

// Initialize/destroy condition variable attributes
extern fn CInt pthread_condattr_init(Pthread_condattr_t* attr);
extern fn CInt pthread_condattr_destroy(Pthread_condattr_t* attr);

// Set/get process-shared attribute
extern fn CInt pthread_condattr_setpshared(Pthread_condattr_t* attr, CInt pshared);
extern fn CInt pthread_condattr_getpshared(Pthread_condattr_t* attr, CInt* pshared);

// Set/get clock attribute
extern fn CInt pthread_condattr_setclock(Pthread_condattr_t* attr, CInt clock_id);
extern fn CInt pthread_condattr_getclock(Pthread_condattr_t* attr, CInt* clock_id);

// Read-Write Lock Functions

// Initialize/destroy read-write lock
extern fn CInt pthread_rwlock_init(Pthread_rwlock_t* rwlock, Pthread_rwlockattr_t* attr);
extern fn CInt pthread_rwlock_destroy(Pthread_rwlock_t* rwlock);

// Acquire read lock
extern fn CInt pthread_rwlock_rdlock(Pthread_rwlock_t* rwlock);

// Try to acquire read lock (non-blocking)
extern fn CInt pthread_rwlock_tryrdlock(Pthread_rwlock_t* rwlock);

// Acquire read lock with timeout
extern fn CInt pthread_rwlock_timedrdlock(Pthread_rwlock_t* rwlock, Timespec* abstime);

// Acquire write lock
extern fn CInt pthread_rwlock_wrlock(Pthread_rwlock_t* rwlock);

// Try to acquire write lock (non-blocking)
extern fn CInt pthread_rwlock_trywrlock(Pthread_rwlock_t* rwlock);

// Acquire write lock with timeout
extern fn CInt pthread_rwlock_timedwrlock(Pthread_rwlock_t* rwlock, Timespec* abstime);

// Unlock read-write lock
extern fn CInt pthread_rwlock_unlock(Pthread_rwlock_t* rwlock);

// Read-Write Lock Attribute Management

// Initialize/destroy read-write lock attributes
extern fn CInt pthread_rwlockattr_init(Pthread_rwlockattr_t* attr);
extern fn CInt pthread_rwlockattr_destroy(Pthread_rwlockattr_t* attr);

// Set/get process-shared attribute
extern fn CInt pthread_rwlockattr_setpshared(Pthread_rwlockattr_t* attr, CInt pshared);
extern fn CInt pthread_rwlockattr_getpshared(Pthread_rwlockattr_t* attr, CInt* pshared);

// Spinlock Functions

// Initialize/destroy spinlock
extern fn CInt pthread_spin_init(Pthread_spinlock_t* lock, CInt pshared);
extern fn CInt pthread_spin_destroy(Pthread_spinlock_t* lock);

// Acquire spinlock
extern fn CInt pthread_spin_lock(Pthread_spinlock_t* lock);

// Try to acquire spinlock (non-blocking)
extern fn CInt pthread_spin_trylock(Pthread_spinlock_t* lock);

// Release spinlock
extern fn CInt pthread_spin_unlock(Pthread_spinlock_t* lock);

// Barrier Functions

// Initialize/destroy barrier
extern fn CInt pthread_barrier_init(Pthread_barrier_t* barrier, Pthread_barrierattr_t* attr, CUInt count);
extern fn CInt pthread_barrier_destroy(Pthread_barrier_t* barrier);

// Wait at barrier
extern fn CInt pthread_barrier_wait(Pthread_barrier_t* barrier);

// Barrier Attribute Management

// Initialize/destroy barrier attributes
extern fn CInt pthread_barrierattr_init(Pthread_barrierattr_t* attr);
extern fn CInt pthread_barrierattr_destroy(Pthread_barrierattr_t* attr);

// Set/get process-shared attribute
extern fn CInt pthread_barrierattr_setpshared(Pthread_barrierattr_t* attr, CInt pshared);
extern fn CInt pthread_barrierattr_getpshared(Pthread_barrierattr_t* attr, CInt* pshared);

// Thread-Specific Data

// Create thread-specific data key
alias Keyfn = fn void(void*);
extern fn CInt pthread_key_create(Pthread_key_t* key, Keyfn destructor);

// Delete thread-specific data key
extern fn CInt pthread_key_delete(Pthread_key_t key);

// Set thread-specific data
extern fn CInt pthread_setspecific(Pthread_key_t key, void* value);

// Get thread-specific data
extern fn void* pthread_getspecific(Pthread_key_t key);

// Once Initialization

// Execute initialization routine once
alias Oncefn = fn void();
extern fn CInt pthread_once(Pthread_once_t* once_control, Oncefn init_routine);


// Cleanup Handlers

// Push cleanup handler
alias CleanupFn = fn void(void*);
extern fn void pthread_cleanup_push(CleanupFn routine, void* arg);

// Pop and execute cleanup handler
extern fn void pthread_cleanup_pop(CInt execute);

// Type Definitions

alias CSize = usz;

// Opaque types
alias Pthread_t = CULong;           // Thread ID
alias Pthread_key_t = CUInt;        // Thread-specific data key

// Timespec structure
struct Timespec {
    CLong tv_sec;    // Seconds
    CLong tv_nsec;   // Nanoseconds
}

// Scheduling parameters
struct Sched_param {
    CInt sched_priority;  // Scheduling priority
}

// Structure Definitions

// Thread attributes
struct Pthread_attr_t {
    char[56] __size;      // Internal implementation (platform-dependent)
}

// Mutex
struct Pthread_mutex_t {
    char[40] __size;      // Internal implementation (platform-dependent)
}

// Mutex attributes
struct Pthread_mutexattr_t {
    char[4] __size;       // Internal implementation
}

// Condition variable
struct Pthread_cond_t {
    char[48] __size;      // Internal implementation (platform-dependent)
}

// Condition variable attributes
struct Pthread_condattr_t {
    char[4] __size;       // Internal implementation
}

// Read-write lock
struct Pthread_rwlock_t {
    char[56] __size;      // Internal implementation (platform-dependent)
}

// Read-write lock attributes
struct Pthread_rwlockattr_t {
    char[8] __size;       // Internal implementation
}

// Spinlock
struct Pthread_spinlock_t {
    CInt __lock;          // Lock state
}

// Barrier
struct Pthread_barrier_t {
    char[32] __size;      // Internal implementation (platform-dependent)
}

// Barrier attributes
struct Pthread_barrierattr_t {
    char[4] __size;       // Internal implementation
}

// Once control
struct Pthread_once_t {
    CInt __once;          // Initialization state
}

// Initialization Macros

// Static initializers
const Pthread_mutex_t PTHREAD_MUTEX_INITIALIZER = {};
const Pthread_cond_t PTHREAD_COND_INITIALIZER = {};
const Pthread_rwlock_t PTHREAD_RWLOCK_INITIALIZER = {};
const Pthread_once_t PTHREAD_ONCE_INIT = { .__once = 0 };

// Constant Definitions

// Detach state
const CInt PTHREAD_CREATE_JOINABLE = 0;  // Joinable (default)
const CInt PTHREAD_CREATE_DETACHED = 1;  // Detached

// Cancellation state
const CInt PTHREAD_CANCEL_ENABLE = 0;    // Cancellation enabled (default)
const CInt PTHREAD_CANCEL_DISABLE = 1;   // Cancellation disabled

// Cancellation type
const CInt PTHREAD_CANCEL_DEFERRED = 0;     // Deferred cancellation (default)
const CInt PTHREAD_CANCEL_ASYNCHRONOUS = 1; // Asynchronous cancellation

// Mutex types
const CInt PTHREAD_MUTEX_NORMAL = 0;        // Normal mutex
const CInt PTHREAD_MUTEX_RECURSIVE = 1;     // Recursive mutex
const CInt PTHREAD_MUTEX_ERRORCHECK = 2;    // Error-checking mutex
const CInt PTHREAD_MUTEX_DEFAULT = 0;       // Default mutex

// Process sharing
const CInt PTHREAD_PROCESS_PRIVATE = 0;  // Private to process (default)
const CInt PTHREAD_PROCESS_SHARED = 1;   // Shared between processes

// Mutex protocol
const CInt PTHREAD_PRIO_NONE = 0;     // No priority
const CInt PTHREAD_PRIO_INHERIT = 1;  // Priority inheritance
const CInt PTHREAD_PRIO_PROTECT = 2;  // Priority protection

// Barrier return value
const CInt PTHREAD_BARRIER_SERIAL_THREAD = -1;  // Last thread to pass barrier

// Scheduling policies
const CInt SCHED_OTHER = 0;   // Standard round-robin time-sharing
const CInt SCHED_FIFO = 1;    // First-in, first-out
const CInt SCHED_RR = 2;      // Round-robin
