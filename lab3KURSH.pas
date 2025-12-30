program Lab3;
uses Math;
var
  a, b, h, integral, error: Double;
  n: Integer;
  choice: Char;
  limitsEntered, integralCalculated: Boolean;
// Функция для вычисления значения кривой f(x) = x*x*x - x + 8
function f(x: Double): Double;
var
  temp: Double;
begin
  temp := x*x*x - x + 8;
  // Если функция отрицательная - не учитываем эту площадь
  if temp < 0 then
    f := 0
  else
    f := temp;
end;
// Процедура для вычисления интеграла методом правых прямоугольников
procedure CalculateIntegral;
var
  i: Integer;
  sum, leftSum, midpointSum: Double;
  inputStr: String;
  code: Integer;
  absoluteError, relativeErrorPercent: Double;
begin
  if not limitsEntered then
  begin
    WriteLn('Ошибка: сначала введите пределы');
    Exit;
  end;
  // Ввод количества разбиений
  Write('Введите количество разбиений (n > 0): ');
  ReadLn(inputStr);
  Val(inputStr, n, code);
  if (code <> 0) or (n <= 0) then
  begin
    WriteLn('Ошибка: некорректное число разбиений!');
    Exit;
  end;
  // Проверка пределов
  if b <= a then
  begin
    WriteLn('Ошибка: b должно быть больше a!');
    Exit;
  end;
  // Вычисление шага
  h := (b - a) / n; 
  // Метод правых прямоугольников
  sum := 0;
  for i := 1 to n do
    sum := sum + f(a + i * h);
  integral := sum * h;
   // Метод левых прямоугольников для оценки погрешности
  leftSum := 0;
  for i := 0 to n - 1 do
    leftSum := leftSum + f(a + i * h);
  // Метод средних прямоугольников для более точной оценки
  midpointSum := 0;
  for i := 0 to n - 1 do
    midpointSum := midpointSum + f(a + (i + 0.5) * h);
  // Вычисление абсолютной погрешности
  absoluteError := Max(Abs(integral - leftSum * h), Abs(integral - midpointSum * h));
  // Вычисление относительной погрешности в процентах
  if integral <> 0 then
    relativeErrorPercent := (absoluteError / Abs(integral)) * 100
  else
    relativeErrorPercent := 0; // Если интеграл равен 0, относительная погрешность не определена
  error := absoluteError; // Сохраняем абсолютную погрешность для вывода
  integralCalculated := True;
  WriteLn('Интеграл успешно вычислен!');
  WriteLn('Абсолютная погрешность: ', absoluteError:0:6);
  WriteLn('Относительная погрешность: ', relativeErrorPercent:0:2, '%');
end;
procedure InputLimits;
var
  inputStr: String;
  code: Integer;
begin
  Write('Введите нижний предел интегрирования a: ');
  ReadLn(inputStr);
  Val(inputStr, a, code);
  if code <> 0 then
  begin
    WriteLn('Ошибка: некорректное число');
    Exit;
  end;
  Write('Введите верхний предел интегрирования b: ');
  ReadLn(inputStr);
  Val(inputStr, b, code);
  if code <> 0 then
  begin
    WriteLn('Ошибка: некорректное число');
    Exit;
  end;
  if b <= a then
  begin
    WriteLn('Ошибка: b должно быть больше a');
    Exit;
  end;
  limitsEntered := True;
  WriteLn('Пределы интегрирования установлены: от ', a:0:2, ' до ', b:0:2);
end;
// Процедура для вывода результатов
procedure OutputResults;
var
  relativeErrorPercent: Double;
begin
  if not limitsEntered then
  begin
    WriteLn('Ошибка: сначала введите пределы');
    Exit;
  end;
  if not integralCalculated then
  begin
    WriteLn('Ошибка: сначала вычислите интеграл');
    Exit;
  end;
  // Вычисляем относительную погрешность заново для вывода
  if integral <> 0 then
    relativeErrorPercent := (error / Abs(integral)) * 100
  else
    relativeErrorPercent := 0;
  WriteLn('РЕЗУЛЬТАТЫ');
  WriteLn('Пределы: [', a:0:2, ', ', b:0:2, ']');
  WriteLn('Функция: f(x) = x*x*x - x + 8');
  WriteLn('Количество разбиений n= ', n);
  WriteLn('Шаг h= ', h:0:6);
  WriteLn('Площадь ≈ ', integral:0:6);
  WriteLn('Абсолютная погрешность: ', error:0:6);
  WriteLn('Относительная погрешность: ', relativeErrorPercent:0:2, '%');
  WriteLn('');
  // Дополнительная информация о точности
  WriteLn;
  WriteLn('Оценка точности:');
  if relativeErrorPercent < 0.1 then
    WriteLn('Очень высокая точность (< 0.1%)')
  else if relativeErrorPercent < 1 then
    WriteLn('Высокая точность (< 1%)')
  else if relativeErrorPercent < 5 then
    WriteLn('Удовлетворительная точность (< 5%)')
  else if relativeErrorPercent < 10 then
    WriteLn('Низкая точность (< 10%)')
  else
    WriteLn('Очень низкая точность - рекомендуется увеличить n');
  WriteLn;
  WriteLn('Для повышения точности увеличьте количество разбиений n.');
end;
// Главная программа
begin 
  limitsEntered := False;
  integralCalculated := False;
  repeat
    WriteLn('ГЛАВНОЕ МЕНЮ');
    WriteLn('1. Ввести пределы интегрирования');
    WriteLn('2. Вычислить интеграл');
    WriteLn('3. Показать результаты');
    WriteLn('0. Выход из программы');
    Write('Ваш выбор: ');
    ReadLn(choice);
    WriteLn;  
    case choice of
      '1': begin
             InputLimits;
           end;
      '2': begin
             CalculateIntegral;
           end;
      '3': begin
             OutputResults;
           end;
      '0': WriteLn('Завершение работы программы.');
    else
      WriteLn('Ошибка: выберите пункт от 0 до 3');
    end;  
    WriteLn;
  until choice = '0';
end.