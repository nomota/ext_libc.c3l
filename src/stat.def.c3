// stat.def.c3
//
// This module provides following functions.
// file_exists() file_size() 
// is_dir() is_file() is_link() 
// is_readable() is_writeable()
// is_executable()
// read_link()

module io::stat;

// Different definitions of `struct stat` on various combinations of following systems
//
// OS: LINUX, DARWIN(macOS), WIN32, FREEBSD, NETBSD, OPENBSD, ANDROID
// ARCH: x86_64, X86(32bit), AARCH64(arm64), ARM, PPC64, RISCV64, SYSTEMZ


// ### Linux x86_64 (144 bytes)
// - `/usr/include/x86_64-linux-gnu/bits/stat.h`
// - `/usr/include/bits/struct_stat.h` 

struct Stat @if(env::LINUX && env::ARCH_TYPE == X86_64)
{
    ulong st_dev; // 8 bytes - Device ID
    ulong st_ino; // 8 bytes - Inode number
    ulong st_nlink; // 8 bytes - Number of hard links
    uint st_mode; // 4 bytes - File mode
    uint st_uid; // 4 bytes - User ID
    uint st_gid; // 4 bytes - Group ID
    int __pad0; // 4 bytes - Padding
    ulong st_rdev; // 8 bytes 
    long st_size; // 8 bytes - Total size in bytes
    long st_blksize; // 8 bytes - Block size for filesystem I/O
    long st_blocks; // 8 bytes - Number of 512B blocks allocated
    // struct st_atim { // 16 bytes - Time of last access
        long st_atime; // 8 bytes 
        long st_atime_nsec; // 8 bytes
    // }
    // struct st_mtim { // 16 bytes - Time of last modification
        long st_mtime; // 8 bytes 
        long st_mtime_nsec; // 8 bytes
    // }
    // struct st_ctim { // 16 bytes - Time of last status change
        long st_ctime;// 8 bytes 
        long st_ctime_nsec;// 8 bytes
    // }
    long[3] __glibc_reserved; // 24 bytes - Reserved
}


// ### Linux i386 (64 bytes)
// `/usr/include/i386-linux-gnu/bits/stat.h`

struct Stat @if(env::LINUX && env::ARCH_TYPE == X86)
{
    ushort st_dev; // 2 bytes - Device ID
    ushort __pad1; // 2 bytes - Padding
    uint st_ino; // 4 bytes - Inode number 
    ushort st_mode; // 2 bytes - File mode
    ushort st_nlink; // 2 bytes - Number of hard links
    ushort st_uid; // 2 bytes - User ID
    ushort st_gid; // 2 bytes - Group ID
    ushort st_rdev; // 2 bytes - Device ID 
    ushort __pad2; // 2 bytes - Padding
    int st_size; // 4 bytes - Total size in bytes
    int st_blksize; // 4 bytes - Block size for filesystem I/O
    int st_blocks; // 4 bytes - Number of 512B blocks allocated
    // struct st_atim { // 8 bytes - Time of last access
        uint st_atime; // 4 bytes 
        uint st_atime_nsec; // 4 bytes
    // }
    // struct st_mtim { // 8 bytes - Time of last modification
        uint st_mtime; // 4 bytes
        uint st_mtime_nsec; // 4 bytes
    // }
    // struct st_ctim { // 8 bytes - Time of last status change
        uint st_ctime; // 4 bytes
        uint st_ctime_nsec; // 4 bytes
    // }
    uint __glibc_reserved4; // 4 bytes - Reserved
    uint __glibc_reserved5; // 4 bytes - Reserved
}


// ### Linux i386 stat64 (96 bytes)
// - `/usr/include/i386-linux-gnu/bits/stat.h`

