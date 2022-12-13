def input = new File("input.txt").getText().toList()

List.metaClass.findFirstMarker = {len -> 
    len + delegate.collate(len, 1).findIndexOf { a -> a.unique().size() == len}
}

part1 = input.findFirstMarker(4)
part2 = input.findFirstMarker(14)

println part1
println part2
