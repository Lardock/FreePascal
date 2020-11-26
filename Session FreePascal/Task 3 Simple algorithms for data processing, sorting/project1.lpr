program project1;
uses
  Windows;

  var i,max:integer;
  z:array[1..19] of integer;
  T1, T2,iCounterPerSec:Int64;
  Timer:real;
begin
  writeln('Nach mass: ');
  randomize;
  for i:=1 to 19 do begin
  z[i]:=random(20001)-10000;
  write(z[i],' | ')
  end;

  {$ASMMODE intel}
  QueryPerformanceFrequency(iCounterPerSec);
  QueryPerformanceCounter(T1);
  asm
  @SE:
      XOR EAX,EAX
      MOV ECX,18
      XOR EDX,EDX
      @b:
         MOV EAX,z[ECX*4]
         CMP EAX,z[ECX*4-4]
         JL @M
         XCHG z[ECX*4-4],EAX
         MOV z[ECX*4],EAX
         MOV EDX,1
             @M:
                LOOP @b
                TEST EDX,1
                JNZ @SE
                MOV EBX,z[0]
                MOV max,EBX
  end;
  QueryPerformanceCounter(T2);
  Timer:= (T2-T1)/iCounterPerSec;
writeln();
writeln('Sort mass: ');
for i:=1 to 19 do begin
write(z[i],' | ')
end;
writeln();
writeln('Maximal element: ', max);
Writeln(Timer:0:6, ' Seconds');
readln();
end.

