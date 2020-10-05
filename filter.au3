; Главная программа
; $fileInput — обрабатываемый входной файл
; $fileNamesOfFiles — файл перечень файлов
;
;
;
#include <file.au3>						; Библиотечная функция
#include <Array.au3>					; Библиотечная функция
;Лог
$logOn = 0
;Файл на чтение имён входных файлов
$inFileName = "NamesOfFiles.txt"; назначение имени
#include "openFileRead.au3"    ; Процедура открытия файла на чтение
;#include "chisloStrok.au3"     ; Процедура подсчёта числа строк в файле;;
$fileNamesOfFiles = $inFile ; переназначение указателя на переменную
$chisloStrokNamesOfFiles = _FileCountLines ($inFileName)
;MsgBox(0, "ФАЙЛ $inFile такой:", $inFile )
; Счётчик строк файл перечень файлов в 1
$NumCurrentLineNamesOfFiles = 1
;БОЛЬШОЙ ЦИКЛ ПЕРЕБОР ФАЙЛОВ
While $NumCurrentLineNamesOfFiles <= $chisloStrokNamesOfFiles
;Файл на чтение данных
;ПОЛУЧАЕМ ИМЯ ФАЙЛА (вся строка)
$fileInput = FileReadLine ( $fileNamesOfFiles, $NumCurrentLineNamesOfFiles )
;MsgBox(0, "ФАЙЛ такой:", $fileInput )
$inFileName = $fileInput
;#include "openFileRead.au3"    ; Процедура открытия файла на чтение
;#include "chisloStrok.au3"     ; Процедура подсчёта числа строк в файле
$fileInput = $inFile ; переназначение указателя на переменную
$chisloStrokCurrentFile = _FileCountLines ($inFileName)
;MsgBox(64, "Error log recordcount", "В файле " & $chisloStrokCurrentFile & " строк."); Процедура Сообщение
; Счётчик строк обрабатываемый входной файл в 1
$NumCurrentLineFileInput = 1
$casesense = 1 ; регистр важен
; ИЩЕМ НАЧАЛО ЗАГОЛОВКА!
; Устанавливаем искомую строку "Тема:&nbsp;&nbsp;"
$vhojdenie = "Тема:&nbsp;&nbsp;"
;пппппппппппппппппппппп
;Переназначение локального счётчика в процедурный
$NumCurrentLine = $NumCurrentLineFileInput
;#include "SearchStrokZnakFileString.au3" ; Ищем вхождение
;Переназначение процедурного счётчика в локальный
$NumCurrentLineFileInput = $NumCurrentLine
;uuuuuuuuuuuuuuuuuuuuuu
;MsgBox (0, "Строка выглядит так", $CurrentLine)
;MsgBox (0, "Позиция искомой последовательности", "Строка " & $NumCurrentLineFileInput & " " & "Знак " & $vhojdenieNaideno)
$StrokaNachaloZagolovka = $NumCurrentLineFileInput
$ZnakNachaloZagolovka = $vhojdenieNaideno + 17
; ИЩЕМ КОНЕЦ ЗАГОЛОВКА!
; Устанавливаем искомую строку "<a href="
$vhojdenie = "<a href="
;пппппппппппппппппппппп
;Переназначение локального счётчика в процедурный
$NumCurrentLine = $NumCurrentLineFileInput
#include "SearchStrokZnakFileString.au3" ; Ищем вхождение
;Переназначение процедурного счётчика в локальный
$NumCurrentLineFileInput = $NumCurrentLine
;uuuuuuuuuuuuuuuuuuuuuu
;MsgBox (0, "Строка выглядит так", $CurrentLine)
;MsgBox (0, "Позиция искомой последовательности", "Строка " & $NumCurrentLineFileInput & " " & "Знак " & $vhojdenieNaideno)
$StrokaKonecZagolovka = $NumCurrentLineFileInput
$ZnakKonecZagolovka = $vhojdenieNaideno - $ZnakNachaloZagolovka - 2
;ПОЛУЧАЕМ ЗАГОЛОВОК!
$zagolovok = StringMid ($CurrentLine, $ZnakNachaloZagolovka, $ZnakKonecZagolovka)
;MsgBox(0, "Заголовок такой:", $zagolovok )
;УДАЛЯЕМ ПРОБЕЛЫ ВНАЧАЛЕ И В КОНЦЕ!
$TEXT = $zagolovok ;отправляем переменную на обработку
#include "DelSpace.au3"
$zagolovok = $TEXT; принимаем переменную с обработки
;Открываем файл на запись
$outFileName = ('выход' & ".txt" )
;#include "openFileWriteEnd.au3"; Процедура открытия файла на запись в конец
; Цикл по постам
While $NumCurrentLineFileInput < $chisloStrokCurrentFile
   ; ИЩЕМ НАЧАЛО ДАТЫ!
   ; Устанавливаем искомую строку "tppabs="http://forumy.ru/img/posticon.gif"> <span class="daten">отправлено "
   $vhojdenie = 'tppabs="http://forumy.ru/img/posticon.gif"> <span class="daten">отправлено '
   ;пппппппппппппппппппппп
   ;Переназначение локального счётчика в процедурный
   $NumCurrentLine = $NumCurrentLineFileInput
   #include "SearchStrokZnakFileString.au3" ; Ищем вхождение
   ;Переназначение процедурного счётчика в локальный
   $NumCurrentLineFileInput = $NumCurrentLine
   ;uuuuuuuuuuuuuuuuuuuuuu
   ;MsgBox (0, "Строка выглядит так", $CurrentLine)
   ;MsgBox (0, "Позиция искомой последовательности", "Строка " & $NumCurrentLineFileInput & " " & "Знак " & $vhojdenieNaideno)
   $StrokaNachaloData = $NumCurrentLineFileInput
   $ZnakNachaloData = $vhojdenieNaideno + 75
   ; ИЩЕМ КОНЕЦ ДАТЫ!
   ; Устанавливаем искомую строку '</span>'
   $vhojdenie = '</span>'
   ;пппппппппппппппппппппп
   ;Переназначение локального счётчика в процедурный
   $NumCurrentLine = $NumCurrentLineFileInput
   #include "SearchStrokZnakFileString.au3" ; Ищем вхождение
   ;Переназначение процедурного счётчика в локальный
   $NumCurrentLineFileInput = $NumCurrentLine
   ;uuuuuuuuuuuuuuuuuuuuuu
   ;MsgBox (0, "Строка выглядит так", $CurrentLine)
   ;MsgBox (0, "Позиция искомой последовательности", "Строка " & $NumCurrentLineFileInput & " " & "Знак " & $vhojdenieNaideno)
   $StrokaKonecData = $NumCurrentLineFileInput
   $ZnakKonecData = $vhojdenieNaideno - $ZnakNachaloData
   ;ПОЛУЧАЕМ ДАТУ!
   $Data = StringMid ($CurrentLine, $ZnakNachaloData, $ZnakKonecData)
   ;MsgBox(0, "ДАТА такая:", $Data )
   ; ИЩЕМ НАЧАЛО E-mail!
   ; Устанавливаем искомую строку "<a href="mailto:"
   $vhojdenie = '<a href="mailto:'
   ;пппппппппппппппппппппп
   ;Переназначение локального счётчика в процедурный
   $NumCurrentLine = $NumCurrentLineFileInput
   #include "SearchStrokZnakFileString.au3" ; Ищем вхождение
   ;Переназначение процедурного счётчика в локальный
   $NumCurrentLineFileInput = $NumCurrentLine
   ;uuuuuuuuuuuuuuuuuuuuuu
   ;MsgBox (0, "Строка выглядит так", $CurrentLine)
   ;MsgBox (0, "Позиция искомой последовательности", "Строка " & $NumCurrentLineFileInput & " " & "Знак " & $vhojdenieNaideno)
   $StrokaNachaloEmail = $NumCurrentLineFileInput
   $ZnakNachaloEmail = $vhojdenieNaideno + 16
   ; ИЩЕМ КОНЕЦ E-mail!
   ; Устанавливаем искомую строку '"><IMG alt="Email для'
   $vhojdenie = '"><IMG alt="Email для'
   ;пппппппппппппппппппппп
   ;Переназначение локального счётчика в процедурный
   $NumCurrentLine = $NumCurrentLineFileInput
   #include "SearchStrokZnakFileString.au3" ; Ищем вхождение
   ;Переназначение процедурного счётчика в локальный
   $NumCurrentLineFileInput = $NumCurrentLine
   ;uuuuuuuuuuuuuuuuuuuuuu
   ;MsgBox (0, "Строка выглядит так", $CurrentLine)
   ;MsgBox (0, "Позиция искомой последовательности", "Строка " & $NumCurrentLineFileInput & " " & "Знак " & $vhojdenieNaideno)
   $StrokaKonecEmail = $NumCurrentLineFileInput
   $ZnakKonecEmail = $vhojdenieNaideno - $ZnakNachaloEmail
   ;ПОЛУЧАЕМ E-mail!
   $Email = StringMid ($CurrentLine, $ZnakNachaloEmail, $ZnakKonecEmail)
   ;MsgBox(0, "E-mail такой:", $Email )
   ; ИЩЕМ НАЧАЛО ЮЗЕРА!
   ; Устанавливаем искомую строку "><IMG alt="Email для "
   $vhojdenie = '><IMG alt="Email для '
   ;пппппппппппппппппппппп
   ;Переназначение локального счётчика в процедурный
   $NumCurrentLine = $NumCurrentLineFileInput
   #include "SearchStrokZnakFileString.au3" ; Ищем вхождение
   ;Переназначение процедурного счётчика в локальный
   $NumCurrentLineFileInput = $NumCurrentLine
   ;uuuuuuuuuuuuuuuuuuuuuu
   ;MsgBox (0, "Строка выглядит так", $CurrentLine)
   ;MsgBox (0, "Позиция искомой последовательности", "Строка " & $NumCurrentLineFileInput & " " & "Знак " & $vhojdenieNaideno)
   $StrokaNachaloUser = $NumCurrentLineFileInput
   $ZnakNachaloUser = $vhojdenieNaideno + 21
   ; ИЩЕМ КОНЕЦ ЮЗЕРА!
   ; Устанавливаем искомую строку '" tppabs='
   $vhojdenie = '" tppabs='
   ;пппппппппппппппппппппп
   ;Переназначение локального счётчика в процедурный
   $NumCurrentLine = $NumCurrentLineFileInput
   #include "SearchStrokZnakFileString.au3" ; Ищем вхождение
   ;Переназначение процедурного счётчика в локальный
   $NumCurrentLineFileInput = $NumCurrentLine
   ;uuuuuuuuuuuuuuuuuuuuuu
   ;MsgBox (0, "Строка выглядит так", $CurrentLine)
   ;MsgBox (0, "Позиция искомой последовательности", "Строка " & $NumCurrentLineFileInput & " " & "Знак " & $vhojdenieNaideno)
   $StrokaKonecUser = $NumCurrentLineFileInput
   $ZnakKonecUser = $vhojdenieNaideno - $ZnakNachaloUser - 29
   ;ПОЛУЧАЕМ ЮЗЕРА!
   $User = StringMid ($CurrentLine, $ZnakNachaloUser, $ZnakKonecUser)
   ;MsgBox(0, "ЮЗЕР такой:", $User )
   ;УДАЛЯЕМ ПРОБЕЛЫ ВНАЧАЛЕ И В КОНЦЕ!
   $TEXT = $User ;отправляем переменную на обработку
   #include "DelSpace.au3"
   $User = $TEXT; принимаем переменную с обработки
   If $logOn = 1 Then; ==== ЕСЛИ ВКЛЮЧЕН ЛОГ ====
      FileWrite ( "log.txt" , '============== Начало цикла ==============' & @CRLF )
      FileWrite ( "log.txt" , 'Нашли дату'& "   " & $Data & "   "& @CRLF &'Нашли Email' & "   "& $Email & @CRLF & 'Нашли ЮЗЕРА' & "   "& $User & @CRLF )
      FileWrite ( "log.txt" , 'Строка' & $NumCurrentLineFileInput & @CRLF )
   EndIf
   ;===============================================================================================
   ;Сообщение
