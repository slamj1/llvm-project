; RUN: llc -filetype=obj %s -o %t.o
; RUN: not wasm-ld -o %t.wasm %t.o 2>&1 | FileCheck %s -check-prefix=UNDEF
; RUN: not wasm-ld --shared -o %t.wasm %t.o 2>&1 | FileCheck %s -check-prefix=BADRELOC

target triple = "wasm32-unknown-unknown"

@data_external = external global i32

define i32 @_start() {
entry:
    %0 = load i32, i32* @data_external, align 4
    ret i32 %0
}

; UNDEF: undefined symbol: data_external
; BADRELOC: undefined-data.ll.tmp.o: relocation R_WASM_MEMORY_ADDR_LEB cannot be used againt symbol data_external; recompile with -fPIC
