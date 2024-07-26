from dataclasses import dataclass


# internal costs are costs, that are directly paid for.
# All values in this class are in €
@dataclass
class InternalCosts:
    variable: float = 0
    fixed: float = 0

    def __add__(self, other):
        return InternalCosts(
            variable=self.variable + other.variable,
            fixed=self.fixed + other.fixed
        )
