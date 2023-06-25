import numpy as np
from fastapi import FastAPI
from package import simple_sum
from pydantic import BaseModel
import torch
import pandas as pd


class User(BaseModel):
    id: int
    name: str


app = FastAPI()


@app.get("/")
async def main():
    print(simple_sum(2, 3))
    return {"message": "hello-world"}
