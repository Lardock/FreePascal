program Zad2Var12;

 {$ASMMODE intel}
 var a:array[0..99] of shortint;         //Число без знака
 var b:array[0..99] of shortint;         //Число без знака
 i:integer;                             //Счётчик
 Count:integer;                          //Ограничитель массива
 Counter:integer;                       //Новый счётчик
 Max:integer;                           //Сумма всех элементов
begin
Writeln('Vvedite skolko chisel v massive vam nyzhno');
Readln(Count);
Writeln('Vvedite ',Count,' Cifr ');
for i:=0 to Count-1 do
  begin
  Writeln('VVOd: ');
  Readln(a[i]);                           //Ввод массива
end;

//==========================================================================
      asm
  MOV ECX,Count                       //Счётчик
  XOR EDX,EDX                         //Обнуление   Макс
  XOR EBX,EBX                         //Обнуление
  MOV EBX,0                           //Установка значения
  @L:
  XOR EAX,EAX                         //Обнуление текущей Цифры
     MOV AL,a[ECX-1]
     TEST AL,AL
     jns @Polozh
     js @L2
     @Polozh: //Положительное
         MOV b[EBX],AL                //В новую таблицу
         ADD EBX,1                    //Увеличиваем счётчик
         CMP EAX,EDX                  //Сравнение кто больше
         JB @L2                       //Старое максимальное число больше
         MOV EDX,EAX                  //Новое максимальное число
         JMP @L2
  @L2:                                //Сумма
     Loop @L
     MOV Max,EDX                  //Максимальное положительное
     MOV Counter,EBX                  //Новый счётчик
  end;
//==========================================================================
Writeln();                               //Пустая строка
Write('STALO: ');
for i:=Counter-1 downto 0 do
begin
Write(' | ',b[i]);
end;
Writeln();                               //Пустая строка
Writeln('MAX: ', Max);
Readln;                                  //Чтобы не закрылась консоль
end.

