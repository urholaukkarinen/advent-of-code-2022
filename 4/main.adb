with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Text_IO.Unbounded_IO;
use Ada.Text_IO.Unbounded_IO;

with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

procedure main is
   File : File_Type;
   Line : Unbounded_String;
   Idx: Natural;
   A: Natural;
   B: Natural;
   C: Natural;
   D: Natural;
   Part1: Natural := 0;
   Part2: Natural := 0;
begin
   Open (File, In_File, "input.txt");

   while not End_Of_File (File) loop
      Line := Get_Line (File);
      
      Idx := Index(Line, "-");
      A := Integer'Value(Slice(Line, 1, Idx-1));
      Line := To_Unbounded_String(Slice(Line, Idx+1, Length(Line)));

      Idx := Index(Line, ",");
      B := Integer'Value(Slice(Line, 1, Idx-1));
      Line := To_Unbounded_String(Slice(Line, Idx+1, Length(Line)));

      Idx := Index(Line, "-");
      C := Integer'Value(Slice(Line, 1, Idx-1));
      D := Integer'Value(Slice(Line, Idx+1, Length(Line)));

      if (A <= C and B >= D) or 
         (C <= A and D >= B) then
         Part1 := Part1 + 1;
      end if;

      if (B >= C and A <= D) or 
         (C <= B and D >= A) then
         Part2 := Part2 + 1;
      end if;

   end loop;

   Close (File);

   Put_Line(Integer'Image(Part1));
   Put_Line(Integer'Image(Part2));
end main;