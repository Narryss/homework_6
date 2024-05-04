uses crt;
type StatDek = record
  tags: array of char;
  size: integer;
end;

type DinDek = ^Node;
  Node = record
  data: char;
  next: DinDek;
end;

var
  sd:StatDek;
  Head,Tail:DinDek;
  q:char;
  w,u:byte;
  maxsize,k:integer;
  stat:boolean;
  
procedure Add(i: char);
var j:integer; cur:DinDek;
begin
  if stat = true then begin
  if sd.size = maxsize then 
  begin
  writeln('Дэк заполнен');
  exit;
  end
  else
    begin
  for j:=sd.size-1 downto 0 do
  sd.tags[j+1]:= sd.tags[j];
  sd.tags[0] := i;
  sd.size := sd.size + 1;
    end;
    end
    else
      begin
      New(cur);
      if Tail = nil then Tail := cur;
      cur^.Next := Head;
      Head := cur;
      cur^.data := i;
      end;
end;

procedure Add1(i: char);
var cur:DinDek;
begin
  if stat = true then begin
  if sd.size = maxsize then 
  begin
  writeln('Дэк заполнен');
  exit;
  end
  else
    begin
  sd.tags[sd.size]:= i;
  sd.size := sd.size + 1;
    end;
    end
    else
    begin
      New(cur);
      cur^.data := i;
      cur^.next := nil;
      if Head = nil then begin
      Head := cur
      end
      else
        Tail^.next := cur;
        Tail := cur;
      end;
end;

procedure Delete();
var i:integer; cur: DinDek;
begin
  if stat = true then begin
  if sd.size <> 0 then
  begin
    for i:=1 to sd.size-1 do
    sd.tags[i-1] := sd.tags[i];
    sd.size := sd.size - 1;
  end;
end
else 
begin
  if Head <> nil then begin 
  cur:=Head; 
  Head := Head^.next; 
  dispose(cur); 
  end;
end;
end;

procedure Delete1();
var cur,temp:DinDek;
begin
  if stat = true then begin
  if sd.size <> 0 then
  begin
    sd.tags[sd.size] := char(255);
    sd.size := sd.size - 1;
  end;
end
else 
  if Head <> nil then 
    begin 
  if Head = Tail then 
    begin 
  dispose(Head);
  Head:=nil;
  Tail:=nil;
  end
  else
  begin
    cur:=Head;
  while cur^.next <> Tail do 
  cur := cur^.next;
  temp:=Tail;
  Tail:=cur;
  dispose(temp);
  cur^.next:= nil;
  end;
  end;
  end;

function IsEmptyDek: Boolean;
begin
  if stat = true then
  Result := (sd.size = 0)
  else
  Result := (Head = nil);
end;

procedure View();
var j:integer; cur:DinDek;
begin
if stat = true then begin
for j:=0 to sd.size-1 do
  write(sd.tags[j],' ');
end
else
  cur:=Head;
  while cur <> nil do begin
    write(cur^.data,' ');
      cur := cur^.next;
  end;
writeln;
end;

begin
  repeat
  writeln('Выбирите структуру дека:');
  writeln('1 - статическая');
  writeln('2 - динамическая');
  readln(k);
  if k = 1 then begin
    stat := True;
    writeln('Задайте максимальную длину');
    readln(maxsize);
    setlength(sd.tags,maxsize);
  end;
  until (k = 1) or (k =2);

k := 0;
clrscr;

repeat
    clrscr;
    writeln('1 - добавление элемента');
    writeln('2 - удаление элемента');
    writeln('3 - узнать, пуст ли дек');
    writeln('4 - просмотр дека');
    writeln('0 - закончить работу');
    readln(k);
    case k of
      1: begin 
      writeln('Добавить в начало - 1'); writeln('Добавить в конец - 2');
      readln(w);
      writeln('Введите добавляемый символ');
      readln(q);
      if w = 1 then add(q) else if w = 2 then add1(q);
      end;
      2: begin
      writeln('Удалить из начала - 1'); writeln('Удалить из конца - 2');
      readln(u);
      if u = 1 then delete() else if u = 2 then delete1();
      end;
      3: writeln(IsEmptyDek);
      4: view;
    end;
    writeln('Нажмите enter...');
    readln(q);
  until k = 0;
  end.