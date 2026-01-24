
# ext_libc - C Standard Library Bindings for C3

A comprehensive collection of C standard library bindings for the [C3 programming language](https://c3-lang.org/), providing cross-platform system programming capabilities.

## Overview

`ext_libc` provides C3 modules that correspond to standard C headers, enabling seamless translation of C code to C3 and direct access to system-level functionality. This library bridges the gap between C3 and native system APIs across POSIX (Linux, BSD, macOS) and Windows platforms.

## Features

- **Cross-Platform Support**: Comprehensive bindings for both POSIX and Windows systems
- **Standard Library Coverage**: Networking, file I/O, threading, memory management, and more
- **Direct C Interop**: Faithful mappings of C APIs to C3 modules
- **Easy Integration**: Simple dependency management via C3's package system
- **Translation-Friendly**: Designed specifically to facilitate C-to-C3 code translation
- **Foundation for Higher-Level Libraries**: Serves as the base for networking and system utilities

## Installation

### Using C3's Package Manager

It requires 'c3l' library manager.

```bash
git clone https://github.com/konimarti/c3l
cd c3l
sudo make install 
``` 

Fetch the library from the repository:

```bash
c3l fetch https://github.com/nomota/ext_libc.c3l
```

This will install the library to your project's `lib/ext_libc.c3l` as a `zip` packed file and update your `project.json`:

```json
// project.json
{
  "dependencies": ["ext_libc"]
}
```

## Usage

Import the modules you need in your C3 source files:

```c3
import stdio;
import unistd;
import sys::socket;
```

Access functions and constants using the module namespace:

```c3
import stdio;

fn void main() 
{
    stdio::printf("Hello from ext_libc!\n");
}
```

### Windows-Specific Example

```c3
import winsock2;
import ws2tcpip;

fn void init_networking() 
{
    WSAData wsa_data;
    winsock2::wsa_startup(0x0202, &wsa_data);
}
```

### POSIX Example

```c3
import sys::socket;
import netinet::in;
import unistd;

fn int create_server_socket(ushort port) 
{
    int sockfd = socket::socket(socket::AF_INET, socket::SOCK_STREAM, 0);
    // ... bind, listen, etc.
    return sockfd;
}
```

### Discrepencies

C3 has strong naming rules, which hinders away 1:1 direct conversion.
* Types (Structure names) should start with uppercase.
* variables and functions should start with lowercase.
* CONSTANTS should all be uppercase.

```c3
// C
// winsock2.h
struct WSADATA {

};

int WSAStartup(unsitned short version_required, struct WSADATA* wsa_data);

// C3
// winsock2.h.c3
struct WSAData {

}

extern fn int wsa_startup(ushort version_required, WSAData* wsa_data) @cname("WSAStartup");
```
## Available Modules

### POSIX/Unix Headers

| Module | Description |
|--------|-------------|
| `arpa::inet` | Internet address manipulation |
| `complex` | Complex number mathematics |
| `dirent` | Directory operations |
| `fcntl` | File control operations |
| `math` | Mathematical functions |
| `netdb` | Network database operations |
| `netinet::in` | Internet protocol family |
| `netinet::tcp` | TCP protocol definitions |
| `netinet::udp` | UDP protocol definitions |
| `poll` | I/O multiplexing |
| `pthread` | POSIX threads |
| `regex` | Regular expressions |
| `signal` | Signal handling |
| `spawn` | Process spawning |
| `stddef` | Standard type definitions |
| `stdio` | Standard input/output |
| `stdlib` | Standard library functions |
| `string` | String manipulation |
| `sys::mman` | Memory management |
| `sys::socket` | Socket interface |
| `sys::stat` | File status |
| `sys::time` | Time types |
| `sys::wait` | Process waiting |
| `time` | Time and date functions |
| `unistd` | POSIX operating system API |

### Windows Headers

| Module | Description |
|--------|-------------|
| `errhandlingapi` | Error handling functions |
| `fileapi` | File management functions |
| `handleapi` | Handle management |
| `io` | Low-level I/O operations |
| `memoryapi` | Memory management functions |
| `process` | Process control |
| `processthreadapi` | Process and thread functions |
| `synchapi` | Synchronization functions |
| `sysinfoapi` | System information functions |
| `windows` | Core Windows API |
| `winsock2` | Windows Sockets 2 |
| `ws2tcpip` | Windows Sockets TCP/IP functions |

## Module Naming Convention

C header files are mapped to C3 modules using the following pattern:

- C header: `sys/socket.h` → C3 module: `sys.socket.h.c3` → Import as: `import sys::socket;`
- C header: `stdio.h` → C3 module: `stdio.h.c3` → Import as: `import stdio;`
- C header: `winsock2.h` → C3 module: `winsock2.h.c3` → Import as: `import winsock2;`

## Use Cases

- **C Code Translation**: Port existing C codebases to C3 with minimal API changes
- **System Programming**: Direct access to OS-level functionality
- **Network Programming**: Socket operations, protocol handling
- **Cross-Platform Development**: Write portable system code targeting multiple platforms
- **Low-Level Libraries**: Build system-level C3 libraries and tools

## Projects Built with ext_libc

### [ext_net.c3l](https://github.com/nomota/ext_net.c3l)

A high-level networking library for C3 built on top of `ext_libc`, providing:
- Simplified socket operations and network abstractions
- Higher-level APIs for common networking patterns

Perfect for developers who want to work with networking in C3 without dealing with low-level socket APIs directly.

```bash
c3l fetch https://github.com/nomota/ext_net.c3l
```

### [logd-c3](https://github.com/nomota/logd-c3)

A logging daemon and library implementation in C3 demonstrating:
- System-level daemon development with `ext_libc`
- Real-world application of C3 for system utilities

An excellent reference implementation for building system services in C3.

These projects showcase `ext_libc`'s capabilities and serve as practical examples for building production-ready system software in C3.

## Contributing

Contributions are welcome! Areas for contribution include:

- Additional header bindings
- Platform-specific implementations
- Documentation improvements
- Bug fixes and compatibility updates
- Test cases and examples
- Example projects and tutorials

## License

MIT License

## Resources

- [C3 Language](https://c3-lang.org/) - The C3 programming language
- [C3 Documentation](https://c3-lang.org/references/docs/) - Official C3 documentation
- [ext_net.c3l](https://github.com/nomota/ext_net.c3l) - High-level networking library
- [logd-c3](https://github.com/nomota/logd-c3) - Logging daemon implementation

## Support

For issues, questions, or contributions, please visit the [GitHub repository](https://github.com/nomota/ext_libc.c3l).

