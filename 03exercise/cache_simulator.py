# Computer Architecture - 5th semester - ECE NTUA
# Copyright (C) 2024  Andreas Stamos
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import operator

maxint = int(1e9)

m = 4  # number of blocks in each set
sets = 2  # number of sets
blocksize = (
    4  # 4 floating-point numbers per block (32 bytes per block / 8 bytes per fpu)
)

# cache[i] is the ith set
# cache[i][j] is the jth block of the ith set
# cache[i][j][0] is the number of block of the main memory
# cache[i][j][1] is the age
cache = [[[-1, maxint] for _ in range(m)] for _ in range(sets)]

misses = 0
hits = 0


def access(loc):
    global hits, misses

    # Calculating in which block the requested location belongs
    block = loc // blocksize
    # Calculating in which set the requsted block belongs
    set_loc = block % sets

    # Increasing the age of all blocks.
    for i in range(sets):
        for j in range(m):
            cache[i][j][1] += 1

    # Checking if the requested block is in the cache and if it is setting the age to 0.
    for i in range(m):
        if cache[set_loc][i][0] == block:
            hits += 1
            cache[set_loc][i][1] = 0
            return

    # From now on it is certainly a miss.
    misses += 1

    # Finding the least recently used block. (it is the one with the maximum age)
    lru = cache[set_loc].index(max(cache[set_loc], key=operator.itemgetter(1)))

    # "Loading" in the cache and setting the age to 0.
    cache[set_loc][lru][0] = block
    cache[set_loc][lru][1] = 0


for i in range(6):
    for j in range(0, 8, 2):
        access(64 + (i % 4) * 8 + j)
        access((i % 3) * 8 + j)
        access(128 + j)
        access((i % 3) * 8 + j)

print("Hits: ", hits)
print("Misses: ", misses)
print("Total: ", hits + misses)
print("Hit rate: ", hits / (hits + misses))
print("Miss rate: ", misses / (hits + misses))