struct Stat64 @if(env::LINUX && env::ARCH_TYPE == X86)
{
    ulong st_dev; // 8 bytes - Device ID
    uint __pad1; // 4 bytes - Padding
    uint __st_ino; // 4 bytes - 32-bit inode 
    uint st_mode; // 4 bytes - File mode
    uint st_nlink; // 4 bytes - Number of hard links
    uint st_uid; // 4 bytes - User ID
    uint st_gid; // 4 bytes - Group ID
    ulong st_rdev; // 8 bytes 
    uint __pad2; // 4 bytes - Padding
    long st_size; // 8 bytes - Total size in bytes
    int st_blksize; // 4 bytes - Block size for filesystem I/O
    long st_blocks; // 8 bytes - Number of 512B blocks allocated
    // struct timespec st_atim; // 8 bytes - Time of last access
        long st_atime; // 4 bytes 
        long st_atime_nsec; // 4 bytes
    // struct timespec st_mtim; // 8 bytes - Time of last modification
        long st_mtime; // 4 bytes 
        long st_mtime_nsec; // 4 bytes
    // struct timespec st_ctim; // 8 bytes - Time of last status change
        long st_ctime; // 4 bytes 
        long st_ctime_nsec; // 4 bytes
    ulong st_ino; // 8 bytes 
}


// ### Linux/Android ARM64 / aarch64 (128 bytes)
// `/usr/include/aarch64-linux-gnu/bits/stat.h`

struct Stat @if((env::LINUX || env::ANDROID) && env::ARCH_TYPE == AARCH64)
{
    ulong st_dev; // 8 bytes - Device ID
    ulong st_ino; // 8 bytes - Inode number
    uint st_mode; // 4 bytes - File mode
    uint st_nlink; // 4 bytes - Number of hard links
    uint st_uid; // 4 bytes - User ID
    uint st_gid; // 4 bytes - Group ID
    ulong st_rdev; // 8 bytes 
    ulong __pad1; // 8 bytes - Padding
    long st_size; // 8 bytes - Total size in bytes
    int st_blksize; // 4 bytes - Block size for filesystem I/O
    int __pad2; // 4 bytes - Padding
    long st_blocks; // 8 bytes - Number of 512B blocks allocated
    // struct timespec st_atim; // 16 bytes - Time of last access
        long st_atime; // 8 bytes 
        long st_atime_nsec; // 8 bytes
    // struct timespec st_mtim; // 16 bytes - Time of last modification
        long st_mtime; // 8 bytes 
        long st_mtime_nsec; // 8 bytes
    // struct timespec st_ctim; // 16 bytes - Time of last status change
        long st_ctime; // 8 bytes 
        long st_ctime_nsec; // 8 bytes
    int[2] __glibc_reserved; // 8 bytes - Reserved
}


// ### Linux ARM32 / armhf (104 bytes)
// - `/usr/include/arm-linux-gnueabihf/bits/stat.h`

struct Stat64 @if(env::LINUX && env::ARCH_TYPE == ARM)
{
    ulong st_dev; // 8 bytes - Device ID
    uint __pad1; // 4 bytes - Padding
    uint __st_ino; // 4 bytes - Inode number
    uint st_mode; // 4 bytes - File mode
    uint st_nlink; // 4 bytes - Number of hard links
    uint st_uid; // 4 bytes - User ID
    uint st_gid; // 4 bytes - Group ID
    ulong st_rdev; // 8 bytes 
    ushort __pad2; // 4 bytes - Padding
    long st_size; // 8 bytes - Total size in bytes
    int st_blksize; // 4 bytes - Block size for filesystem I/O
    long st_blocks; // 8 bytes - Number of 512B blocks allocated
    // struct timespec st_atim; // 8 bytes - Time of last access
        uint st_atime; // 4 bytes 
        uint st_atime_nsec; // 4 bytes
    // struct timespec st_mtim; // 8 bytes - Time of last modification
        uint st_mtime; // 4 bytes 
        uint st_mtime_nsec; // 4 bytes
    // struct timespec st_ctim; // 8 bytes - Time of last status change
        uint st_ctime; // 4 bytes 
        uint st_ctime_nsec; // 4 bytes
    ulong st_ino; // 8 bytes
}


// ### Linux ARM32 (64 bytes)

