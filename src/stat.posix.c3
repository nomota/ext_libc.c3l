// stat.posix.c3
//
// This module provides following functions for Posix systems.
// file_exists() file_size() 
// is_dir() is_file() is_link() 
// is_readable() is_writeable()
// is_executable()
// read_link()

module io::stat @if(! env::WIN32); // Posix

extern fn CInt stat(char* path, Stat* buf) ;
extern fn CInt lstat(char* path, Stat* buf);
extern fn CInt access(char* path, CInt mode);
extern fn CLong readlink(char* path, char* buf, CULong bufsize);

// File mode constants
const CUInt S_IFMT   = 0o170000;  // Bit mask for file type
const CUInt S_IFSOCK = 0o140000;  // Socket
const CUInt S_IFLNK  = 0o120000;  // Symbolic link
const CUInt S_IFREG  = 0o100000;  // Regular file
const CUInt S_IFBLK  = 0o060000;  // Block device
const CUInt S_IFDIR  = 0o040000;  // Directory
const CUInt S_IFCHR  = 0o020000;  // Character device
const CUInt S_IFIFO  = 0o010000;  // FIFO

// Permission bits
const CUInt S_ISUID  = 0o4000;    // Set UID bit
const CUInt S_ISGID  = 0o2000;    // Set GID bit
const CUInt S_ISVTX  = 0o1000;    // Sticky bit
const CUInt S_IRWXU  = 0o0700;    // Owner permissions
const CUInt S_IRUSR  = 0o0400;    // Owner read
const CUInt S_IWUSR  = 0o0200;    // Owner write
const CUInt S_IXUSR  = 0o0100;    // Owner execute
const CUInt S_IRWXG  = 0o0070;    // Group permissions
const CUInt S_IRWXO  = 0o0007;    // Other permissions

// Access mode constants
const CInt F_OK = 0;  // File exists
const CInt R_OK = 4;  // Read permission
const CInt W_OK = 2;  // Write permission
const CInt X_OK = 1;  // Execute permission

faultdef FILE_NOT_FOUND, GENERAL_ERROR;

fn ulong? file_size(String path)
{
    char[1024] p2; 
    p2[0:path.len] = path[0:path.len];
    ZString zpath = (ZString)&p2[0];
    
    Stat st;
    if (stat(zpath, &st) != 0) {
        return FILE_NOT_FOUND?;
    }
    
    return (ulong)st.st_size;
}

fn bool file_exists(String path)
{
    char[1024] p2; 
    p2[0:path.len] = path[0:path.len];
    ZString zpath = (ZString)&p2[0];

    return access(zpath, F_OK) == 0;
}

fn bool is_dir(String path)
{
    char[1024] p2; 
    p2[0:path.len] = path[0:path.len];
    ZString zpath = (ZString)&p2[0];
    
    Stat st;
    if (stat(zpath, &st) != 0) return false;
    
    return (st.st_mode & S_IFMT) == S_IFDIR;
}

fn bool is_file(String path)
{
    char[1024] p2; 
    p2[0:path.len] = path[0:path.len];
    ZString zpath = (ZString)&p2[0];
    
    Stat st;
    if (stat(zpath, &st) != 0) return false;
    
    return (st.st_mode & S_IFMT) == S_IFREG;
}


fn bool is_link(String path)
{
    char[1024] p2; 
    p2[0:path.len] = path[0:path.len];
    ZString zpath = (ZString)&p2[0];
    
    Stat st;
    // lstat doesn't follow symbolic links
    if (lstat(zpath, &st) != 0) return false;
    
    return (st.st_mode & S_IFMT) == S_IFLNK;
}

fn long? last_modified(String path)
{
    char[1024] p2; 
    p2[0:path.len] = path[0:path.len];
    ZString zpath = (ZString)&p2[0];
    
    Stat st;
    if (stat(zpath, &st) != 0) {
        return FILE_NOT_FOUND?;
    }
    
    return st.st_mtime;
}

fn bool is_readable(String path)
{
    char[1024] p2; 
    p2[0:path.len] = path[0:path.len];
    ZString zpath = (ZString)&p2[0];
    
    return access(zpath, R_OK) == 0;
}

fn bool is_writeable(String path)
{
    char[1024] p2; 
    p2[0:path.len] = path[0:path.len];
    ZString zpath = (ZString)&p2[0];
    
    return access(zpath, W_OK) == 0;
}

fn bool is_executable(String path)
{
    char[1024] p2; 
    p2[0:path.len] = path[0:path.len];
    ZString zpath = (ZString)&p2[0];

    return access(zpath, X_OK) == 0;
}

fn usz? read_link(String path, char[] output)
{
    char[1024] p2; 
    p2[0:path.len] = path[0:path.len];
    ZString zpath = (ZString)&p2[0];
    
    CLong n = readlink(zpath, output.ptr, (CULong)output.len-1);
    
    if (n < 0) {
        return FILE_NOT_FOUND?;
    }
    
    output[n] = 0;
    return (usz)n;
}

/*
module std::io::stat::test;

import std::io::stat;
import std::io;

fn void test_stat()
{
    if (stat::file_exists("test.txt")) {
        io::printn("File exists!");
        
        ulong? size = stat::file_size("test.txt");
        if (catch size) {
            io::printn("Cannot get file size");
        } else {
            io::printfn("File size: %d bytes", size);
        }
        
        if (stat::is_readable("test.txt")) {
            io::printn("File is readable");
        }
        
        if (stat::is_writeable("test.txt")) {
            io::printn("File is writeable");
        }
    }
    
    if (stat::is_dir("/tmp")) {
        io::printn("/tmp is a directory");
    }
    
    if (stat::is_link("mylink")) {
        char[1024] target;
        usz? len = stat::read_link("mylink", &target);
        if (catch len) {
            io::printn("Cannot read link");
        } else {
            io::printfn("Link target: %s", (ZString)target.ptr);
        }
    }
    
    long? mtime = stat::last_modified("test.txt");
    if (catch mtime) {
        io::printn("Cannot get modification time");
    } else {
        io::printfn("Last modified: %d", mtime);
    }
}
*/