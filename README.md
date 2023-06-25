I have an virtualenv in python with `fastapi`, `pydantic` and `uvicorn` already installed.

In following scripts I want to find out if it is using any package that not installed in venv and send an error without executing scripts

```python
import numpy as np
from fastapi import FastAPI
from package import simple_sum
from pydantic import BaseModel


class User(BaseModel):
    id: int
    name: str


app = FastAPI()


@app.get("/")
async def main():
    print(simple_sum(2, 3))
    return {"message": "hello-world"}
```

For example in this scripts it supposed to say `numpy` is not installed!

---

- Content of virtual env

```
Package        Version
-------------- -------
click          8.1.3
docopt         0.6.2
fastapi        0.98.0
h11            0.14.0
pip            23.1.2
pip-check-reqs 2.4.4
pipreqs        0.4.13
pydantic       1.10.9
starlette      0.27.0
uvicorn        0.22.0
yarg           0.1.9
```

## Usage

### Method 1

If user set `requirements.txt` in root directory execute following command:

```bash
# just check-extra-reqs-default <SRC_PROJECT_DIR>
just check-extra-reqs-default sample
```

In `sample/app.py` I import **numpy**, **torch**, **pandas**  but they are not installed!

```
pip-extra-reqs --requirements-file requirements.txt sample/ -v
pip-check-reqs 2.4.4 from /workspace/.pyenv_mirror/user/current/lib/python3.11/site-packages/pip_check_reqs (python 3.11.1)
Extra requirements:
pandas in requirements.txt
torch in requirements.txt
numpy in requirements.txt
error: Recipe `check-extra-reqs-default` failed on line 16 with exit code 1
```

### Method 2

In this method I extract imported packages in `sample/` directory then find extra ones:

```bash
# just check-extra-reqs <SRC_PROJECT_DIR>
just check-extra-reqs sample
```

```
just get-reqs sample/
pipreqs sample/ --mode no-pin --savepath requirements-project.txt --force
WARNING: Import named "fastapi" not found locally. Trying to resolve it at the PyPI server.
WARNING: Import named "fastapi" was resolved to "fastapi:0.98.0" package (https://pypi.org/project/fastapi/).
Please, verify manually the final list of requirements.txt to avoid possible dependency confusions.
WARNING: Import named "numpy" not found locally. Trying to resolve it at the PyPI server.
WARNING: Import named "numpy" was resolved to "numpy:1.25.0" package (https://pypi.org/project/numpy/).
Please, verify manually the final list of requirements.txt to avoid possible dependency confusions.
WARNING: Import named "pandas" not found locally. Trying to resolve it at the PyPI server.
WARNING: Import named "pandas" was resolved to "pandas:2.0.2" package (https://pypi.org/project/pandas/).
Please, verify manually the final list of requirements.txt to avoid possible dependency confusions.
WARNING: Import named "torch" not found locally. Trying to resolve it at the PyPI server.
WARNING: Import named "torch" was resolved to "torch:2.0.1" package (https://pypi.org/project/torch/).
Please, verify manually the final list of requirements.txt to avoid possible dependency confusions.
INFO: Successfully saved requirements file in requirements-project.txt
pip-extra-reqs --requirements-file requirements-project.txt sample/ -v
pip-check-reqs 2.4.4 from /workspace/.pyenv_mirror/user/current/lib/python3.11/site-packages/pip_check_reqs (python 3.11.1)
Extra requirements:
torch in requirements-project.txt
numpy in requirements-project.txt
pandas in requirements-project.txt
error: Recipe `check-extra-reqs` failed on line 12 with exit code 1
```