struct Stat @if(env::LINUX && env::ARCH_TYPE == ARM) 
{
    uint  st_dev;      // [4b]
    uint  st_ino;      // [4b] 
    ushort st_mode;     // [2b]
    ushort st_nlink;    // [2b]
    ushort st_uid;      // [2b]
    ushort st_gid;      // [2b]
    uint  st_rdev;     // [4b]
    int st_size;     // [4b] 
    uint st_blksize;  // [4b] 
    uint  st_blocks;   // [4b]
    uint  st_atime;    // [4b] 
    uint  st_atime_nsec; // [4b]
    uint  st_mtime;    // [4b] 
    uint  st_mtime_nsec; // [4b]
    uint  st_ctime;    // [4b]
    uint  st_ctime_nsec; // [4b] 
    uint  __unused4;   // [4b] 
    uint  __unused5;   // [4b] 
}


// ### Linux RISC-V 64 (128 bytes)
// - `/usr/include/riscv64-linux-gnu/bits/stat.h`

struct Stat @if(env::LINUX && env::ARCH_TYPE == RISCV64)
{
    ulong st_dev; // 8 bytes - Device ID
    ulong st_ino; // 8 bytes - Inode number
    uint st_mode; // 4 bytes - File mode
    uint st_nlink; // 4 bytes - Number of hard links
    uint st_uid; // 4 bytes - User ID
    uint st_gid; // 4 bytes - Group ID
    ulong st_rdev; // 8 bytes 
    ulong __pad1; // 8 bytes - Padding
    long st_size; // 8 bytes - Total size in bytes
    int st_blksize; // 4 bytes - Block size for filesystem I/O
    int __pad2;  // 4 bytes - Padding
    long st_blocks; // 8 bytes - Number of 512B blocks allocated
    // struct timespec st_atim; // 16 bytes - Time of last access
        long st_atime; // 8 bytes 
        long st_atime_nsec; // 8 bytes
    // struct timespec st_mtim; // 16 bytes - Time of last modification
        long st_mtime; // 8 bytes 
        long st_mtime_nsec; // 8 bytes
    // struct timespec st_ctim; // 16 bytes - Time of last status change
        long st_ctime; // 8 bytes 
        long st_cime_nsec; // 8 bytes
    int[2] __glibc_reserved; // 8 bytes - Reserved
}


// ### Linux PowerPC64 / ppc64le 
// - `/usr/include/powerpc64le-linux-gnu/bits/stat.h`

struct Stat @if(env::LINUX && env::ARCH_TYPE == PPC64)
{
    ulong st_dev; // 8 bytes - Device ID
    ulong st_ino; // 8 bytes - Inode number
    ulong st_nlink; // 8 bytes - Number of hard links
    uint st_mode; // 4 bytes - File mode
    uint st_uid; // 4 bytes - User ID
    uint st_gid; // 4 bytes - Group ID
    int __pad0; // 4 bytes - Padding
    ulong st_rdev; // 8 bytes 
    long st_size; // 8 bytes - Total size in bytes
    long st_blksize; // 8 bytes - Block size for filesystem I/O
    long st_blocks; // 8 bytes - Number of 512B blocks allocated
    // struct timespec st_atim; // 16 bytes - Time of last access
        long st_atime; // 8 bytes 
        long st_atime_nsec; // 8 bytes
    // struct timespec st_mtim; // 16 bytes - Time of last modification
        long st_mtime; // 8 bytes 
        long st_mtime_nsec; // 8 bytes
    // struct timespec st_ctim; // 16 bytes - Time of last status change
        long st_ctime; // 8 bytes 
        long st_ctime_nsec; // 8 bytes
    uint[3] __glibc_reserved; // 24 bytes - Reserved
}


// ### Linux s390x (144 bytes)
// - `/usr/include/s390x-linux-gnu/bits/stat.h`

