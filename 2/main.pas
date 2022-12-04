function value(choice: char): integer;
begin
    case (choice) of
        'A','X' : value := 1;
        'B','Y' : value := 2;
        'C','Z' : value := 3;
    end;    
end;

function outcome(a, b: integer): integer;
begin
    if a = b then
        outcome := 3
    else if (b mod 3) + 1 = a then
        outcome := 6
    else
        outcome := 0;
end;

function part2Choice(i, j: integer): integer;
begin
    case (j) of
        // lose
        1: part2Choice := ((i+1) mod 3) + 1;
        // draw
        2: part2Choice := i;
        // win
        3: part2Choice := (i mod 3) + 1;
    end;
end;

function score(i, j: integer): integer;
begin
    score := i + outcome(i, j);
end;

var
    input: TextFile;
    line: string;
    part1, part2: integer;
    elf, you: integer;
begin
    AssignFile(input, 'input.txt');

    part1 := 0;
    part2 := 0;

    try
        reset(input);

        while not eof(input) do
        begin
            ReadLn(input, line);

            elf := value(line[1]);
            you := value(line[3]);

            part1 += score(you, elf);
            part2 += score(part2Choice(elf, you), elf);
        end;

        WriteLn(part1);
        WriteLn(part2);
    except end;
end.