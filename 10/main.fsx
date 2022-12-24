open System.IO

let input = 
    (File.ReadAllText "input.txt").Split [|'\n'|]
    |> Seq.ofArray

let processLine (line:string) =
    let parts = line.Split [| |]
    if parts.[0] = "addx"
        then [|[|"noop"|]; parts|]
        else [|parts|]

let instructions () =
    input
    |> Seq.map processLine
    |> Seq.concat
    |> Seq.toList

let rec signalStrengths instructions (cycle:int) (x:int) =
    ((cycle+1) * x) ::
    match instructions with
    | [|"noop"|]::xs -> signalStrengths xs (cycle+1) x
    | [|"addx"; n|]::xs -> signalStrengths xs (cycle+1) (x + (int n))
    | _ -> []

let rec crt instructions (cycle:int) (x:int) =
    let n = cycle % 40

    (if n >= x-1 && n <= x+1 then "#" else ".") ::
    match instructions with
    | [|"noop"|]::xs -> crt xs (cycle+1) x
    | [|"addx"; n|]::xs -> crt xs (cycle+1) (x + (int n))
    | _ -> []

let part1 =
    let results = signalStrengths (instructions ()) 0 1
    [20; 60; 100; 140; 180; 220]
    |> List.sumBy (fun i -> List.item (i-1) results)
    |> printf "%A\n"

let part2 =
    crt (instructions ()) 0 1
    |> List.chunkBySize 40  
    |> List.map (fun row -> String.concat "" row)
    |> printf "%A\n"