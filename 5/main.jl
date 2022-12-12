(stack_lines, instructions) = open("input.txt") do file
    parts = split(read(file, String), "\n\n")

    (split(parts[1], "\n")[1:end-1], split(parts[2], "\n"))    
end

stacks = [[] for _ in 1:ceil(length(stack_lines[1])/4)]

for line in stack_lines
    for j in range(1, length(stacks))
        item = line[2+(j-1)*4]
        if item != ' '
            push!(stacks[j], item)
        end
    end
end

stacks2 = deepcopy(stacks)

for inst in instructions
    (count, from, to) = map((s) -> parse(Int32, s), split(inst, ' ')[2:2:end])

    prepend!(stacks[to], reverse(stacks[from][1:count]))
    stacks[from] = stacks[from][count+1:end]

    prepend!(stacks2[to], stacks2[from][1:count])
    stacks2[from] = stacks2[from][count+1:end]
end

part1 = join(filter(!isempty, map((s) -> s[1], stacks)))
part2 = join(filter(!isempty, map((s) -> s[1], stacks2)))

println(part1)
println(part2)