from fastapi import FastAPI

app = FastAPI()

@app.get("/admin")
def admin():
    return "Super Secret Admin Stuff"

@app.get("/images")
def images():
    return ":-)"

@app.get("/js")
def js():
    return "console.log('Hello, world!');"
