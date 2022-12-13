import 'dart:io';

int process(String name, List<String> lines, Map<String, int> dirs) {
  var size = 0;

  while (!lines.isEmpty) {
    var line = lines.removeAt(0);
    var parts = line.split(" ");

    if (parts.length > 2 && parts[2] == "..") {
      // Exiting a directory
      break;
    }

    if (parts[1] == "cd") {
      // Entering a directory
      size += process(name + parts[2] + "/", lines, dirs);
      continue;
    }

    if (parts[0] == "dir" || parts[1] == "ls") {
      // Unnecessary
      continue;
    }

    size += int.parse(parts[0]);
  }

  dirs[name] = size;

  return size;
}

void main() {
  List<String> lines = new File('input.txt').readAsLinesSync().sublist(1);

  var dirs = new Map<String, int>();
  var totalSize = process("/", lines, dirs);
  var maxSize = 70000000;
  var unusedSpace = maxSize - totalSize;
  var spaceNeeded = 30000000 - unusedSpace;
  var part1 = 0;
  var part2 = maxSize;

  for (var entry in dirs.entries) {
    if (entry.value < 100000) {
      part1 += entry.value;
    }

    if (entry.value >= spaceNeeded && entry.value < part2) {
      part2 = entry.value;
    }
  }

  print(part1);
  print(part2);
}