struct Stat @if(env::LINUX && env::ARCH_TYPE == SYSTEMZ)
{
    ulong st_dev; // 8 bytes - Device ID
    ulong st_ino; // 8 bytes - Inode number
    uint st_nlink; // 8 bytes - Number of hard links
    uint st_mode; // 4 bytes - File mode
    uint st_uid; // 4 bytes - User ID
    uint st_gid; // 4 bytes - Group ID
    int __pad0; // 4 bytes - Padding
    ulong st_rdev; // 8 bytes 
    long st_size; // 8 bytes - Total size in bytes
    // struct timespec st_atim; // 16 bytes - Time of last access
        long st_atime; // 8 bytes 
        long st_atime_nsec; // 8 bytes
    // struct timespec st_mtim; // 16 bytes - Time of last modification
        long st_mtime; // 8 bytes 
        long st_mtime_nsec; // 8 bytes
    // struct timespec st_ctim; // 16 bytes - Time of last status change
        long st_ctime; // 8 bytes 
        long st_ctime_nsec; // 8 bytes
    long st_blksize; // 8 bytes - Block size for filesystem I/O
    long st_blocks; // 8 bytes - Number of 512B blocks allocated
    uint[3] __glibc_reserved; // 24 bytes - Reserved
}



// ### macOS x86_64  (144 bytes)
// - `/usr/include/sys/stat.h`
// - `/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/sys/stat.h`

struct Stat @if(env::DARWIN && env::ARCH_TYPE == X86_64)
{
    uint st_dev; // 4 bytes - Device ID
    ushort st_mode; // 2 bytes - File mode
    ushort st_nlink; // 2 bytes - Number of hard links
    ulong st_ino; // 8 bytes - Inode number
    uint st_uid; // 4 bytes - User ID
    uint st_gid; // 4 bytes - Group ID
    uint st_rdev; // 4 bytes 
    // struct timespec st_atimespec; // 16 bytes - Time of last access
        long st_atime; // 8 bytes 
        long st_atime_nsec; // 8 bytes
    // struct timespec st_mtimespec; // 16 bytes - Time of last modification
        long st_mtime; // 8 bytes 
        long st_mtime_nsec; // 8 bytes
    // struct timespec st_ctimespec; // 16 bytes - Time of last status change
        long st_ctime; // 8 bytes 
        long st_ctime_nsec; // 8 bytes
    // struct timespec st_birthtimespec; // 16 bytes - Time of file creation
        long st_btime; // 8 bytes 
        long st_btime_nsec; // 8 bytes
    ulong st_size; // 8 bytes - Total size in bytes
    ulong st_blocks; // 8 bytes - Number of 512B blocks allocated
    uint st_blksize; // 4 bytes - Block size for filesystem I/O
    uint st_flags; // 4 bytes - User defined flags
    uint st_gen; // 4 bytes - File generation number
    int st_lspare; // 4 bytes - Reserved
    long[2] st_qspare; // 16 bytes - Reserved
}



// ### macOS ARM64 / Apple Silicon (144 byes)
// - `/usr/include/sys/stat.h`
// - `/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/sys/stat.h`

struct Stat @if(env::DARWIN && env::ARCH_TYPE == AARCH64)
{
    uint st_dev; // 4 bytes - Device ID
    ushort st_mode; // 2 bytes - File mode
    ushort st_nlink; // 2 bytes - Number of hard links
    ulong st_ino; // 8 bytes - Inode number
    uint st_uid; // 4 bytes - User ID
    uint st_gid; // 4 bytes - Group ID
    uint st_rdev; // 4 bytes 
    int __paddind0; // 4 bytes
    // struct timespec st_atimespec; // 16 bytes - Time of last access
        long st_atime; // 8 bytes 
        long st_atime_nsec; // 8 bytes
    // struct timespec st_mtimespec; // 16 bytes - Time of last modification
        long st_mtime; // 8 bytes 
        long st_mtime_nsec; // 8 bytes
    // struct timespec st_ctimespec; // 16 bytes - Time of last status change
        long st_ctime; // 8 bytes 
        long st_ctime_nsec; // 8 bytes
    // struct timespec st_birthtimespec; // 16 bytes - Time of file creation
        long st_btime; // 8 bytes 
        long st_btime_nsec; // 8 bytes
    ulong st_size; // 8 bytes - Total size in bytes
    ulong st_blocks; // 8 bytes - Number of 512B blocks allocated
    uint st_blksize; // 4 bytes - Block size for filesystem I/O
    uint st_flags; // 4 bytes - User defined flags
    uint st_gen; // 4 bytes - File generation number
    int st_lspare; // 4 bytes - Reserved
    long[2] st_qspare; // 16 bytes - Reserved
}



