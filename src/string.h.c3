
// string.h.c3

// string.h C3 Extern Mapping
// Unified for Windows (WIN32) and POSIX systems

module string;

// Platform-specific wchar_t handling:
alias Wchar_t @if(env::WIN32) = ushort;
alias Wchar_t @if(env::POSIX) = uint;

// Common Functions (All Platforms)

// Copying Functions
extern fn void* memcpy(void* dest, void* src, usz n);
extern fn void* memmove(void* dest, void* src, usz n);
extern fn char* strcpy(char* dest, char* src);
extern fn char* strncpy(char* dest, char* src, usz n);

// Concatenation Functions
extern fn char* strcat(char* dest, char* src);
extern fn char* strncat(char* dest, char* src, usz n);

// Comparison Functions
extern fn CInt memcmp(void* s1, void* s2, usz n);
extern fn CInt strcmp(char* s1, char* s2);
extern fn CInt strncmp(char* s1, char* s2, usz n);
extern fn CInt strcoll(char* s1, char* s2);

// Transformation Functions
extern fn usz strxfrm(char* dest, char* src, usz n);

// Search Functions
extern fn void* memchr(void* s, CInt c, usz n);
extern fn char* strchr(char* s, CInt c);
extern fn usz strcspn(char* s, char* reject);
extern fn char* strpbrk(char* s, char* accept);
extern fn char* strrchr(char* s, CInt c);
extern fn usz strspn(char* s, char* accept);
extern fn char* strstr(char* haystack, char* needle);
extern fn char* strtok(char* str, char* delim);

// Other Functions
extern fn void* memset(void* s, CInt c, usz n);
extern fn char* strerror(CInt errnum);
extern fn usz strlen(char* s);

// C23 / Modern additions (widely available)
extern fn void* memccpy(void* dest, void* src, CInt c, usz n);
extern fn char* strdup(char* s);

// POSIX Extensions

module string @if(env::POSIX);

// POSIX String Functions
extern fn CInt strcasecmp(char* s1, char* s2);
extern fn CInt strncasecmp(char* s1, char* s2, usz n);

// String Length (POSIX.1-2008)
extern fn usz strnlen(char* s, usz maxlen);

// String Duplication
extern fn char* strndup(char* s, usz n);

// String Parsing
extern fn char* strsep(char** stringp, char* delim);

// Signal String Functions
extern fn char* strsignal(CInt sig);

// Thread-safe strerror
extern fn CInt strerror_r(CInt errnum, char* buf, usz buflen);

// String Tokenization (reentrant)
extern fn char* strtok_r(char* str, char* delim, char** saveptr);

// BSD Extensions (also in POSIX systems)
extern fn usz strlcpy(char* dest, char* src, usz size);
extern fn usz strlcat(char* dest, char* src, usz size);

// Memory Functions
extern fn void* mempcpy(void* dest, void* src, usz n);  // GNU extension
extern fn void* memrchr(void* s, CInt c, usz n);  // GNU extension
extern fn void* rawmemchr(void* s, CInt c);  // GNU extension
extern fn void* memmem(void* haystack, usz haystacklen, void* needle, usz needlelen);

// String Prefix/Suffix (GNU extensions)
extern fn CInt strverscmp(char* s1, char* s2);

// Explicit memory operations
extern fn void explicit_bzero(void* s, usz n);  // POSIX.1-2008

// Case conversion (non-standard but common)
extern fn char* index(char* s, CInt c);  // Obsolete, use strchr
extern fn char* rindex(char* s, CInt c);  // Obsolete, use strrchr
extern fn void bcopy(void* src, void* dest, usz n);  // Obsolete, use memmove
extern fn void bzero(void* s, usz n);  // Obsolete, use memset
extern fn CInt bcmp(void* s1, void* s2, usz n);  // Obsolete, use memcmp
extern fn CInt ffs(CInt i);  // Find first set bit
extern fn CInt ffsl(CLong i);
extern fn CInt ffsll(CLongLong i);

// String list functions (non-standard)
extern fn char* stpcpy(char* dest, char* src);  // POSIX.1-2008
extern fn char* stpncpy(char* dest, char* src, usz n);  // POSIX.1-2008

// Locale-specific
extern fn char* strcoll_l(char* s1, char* s2, void* locale);
extern fn usz strxfrm_l(char* dest, char* src, usz n, void* locale);
extern fn CInt strcasecmp_l(char* s1, char* s2, void* locale);
extern fn CInt strncasecmp_l(char* s1, char* s2, usz n, void* locale);


// Linux-specific Extensions

module string @if(env::LINUX);

// Additional GNU/Linux extensions
extern fn char* strchrnul(char* s, CInt c);  // GNU extension
extern fn char* basename(char* path);  // GNU version (different from POSIX)
extern fn void* memfrob(void* s, usz n);  // GNU extension (obfuscation)

// Windows (WIN32) Extensions

module string @if(env::WIN32);

