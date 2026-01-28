// stat.win32.c3
//
// This module provides following functions for Win32.
// file_exists() file_size() 
// is_dir() is_file() is_link() 
// is_readable() is_writeable()
// is_executable()
// read_link()

module io::stat @if(env::WIN32);

// Windows API Types
alias Dword = uint;
alias Handle = void*;
alias Bool = int;
alias LPCWstr = Char16*;
alias Long = long;

const Handle INVALID_HANDLE_VALUE = (Handle)uptr.max;
const Dword GENERIC_READ = 0x80000000;
const Dword GENERIC_WRITE = 0x40000000;
const Dword FILE_SHARE_READ = 0x00000001;
const Dword FILE_SHARE_WRITE = 0x00000002;
const Dword OPEN_EXISTING = 3;
const Dword FILE_ATTRIBUTE_DIRECTORY = 0x10;
const Dword FILE_ATTRIBUTE_NORMAL = 0x80;
const Dword FILE_ATTRIBUTE_REPARSE_POINT = 0x400;
const Dword FILE_FLAG_OPEN_REPARSE_POINT = 0x00200000;
const Dword INVALID_FILE_ATTRIBUTES = 0xFFFFFFFF;
const Dword IO_REPARSE_TAG_SYMLINK = 0xA000000C;
const Dword IO_REPARSE_TAG_MOUNT_POINT = 0xA0000003;
const Dword FSCTL_GET_REPARSE_POINT = 0x900a8;

struct Win32FileAttributeData {
    Dword dwFileAttributes;
    Dword ftCreationTime_low;
    Dword ftCreationTime_high;
    Dword ftLastAccessTime_low;
    Dword ftLastAccessTime_high;
    Dword ftLastWriteTime_low;
    Dword ftLastWriteTime_high;
    Dword nFileSizeHigh;
    Dword nFileSizeLow;
}

struct Win32FindDataW {
    Dword dwFileAttributes;
    Dword ftCreationTime_low;
    Dword ftCreationTime_high;
    Dword ftLastAccessTime_low;
    Dword ftLastAccessTime_high;
    Dword ftLastWriteTime_low;
    Dword ftLastWriteTime_high;
    Dword nFileSizeHigh;
    Dword nFileSizeLow;
    Dword dwReserved0;
    Dword dwReserved1;
    ushort[260] cFileName;
    ushort[14] cAlternateFileName;
}

struct ReparseDataBuffer {
    Dword reparseTag;
    ushort reparseDataLength;
    ushort reserved;
    ushort substituteNameOffset;
    ushort substituteNameLength;
    ushort printNameOffset;
    ushort printNameLength;
    Dword flags;
    ushort[1] pathBuffer;
}

// Windows API functions
extern fn Bool getFileAttributesExW(
    LPCWstr filename, 
    int info_level, 
    void* file_info
) @cname("GetFileAttributesExW");

extern fn Dword getFileAttributesW(
    LPCWstr filename
) @cname("GetFileAttributesW");

extern fn Handle createFileW(
    LPCWstr filename,
    Dword access,
    Dword share_mode, 
    void* security, 
    Dword creation,
    Dword flags, 
    Handle template
) @cname("CreateFileW");

extern fn Bool closeHandle(Handle handle) @cname("CloseHandle");
extern fn Bool getFileSizeEx(Handle file, Long* size) @cname("GetFileSizeEx");

extern fn Bool deviceIoControl(
    Handle device, 
    Dword control_code, 
    void* in_buffer, 
    Dword in_size,
    void* out_buffer, 
    Dword out_size, 
    Dword* bytes_returned, 
    void* overlapped
) @cname("DeviceIoControl");

extern fn Handle findFirstFileW(
    LPCWstr filename, 
    Win32FindDataW* find_data
) @cname("FindFirstFileW");

extern fn Bool findClose(Handle find_file) @cname("FindClose");

fn void? utf8to16(String path, Char16[] wpath) 
{
    Char16[]? p2 = path.to_utf16(mem);
    if (catch err = p2) return err?;
    defer free(p2);
    wpath[0:p2.len] = p2[0:p2.len];;
    wpath[p2.len] = 0;
}

fn bool file_exists(String path) 
{
    Char16[260] wpath;
    if (catch utf8to16(path, &wpath)) return false;
    
    Dword attrs = getFileAttributesW(&wpath[0]);
    return attrs != INVALID_FILE_ATTRIBUTES;
}

faultdef FILE_NOT_FOUND, GENERAL_ERROR;

fn long? file_size(String path) 
{
    Char16[260] wpath;
    if (catch utf8to16(path, &wpath)) return FILE_NOT_FOUND?;
    
    Win32FileAttributeData file_info;
    if (!getFileAttributesExW(&wpath[0], 0, &file_info)) {
        return FILE_NOT_FOUND?;
    }
    
    long size = ((long)file_info.nFileSizeHigh << 32) | (long)file_info.nFileSizeLow;
    return size;
}

fn long? last_modified(String path) 
{
    Char16[260] wpath;
    if (catch utf8to16(path, &wpath)) return FILE_NOT_FOUND?;
    
    Win32FileAttributeData file_info;
    if (!getFileAttributesExW(&wpath[0], 0, &file_info)) {
        return FILE_NOT_FOUND?;
    }
    
    long filetime = ((long)file_info.ftLastWriteTime_high << 32) | (long)file_info.ftLastWriteTime_low;
    return filetime;
}