// ### FreeBSD x86_64 (120 bytes)
// - `/usr/include/sys/stat.h`

struct Stat @if(env::FREEBSD && env::ARCH_TYPE == X86_64)
{
    uint st_dev; // 8 bytes - Device ID
    long st_ino; // 8 bytes - Inode number
    ushort st_mode; // 2 bytes - File mode
    ushort st_nlink; // 2 bytes - Number of hard links
    uint st_uid; // 4 bytes - User ID
    uint st_gid; // 4 bytes - Group ID
    uint st_rdev; // 8 bytes 
    // struct timespec st_atim; // 16 bytes - Time of last access
        long st_atime; // 8 bytes 
        long st_atime_nsec; // 8 bytes
    // struct timespec st_mtim; // 16 bytes - Time of last modification
        long st_mtime; // 8 bytes 
        long st_mtime_nsec; // 8 bytes
    // struct timespec st_ctim; // 16 bytes - Time of last status change
        long st_ctime; // 8 bytes 
        long st_ctime_nsec; // 8 bytes
    // struct timespec st_birthtim; // 16 bytes - Time of file creation
        long st_btime; // 8 bytes 
        long st_btime_nsec; // 8 bytes
    ulong st_size; // 8 bytes - Total size in bytes
    ulong st_blocks; // 8 bytes - Number of 512B blocks allocated
    uint st_blksize; // 4 bytes - Block size for filesystem I/O
    uint st_flags; // 4 bytes - User defined flags
    ulong st_gen; // 8 bytes - File generation number
    uint st_spare; // 4 bytes - Reserved
}



// ### FreeBSD ARM64 / aarch64 (120 bytes)
// - `/usr/include/sys/stat.h`

struct Stat @if(env::FREEBSD && env::ARCH_TYPE == AARCH64)
{
    uint st_dev; // 8 bytes - Device ID
    long st_ino; // 8 bytes - Inode number
    ushort st_mode; // 2 bytes - File mode
    ushort st_nlink; // 2 bytes - Number of hard links
    uint st_uid; // 4 bytes - User ID
    uint st_gid; // 4 bytes - Group ID
    uint st_rdev; // 8 bytes 
    // struct timespec st_atim; // 16 bytes - Time of last access
        long st_atime; // 8 bytes 
        long st_atime_nsec; // 8 bytes
    // struct timespec st_mtim; // 16 bytes - Time of last modification
        long st_mtime; // 8 bytes 
        long st_mtime_nsec; // 8 bytes
    // struct timespec st_ctim; // 16 bytes - Time of last status change
        long st_ctime; // 8 bytes 
        long st_ctime_nsec; // 8 bytes
    // struct timespec st_birthtim; // 16 bytes - Time of file creation
        long st_btime; // 8 bytes 
        long st_btime_nsec; // 8 bytes
    ulong st_size; // 8 bytes - Total size in bytes
    ulong st_blocks; // 8 bytes - Number of 512B blocks allocated
    uint st_blksize; // 4 bytes - Block size for filesystem I/O
    uint  st_flags; // 4 bytes - User defined flags
    ulong st_gen; // 8 bytes - File generation number
    uint st_spare; // 4 bytes - Reserved
}



// ### OpenBSD x86_64 (128 bytes)
// - `/usr/include/sys/stat.h`

