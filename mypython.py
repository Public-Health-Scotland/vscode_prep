import pandas as pd

df = pd.read_csv(
    "https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-03-05/trashwheel.csv", parse_dates=['Date'])
print(df.head(3))
print(df.describe())


def calc_sum(a: int, b: int):
    return a+b


x = calc_sum(2, 3)

print("Result is", x)


def calc_div(a: int, b: int):
    return a/b


y = calc_div(5, 2)
print("Result is", y)


def calc_mul(a: int, b: int):
    return a*b


z = calc_mul(5, 2)
print("Result is", z)
