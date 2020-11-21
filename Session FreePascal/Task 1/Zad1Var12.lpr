program Zad1Var12;
 {$ASMMODE intel}
 const Count=6;                         //Количество элементов  (6)
 var a:array[0..Count] of byte;         //Число без знака
 i:integer;                             //Счётчик
 Sum:integer;                           //Сумма всех элементов
begin
Randomize;                              //Для рандома  иначе не работает
Write('BYLO:');
for i:=0 to Count-1 do
  begin
  a[i]:=Random(255)+1;                  //Диапазон рандома (1-255)
  Write(' | ',a[i]);
end;
//==========================================================================
  asm
  MOV ECX,Count                          //Счётчик
  XOR EBX,EBX                            //Обнуление Сумма
  @L:
  XOR EAX,EAX                         //Обнуление текущей Цифры
     MOV AL,a[ECX-1]
     TEST ECX,1
     jz @CHET
     jnz @NECH
     @NECH: //НеЧёт
         OR AL,00001000b                    //Установка значения  1 в 4 бите
         JMP @L2
     @CHET: //Чёт
         AND AL,11101111b                   //Установка значения  0 в 5 бите
  @L2:
     ADD EBX,EAX                             //Сумма
     MOV a[ECX-1],AL                        //Вывод полученного числа
     Loop @L
     MOV Sum,EBX


  end;
//==========================================================================
Writeln();                               //Пустая строка
Write('STALO: ');
for i:=0 to Count-1 do
begin
Write(' | ',a[i]);
end;
Writeln();                               //Пустая строка
Writeln('SUMMA: ', Sum);
Readln;                                  //Чтобы не закрылась консоль
end.