struct Stat @if(env::OPENBSD && env::ARCH_TYPE == X86_64)
{
    uint st_mode; // 4 bytes - File mode
    uint st_dev; // 4 bytes - Device ID
    long st_ino; // 8 bytes - Inode number
    uint st_nlink; // 4 bytes - Number of hard links
    uint st_uid; // 4 bytes - User ID
    uint st_gid; // 4 bytes - Group ID
    uint st_rdev; // 4 bytes 
    // struct timespec st_atim; // 16 bytes - Time of last access
        long st_atime; // 8 bytes 
        long st_atime_nsec; // 8 bytes
    // struct timespec st_mtim; // 16 bytes - Time of last modification
        long st_mtime; // 8 bytes 
        long st_mtime_nsec; // 8 bytes
    // struct timespec st_ctim; // 16 bytes - Time of last status change
        long st_ctime; // 8 bytes 
        long st_ctime_nsec; // 8 bytes
    // struct timespec st_birthtim; // 16 bytes - Time of last status change
        long st_btime; // 8 bytes 
        long st_btime_nsec; // 8 bytes
    ulong st_size; // 8 bytes - Total size in bytes
    ulong st_blocks; // 8 bytes - Number of 512B blocks allocated
    uint st_blksize; // 4 bytes - Block size for filesystem I/O
    uint st_flags; // 4 bytes - User defined flags
    uint st_gen; // 4 bytes - File generation number
    uint __pad; // 4 bytes - Reserved
}



// ### OpenBSD ARM64 / aarch64 (144 bytes)
// - `/usr/include/sys/stat.h`

struct Stat @if(env::OPENBSD && env::ARCH_TYPE == AARCH64)
{
    uint st_mode; // 4 bytes - File mode
    uint st_dev; // 4 bytes - Device ID
    long st_ino; // 8 bytes - Inode number
    uint st_nlink; // 4 bytes - Number of hard links
    uint st_uid; // 4 bytes - User ID
    uint st_gid; // 4 bytes - Group ID
    uint st_rdev; // 4 bytes 
    // struct timespec st_atim; // 16 bytes - Time of last access
        long st_atime; // 8 bytes 
        long st_atime_nsec; // 8 bytes
    // struct timespec st_mtim; // 16 bytes - Time of last modification
        long st_mtime; // 8 bytes 
        long st_mtime_nsec; // 8 bytes
    // struct timespec st_ctim; // 16 bytes - Time of last status change
        long st_ctime; // 8 bytes 
        long st_ctime_nsec; // 8 bytes
    // struct timespec st_birthtim; // 16 bytes - Time of last status change
        long st_btime; // 8 bytes 
        long st_btime_nsec; // 8 bytes
    ulong st_size; // 8 bytes - Total size in bytes
    ulong st_blocks; // 8 bytes - Number of 512B blocks allocated
    uint st_blksize; // 4 bytes - Block size for filesystem I/O
    uint st_flags; // 4 bytes - User defined flags
    uint st_gen; // 4 bytes - File generation number
    uint __pad; // 4 bytes - Reserved
    long[2] __unused; // 16 bytes
}



// ### NetBSD x86_64 (128 bytes)
// - `/usr/include/sys/stat.h`

struct Stat @if(env::NETBSD && env::ARCH_TYPE == X86_64)
{
    uint st_dev; // 8 bytes - Device ID
    ushort st_mode; // 4 bytes - File mode
    long st_ino; // 8 bytes - Inode number
    ushort st_nlink; // 4 bytes - Number of hard links
    uint st_uid; // 4 bytes - User ID
    uint st_gid; // 4 bytes - Group ID
    uint st_rdev; // 8 bytes 
    // struct timespec st_atimespec; // 16 bytes - Time of last access
        long st_atime; // 8 bytes 
        long st_atime_nsec; // 8 bytes
    // struct timespec st_mtimespec; // 16 bytes - Time of last modification
        long st_mtime; // 8 bytes 
        long st_mtime_nsec; // 8 bytes
    // struct timespec st_ctimespec; // 16 bytes - Time of last status change
        long st_ctime; // 8 bytes 
        long st_ctime_nsec; // 8 bytes
    // struct timespec st_birthtimespec; // 16 bytes - Time of file creation
        long st_btime; // 8 bytes 
        long st_btime_nsec; // 8 bytes
    ulong st_size; // 8 bytes - Total size in bytes
    ulong st_blocks; // 8 bytes - Number of 512B blocks allocated
    uint st_blksize; // 4 bytes - Block size for filesystem I/O
    uint st_flags; // 4 bytes - User defined flags
    uint st_gen; // 4 bytes - File generation number
    uint[2] st_spare; // 8 bytes - Reserved
}



