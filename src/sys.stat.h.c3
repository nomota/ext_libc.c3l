// sys.stat.h.c3

// sys/stat.h

module sys::stat;

// Get file status
extern fn CInt stat(char* path, Stat* buf);
extern fn CInt fstat(CInt fd, Stat* buf);
extern fn CInt lstat(char* path, Stat* buf);

// Get file status (including flags) - Linux only
extern fn CInt fstatat(CInt dirfd, char* pathname, Stat* buf, CInt flags);


// Chane file permission
extern fn CInt chmod(char* path, Mode_t mode);
extern fn CInt fchmod(CInt fd, Mode_t mode);
extern fn CInt fchmodat(CInt dirfd, char* pathname, Mode_t mode, CInt flags);

// Make directory
extern fn CInt mkdir(char* pathname, Mode_t mode);
extern fn CInt mkdirat(CInt dirfd, char* pathname, Mode_t mode);

// FIFO special file create
extern fn CInt mkfifo(char* pathname, Mode_t mode);
extern fn CInt mkfifoat(CInt dirfd, char* pathname, Mode_t mode);

// File create 
extern fn CInt mknod(char* pathname, Mode_t mode, Dev_t dev);
extern fn CInt mknodat(CInt dirfd, char* pathname, Mode_t mode, Dev_t dev);

// File creation mode masking
extern fn Mode_t umask(Mode_t mask);

module sys::stat @if(env::POSIX);

// POSIX  asic types
alias Mode_t = CUInt;
alias Dev_t = CULong;
alias Ino_t = CULong;
alias Nlink_t = CULong;
alias Uid_t = CUInt;
alias Gid_t = CUInt;
alias Off_t = CLongLong;
alias Blksize_t = CLong;
alias Blkcnt_t = CLongLong;
alias Time_t = CLong;

// Timespec 
struct Timespec {
    Time_t tv_sec;
    CLong tv_nsec;
}

// struct stat
struct Stat {
    Dev_t st_dev; 
    Ino_t st_ino;  
    Nlink_t st_nlink; 
    Mode_t st_mode;
    Uid_t st_uid;
    Gid_t st_gid; 
    CInt __pad0;
    Dev_t st_rdev;
    Off_t st_size;
    Blksize_t st_blksize;
    Blkcnt_t st_blocks;
    Timespec st_atim;
    Timespec st_mtim;
    Timespec st_ctim;
    
    CLong[3] __unused;
}

// File type mask
const Mode_t S_IFMT   = 0o170000;
const Mode_t S_IFSOCK = 0o140000;
const Mode_t S_IFLNK  = 0o120000;
const Mode_t S_IFREG  = 0o100000;
const Mode_t S_IFBLK  = 0o060000;
const Mode_t S_IFDIR  = 0o040000;
const Mode_t S_IFCHR  = 0o020000;
const Mode_t S_IFIFO  = 0o010000;

// File type test macro 
fn bool s_isreg(Mode_t m) @inline => (m & S_IFMT) == S_IFREG;
fn bool s_isdir(Mode_t m) @inline => (m & S_IFMT) == S_IFDIR;
fn bool s_ischr(Mode_t m) @inline => (m & S_IFMT) == S_IFCHR;
fn bool s_isblk(Mode_t m) @inline => (m & S_IFMT) == S_IFBLK;
fn bool s_isfifo(Mode_t m) @inline => (m & S_IFMT) == S_IFIFO;
fn bool s_islnk(Mode_t m) @inline => (m & S_IFMT) == S_IFLNK;
fn bool s_issock(Mode_t m) @inline => (m & S_IFMT) == S_IFSOCK;

// Owner permission
const Mode_t S_ISUID = 0o4000;
const Mode_t S_ISGID = 0o2000;
const Mode_t S_ISVTX = 0o1000;
const Mode_t S_IRWXU = 0o0700;
const Mode_t S_IRUSR = 0o0400;
const Mode_t S_IWUSR = 0o0200;
const Mode_t S_IXUSR = 0o0100;

// Group permission
const Mode_t S_IRWXG = 0o0070;
const Mode_t S_IRGRP = 0o0040;
const Mode_t S_IWGRP = 0o0020;
const Mode_t S_IXGRP = 0o0010;

// Other user permission
const Mode_t S_IRWXO = 0o0007;
const Mode_t S_IROTH = 0o0004;
const Mode_t S_IWOTH = 0o0002;
const Mode_t S_IXOTH = 0o0001;