// Secure CRT Functions (_s suffix)
extern fn CInt memcpy_s(void* dest, usz destSize, void* src, usz count);
extern fn CInt memmove_s(void* dest, usz destSize, void* src, usz count);
extern fn CInt strcpy_s(char* dest, usz destSize, char* src);
extern fn CInt strncpy_s(char* dest, usz destSize, char* src, usz count);
extern fn CInt strcat_s(char* dest, usz destSize, char* src);
extern fn CInt strncat_s(char* dest, usz destSize, char* src, usz count);
extern fn CInt strerror_s(char* buffer, usz bufferSize, CInt errnum);
extern fn usz strnlen_s(char* str, usz maxCount);

// Case Conversion (MS-specific, modify in place)
extern fn char* _strlwr(char* str);
extern fn char* _strupr(char* str);
extern fn char* _strlwr_s(char* str, usz size);
extern fn char* _strupr_s(char* str, usz size);

// Locale-specific case conversion
extern fn char* _strlwr_l(char* str, void* locale);
extern fn char* _strupr_l(char* str, void* locale);
extern fn char* _strlwr_s_l(char* str, usz size, void* locale);
extern fn char* _strupr_s_l(char* str, usz size, void* locale);

// String reversal (MS-specific)
extern fn char* _strrev(char* str);

// Set functions (MS-specific)
extern fn char* _strset(char* str, CInt c);
extern fn char* _strnset(char* str, CInt c, usz count);
extern fn char* _strset_s(char* str, usz destSize, CInt c);
extern fn char* _strnset_s(char* str, usz destSize, CInt c, usz count);

// Duplication (MS-specific underscore version)
extern fn char* _strdup(char* str);
extern fn char* _strndup(char* str, usz count);

// Case-insensitive comparison (MS-specific names)
extern fn CInt _stricmp(char* s1, char* s2);
extern fn CInt _strnicmp(char* s1, char* s2, usz count);
extern fn CInt _stricmp_l(char* s1, char* s2, void* locale);
extern fn CInt _strnicmp_l(char* s1, char* s2, usz count, void* locale);

// Collation (MS-specific)
extern fn CInt _strcoll_l(char* s1, char* s2, void* locale);
extern fn CInt _stricoll(char* s1, char* s2);
extern fn CInt _stricoll_l(char* s1, char* s2, void* locale);
extern fn CInt _strncoll(char* s1, char* s2, usz count);
extern fn CInt _strncoll_l(char* s1, char* s2, usz count, void* locale);
extern fn CInt _strnicoll(char* s1, char* s2, usz count);
extern fn CInt _strnicoll_l(char* s1, char* s2, usz count, void* locale);

// Token functions (MS-specific)
extern fn char* _strtok_s(char* str, char* delimiters, char** context);

// Find functions
extern fn char* _strpbrk_l(char* str, char* control, void* locale);
extern fn usz _strspn_l(char* str, char* control, void* locale);
extern fn usz _strcspn_l(char* str, char* control, void* locale);

// Transformation (MS-specific)
extern fn usz _strxfrm_l(char* dest, char* src, usz count, void* locale);

// Additional error functions
extern fn char* _strerror(char* errMsg);
extern fn char* __strerror(CInt errnum);


// Wide Character String Functions (Common across platforms)

module string;

// Wide character memory functions
extern fn usz wcslen(Wchar_t* s);
extern fn Wchar_t* wcscpy(Wchar_t* dest, Wchar_t* src);
extern fn Wchar_t* wcsncpy(Wchar_t* dest, Wchar_t* src, usz n);
extern fn Wchar_t* wcscat(Wchar_t* dest, Wchar_t* src);
extern fn Wchar_t* wcsncat(Wchar_t* dest, Wchar_t* src, usz n);
extern fn CInt wcscmp(Wchar_t* s1, Wchar_t* s2);
extern fn CInt wcsncmp(Wchar_t* s1, Wchar_t* s2, usz n);
extern fn CInt wcscoll(Wchar_t* s1, Wchar_t* s2);
extern fn usz wcsxfrm(Wchar_t* dest, Wchar_t* src, usz n);
extern fn Wchar_t* wcschr(Wchar_t* s, Wchar_t c);
extern fn Wchar_t* wcsrchr(Wchar_t* s, Wchar_t c);
extern fn usz wcsspn(Wchar_t* s, Wchar_t* accept);
extern fn usz wcscspn(Wchar_t* s, Wchar_t* reject);
extern fn Wchar_t* wcspbrk(Wchar_t* s, Wchar_t* accept);
extern fn Wchar_t* wcsstr(Wchar_t* haystack, Wchar_t* needle);
extern fn Wchar_t* wcstok(Wchar_t* str, Wchar_t* delim, Wchar_t** ptr);
extern fn Wchar_t* wcsdup(Wchar_t* s);

// Wide character memory operations
extern fn Wchar_t* wmemcpy(Wchar_t* dest, Wchar_t* src, usz n);
extern fn Wchar_t* wmemmove(Wchar_t* dest, Wchar_t* src, usz n);
extern fn Wchar_t* wmemset(Wchar_t* s, Wchar_t c, usz n);
extern fn CInt wmemcmp(Wchar_t* s1, Wchar_t* s2, usz n);
extern fn Wchar_t* wmemchr(Wchar_t* s, Wchar_t c, usz n);


