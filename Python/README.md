# Python tips
Here are 7 common Python mistakes we should avoid in production code:
- Type Hints
```python
# Mistake:
def add(x, y):
    return x + y
# Fix:
def add(x: int, y: int) -> int:
    return x + y
```
Comment: Functions become harder to understand, refactor, or use Without type hints. Type hints make code self-documenting and are a gateway to tools like mypy and better IDE support.
- Using Mutable Default Arguments
```python
# Mistake:
def append_item(item, items=[]):
    items.append(item)
    return items`
# Fix:
`def append_item(item, items=None):
    if items is None:
        items = []
    items.append(item)
    return items
```
Comment: The default list is shared across all function calls. This leads to odd behavior and hard-to-trace bugs. So, avoid mutable default arguments unless you really know what you’re doing.
- Overusing List Comprehensions
```python
# Mistake:
result = [transform(x) for x in some_large_iterable if condition(x)]
# Fix:
for x in some_large_iterable:
    if condition(x):
        yield transform(x)
```
Comment: List comprehensions are elegant, but they can become unreadable or memory-intensive with complex logic or large data sets. Use regular loops when readability or memory is a concern.
- Catching Bare Exceptions
```python
# Mistake:
try:
    do_something()
except:
    handle_error()
# Fix:
try:
    do_something()
except ValueError as e:
    handle_value_error(e)
```
Comment: Catching all exceptions (KeyboardInterrupt, SystemExit, and MemoryError) can hide serious problems and make debugging difficult. Be specific in your exception handling. It makes code safer and easier to debug.
- Misusing print
```python
# Mistake:
print("Something went wrong")
# Fix:
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)
logger.info("Something went wrong")
```
Comment: print is fine for debugging but useless in a real-world environment where logs matter. Logging is your best friend in production. Use it early and often.
- Monolithic Functions
```python
# Mistake:
def process_data():
    # 50+ lines doing many things
# Fix:
def fetch_data(): ...
def clean_data(): ...
def transform_data(): ...
def save_data(): ...
```
Comment: Monolithic functions are hard to test, debug, and maintain. Break down functionality into smaller, reusable functions.

## Test package installation speed
- Run installing_on_linux.sh to test package installation speed on Linux.
- Run installing_on_windows.bat to test package installation speed on Windows.