;пппппппппппппппппппппп
;Переназначение локального счётчика в процедурный
$NumCurrentLine = $NumCurrentLineFileInput
   #include "PoiskNachalaSoobscheniya.au3"; Определяем координаты начала сообщения
;Переназначение процедурного счётчика в локальный
$NumCurrentLineFileInput = $NumCurrentLine
;uuuuuuuuuuuuuuuuuuuuuu
      If $logOn = 1 Then; ==== ЕСЛИ ВКЛЮЧЕН ЛОГ ====
         FileWrite ( "log.txt" , 'Вхождение найдено'& "   " & $vhojdenieNaideno & "   "& @CRLF & 'Строка начала сообщения' & "   "& $StrokaNachaloPost & @CRLF & 'Знак начала' & "   "& $ZnakNachaloPost & @CRLF )
      EndIf
;пппппппппппппппппппппп
;Переназначение локального счётчика в процедурный
$NumCurrentLine = $NumCurrentLineFileInput
   #include "PropuskJavaScript.au3" ; ИЩЕМ И ПРОПУСКАЕМ JAVA SCRIPT
;Переназначение процедурного счётчика в локальный
$NumCurrentLineFileInput = $NumCurrentLine
;uuuuuuuuuuuuuuuuuuuuuu
   Dim $ArrayDlinStroka[1000] = ['Инициализация массива']
   ;Заносим в массив первую строку
   ;$ArrayDlinStroka[$strokVBloke] = StringMid ($CurrentLine, $ZnakNachaloPost)
   ;MsgBox (0, "Строка в массиве", $ArrayDlinStroka[$strokVBloke])
   ;ПРИБАВЛЯЕМ ПО ОДНОЙ СТРОКЕ, ЗАПИСЫВАЯ В МАССИВ, ПОКА НЕ НАЙДЁМ КОНЕЦ
   While $NumCurrentLineFileInput <= $chisloStrokCurrentFile
      ;Смотрим, кончается ли строка конечным вхождением
      ; ИЩЕМ КОНЕЦ СООБЩЕНИЯ!
      ; Устанавливаем искомую строку '</FONT>'
      $vhojdenie = '</FONT>'
      ;пппппппппппппппппппппп
      ;Переназначение локального счётчика в процедурный
      $NumCurrentLine = $NumCurrentLineFileInput
      #include "SearchStrokZnakFileMnogostrok.au3" ; Ищем вхождение
      ;Переназначение процедурного счётчика в локальный
      $NumCurrentLineFileInput = $NumCurrentLine
      ;uuuuuuuuuuuuuuuuuuuuuu
         If $vhojdenieNaideno > 0 Then
            If $strokVBloke = 1 Then; если вхождение найдено в 1-й строке
               ;Считаем конец
               $StrokaKonecPost = $NumCurrentLineFileInput
               $ZnakKonecPost = $vhojdenieNaideno - 20
               ;Заносим в массив единственную строку
               $ArrayDlinStroka[$strokVBloke] = StringMid ($CurrentLine, $ZnakNachaloPost, $ZnakKonecPost)
            EndIf
            ExitLoop ;выход из цикла, если вхождение найдено
         EndIf
                  ;MsgBox (0, "Вхождение?", $vhojdenieNaideno)
         If $strokVBloke = 1 Then; если вхождение найдено в 1-й строке
            ;Заносим в массив первую строку (ограничение сначала)
            $ArrayDlinStroka[$strokVBloke] = StringMid ($CurrentLine, $ZnakNachaloPost)
         Else
            ;Заносим в массив строку без ограничения по длине
            $ArrayDlinStroka[$strokVBloke] = StringMid ($CurrentLine, 1 )
         EndIf
   ;$ArrayDlinStroka[$strokVBloke] = StringMid ($CurrentLine, $ZnakNachaloPost)
   ;MsgBox (0, "Строка в массиве", $ArrayDlinStroka[$strokVBloke])
      ;увеличиваем счётчики
      $strokVBloke = $strokVBloke + 1
      $NumCurrentLineFileInput = $NumCurrentLineFileInput + 1
   WEnd
   ;Координаты конца
   $StrokaKonecPost = $NumCurrentLineFileInput
   $ZnakKonecPost = $vhojdenieNaideno - 1
   If $logOn = 1 Then; если включен лог
      FileWrite ( "log.txt" , 'Вхождение найдено'& "   " & $vhojdenieNaideno & "   "& @CRLF & 'Строка конца сообщения' & "   "& $StrokaKonecPost & @CRLF & 'Знак конца сообщения' & "   "& $ZnakKonecPost & @CRLF )
   EndIf
   If $strokVBloke > 1 Then; если строк больше одной
      ;Заносим в массив последнюю строку, с 1-го символа и до ограничения
      $ArrayDlinStroka[$strokVBloke] = StringMid ($CurrentLine, 1, $ZnakKonecPost )
   EndIf
   ;MsgBox (0, "Строка в массиве", $ArrayDlinStroka[$strokVBloke])
   #include "MassivVPeremennuyu.au3" ; Массив заносим в одну строку
   ;MsgBox(0, "Сообщение такое:", $Soobschenie ); тест текста сообщений
   ;ОЧИЩАЕМ РЕГУЛЯРНЫМИ ВЫРАЖЕНИЯМИ!
   $TEXT = $Soobschenie ;отправляем переменную на обработку
   #include "RegexpClearSoobschen.au3"
   $TEXT = $TEXT; принимаем переменную с обработки
   $TEXT = '' ;Обнуляем переменную
   ;MsgBox(0, "Чистое сообщение такое:", $ClearSoobschenie ); тест очищенного текста сообщений
   If StringLen ( $ClearSoobschenie ) > 0 Then; если длина сообщения больше 0
      ; Пишем строку в файл
      ;FileWrite ( $outFileName , $zagolovok & @CRLF & $Data & @CRLF & @CRLF & $Email & @CRLF & @CRLF & $User & @CRLF & @CRLF &     $ClearSoobschenie & @CRLF& @CRLF& @CRLF)
      FileWrite ( $outFileName , $inFileName & "'" & $zagolovok & "'" & $Data &  "'" & $Email & "'" & $User & "'" & $ClearSoobschenie & "'"& @CRLF )
      ;FileWrite ( $outFileName , $ClearSoobschenie & "'"& @CRLF )
   EndIf
WEnd
$NumCurrentLineNamesOfFiles = $NumCurrentLineNamesOfFiles + 1
WEnd