fn bool is_dir(String path) 
{
    Char16[260] wpath;
    if (catch utf8to16(path, &wpath)) return false;
    
    Dword attrs = getFileAttributesW(&wpath[0]);
    if (attrs == INVALID_FILE_ATTRIBUTES) return false;
    
    return (attrs & FILE_ATTRIBUTE_DIRECTORY) != 0;
}

fn bool is_file(String path) 
{
    Char16[260] wpath;
    if (catch utf8to16(path, &wpath)) return false;
    
    Dword attrs = getFileAttributesW(&wpath[0]);
    if (attrs == INVALID_FILE_ATTRIBUTES) return false;
    
    return (attrs & FILE_ATTRIBUTE_DIRECTORY) == 0;
}


fn bool is_link(String path) 
{
    Char16[260] wpath;
    if (catch utf8to16(path, &wpath)) return false;
    
    Dword attrs = getFileAttributesW(&wpath[0]);
    if (attrs == INVALID_FILE_ATTRIBUTES) return false;
    
    return (attrs & FILE_ATTRIBUTE_REPARSE_POINT) != 0;
}

fn void? read_link(String path, char[] output) 
{
    Char16[260] wpath;
    if (catch utf8to16(path, &wpath)) return FILE_NOT_FOUND?;
    
    Handle handle = createFileW(
        &wpath[0], 0, 
        FILE_SHARE_READ | FILE_SHARE_WRITE,
        null, OPEN_EXISTING, FILE_FLAG_OPEN_REPARSE_POINT,
        INVALID_HANDLE_VALUE);
    
    if (handle == INVALID_HANDLE_VALUE) {
        return FILE_NOT_FOUND?;
    }
    
    defer closeHandle(handle);
    
    char[16384] buffer;
    Dword bytes_returned;
    
    if (!deviceIoControl(handle, FSCTL_GET_REPARSE_POINT, null, 0,
        &buffer, 16384, &bytes_returned, null)) {
        return GENERAL_ERROR?;
    }
    
    ReparseDataBuffer* reparse = (ReparseDataBuffer*)&buffer;
    
    if ((reparse.reparseTag != IO_REPARSE_TAG_SYMLINK) && (reparse.reparseTag != IO_REPARSE_TAG_MOUNT_POINT)) {
        return GENERAL_ERROR?;
    }

    Char16* target = (Char16*)&reparse.pathBuffer[reparse.printNameOffset / 2];
    usz len = reparse.printNameLength / 2;
    
    String? s = string::from_utf16(tmem, target[0:len]);
    if (catch err = s) return GENERAL_ERROR?;
    defer s.free(tmem);
    
    output[0:s.len] = s[0:s.len];
    output[s.len] = 0;
}


fn bool is_readable(String path) 
{
    Char16[260] wpath;
    if (catch utf8to16(path, &wpath)) return false;
    
    Handle handle = createFileW(
        &wpath[0], GENERIC_READ,
        FILE_SHARE_READ | FILE_SHARE_WRITE,
        null, OPEN_EXISTING, 0, INVALID_HANDLE_VALUE);
    
    if (handle == INVALID_HANDLE_VALUE) return false;
    
    closeHandle(handle);
    return true;
}


fn bool is_writeable(String path) 
{
    Char16[260] wpath;
    if (catch utf8to16(path, &wpath)) return false;

    Handle handle = createFileW(
        &wpath[0], GENERIC_WRITE,
        FILE_SHARE_READ | FILE_SHARE_WRITE,
        null, OPEN_EXISTING, 0, INVALID_HANDLE_VALUE);
    
    if (handle == INVALID_HANDLE_VALUE) return false;
    
    closeHandle(handle);
    return true;
}


fn bool is_executable(String path) 
{
    if (!file_exists(path)) return false;
    if (is_dir(path)) return false;
    
    // .exe, .bat, .cmd, .com

    String lower = path.to_lower_tcopy();
    defer lower.free(tmem);
    
    return lower.ends_with(".exe") || 
           lower.ends_with(".bat") || 
           lower.ends_with(".cmd") || 
           lower.ends_with(".com");
}

/*
module std::io::stat::test;

import std::io::stat;
import std::io;

// Usage example
fn void test_file_functions() {
    io::printfn("Testing file utility functions...\n");
    
    String test_path = "C:\\Windows\\System32\\notepad.exe";
    
    io::printfn("file_exists(%s): %s", test_path, file_exists(test_path) ? "true" : "false");
    io::printfn("is_file(%s): %s", test_path, is_file(test_path) ? "true" : "false");
    io::printfn("is_dir(%s): %s", test_path, is_dir(test_path) ? "true" : "false");
    io::printfn("is_executable(%s): %s", test_path, is_executable(test_path) ? "true" : "false");
    io::printfn("is_readable(%s): %s", test_path, is_readable(test_path) ? "true" : "false");
    
    long? size = file_size(test_path);
    if (catch err = size) {
        io::printfn("file_size error: %s", err);
    } else {
        io::printfn("file_size(%s): %d bytes", test_path, size);
    }
    
    long? mtime = last_modified(test_path);
    if (catch err = mtime) {
        io::printfn("last_modified error: %s", err);
    } else {
        io::printfn("last_modified(%s): %d", test_path, mtime);
    }
}
*/