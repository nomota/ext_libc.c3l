// stddef.h.c3
module stddef;

alias Size_t = usz;
alias Ssize_t = isz;

alias Uintptr_t = uptr;
alias Ptrdiff_t = isz;
alias Wchar_t = uint;

alias Uint8_t = char;
alias Uint16_t = ushort;
alias Uint32_t = uint;
alias Uint64_t = ulong;

alias Int8_t = ichar;
alias Int16_t = short;
alias Int32_t = int;
alias Int64_t = long;

macro offsetof($Type, $member) {
    $Type.$member.offset;
}
