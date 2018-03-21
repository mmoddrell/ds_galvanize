#!/usr/bin/env python
"""
A class to model dice
"""

__author__ = "Micah Moddrell"
import random

class SomeClass():
    """
    A generic class
    """
    sides = []
    current_top = 1


    def __init__(self,s=6):
        """
        Constructor
        """
        for i in range(s):
            self.sides.append(i+1)

    def roll_dice(self):
        """
        rolls the dices
        """
        self.current_top = random.randint(1,6)
        print('You rolled a {}!!!'.format(self.current_top))

    def print_top(self):
        """
        prints current top for dice
        """
        print(self.current_top)

    def __lt__(self, other):
        """
        MM for <
        """
        return (self.current_top < other.current_top)
    def __le__(self, other):
        """
        MM for <=
        """
        return (self.current_top <= other.current_top)
    def __gt__(self, other):
        """
        MM for >
        """
        return (self.current_top > other.current_top)
    def __ge__(self, other):
        """
        MM for >=
        """
        return (self.current_top >= other.current_top)
    def __eq__(self, other):
        """
        MM for ==
        """
        return (self.current_top == other.current_top)



if __name__ == "__main__":
    print("\nRunning...")
    sc = SomeClass()
    sc.roll_dice()
    sc1 = SomeClass()
    sc1.roll_dice()

    print(sc < sc1)


    print(dir(sc))