// Wide Character String Functions (POSIX)

module string @if(env::POSIX);

// POSIX wide character extensions
extern fn usz wcsnlen(Wchar_t* s, usz maxlen);
extern fn Wchar_t* wcsndup(Wchar_t* s, usz n);
extern fn CInt wcscasecmp(Wchar_t* s1, Wchar_t* s2);
extern fn CInt wcsncasecmp(Wchar_t* s1, Wchar_t* s2, usz n);
extern fn Wchar_t* wcpcpy(Wchar_t* dest, Wchar_t* src);
extern fn Wchar_t* wcpncpy(Wchar_t* dest, Wchar_t* src, usz n);

// Locale-specific wide character functions
extern fn CInt wcscoll_l(Wchar_t* s1, Wchar_t* s2, void* locale);
extern fn usz wcsxfrm_l(Wchar_t* dest, Wchar_t* src, usz n, void* locale);
extern fn CInt wcscasecmp_l(Wchar_t* s1, Wchar_t* s2, void* locale);
extern fn CInt wcsncasecmp_l(Wchar_t* s1, Wchar_t* s2, usz n, void* locale);


// Wide Character String Functions (Windows)

module string @if(env::WIN32);

// Secure wide string functions
extern fn CInt wcscpy_s(Wchar_t* dest, usz destSize, Wchar_t* src);
extern fn CInt wcsncpy_s(Wchar_t* dest, usz destSize, Wchar_t* src, usz count);
extern fn CInt wcscat_s(Wchar_t* dest, usz destSize, Wchar_t* src);
extern fn CInt wcsncat_s(Wchar_t* dest, usz destSize, Wchar_t* src, usz count);
extern fn usz wcsnlen_s(Wchar_t* str, usz maxCount);
extern fn CInt wmemcpy_s(Wchar_t* dest, usz destSize, Wchar_t* src, usz count);
extern fn CInt wmemmove_s(Wchar_t* dest, usz destSize, Wchar_t* src, usz count);

// Wide character case conversion (MS-specific)
extern fn Wchar_t* _wcslwr(Wchar_t* str);
extern fn Wchar_t* _wcsupr(Wchar_t* str);
extern fn Wchar_t* _wcslwr_s(Wchar_t* str, usz size);
extern fn Wchar_t* _wcsupr_s(Wchar_t* str, usz size);
extern fn Wchar_t* _wcslwr_l(Wchar_t* str, void* locale);
extern fn Wchar_t* _wcsupr_l(Wchar_t* str, void* locale);
extern fn Wchar_t* _wcslwr_s_l(Wchar_t* str, usz size, void* locale);
extern fn Wchar_t* _wcsupr_s_l(Wchar_t* str, usz size, void* locale);

// Wide character reversal (MS-specific)
extern fn Wchar_t* _wcsrev(Wchar_t* str);

// Wide character set functions (MS-specific)
extern fn Wchar_t* _wcsset(Wchar_t* str, Wchar_t c);
extern fn Wchar_t* _wcsnset(Wchar_t* str, Wchar_t c, usz count);
extern fn Wchar_t* _wcsset_s(Wchar_t* str, usz destSize, Wchar_t c);
extern fn Wchar_t* _wcsnset_s(Wchar_t* str, usz destSize, Wchar_t c, usz count);

// Wide character duplication (MS-specific)
extern fn Wchar_t* _wcsdup(Wchar_t* str);
extern fn Wchar_t* _wcsndup(Wchar_t* str, usz count);

// Wide character case-insensitive comparison (MS-specific)
extern fn CInt _wcsicmp(Wchar_t* s1, Wchar_t* s2);
extern fn CInt _wcsnicmp(Wchar_t* s1, Wchar_t* s2, usz count);
extern fn CInt _wcsicmp_l(Wchar_t* s1, Wchar_t* s2, void* locale);
extern fn CInt _wcsnicmp_l(Wchar_t* s1, Wchar_t* s2, usz count, void* locale);

// Wide character collation (MS-specific)
extern fn CInt _wcscoll_l(Wchar_t* s1, Wchar_t* s2, void* locale);
extern fn CInt _wcsicoll(Wchar_t* s1, Wchar_t* s2);
extern fn CInt _wcsicoll_l(Wchar_t* s1, Wchar_t* s2, void* locale);
extern fn CInt _wcsncoll(Wchar_t* s1, Wchar_t* s2, usz count);
extern fn CInt _wcsncoll_l(Wchar_t* s1, Wchar_t* s2, usz count, void* locale);
extern fn CInt _wcsnicoll(Wchar_t* s1, Wchar_t* s2, usz count);
extern fn CInt _wcsnicoll_l(Wchar_t* s1, Wchar_t* s2, usz count, void* locale);

// Wide character token (MS-specific)
extern fn Wchar_t* _wcstok_s(Wchar_t* str, Wchar_t* delimiters, Wchar_t** context);

// Wide character transformation (MS-specific)
extern fn usz _wcsxfrm_l(Wchar_t* dest, Wchar_t* src, usz count, void* locale);


