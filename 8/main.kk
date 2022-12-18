import std/os/path
import std/os/file

// remove duplicates from a list of tuples
fun dedup(input: list<(int, int)>) : list<(int, int)>
    match input
        Cons((a, b), xx) -> Just((a, b)).list ++ xx.dedup.remove(fn((c, d)) a == c && b == d)
        Nil -> Nil

// get element from a two-dimensional list
fun get(input : list<list<a>>, x, y) : maybe<a>
    match input[y]
        Just(row) -> match row[x]
            Just(tree) -> Just(tree) 
            Nothing -> Nothing
        Nothing -> Nothing

fun is-at-edge(input: list<list<char>>, x, y) : bool
    !get(input, x + 1, 0).bool || !get(input, x, y + 1).bool

fun is-visible(input: list<list<char>>, tree: char, tallest: char, x: int, y: int) : bool
    tree > tallest || x == 0 || y == 0 || is-at-edge(input, x, y)

fun visible-trees(input: list<list<char>>, tallest: char, x: int, y: int, add-x: int, add-y: int) : div list<(int, int)>
    match get(input, x, y)
        Just(tree) -> if is-visible(input, tree, tallest, x, y)
            then 
                list(Just((x, y))) ++ visible-trees(input, tree, x + add-x, y + add-y, add-x, add-y)
            else
                visible-trees(input, tallest, x + add-x, y + add-y, add-x, add-y)
        Nothing -> Nil

// calculate scenic score of a tree from one direction
fun scenic-score-dir(input: list<list<char>>, tree: char, x: int, y: int, dir-x: int, dir-y: int) : div list<(int, int)>
    match get(input, x, y)
        Just(other) -> if other < tree
            then 
                list(Just((x, y))) ++ scenic-score-dir(input, tree, x + dir-x, y + dir-y, dir-x, dir-y)
            else
                list(Just((x, y)))
        Nothing -> Nil

// brute force the scenic score of a tree at (x, y) by looking at all 4 directions
fun scenic-score(input: list<list<char>>, x, y)
    val tree = get(input, x, y).unjust
    scenic-score-dir(input, tree, x + 1, y, 1, 0).length
    * scenic-score-dir(input, tree, x - 1, y, -1, 0).length
    * scenic-score-dir(input, tree, x, y + 1, 0, 1).length
    * scenic-score-dir(input, tree, x, y - 1, 0, -1).length

fun coords(width, height)
    list(0, width - 1, fn(y)
        list(0, height - 1, fn(x)
            (x, y)
        )
    ).concat

fun part1(input: list<list<char>>)
    val height = input.length 
    val width = input[0].unjust.length

    // left and right
    var visible := list(0, height - 1, fn(i) 
        visible-trees(input, get(input, 0, i).unjust, 1, i, 1, 0)
        ++ visible-trees(input, get(input, width - 1, i).unjust, width - 2, i, -1, 0)
    ) 
    // top and bottom
    visible := visible ++ list(0, width - 1, fn(i) 
        visible-trees(input, get(input, i, 0).unjust, i, 1, 0, 1)
        ++ visible-trees(input, get(input, i, height - 1).unjust, i, height - 2, 0, -1)
    )

    visible.concat.dedup.length

fun part2(input: list<list<char>>)
    val height = input.length 
    val width = input[0].unjust.length

    coords(width, height).map(fn((x, y)) scenic-score(input, x, y)).maximum
    
fun main()
    val input = read-text-file("input.txt".path).lines.map(list)

    println(part1(input))
    println(part2(input))