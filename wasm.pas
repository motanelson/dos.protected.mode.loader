program wasm_generator;

uses
  SysUtils;

var
  f: File;
  funcname: string[3];
  codes: array[0..5] of Byte = ($20, $00, $20, $01, $6A, $0B);

begin
  Assign(f, 'main.wasm');
  Rewrite(f, 1);
  WriteLn(#27'[43;30mCriando ficheiro main.wasm...');

  // Cabeçalho
  BlockWrite(f, #0'asm', 4);
  BlockWrite(f, #1#0#0#0, 4);

  // Seção de tipos
  BlockWrite(f, #1#7, 2);         // section id 1, size 7
  BlockWrite(f, #1#96#2#127#127#1#127, 7); // 1 type: (i32, i32) -> i32

  // Seção de funções
  BlockWrite(f, #3#2#1#0, 4);     // section id 3, size 2, 1 function, type 0

  // Seção de exportações
  BlockWrite(f, #7#7#1#3, 4);     // section id 7, size 7, 1 export, string length 3
  funcname := 'sum';              // nome da função exportada
  BlockWrite(f, funcname[1], Length(funcname)); // escreve 'sum'
  BlockWrite(f, #0#0, 2);         // export kind = func, func index = 0

  // Seção de código
  BlockWrite(f, #10#9#1#7#0, 5);  // section id 10, size 9, 1 function body, size 7, no locals
  BlockWrite(f, codes, SizeOf(codes)); // instruções: get_local 0, get_local 1, i32.add, end

  Close(f);
  WriteLn('Ficheiro main.wasm criado com sucesso!');
end.

