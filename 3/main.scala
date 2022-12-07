def toPriority(c: Char) : Int = {
    return c.toInt - (if (c.isUpper) 38 else 96);
}

def main(args: Array[String]) : Unit = {
    val rucksacks = scala.io.Source.fromFile("input.txt").getLines.toList;

    val part1 = rucksacks
        .map(line => line.splitAt(line.length / 2))
        .map((l, r) => l.find(r.contains))
        .flatten
        .map(toPriority)
        .sum;

    println(part1);

    val part2 = rucksacks.sliding(3, 3)
        .map(l => l.head.find(c => l.forall(_.contains(c))))
        .flatten
        .map(toPriority)
        .sum;

    println(part2);
}