// ### NetBSD ARM64 / aarch64 (128 bytes)
// - `/usr/include/sys/stat.h`

struct Stat @if(env::NETBSD && env::ARCH_TYPE == AARCH64)
{
    uint st_dev; // 8 bytes - Device ID
    ushort st_mode; // 4 bytes - File mode
    long st_ino; // 8 bytes - Inode number
    ushort st_nlink; // 4 bytes - Number of hard links
    uint st_uid; // 4 bytes - User ID
    uint st_gid; // 4 bytes - Group ID
    uint st_rdev; // 8 bytes 
    // struct timespec st_atimespec; // 16 bytes - Time of last access
        long st_atime; // 8 bytes 
        long st_atime_nsec; // 8 bytes
    // struct timespec st_mtimespec; // 16 bytes - Time of last modification
        long st_mtime; // 8 bytes 
        long st_mtime_nsec; // 8 bytes
    // struct timespec st_ctimespec; // 16 bytes - Time of last status change
        long st_ctime; // 8 bytes 
        long st_ctime_nsec; // 8 bytes
    // struct timespec st_birthtimespec; // 16 bytes - Time of file creation
        long st_btime; // 8 bytes 
        long st_btime_nsec; // 8 bytes
    ulong st_size; // 8 bytes - Total size in bytes
    ulong st_blocks; // 8 bytes - Number of 512B blocks allocated
    uint st_blksize; // 4 bytes - Block size for filesystem I/O
    uint st_flags; // 4 bytes - User defined flags
    uint st_gen; // 4 bytes - File generation number
    uint[2] __spare; // 8 bytes - Reserved
}



// ### Windows x86_64 - struct _stat64 (56 bytes)
// - `C:\Program Files \Windows Kits\10\Include\<version>\ucrt\sys\stat.h`
// - `C:\Program Files\Microsoft Visual Studio\<version>\VC\Tools\MSVC\<version>\include\sys\stat.h`

struct Stat64 @if(env::WIN32 && env::ARCH_TYPE == X86_64) @cname("_stat64")
{
    uint st_dev; // 4 bytes - Drive number or handle
    ushort st_ino; // 2 bytes 
    ushort st_mode; // 2 bytes - File mode bit mask
    short st_nlink; // 2 bytes - Always 1 on NTFS
    short st_uid; // 2 bytes - Always 0 
    short st_gid; // 2 bytes - Always 0 
    short __pad1; // 2 bytes
    uint st_rdev; // 4 bytes - Same as st_dev
    uint __pad2; // 4bytes
    long st_size; // 8 bytes - Size of file in bytes
    long st_atime; // 8 bytes - Time of last access
    long st_mtime; // 8 bytes - Time of last modification
    long st_ctime; // 8 bytes - Time of creation
}


// ### Windows x86 - struct _stat64 (56 bytes)

struct Stat64 @if(env::WIN32 && env::ARCH_TYPE == X86) @cname("_stat64")
{
    uint st_dev; // 4 bytes - Drive number or handle
    ushort st_ino; // 2 bytes 
    ushort st_mode; // 2 bytes - File mode bit mask
    short st_nlink; // 2 bytes - Always 1 on NTFS
    short st_uid; // 2 bytes - Always 0 
    short st_gid; // 2 bytes - Always 0 
    short __pad1; // 2 bytes
    uint st_rdev; // 4 bytes - Same as st_dev
    uint __pad2; // 4bytes
    long st_size; // 8 bytes - Size of file in bytes
    long st_atime; // 8 bytes - Time of last access
    long st_mtime; // 8 bytes - Time of last modification
    long st_ctime; // 8 bytes - Time of creation
}



// ### Windows x86_64 - struct _stat (48 bytes)

struct Stat @if(env::WIN32 && env::ARCH_TYPE == X86_64) @cname("_stat")
{
    uint st_dev; // 4 bytes - Drive number or handle
    ushort st_ino; // 2 bytes 
    ushort st_mode; // 2 bytes - File mode bit mask
    short st_nlink; // 2 bytes - Always 1 on NTFS
    short st_uid; // 2 bytes - Always 0 
    short st_gid; // 2 bytes - Always 0 
    uint st_rdev; // 4 bytes - Same as st_dev
    uint st_size; // 4 bytes - Size of file in bytes
    short __pad; // 2 bytes
    long st_atime; // 8 bytes - Time of last access
    long st_mtime; // 8 bytes - Time of last modification
    long st_ctime; // 8 bytes - Time of creation
}



// ### Windows x86 - struct _stat (48 bytes)

struct Stat @if(env::WIN32 && env::ARCH_TYPE == X86) @cname("_stat")
{
    uint st_dev; // 4 bytes - Drive number or handle
    ushort st_ino; // 2 bytes 
    ushort st_mode; // 2 bytes - File mode bit mask
    short st_nlink; // 2 bytes - Always 1 on NTFS
    short st_uid; // 2 bytes - Always 0 
    short st_gid; // 2 bytes - Always 0
    uint st_rdev; // 4 bytes - Same as st_dev
    uint st_size; // 4 bytes - Size of file in bytes
    short __pad; // 2 bytes
    long st_atime; // 8 bytes - Time of last access
    long st_mtime; // 8 bytes - Time of last modification
    long st_ctime; // 8 bytes - Time of creation
}



// ### Windows x86_64 - struct _stat64i32 (48 bytes)

struct Stat64i32 @if(env::WIN32 && env::ARCH_TYPE == X86_64) @cname("_stat64i32")
{
    uint st_dev; // 4 bytes - Drive number or handle
    ushort st_ino; // 2 bytes 
    ushort st_mode; // 2 bytes - File mode bit mask
    short st_nlink; // 2 bytes - Always 1 on NTFS
    short st_uid; // 2 bytes - Always 0 
    short st_gid; // 2 bytes - Always 0 
    short __pad; // 2 bytes
    uint st_rdev; // 4 bytes - Same as st_dev
    uint st_size; // 4 bytes - Size of file in bytes
    long st_atime; // 8 bytes - Time of last access
    long st_mtime; // 8 bytes - Time of last modification
    long st_ctime; // 8 bytes - Time of creation
}

/*
// ### MinGW x86_64 - struct stat (56 bytes)
// - `/usr/x86_64-w64-mingw32/include/sys/stat.h`
// - `C:\msys64\mingw64\include\sys\stat.h`

struct Stat @if(env::MINGW && env::ARCH_TYPE == X86_64)
{
    uint st_dev; // 4 bytes - Drive number or handle
    ushort st_ino; // 2 bytes 
    ushort st_mode; // 2 bytes - File mode bit mask
    short st_nlink; // 2 bytes - Always 1 on NTFS
    short st_uid; // 2 bytes - Always 0 
    short st_gid; // 2 bytes - Always 0
    short __pad1; // 2 bytes
    uint st_rdev; // 4 bytes - Same as st_dev
    int __pad2; // 4 bytes
    uint st_size; // 8 bytes - Size of file in bytes
    long st_atime; // 8 bytes - Time of last access
    long st_mtime; // 8 bytes - Time of last modification
    long st_ctime; // 8 bytes - Time of creation
}
*/


/*
// ### MinGW x86 - struct stat (48 bytes)

// - `/usr/i686-w64-mingw32/include/sys/stat.h`
// - `C:\msys64\mingw32\include\sys\stat.h`

struct Stat @if(env::MINGW && env::ARCH_TYPE == X86)
{
    uint st_dev; // 4 bytes - Drive number or handle
    ushort st_ino; // 2 bytes 
    ushort st_mode; // 2 bytes - File mode bit mask
    short st_nlink; // 2 bytes - Always 1 on NTFS
    short st_uid; // 2 bytes - Always 0 
    short st_gid; // 2 bytes - Always 0 
    uint st_rdev; // 4 bytes - Same as st_dev
    uint st_size; // 4 bytes - Size of file in bytes
    short __pad; // 2 bytes
    long st_atime; // 8 bytes - Time of last access
    long st_mtime; // 8 bytes - Time of last modification
    long st_ctime; // 8 bytes - Time of creation
}
*/
